package com.spring.cjs2108_sjm.vo;

import lombok.Data;

@Data
public class DbOptionVO {
	private int idx;
	private int productIdx;
	private String optionName;
	private int optionPrice;
	
	private String productName;  // 옵션이 적용되는 사용자가 선택한 상품명
}
