package com.spring.cjs2108_sjm.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_sjm.dao.DbShopDAO;
import com.spring.cjs2108_sjm.vo.CategoryMiddleVO;
import com.spring.cjs2108_sjm.vo.DbBaesongVO;
import com.spring.cjs2108_sjm.vo.DbCartListVO;
import com.spring.cjs2108_sjm.vo.DbOptionVO;
import com.spring.cjs2108_sjm.vo.DbOrderVO;
import com.spring.cjs2108_sjm.vo.DbProductVO;

@Service
public class DbShopServiceImpl implements DbShopService {
	@Autowired
	DbShopDAO dbShopDAO;

	@Override
	public List<CategoryMiddleVO> getCategoryMain() {
		return dbShopDAO.getCategoryMain();
	}

	@Override
	public List<CategoryMiddleVO> getCategoryMiddle() {
		return dbShopDAO.getCategoryMiddle();
	}

	@Override
	public CategoryMiddleVO getCategoryMainOne(String categoryMainCode, String categoryMainName) {
		return dbShopDAO.getCategoryMainOne(categoryMainCode, categoryMainName);
	}

	@Override
	public List<CategoryMiddleVO> getCategoryMiddleOne(CategoryMiddleVO vo) {
		return dbShopDAO.getCategoryMiddleOne(vo);
	}
	
	@Override
	public List<CategoryMiddleVO> getDelCategoryMiddleOne(CategoryMiddleVO vo) {
		return dbShopDAO.getDelCategoryMiddleOne(vo);
	}
	
	@Override
	public List<DbProductVO> getDbProductOne(String categoryMiddleCode) {
		return dbShopDAO.getDbProductOne(categoryMiddleCode);
	}
	
	@Override
	public void categoryMainInput(CategoryMiddleVO vo) {
		dbShopDAO.categoryMainInput(vo);
	}
	
	@Override
	public void categoryMiddleInput(CategoryMiddleVO vo) {
		dbShopDAO.categoryMiddleInput(vo);
	}
	
	@Override
	public void delCategoryMain(String categoryMainCode) {
		dbShopDAO.delCategoryMain(categoryMainCode);
	}
	
	@Override
	public void delCategoryMiddle(String categoryMiddleCode) {
		dbShopDAO.delCategoryMiddle(categoryMiddleCode);
	}

	@Override
	public List<CategoryMiddleVO> getCategoryMiddleName(String categoryMainCode) {
		return dbShopDAO.getCategoryMiddleName(categoryMainCode);
	}

