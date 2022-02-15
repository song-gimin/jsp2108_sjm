package com.spring.cjs2108_sjm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_sjm.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getIdCheck(@Param("mid") String mid);

	public void setLastDateUpdate(@Param("mid") String mid, @Param("newPoint") int newPoint, @Param("todayCnt") int todayCnt);

	public MemberVO getNickNameCheck(@Param("nickName") String nickName);

	public int setMemInput(@Param("vo") MemberVO vo);

	public int setMemUpdate(@Param("vo") MemberVO vo);

	public void setMemDelete(@Param("mid") String mid);

	public MemberVO getPwdConfirm(@Param("mid") String mid, @Param("toMail") String toMail);

	public void setPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	public ArrayList<MemberVO> getIdConfirm(@Param("toMail") String toMail);

}
