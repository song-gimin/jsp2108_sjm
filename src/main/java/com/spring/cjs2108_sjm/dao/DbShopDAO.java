package com.spring.cjs2108_sjm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_sjm.vo.CategoryMiddleVO;
import com.spring.cjs2108_sjm.vo.DbBaesongVO;
import com.spring.cjs2108_sjm.vo.DbCartListVO;
import com.spring.cjs2108_sjm.vo.DbOptionVO;
import com.spring.cjs2108_sjm.vo.DbOrderVO;
import com.spring.cjs2108_sjm.vo.DbProductVO;

public interface DbShopDAO {

	public List<CategoryMiddleVO> getCategoryMain();

	public List<CategoryMiddleVO> getCategoryMiddle();

	public CategoryMiddleVO getCategoryMainOne(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMainName") String categoryMainName);

	public List<CategoryMiddleVO> getCategoryMiddleOne(@Param("vo") CategoryMiddleVO vo);
	
	public List<CategoryMiddleVO> getDelCategoryMiddleOne(@Param("vo") CategoryMiddleVO vo);

	public List<DbProductVO> getDbProductOne(@Param("categoryMiddleCode") String categoryMiddleCode);
	
	public void categoryMainInput(@Param("vo") CategoryMiddleVO vo);
	
	public void categoryMiddleInput(@Param("vo") CategoryMiddleVO vo);
	
	public void delCategoryMain(@Param("categoryMainCode") String categoryMainCode);
	
	public void delCategoryMiddle(@Param("categoryMiddleCode") String categoryMiddleCode);

	public List<CategoryMiddleVO> getCategoryMiddleName(@Param("categoryMainCode") String categoryMainCode);

	public void setDbProductInput(@Param("vo") DbProductVO vo);

	public DbProductVO getProductMaxIdx();

	public String[] getProductName();

	public void setDbOptionInput(@Param("vo") DbOptionVO vo);

	public List<DbProductVO> getProductInfor(@Param("productName") String productName);

	public List<DbProductVO> getMiddleTitle();

	public List<DbProductVO> getDbShopList(@Param("part") String part);

	public DbProductVO getDbShopProduct(@Param("idx") int idx);

	public List<DbOptionVO> getDbShopOption(@Param("idx") int idx);

	public DbCartListVO dbCartListProductOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName);

	public void dbShopCartUpdate(@Param("vo") DbCartListVO vo);

	public void dbShopCartInput(@Param("vo") DbCartListVO vo);

	public List<DbCartListVO> getDbCartList(@Param("mid") String mid);

	public void dbCartDel(@Param("idx") int idx);

	public DbCartListVO getCartIdx(@Param("idx") String idx);

	public DbOrderVO getOrderMaxIdx();

	public void setDbOrder(@Param("vo") DbOrderVO vo);

	public void delDbCartList(@Param("cartIdx") int cartIdx);

	public void setDbBaesong(@Param("bVo") DbBaesongVO bVo);

	public List<DbBaesongVO> getBaesong(@Param("mid") String mid);

	public int getOrderOIdx(@Param("orderIdx") String orderIdx);

	public List<DbBaesongVO> getOrderBaesong(@Param("orderIdx") String orderIdx);

	public int totRecCnt(@Param("mid") String mid);

	public List<DbOrderVO> getDbMyOrder(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public List<DbBaesongVO> getOrderStatus(@Param("mid") String mid, @Param("orderStatus") String orderStatus);

	public int totRecCntStatus(@Param("mid") String mid, @Param("orderStatus") String orderStatus);

	public void setMemberPointPlus(@Param("point") int point, @Param("mid") String mid);

	public int totRecCntOrderCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate);

	public List<DbBaesongVO> orderCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate);

	public List<DbBaesongVO> adminOrderStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public void setOrderStatusUpdate(@Param("orderStatus") String orderStatus, @Param("orderIdx") String orderIdx);

	public int totRecCntAdminStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public List<DbBaesongVO> getOrderAdminStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

}
