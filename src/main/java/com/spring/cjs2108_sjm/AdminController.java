package com.spring.cjs2108_sjm;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_sjm.service.AdminService;
import com.spring.cjs2108_sjm.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	String msgFlag = "";
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value="/adPage", method = RequestMethod.GET)
	public String adPageGet() {
		return "admin/adPage";
	}
	
	@RequestMapping(value="/adMemberList", method = RequestMethod.GET)
	public String adMemberListGet(
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="lately", defaultValue = "0", required = false) int lately,
			@RequestParam(name="level", defaultValue="99", required=false) int level,
			@RequestParam(name="mid", defaultValue="", required=false) String mid,
			Model model) {
		
		/* 페이징처리(블록페이지) 변수지정 시작 */
	  int totRecCnt = 0;
	  if(mid.equals("")) {
	  	totRecCnt = adminService.totRecCnt(level);
	  }
	  else {
	  	totRecCnt = adminService.totRecCntMid(mid);	
	  }
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		
	  int curBlock = (pag - 1) / blockSize;		
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
		
	  ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
	  if(mid.equals("")) {	
	  	vos = adminService.getMemberList(startIndexNo, pageSize, level);
	  }
	  else {							
	  	vos = adminService.getMemberListMid(startIndexNo, pageSize, mid);
	  }
	  
	  model.addAttribute("vos", vos);
	  model.addAttribute("pag", pag);
	  model.addAttribute("pageSize", pageSize);
	  model.addAttribute("totPage", totPage);
	  model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("lately", lately);
		
		model.addAttribute("level", level);
		model.addAttribute("mid", mid);
		model.addAttribute("totRecCnt", totRecCnt);
		
		return "admin/member/adMemberList";
	}
	
	@ResponseBody
	@RequestMapping(value="/adMemberLevel", method = RequestMethod.POST)
	public String adMemberLevelPost(int idx, int level) {
		adminService.setLevelUpdate(idx, level);
		return "";
	}
	
	@RequestMapping(value="/adMemberReset", method = RequestMethod.GET)
	public String adMemberResetGet(int idx) {
		adminService.setMemberReset(idx);
		
		msgFlag = "memberResetOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	@RequestMapping(value="/adMemberInfor", method = RequestMethod.GET)
	public String adMemberInforGet(int idx) {
		MemberVO vo =  adminService.getMemberInfor(idx);
		return "";
	}
	
	
	@RequestMapping(value="/adBoardList", method = RequestMethod.GET)
	public String adBoardListGet(
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="level", defaultValue="99", required=false) int level,
			@RequestParam(name="mid", defaultValue="", required=false) String mid,
			Model model) {
		
		/* 페이징처리(블록페이지) 변수지정 시작 */
		int pageSize = 5;
		int totRecCnt = 0;
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;		
		int curBlock = (pag - 1) / blockSize;		
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		/* 블록페이징처리 끝 */
		
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		model.addAttribute("level", level);
		model.addAttribute("mid", mid);
		model.addAttribute("totRecCnt", totRecCnt);
		
		return "admin/board/adBoardList";
	}
	
	
}
