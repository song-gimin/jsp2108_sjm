package com.spring.cjs2108_sjm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.cjs2108_sjm.service.DbShopService;
import com.spring.cjs2108_sjm.service.MenuService;
import com.spring.cjs2108_sjm.vo.DbProductVO;

@Controller
@RequestMapping("/menu")
public class MenuController {
	String msgFlag = "";
	
	@Autowired
	MenuService menuService;
	
	@Autowired
	DbShopService dbShopService;
	
	@RequestMapping(value="/mainMenu")
	public String mainMenuGet(Model model, String mainKey, String mainTitle) {
		List<DbProductVO> vos = menuService.getMainMenu(mainKey);
		model.addAttribute("vos", vos);
		model.addAttribute("mainTitle", mainTitle);
		
		return "dbShop/dbShopList";
	}
	
	@RequestMapping(value="/middleMenu")
	public String middleMenuGet(Model model, String middleKey, String middleTitle) {
		List<DbProductVO> vos = menuService.getMiddleMenu(middleKey);
		model.addAttribute("vos", vos);
		model.addAttribute("middleTitle", middleTitle);
		
		return "dbShop/dbShopList";
	}
	
	
	
}
