package com.spring.cjs2108_sjm;

import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_sjm.service.MemberService;
import com.spring.cjs2108_sjm.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	String msgFlag = "";
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	// 로그인 폼 호출
	@RequestMapping(value="/memLogin", method = RequestMethod.GET)
	public String memLoginGet(HttpServletRequest request) {
		// 아이디저장 쿠키
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		return "member/memLogin";
	}
	
	// 로그인 인증
	@RequestMapping(value="/memLogin", method = RequestMethod.POST)
	public String memLoginPost(String mid, String pwd, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		MemberVO vo = memberService.getIdCheck(mid);
		
		if(vo!=null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
			String strLevel = "";
		  if(vo.getLevel() == 0) strLevel = "관리자";
		  else if(vo.getLevel() == 1) strLevel = "VVIP";
		  else if(vo.getLevel() == 2) strLevel = "VIP";
		  else if(vo.getLevel() == 3) strLevel = "GOLD";
		  else if(vo.getLevel() == 4) strLevel = "SILVER";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			
			// 최종 접속일을 세션에 저장
			session.setAttribute("sLastDate", vo.getLastDate().substring(0, vo.getLastDate().lastIndexOf(" ")));
					
			// 방문시에 처리 할 내용들을 서비스객체에서 처리(오늘방문카운트누적, 포인트누적, 등등등~~)
			memberService.getMemberTodayProcess(vo.getTodayCnt());
			
			// 아이디에 대한 정보를 쿠키로 저장 처리하기
			String idCheck = request.getParameter("idCheck")==null? "" : request.getParameter("idCheck");
			
			// 쿠키처리
			if(idCheck.equals("on")) {			
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*4); 
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);	
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			msgFlag = "memLoginOk";
		}
		else {
			msgFlag = "memLoginNo";
		}
		return "redirect:/msg/" + msgFlag;
	}
	
	//로그아웃
	@RequestMapping(value="/memLogout", method = RequestMethod.GET)
	public String memLogoutGet() {
		msgFlag = "memLogout";
		return "redirect:/msg/" + msgFlag;
	}
	
	// 회원가입 폼 호출
	@RequestMapping(value="/memInput", method = RequestMethod.GET)
	public String memInputGet() {
		return "member/memInput";
	}
	
	//회원가입처리
	@RequestMapping(value="/memInput", method = RequestMethod.POST)
	public String memInputPost(MemberVO vo) {
		// 아이디 중복체크
		if(memberService.getIdCheck(vo.getMid())!=null) {
			msgFlag = "memIdCheckNo";
			return "redirect:/msg/" + msgFlag;
		}
		
		// 닉네임 중복체크
		if(memberService.getNickNameCheck(vo.getNickName())!=null) {
			msgFlag = "memNickNameCheckNo";
			return "redirect:/msg/" + msgFlag;
		}
		
		// 비밀번호암호화 처리
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// DB에 가입회원등록하기
		int res = memberService.setMemInput(vo);
		
		if(res==1) msgFlag = "memInputOk";
		else msgFlag = "memInputNo";
		
		return "redirect:/msg/" + msgFlag;
	}
	
	//회원 아이디 검색
	@ResponseBody
	@RequestMapping(value="/idCheck", method = RequestMethod.POST)
	public String idCheckPost(String mid) {
		String res = "0";
		MemberVO vo = memberService.getIdCheck(mid);
		if(vo!=null) res="1";
		return res;
	}
	
	// 회원 닉네임 검색
	@ResponseBody
	@RequestMapping(value="/nickNameCheck", method = RequestMethod.POST)
	public String nickNameCheckPost(String nickName) {
		String res = "0";
		MemberVO vo = memberService.getNickNameCheck(nickName);
		if(vo!=null) res="1";
		return res;
	}	
	
	@RequestMapping(value="/memPwdCheck", method = RequestMethod.GET)
	public String memPwdCheckGet() {
		return "member/memPwdCheck";
	}
	
	// 비밀번호체크... 수정 폼 부를때
	@RequestMapping(value="/memPwdCheck", method = RequestMethod.POST)
	public String memPwdCheckPost(String pwd, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getIdCheck(mid);
		if(vo!=null && passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sPwd", pwd);
			model.addAttribute("vo", vo);
			return "member/memUpdate";
		}
		else {
			msgFlag = "pwdCheckNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	
	//회원정보변경 폼 불러오기
	@RequestMapping(value="/memUpdate", method = RequestMethod.GET)
	public String memUpdateGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getIdCheck(mid);
		model.addAttribute("vo", vo);
		return "member/memUpdate";
	}
	
	// 회원정보변경
	@RequestMapping(value="/memUpdate", method = RequestMethod.POST)
	public String memUpdatePost(MemberVO vo, HttpSession session) {
		String nickName = (String) session.getAttribute("sNickName");
		
		// 닉네임 중복체크(닉네임이 변경되었으면 새로 닉네임등록)
		if(!nickName.equals(vo.getNickName())) {
			if(memberService.getNickNameCheck(vo.getNickName())!=null) {
				msgFlag = "memNickNameCheckNo";
				return "redirect:/msg/" + msgFlag;
			}
			else {
				session.setAttribute("sNickName", vo.getNickName());
			}
		}
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemUpdate(vo);
		
		if(res == 1) {
			msgFlag = "memUpdateOk";
		}
		else {
			msgFlag = "memUpdateNo";
		}
		return "redirect:/msg/" + msgFlag;
	}
	
	@RequestMapping(value="/memDelete", method = RequestMethod.GET)
	public String memDeleteGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		memberService.setMemDelete(mid);
		msgFlag = "memDeleteOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	//비밀번호 찾기 폼
	@RequestMapping(value="/pwdConfirm", method = RequestMethod.GET)
	public String pwdConfirmGet() {
		return "member/pwdConfirm";
	}
	
	//임시비밀번호발급(메일로 보낼 준비)
	@RequestMapping(value="/pwdConfirm", method = RequestMethod.POST)
	public String pwdConfirmPost(String mid, String toMail) {
		MemberVO vo = memberService.getPwdConfirm(mid, toMail);
		//System.out.println("vo : " + vo);
		if(vo!=null) {
			// 임시비밀번호만들기
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8); 
			memberService.setPwdChange(mid, passwordEncoder.encode(pwd));
			String content = pwd;
			return "redirect:/mail/pwdConfirmSend/"+toMail+"/"+content+"/";
		}
		else {
			msgFlag = "pwdConfirmNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	
	// 아이디 찾기 폼
	@RequestMapping(value="/idConfirm", method = RequestMethod.GET)
	public String idConfirmGet() {
		return "member/idConfirm";
	}
	
	// 메일주소와 맞는 아이디를 찾아서 리스트로 출력(여러건일수도있으니까)
	@RequestMapping(value="/idConfirm", method = RequestMethod.POST)
	public String idConfirmPost(String toMail, Model model) {
		ArrayList<MemberVO> vos = memberService.getIdConfirm(toMail);
		if(vos.size() != 0) {
			model.addAttribute("vos", vos);
			return "member/idSearchList";
		}
		else {
			msgFlag = "idConfirmNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	
}
