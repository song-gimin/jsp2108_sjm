package com.spring.cjs2108_sjm.service;

import java.util.ArrayList;

import com.spring.cjs2108_sjm.vo.MemberVO;

public interface MemberService {
	
	public MemberVO getIdCheck(String mid);

	public void getMemberTodayProcess(int todayCnt);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemInput(MemberVO vo);

	public int setMemUpdate(MemberVO vo);

	public void setMemDelete(String mid);

	public MemberVO getPwdConfirm(String mid, String toMail);

	public void setPwdChange(String mid, String pwd);

	public ArrayList<MemberVO> getIdConfirm(String toMail);

}
