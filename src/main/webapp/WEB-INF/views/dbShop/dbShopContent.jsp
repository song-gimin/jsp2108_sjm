<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품상세페이지</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
    var idxArray = new Array();
  
    $(function(){
    	$("#selectOption").change(function(){						
    		var selectOption = $(this).val();							
    		var idx = selectOption.substring(0,selectOption.indexOf(":")); 																	// 현재 옵션의 고유번호(기본품목은 0으로 처리한다)
    		var optionName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_")); // 옵션명
    		var optionPrice = selectOption.substring(selectOption.indexOf("_")+1); 													// 옵션가격
    		var commaPrice = numberWithCommas(optionPrice);																									// 콤마붙인 가격
    		
    		if($("#layer"+idx).length == 0 && selectOption != "") {
    		  idxArray[idx] = idx;		// 옵션을 선택한 개수만큼 배열의 크기로 잡는다.
    		  
	    		var str = "";
	    		str += "<div class='layer row' id='layer"+idx+"'><div class='col'>"+optionName+"</div>";
	    		str += "<input type='number' class='numBox' id='numBox"+idx+"' name='optionNum' onchange='numChange("+idx+")' value='1' min='1'/> &nbsp;";
	    		str += "<input type='text' id='imsiPrice"+idx+"' class='price' value='"+commaPrice+"' readonly />";
	    		str += "<input type='hidden' id='price"+idx+"' class='price' value='"+optionPrice+"'/>&nbsp;";
	    		str += "<input type='button' class='btn btn-outline-secondary btn-sm' onclick='remove("+idx+")' value='X'/>";
	    		str += "<input type='hidden' name='statePrice' id='statePrice"+idx+"' value='"+optionPrice+"'/>";
	    		str += "<input type='hidden' name='optionIdx' value='"+idx+"'/>";
	    		str += "<input type='hidden' name='optionName' value='"+optionName+"'/>";
	    		str += "<input type='hidden' name='optionPrice' value='"+optionPrice+"'/>";
	    		str += "</div>";
	    		$("#product1").append(str);
	    		onTotal();
    	  }
    	  else {
    		  alert("이미 선택한 옵션입니다.");
    	  }
    	});
    });
    
    // 등록(추가)시킨 옵션 상품 삭제하기
    function remove(idx) {
  	  $("div").remove("#layer"+idx);
  	  onTotal();
    }
    
    // 상품의 총 금액 (재)계산하기
    function onTotal() {
  	  var total = 0;
  	  for(var i=0; i<idxArray.length; i++) {
  		  if($("#layer"+idxArray[i]).length != 0) {
  		  	total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
  		  	document.getElementById("totalPriceResult").value = total;
  		  }
  	  }
  	  document.getElementById("totalPrice").value = numberWithCommas(total);
    }
    
    // 수량 변경시 처리하는 함수
    function numChange(idx) {
    	var price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
    	document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);
    	document.getElementById("price"+idx).value = price;
    	onTotal();
    }
    
    // 장바구니 호출시 수행함수
    function cart() {
    	if(document.getElementById("totalPrice").value==0) {
    		alert("옵션을 선택해주세요.");
    		return false;
    	}
    	else {
    		var ans = confirm("장바구니로 이동하시겠습니까?");
    		if(!ans) {
    			return false;
    		}
    		else {
    			document.myform.action = "${ctp}/dbShop/dbShopContent";
	    		document.myform.submit();
    		}
    	}
    }
    
    // 직접 주문하기
    function order(mid) {
    	if(mid == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${ctp}/member/mLogin";
    	}
    	else if(document.getElementById("totalPrice").value=="" || document.getElementById("totalPrice").value==0) {
    		alert("옵션을 선택해주세요.");
    		return false;
    	}
    	else {
    		/* document.myform.action = "${ctp}/dbShop/dbOrder"; */
    		document.myform.submit();
    	}
    }
    
    // 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
  </script>
	<style>
  	a:link {color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black; text-decoration: none;}
    
    .layer  {
    	border:0px;
      padding:13px;
      margin-left:1px;
      background-color:aliceblue;
      font-size:15px;
    }
    
    .numBox {width:50px}
    
    .price  {
      width:160px;
      background-color:aliceblue;
      text-align:right;
      font-size:1.2em;
      border:0px;
      outline: none;
    }
    
    .totalPrice {
      text-align:right;
      margin-right:10px;
      color:#006;
      font-size:1.5em;
      font-weight: bold;
      border:0px;
      outline: none;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<hr/>
<p><br></p>
<div class="container">
  <div class="row">
  	<div class="col p-4 text-center">
  		<!-- 상품메인이미지 들어가는 부분 -->
  		<div><img src="${ctp}/dbShop/${productVo.FSName}" width="100%"/></div>
  	</div>
  	<div class="container col text-left">
  		<!-- 상품기본정보 -->
  		<div id="itemInfor">
  			<h4><b>${productVo.productName}</b></h4>
  			<p><font size="2.5">${productVo.detail}</font></p>
  		<hr/>
				<p><b>판매가</b></p>
				<p class="text-right"><font size="4"><b><fmt:formatNumber value="${productVo.mainPrice}"/> 원</b></font></p>
			</div>
  		<%-- <h5>배송비 <fmt:formatNumber value=""/>원</h5> --%>
  		<hr/>
  		<!-- 옵션출력 -->
			<p>상품선택</p>
  		<div class="form-group select_box">
  			<form name="optionForm">  <!-- 옵션의 정보를 보여주기 위한 폼 -->
		      <select size="1" class="form-control" id="selectOption">
		        <option value="" disabled selected>상품선택</option>
		        <option value="0:${productVo.productName}_${productVo.mainPrice}">${productVo.productName}</option>
		        <c:forEach var="vo" items="${optionVos}">
		          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
		        </c:forEach>
		      </select>
		    </form>
		  </div>
		  <form name="myform" method="post">  <!-- 실제 상품의 정보를 넘겨주기 위한 폼 -->
		    <input type="hidden" name="mid" value="${sMid}"/>
		    <input type="hidden" name="productIdx" value="${productVo.idx}"/>
		    <input type="hidden" name="productName" value="${productVo.productName}"/>
		    <input type="hidden" name="mainPrice" value="${productVo.mainPrice}"/>
		    <input type="hidden" name="thumbImg" value="${productVo.FSName}"/>
		    <input type="hidden" name="totalPrice" id="totalPriceResult"/>
		    <div id="product1"></div>
		  </form>
		  <br/>
  		<!-- 상품의 총가격 출력(옵션포함) -->
  		<div class="product2">
  			<p><b>상품합계금액</b></p>
		    <p align="right">
	        <b><input type="text" class="totalPrice text-right" id="totalPrice" value="<fmt:formatNumber value='0'/>" readonly />원</b>
		    </p>
  		</div>
  		<hr/><br/>
  		<!-- 결제하기/장바구니 -->
  		<div style="text-align: center;">
		    <input type="button" value="결제하기" class="btn btn-primary" style="width:150px;" onclick="order()">&nbsp;
  			<input type="button" value="장바구니" class="btn btn-light" style="width:150px;" onclick="cart()">
  		</div>
  	</div>
  </div>
  <p><br/></p>
  <hr color="black"/>
  <!-- 상품상세설명 -->
  <div id="content" class="container tab-pane active"><br/>
  	<div class="next text-center">
  		${productVo.content}
  	</div>
  </div>
  <hr/>
  <br/>
  <h4><b>상품후기</b></h4>
	<hr color="black"/>
	<br/>
	<hr/>
	<br/>
  <h4><b>상품Q&A</b></h4>
	<hr color="black"/>
	<div style="text-align: center;"><br/>
  	<a href="${ctp}/board/boardList" class="btn btn-light btn-outline-dark btn-sm">문의하기</a>
	</div>
	<br/>
	<hr/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>