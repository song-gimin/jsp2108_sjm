package com.spring.cjs2108_sjm.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_sjm.vo.CategoryMiddleVO;
import com.spring.cjs2108_sjm.vo.DbBaesongVO;
import com.spring.cjs2108_sjm.vo.DbCartListVO;
import com.spring.cjs2108_sjm.vo.DbOptionVO;
import com.spring.cjs2108_sjm.vo.DbOrderVO;
import com.spring.cjs2108_sjm.vo.DbProductVO;

public interface DbShopService {

	public List<CategoryMiddleVO> getCategoryMain();

	public List<CategoryMiddleVO> getCategoryMiddle();

	public CategoryMiddleVO getCategoryMainOne(String categoryMainCode, String categoryMainName);

	public List<CategoryMiddleVO> getCategoryMiddleOne(CategoryMiddleVO vo);

	public List<CategoryMiddleVO> getDelCategoryMiddleOne(CategoryMiddleVO vo);

	public List<DbProductVO> getDbProductOne(String categoryMiddleCode);
	
	public void categoryMainInput(CategoryMiddleVO vo);
	
	public void categoryMiddleInput(CategoryMiddleVO vo);

	public void delCategoryMain(String categoryMainCode);
	
	public void delCategoryMiddle(String categoryMiddleCode);

	public List<CategoryMiddleVO> getCategoryMiddleName(String categoryMainCode);

	public void imgCheckProductInput(MultipartFile file, DbProductVO vo);

	public String[] getProductName();

	public void setDbOptionInput(DbOptionVO vo);

	public List<DbProductVO> getProductInfor(String productName);

	public List<DbProductVO> getMiddleTitle();

	public List<DbProductVO> getDbShopList(String part);

	public DbProductVO getDbShopProduct(int idx);

	public List<DbOptionVO> getDbShopOption(int idx);

	public DbCartListVO dbCartListProductOptionSearch(String productName, String optionName);

	public void dbShopCartUpdate(DbCartListVO vo);

	public void dbShopCartInput(DbCartListVO vo);

	public List<DbCartListVO> getDbCartList(String mid);

	public void dbCartDel(int idx);

	public DbCartListVO getCartIdx(String idx);

	public DbOrderVO getOrderMaxIdx();

	public void setDbOrder(DbOrderVO vo);

	public void delDbCartList(int cartIdx);

	public void setDbBaesong(DbBaesongVO bVo);

	public List<DbBaesongVO> getBaesong(String mid);

	public int getOrderOIdx(String orderIdx);

	public List<DbBaesongVO> getOrderBaesong(String orderIdx);

	public int totRecCnt(String mid);

	public List<DbOrderVO> getDbMyOrder(int startIndexNo, int pageSize, String mid);

	public List<DbBaesongVO> getOrderStatus(String mid, String orderStatus);

	public int totRecCntStatus(String mid, String orderStatus);

	public void setMemberPointPlus(int point, String mid);

	public int totRecCntOrderCondition(String mid, int conditionDate);

	public List<DbBaesongVO> orderCondition(String mid, int conditionDate);

	public List<DbBaesongVO> adminOrderStatus(String startJumun, String endJumun, String orderStatus);

	public void setOrderStatusUpdate(String orderStatus, String orderIdx);

	public int totRecCntAdminStatus(String startJumun, String endJumun, String orderStatus);

	public List<DbBaesongVO> getOrderAdminStatus(String startJumun, String endJumun, String orderStatus);

}
