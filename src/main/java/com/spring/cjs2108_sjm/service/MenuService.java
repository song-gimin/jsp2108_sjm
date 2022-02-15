package com.spring.cjs2108_sjm.service;

import java.util.List;

import com.spring.cjs2108_sjm.vo.DbProductVO;

public interface MenuService {

	public List<DbProductVO> getMainMenu(String mainKey);

	public List<DbProductVO> getMiddleMenu(String middleKey);
	
	
	
}
