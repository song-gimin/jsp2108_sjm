package com.spring.cjs2108_sjm.vo;

import lombok.Data;

@Data
public class DbProductVO {
	private int idx;
	private String productCode;
	private String productName;
	private String detail;
	private String mainPrice;
	private String fName;
	private String fSName;
	private String content;
	/*
	 * private String disPrice;
	 */	
	private String categoryMainCode;
	private String categoryMainName;
	private String categoryMiddleCode;
	private String categoryMiddleName;
	
	private String mainKey;
	private String middleTitle;
}