	@SuppressWarnings("deprecation")
	@Override
	public void imgCheckProductInput(MultipartFile file, DbProductVO vo) {
		// ?????? ????????????????????? 'dbShop/product'????????? ????????? ????????????.
		try {
			String originalFilename = file.getOriginalFilename();
			if(originalFilename != "" && originalFilename != null) {
				// ?????? ??????????????? ??????????????????????????? ???????????????????????? ???????????????
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			  String saveFileName = sdf.format(date) + "_" + originalFilename;
				writeFile(file, saveFileName);	  // ?????? ???????????? ????????? ????????? ???????????? ????????? ??????
				vo.setFName(originalFilename);		// ???????????? ???????????? fName??? ??????
				vo.setFSName(saveFileName);				// ????????? ????????? ???????????? vo??? set????????????.
			}
			else {
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//             0         1         2         3         4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_sjm/data/dbShop/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_sjm/data/dbShop/product/211229124318_4.jpg"
		
		// ckeditor??? ???????????? ?????? ????????? ????????????????????? ????????? ???????????? ????????? ????????? dbShop/product????????? ?????????????????? ????????????.
		String content = vo.getContent();
		if(content.indexOf("src=\"/") == -1) return;		// content????????? ????????? ????????? ????????? ????????????.
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/dbShop/");
		
		int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile;	// ?????? ????????? ???????????? '?????????+?????????'
			
			copyFilePath = uploadPath + "product/" + imgFile;	// ????????? ??? '?????????+?????????'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// ??????????????? ????????? ????????? ???????????????????????? ?????????
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		// ????????? ??????????????? ???????????? ????????? ????????? 'dbShop/product'???????????? vo??? set???????????? ??????.
		vo.setContent(vo.getContent().replace("/data/dbShop/", "/data/dbShop/product/"));

		// ?????? ??????????????? ?????? ????????? vo??? ??????????????? ????????? ????????? DB??? ????????????.
		// ?????? productCode??? ??????????????? ?????? ???????????? ????????? dbProduct???????????? idx????????? ???????????? ????????????. ????????? 0?????? ????????????.
		int maxIdx = 0;
		DbProductVO maxVo = dbShopDAO.getProductMaxIdx();
		if(maxVo != null) maxIdx = maxVo.getIdx();
		vo.setProductCode(vo.getCategoryMainCode()+vo.getCategoryMiddleCode()+maxIdx);
		dbShopDAO.setDbProductInput(vo);
	}
	
  // ?????? ??????(dbShop??????)??? 'dbShop/product'????????? ?????????????????????
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream  fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// ?????? ?????? ????????? ????????? ????????????
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/product/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public String[] getProductName() {
		return dbShopDAO.getProductName();
	}

	@Override
	public void setDbOptionInput(DbOptionVO vo) {
		System.out.println("vo : " + vo);
		dbShopDAO.setDbOptionInput(vo);
	}

	@Override
	public List<DbProductVO> getProductInfor(String productName) {
		return dbShopDAO.getProductInfor(productName);
	}

	@Override
	public List<DbProductVO> getMiddleTitle() {
		return dbShopDAO.getMiddleTitle();
	}

	@Override
	public List<DbProductVO> getDbShopList(String part) {
		return dbShopDAO.getDbShopList(part);
	}

	@Override
	public DbProductVO getDbShopProduct(int idx) {
		return dbShopDAO.getDbShopProduct(idx);
	}

	@Override
	public List<DbOptionVO> getDbShopOption(int idx) {
		return dbShopDAO.getDbShopOption(idx);
	}

	@Override
	public DbCartListVO dbCartListProductOptionSearch(String productName, String optionName) {
		return dbShopDAO.dbCartListProductOptionSearch(productName, optionName);
	}

	@Override
	public void dbShopCartUpdate(DbCartListVO vo) {
		dbShopDAO.dbShopCartUpdate(vo);
	}

	@Override
	public void dbShopCartInput(DbCartListVO vo) {
		dbShopDAO.dbShopCartInput(vo);
	}

	@Override
	public List<DbCartListVO> getDbCartList(String mid) {
		return dbShopDAO.getDbCartList(mid);
	}

	@Override
	public void dbCartDel(int idx) {
		dbShopDAO.dbCartDel(idx);
	}

	@Override
	public DbCartListVO getCartIdx(String idx) {
		return dbShopDAO.getCartIdx(idx);
	}

	@Override
	public DbOrderVO getOrderMaxIdx() {
		return dbShopDAO.getOrderMaxIdx();
	}

	@Override
	public void setDbOrder(DbOrderVO vo) {
		dbShopDAO.setDbOrder(vo);
	}

	@Override
	public void delDbCartList(int cartIdx) {
		dbShopDAO.delDbCartList(cartIdx);
	}

	@Override
	public void setDbBaesong(DbBaesongVO bVo) {
		//System.out.println("bVo : " + bVo);
		dbShopDAO.setDbBaesong(bVo);
	}

	@Override
	public List<DbBaesongVO> getBaesong(String mid) {
		return dbShopDAO.getBaesong(mid);
	}

	@Override
	public int getOrderOIdx(String orderIdx) {
		return dbShopDAO.getOrderOIdx(orderIdx);
	}

	@Override
	public List<DbBaesongVO> getOrderBaesong(String orderIdx) {
		return dbShopDAO.getOrderBaesong(orderIdx);
	}

	@Override
	public int totRecCnt(String mid) {
		return dbShopDAO.totRecCnt(mid);
	}

	@Override
	public List<DbOrderVO> getDbMyOrder(int startIndexNo, int pageSize, String mid) {
		return dbShopDAO.getDbMyOrder(startIndexNo, pageSize, mid);
	}

	@Override
	public List<DbBaesongVO> getOrderStatus(String mid, String orderStatus) {
		return dbShopDAO.getOrderStatus(mid, orderStatus);
	}

	@Override
	public int totRecCntStatus(String mid, String orderStatus) {
		return dbShopDAO.totRecCntStatus(mid, orderStatus);
	}

	@Override
	public void setMemberPointPlus(int point, String mid) {
		dbShopDAO.setMemberPointPlus(point, mid);
	}

	@Override
	public int totRecCntOrderCondition(String mid, int conditionDate) {
		return dbShopDAO.totRecCntOrderCondition(mid, conditionDate);
	}

	@Override
	public List<DbBaesongVO> orderCondition(String mid, int conditionDate) {
		return dbShopDAO.orderCondition(mid, conditionDate);
	}

	@Override
	public List<DbBaesongVO> adminOrderStatus(String startJumun, String endJumun, String orderStatus) {
		return dbShopDAO.adminOrderStatus(startJumun, endJumun, orderStatus);
	}

	@Override
	public void setOrderStatusUpdate(String orderStatus, String orderIdx) {
		switch(orderStatus) {
			case "????????????": orderStatus = "?????????"; break;
			case "?????????": orderStatus = "????????????"; break;
			case "????????????": orderStatus = "????????????"; break;
			default : orderStatus = "????????????";
		}
		dbShopDAO.setOrderStatusUpdate(orderStatus, orderIdx);
	}

	@Override
	public int totRecCntAdminStatus(String startJumun, String endJumun, String orderStatus) {
		return dbShopDAO.totRecCntAdminStatus(startJumun, endJumun, orderStatus);
	}

	@Override
	public List<DbBaesongVO> getOrderAdminStatus(String startJumun, String endJumun, String orderStatus) {
		return dbShopDAO.getOrderAdminStatus(startJumun, endJumun, orderStatus);
	}

}