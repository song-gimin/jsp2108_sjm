package com.spring.cjs2108_sjm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_sjm.vo.DbProductVO;

public interface MenuDAO {

	public List<DbProductVO> getMainMenu(@Param("mainKey") String mainKey);

	public List<DbProductVO> getMiddleMenu(@Param("middleKey") String middleKey);
	
	
	
}
