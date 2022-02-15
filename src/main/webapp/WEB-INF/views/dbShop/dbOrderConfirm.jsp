<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>주문정보확인</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" rel="stylesheet">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <%-- <link rel="stylesheet" href="${ctp}/css/cart.css?after"> --%>
  <script>
	  function nWin(orderIdx) {
	  	var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
	  	window.open(url,"dbOrderBaesong","width=600px,height=400px");
	  }
  </script>
  <style>
  	a:link {color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black; text-decoration: none;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr/>
<p><br/></p><br/>
<div class="container">
  <h2 class="text-center"><i class="far fa-check-circle"></i>&nbsp;고객님의 <b>주문이 완료</b>되었습니다.</h2>
  <p><br/></p>
  <table class="table table-bordered" style="width: 50%; margin-left: auto; margin-right: auto;">
    <c:forEach var="vo" items="${vos}">
	    <tr>
	      <th style="text-align: center; background-color: aliceblue; width: 30%;">주문번호</th>
	    	<td>
	    		<p><b>${vo.orderIdx}</b>&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn btn-outline-info btn-sm" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>	
	    	</td>
	    </tr>
	    <tr>
	      <th style="text-align: center; background-color: aliceblue; width: 30%;">주문상품</th>
	      <td>
	        <p style="color:navy;font-weight:bold;">${vo.productName}</p>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p style="font-size:0.9em;">
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach> 
	        </p>
	      </td>
	    </tr>
	    <tr>
	    	<th style="text-align: center; background-color: aliceblue; width: 30%;">주문금액</th>
	      <td>
	      	<p><fmt:formatNumber value="${vo.totalPrice}"/>원</p>
	      </td>
	    </tr>
	    <tr>
	    	<th style="text-align: center; background-color: aliceblue; width: 30%;">주문상태</th>
	      <td>결제완료&nbsp;(배송준비중)</td>
	    </tr>
    </c:forEach>
  </table>
  <p><br/></p>
  <p class="text-center">
  	<a href="${ctp}/" class="btn btn btn-outline-secondary btn-light" style="width:300px;">쇼핑계속하기</a>
  </p>
	<p><br/></p>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>