package com.spring.cjs2108_sjm.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.cjs2108_sjm.dao.MemberDAO;
import com.spring.cjs2108_sjm.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getIdCheck(String mid) {
		return memberDAO.getIdCheck(mid);
	}

	@Override
	public void getMemberTodayProcess(int todayCnt) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		String lastDate = (String) session.getAttribute("sLastDate");	
		
	  // 오늘 방문횟수 5회까지만 포인트 10점을 누적처리
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strToday = sdf.format(today);
		
		int newPoint = 0;		
		if(lastDate.substring(0, 10).equals(strToday)) {
			if(todayCnt >= 5) newPoint = 0; 
			else	newPoint = 10;
			todayCnt += 1;	
		}
		else {	
			todayCnt = 1;
			newPoint = 10;
		}
		memberDAO.setLastDateUpdate(mid, newPoint, todayCnt); 
	}

	@Override
	public MemberVO getNickNameCheck(String nickName) {
		return memberDAO.getNickNameCheck(nickName);
	}

	@Override
	public int setMemInput(MemberVO vo) {
		return memberDAO.setMemInput(vo);
	}

	@Override
	public int setMemUpdate(MemberVO vo) {
		return memberDAO.setMemUpdate(vo);
	}

	@Override
	public void setMemDelete(String mid) {
		memberDAO.setMemDelete(mid);
	}

	@Override
	public MemberVO getPwdConfirm(String mid, String toMail) {
		return memberDAO.getPwdConfirm(mid, toMail);
	}

	@Override
	public void setPwdChange(String mid, String pwd) {
		memberDAO.setPwdChange(mid, pwd);
	}

	@Override
	public ArrayList<MemberVO> getIdConfirm(String toMail) {
		return memberDAO.getIdConfirm(toMail);
	}
		
	
	
}
