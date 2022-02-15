package com.spring.cjs2108_sjm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_sjm.dao.MenuDAO;
import com.spring.cjs2108_sjm.vo.DbProductVO;

@Service
public class MenuServiceImpl implements MenuService {
	@Autowired
	MenuDAO menuDAO;

	@Override
	public List<DbProductVO> getMainMenu(String mainKey) {
		return menuDAO.getMainMenu(mainKey);
	}

	@Override
	public List<DbProductVO> getMiddleMenu(String middleKey) {
		return menuDAO.getMiddleMenu(middleKey);
	}
	
	
	
}
