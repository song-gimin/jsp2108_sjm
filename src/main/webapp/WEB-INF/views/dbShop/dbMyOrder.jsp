<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbMyOrder.jsp(회원 주문확인)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    // 배송지 정보보기
    function nWin(orderIdx) {
    	var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
    	window.open(url,"dbOrderBaesong","width=600px,height=400px");
    }
    
    $(document).ready(function() {
    	// 주문 상태별 조회
    	$("#orderStatus").change(function() {
	    	var orderStatus = $(this).val();
	    	location.href="${ctp}/dbShop/orderStatus?orderStatus="+orderStatus+"&pag=${pag}";
    	});
    });
    
    // 날짜별 주문 조건 조회
    function orderCondition(conditionDate) {
    	location.href="${ctp}/dbShop/orderCondition?conditionDate="+conditionDate+"&pag=${pag}";
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
<hr/><hr/>
<p><br/></p>
<c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
<c:set var="orderStatus" value="${orderStatus}"/>
<div class="container">
  <c:set var="condition" value="전체"/>
  <c:if test="${conditionDate=='1'}"><c:set var="condition" value="오늘"/></c:if>
  <c:if test="${conditionDate=='7'}"><c:set var="condition" value="일주일 이내 "/></c:if>
  <c:if test="${conditionDate=='15'}"><c:set var="condition" value="15일 이내"/></c:if>
  <c:if test="${conditionDate=='30'}"><c:set var="condition" value="1개월 이내"/></c:if>
  <c:if test="${conditionDate=='90'}"><c:set var="condition" value="3개월 이내"/></c:if>
	<font size="6"><b>주문조회</b></font>&nbsp;<font size="4">(${condition})</font>&nbsp;
	<c:choose>
    <c:when test="${conditionDate == '1'}"><c:set var="conditionDate" value="오늘"/></c:when>
    <c:when test="${conditionDate == '7'}"><c:set var="conditionDate" value="일주일 이내"/></c:when>
    <c:when test="${conditionDate == '15'}"><c:set var="conditionDate" value="15일 이내"/></c:when>
    <c:when test="${conditionDate == '30'}"><c:set var="conditionDate" value="1개월 이내"/></c:when>
    <c:when test="${conditionDate == '90'}"><c:set var="conditionDate" value="3개월 이내"/></c:when>
    <c:otherwise><c:set var="conditionDate" value="전체"/></c:otherwise>
  </c:choose>
  <input type="button" class="btn btn-outline-secondary btn-sm" value="전체" onclick="orderCondition(99999)"/>
  <input type="button" class="btn btn-outline-secondary btn-sm" value="오늘" onclick="orderCondition(1)"/>
  <input type="button" class="btn btn-outline-secondary btn-sm" value="일주일이내" onclick="orderCondition(7)"/>
  <input type="button" class="btn btn-outline-secondary btn-sm" value="15일이내" onclick="orderCondition(15)"/>
  <input type="button" class="btn btn-outline-secondary btn-sm" value="1개월이내" onclick="orderCondition(30)"/>
  <input type="button" class="btn btn-outline-secondary btn-sm" value="3개월이내" onclick="orderCondition(90)"/>
  
  <hr color="black"/>
  <p class="text-right">
	  <select name="orderStatus" id="orderStatus">
	    <option value="전체" ${orderStatus == '전체' ? 'selected' : ''}>전체조회</option>
	    <option value="결제완료" ${orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
	    <option value="배송중"  ${orderStatus == '배송중' ? 'selected' : ''}>배송중</option>
	    <option value="배송완료"  ${orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
	    <option value="구매완료"  ${orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
	    <option value="반품처리"  ${orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
	  </select>
	</p>
  <table class="table table-borderless" style="width:100%; border-bottom: 1px solid #ccc; border-top: 1px solid #ccc;">
    <tr class="text-center" style="border-bottom: 1px solid #ccc; background-color: aliceblue">
      <th>주문일시</th>
      <th>주문번호</th>
      <th colspan="2">주문내역</th>
      <th>주문금액</th>
      <th>주문상태</th>
    </tr>
    <c:forEach var="vo" items="${myOrderVos}">
      <tr style="border-bottom: 1px solid #ccc;">
        <td style="text-align:center;">
        	<br/>
          <p>${fn:substring(vo.orderDate,0,10)}</p>
        </td>
        <td style="text-align:center;">
        	<br/>
          <p><b>${vo.orderIdx}</b></p>
          <p><input type="button" class="btn btn btn-outline-info btn-sm" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td style="text-align:center;">
        	<img src="${ctp}/dbShop/${vo.thumbImg}" class="thumb" width="150px"/>
        </td>
        <td align="left">
        	<br/>
	        <p style="color: navy; font-weight: bold;">${vo.productName}</p>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p style="font-size: 0.8em;">
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	          &nbsp; &nbsp;${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach>
	        </p>
	      </td>
        <td style="text-align:center;">
        	<br/>
          <p><fmt:formatNumber value="${vo.totalPrice}"/>원</p>
        </td>
        <td style="text-align:center;">
        	<br/>
          <font color="brown">${vo.orderStatus}</font><br/>
          <c:if test="${vo.orderStatus eq '결제완료'}">(배송준비중)</c:if>
        </td>
      </tr>
    </c:forEach>
  </table>
  <br/>
  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${totPage != 0}">
			  <c:if test="${pag != 1}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=1" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${(curBlock-1)*blockSize + 1}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			    <c:if test="${i == pag && i <= totPage}">
			      <li class="page-item active"><a href='${ctp}/dbShop/dbMyOrder?pag=${i}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pag && i <= totPage}">
			      <li class="page-item"><a href='${ctp}/dbShop/dbMyOrder?pag=${i}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${curBlock < lastBlock}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${(curBlock+1)*blockSize + 1}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pag != totPage}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${totPage}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>