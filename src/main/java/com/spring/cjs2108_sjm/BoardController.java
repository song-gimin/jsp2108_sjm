package com.spring.cjs2108_sjm;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_sjm.service.BoardService;
import com.spring.cjs2108_sjm.vo.BoardReplyVO;
import com.spring.cjs2108_sjm.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	String msgFlag = "";
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value="/boardList", method = RequestMethod.GET)
	public String boardListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="lately", defaultValue = "0", required = false) int lately,
			Model model) {
		
		/* 페이징처리(블록페이지) 변수지정 시작 */
	  int totRecCnt = boardService.totRecCnt();		// 전체자료검색
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자지정)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
		
	  List<BoardVO> vos = boardService.getBoardList(startIndexNo, pageSize);
	  
	  model.addAttribute("vos", vos);
	  model.addAttribute("pag", pag);
	  model.addAttribute("pageSize", pageSize);
	  model.addAttribute("totPage", totPage);
	  model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("lately", lately);
		
		return "board/boardList";
	}
	
	 // 게시글 등록 폼 호출
	@RequestMapping(value="/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	// 게시글 입력 후 DB에 저장하기
	@RequestMapping(value="/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {
		// 이미지 파일 업로드 시에는 ckeditor폴더에서 board폴더로 복사 작업 처리 하기
		boardService.imgCheck(vo.getContent());
		
		// 이미지 복사 작업이 종료되면 실제로 저장된 board폴더명을 DB에 저장시켜줘야한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));
		
		// 이미지 작업과 실제저장폴더를 set 처리한 후, 잘 정비된 vo를 DB에 저장한다.
		boardService.setBoardInput(vo);
		
		return "redirect:/msg/boardInputOk";
	}
	
	// board의 ckeditor에서 그림 업로드시 처리하는곳
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;          // 파일명 중복 안되게 하려고........... 이러고 있음............
		
		byte[] bytes = upload.getBytes();
		
		// ckeditor에서 올린 파일을 서버 파일 시스템에 저장시켜준다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		// 서버 파일 시스템에 저장된 파일을 화면(textarea)에 출력하기
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");               // "atom":"12.jpg","uploaded":1,"":
		
		out.flush();
		outStr.close();
	}
	
	// 게시글 내용보기
	@RequestMapping(value="/boardContent", method = RequestMethod.GET)
	public String boardContentGet(int idx, int pag, int pageSize, int lately, Model model) {
		// 조회수 증가하기(중복방지X)
		boardService.addReadNum(idx);
		
		// 원본 글 가져오기
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 이전글 다음글 가져오기
		List<BoardVO> pnVos = boardService.getPreNext(idx);
		
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("lately",lately);
		
		// 댓글가져오기
		List<BoardReplyVO> rVos = boardService.getBoardReply(idx);
		model.addAttribute("rVos",rVos);
		
		return "board/boardContent";
	}
	
	// 수정 폼 불러오기
	@RequestMapping(value="/boardUpdate",method = RequestMethod.GET)
	public String boardUpdateGet(Model model, int idx, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately) {
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 수정작업 처리 전에 그림파일이 존재한다면 원본파일을 ckeditor폴더로 복사 시켜둔다.
		if(vo.getContent().indexOf("src=\"/") != -1)	boardService.imgCheckUpdate(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("lately", lately);
		return "board/boardUpdate";
	}
	
	//수정한 내용 DB에 저장하기
	@RequestMapping(value="/boardUpdate",method = RequestMethod.POST)
	public String boardUpdatePost(BoardVO vo, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately) {
		
		// 원본파일들을 board폴더에서 삭제처리
		if(vo.getOriContent().indexOf("src=\"/") != -1)	boardService.imgDelete(vo.getOriContent());
		
		// 원본파일을 수정 폼에 들어올 때 board폴더에서 ckeditor폴더로 복사해두고, board폴더의 파일은 지웠기에 아래의 복사 처리 전에 원본파일위치를 vo.content안의 파일경로를 board폴더에서 ckeditor폴더로 변경처리 해줘야한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/board/", "/data/ckeditor/"));
		
		// 수정된 그림파일을 다시 복사처리한다.(수정된 그림파일의 정보는 content필드에 담겨있다.)('/ckeditor'폴더 -> '/ckeditor/board'폴더로복사) : 처음파일 입력작업과 같은 작업이기에 아래는 처음 입력시의 메소드를 호출했다.
		boardService.imgCheck(vo.getContent());
		
		// 필요한 파일을 board폴더로 복사했기에 vo.content의 내용도 변경한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));
		
		// 잘 정비된 vo값만을 DB에 저장시킨다.
		boardService.setBoardUpdate(vo);
		
		msgFlag = "boardUpdateOk$idx="+vo.getIdx()+"&pag="+pag+"&pageSize="+pageSize+"&lately="+lately;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 게시글 삭제 처리 부분
	@RequestMapping(value="/boardDelete")
	public String boardDeleteGet(int idx, int pag, int pageSize, int lately) {
		// 게시글에 사진이 존재한다면 실제 서버 파일 시스템에서 사진파일을 삭제처리
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1)	boardService.imgDelete(vo.getContent());
		
		// DB에서 실제 게시글을 삭제처리한다.
		boardService.setBoardDelete(idx);
		
		msgFlag = "boardDeleteOk$pag="+pag+"&pageSize="+pageSize+"&lately="+lately;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 댓글저장하기
	@ResponseBody
	@RequestMapping(value="/boardReplyInsert", method = RequestMethod.POST)
	public String boardReplyInsertPost(BoardReplyVO rVo) {
		int levelOrder = 0;
		String strLevelOrder = boardService.maxLevelOrder(rVo.getBoardIdx());
		if(strLevelOrder!=null) levelOrder = Integer.parseInt(strLevelOrder) + 1;
		rVo.setLevelOrder(levelOrder);
		
		boardService.setReplyInsert(rVo);
		return "";
	}
	
	// 답글저장하기
	@ResponseBody
	@RequestMapping(value="/boardReplyInsert2", method = RequestMethod.POST)
	public String boardReplyInsert2Post(BoardReplyVO rVo) {
		boardService.levelOrderPlusUpdate(rVo);  // 부모댓글의 levelOrder 값보다 큰 모든 댓글의 levelOrder값을 +1 시켜준다.(update)
		rVo.setLevel(rVo.getLevel()+1);  // 자신의 level은 부모 level보다 +1 해준다.
		rVo.setLevelOrder(rVo.getLevelOrder()+1);  // 자신의 levelOrder은 부모 levelOrder 보다 +1 해준다.
		
		boardService.setReplyInsert2(rVo);
		return "";
	}
	
	// 댓글삭제처리
	@ResponseBody
	@RequestMapping(value="/boardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(int replyIdx) {
		boardService.setReplyDelete(replyIdx);
		return "";
	}
	
	
}
