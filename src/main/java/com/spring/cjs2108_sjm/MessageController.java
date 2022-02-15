package com.spring.cjs2108_sjm;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model, HttpSession session) {
		String nickName = session.getAttribute("sNickName")==null ? "" : (String) session.getAttribute("sNickName");
		String strLevel = session.getAttribute("sStrLevel")==null ? "" : (String) session.getAttribute("sStrLevel");
		
		if(msgFlag.equals("memLoginOk")) {
			model.addAttribute("msg", nickName + "님("+strLevel+") 로그인되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memLoginNo")) {
			model.addAttribute("msg", "로그인 실패");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memLogout")) {
			session.invalidate();
			model.addAttribute("msg", nickName + "님 로그아웃되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", nickName + "님 세션이나 등급 확인 후 사용하세요.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memIdCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다.");
			model.addAttribute("url", "member/memInput");
		}
		else if(msgFlag.equals("memNickNameCheckNo")) {
			model.addAttribute("msg", "닉네임이 중복되었습니다.");
			model.addAttribute("url", "member/memInput");
		}
		else if(msgFlag.equals("memInputOk")) {
			model.addAttribute("msg", "회원가입되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memInputNo")) {
			model.addAttribute("msg", "회원가입실패");
			model.addAttribute("url", "member/memInput");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("msg", "비밀번호를 확인해주세요.");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memUpdateNo")) {
			model.addAttribute("msg", "회원정보수정실패");
			model.addAttribute("url", "member/memUpdate");
		}
		else if(msgFlag.equals("memDeleteOk")) {
			session.invalidate();
			model.addAttribute("msg", nickName + "님 탈퇴되었습니다.\\n(1개월간 같은 아이디로 가입하실 수 없습니다.)\\n\\n이용해주셔서 감사합니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일이 전송되었습니다.");
			model.addAttribute("url", "mail/mailForm");
		}
		else if(msgFlag.equals("pwdConfirmOk")) {
			model.addAttribute("msg", "임시비밀번호가 메일로 전송되었습니다.\\n메일을 확인해주세요.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("pwdConfirmNo")) {
			model.addAttribute("msg", "임시비밀번호발급실패 \\n사용자정보를 확인해주세요.");
			model.addAttribute("url", "member/pwdConfirm");
		}
		else if(msgFlag.equals("idConfirmNo")) {
			model.addAttribute("msg", "아이디찾기실패 \\n사용자정보를 확인해주세요.");
			model.addAttribute("url", "member/idConfirm");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "board/boardList");
		}
		else if(msgFlag.equals("memberResetOk")) {
			model.addAttribute("msg", "회원 DB에서 완전히 탈퇴 처리 완료");
			model.addAttribute("url", "admin/adMemberList");
		}
		else if(msgFlag.equals("dbProductInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbProduct");
		}
		else if(msgFlag.equals("dbOptionInputOk")) {
			model.addAttribute("msg", "상품 옵션이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbOption");
		}
		else if(msgFlag.equals("orderInputOk")) {
			model.addAttribute("msg", "주문이 완료되었습니다.");
			model.addAttribute("url", "dbShop/dbOrderConfirm");
		}
		/*
		 * else if(msgFlag.equals("sessionProductNo")) { model.addAttribute("msg",
		 * "장바구니가 비어있습니다."); model.addAttribute("url", "sessionShop/shopList"); }
		 */
		
		
		
		// 이거 맨 뒤로 빼두기.. 왜일까? substring 써서 그른가... 그냥 그른가부다..
		else if(msgFlag.substring(0,13).equals("boardUpdateOk")) {
			model.addAttribute("msg", "게시글이 수정되었습니다.");
			model.addAttribute("url", "/board/boardContent?"+msgFlag.substring(14));
		}
		else if(msgFlag.substring(0,13).equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제되었습니다.");
			model.addAttribute("url", "/board/boardList?"+msgFlag.substring(14));
		}
		
		
		
		return "include/message";
	}
	
}
