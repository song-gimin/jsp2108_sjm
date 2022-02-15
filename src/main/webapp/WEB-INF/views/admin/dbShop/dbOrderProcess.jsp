<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>주문관리</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    $(document).ready(function() {
<%
      String startJumun = request.getParameter("startJumun")==null ? "" : request.getParameter("startJumun");
      String endJumun = request.getParameter("endJumun")==null ? "" : request.getParameter("endJumun");
      //System.out.println("startJumun : " + startJumun);
%>
<%		if(startJumun.equals("")) { %>
		    document.getElementById("startJumun").value = new Date().toISOString().substring(0,10);
		    document.getElementById("endJumun").value = new Date().toISOString().substring(0,10);
<%    } else { %>
		    document.getElementById("startJumun").value = new Date('<%=startJumun%>').toISOString().substring(0,10);
		    document.getElementById("endJumun").value = new Date('<%=endJumun%>').toISOString().substring(0,10);
<%    } %>
    });
  
    function nWin(orderIdx) {
    	var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
    	window.open(url,"dbOrderBaesong","width=600px,height=400px");
    }
    
    $(document).ready(function() {
    	// 주문/배송일자 조회
    	$("#orderStatus").change(function() {
	    	var startJumun = document.getElementById("startJumun").value;
	    	var endJumun = document.getElementById("endJumun").value;
	    	var orderStatus = $(this).val();
	    	location.href="${ctp}/dbShop/adminOrderStatus?startJumun="+startJumun+"&endJumun="+endJumun+"&orderStatus="+orderStatus;
    	});
    	
    	// 주문상태조회
    	$("#orderDateSearch").click(function() {
	    	var startJumun = document.getElementById("startJumun").value;
	    	var endJumun = document.getElementById("endJumun").value;
	    	var orderStatus = $(this).val();
	    	location.href="${ctp}/dbShop/adminOrderStatus?startJumun="+startJumun+"&endJumun="+endJumun+"&orderStatus="+orderStatus;
    	});
    });
    
    function orderProcess(orderIdx, orderStatus) {
    	var ans = confirm("주문상태("+orderStatus+")를 변경하시겠습니까?");
    	if(!ans) return false;
  		var query = {
  				orderStatus : orderStatus,
  				orderIdx : orderIdx
  		};
  		$.ajax({
  			type  : "post",
  			url   : "${ctp}/dbShop/goodsStatus",
  			data  : query,
  			success : function(data) {
  				location.reload();
  			}
    	});
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
<hr/><hr/><br/>
<c:set var="orderStatus" value="${orderStatus}"/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adMenu.jsp"/>
	<br/>
  <h3 class="text-center">주문/배송 내역</h3>
  <br/>
  <table class="table table-borderless">
    <tr>
      <td>
        <input type="date" name="startJumun" id="startJumun"/> ~<input type="date" name="endJumun" id="endJumun"/>
        <button type="button" id="orderDateSearch" class="btn btn-outline-secondary m-0 p-1">조회</button>
      </td>
      <td align="right">
        <select name="orderStatus" id="orderStatus">
          <option value="전체"       ${orderStatus == '전체'    ? 'selected' : ''}>전체조회</option>
          <option value="결제완료"    ${orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
          <option value="배송중"     ${orderStatus == '배송중'   ? 'selected' : ''}>배송중</option>
          <option value="배송완료"    ${orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
          <option value="구매완료"    ${orderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
          <option value="반품처리"    ${orderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
        </select>
      </td>
    </tr>
  </table>
  <table class="table table-borderless" style="width:100%; border-bottom: 1px solid #ccc; border-top: 1px solid #ccc;">
    <tr class="text-center" style="border-bottom: 1px solid #ccc; background-color: aliceblue">
      <th style="width:10%;">주문일시</th>
      <th style="width:10%;">주문번호</th>
      <th style="width:10%;">주문회원</th>
      <th colspan="2" style="width:50%;">주문내역</th>
      <th style="width:10%;">주문금액</th>
      <th style="width:10%;">주문상태</th>
    </tr>
    <c:forEach var="vo" items="${orderVos}">
      <tr style="border-bottom: 1px solid #ccc;">
      	<td style="text-align: center;">
      		<br/>
      		<p>${fn:substring(vo.orderDate,0,10)}</p>
      	</td>
        <td style="text-align: center;">
        	<br/>
          <p><b>${vo.orderIdx}</b></p>
          <p><input type="button" class="btn btn btn-outline-info btn-sm" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td style="text-align: center;">
        	<br/>
        	<p>${vo.name}</p>
        </td>
        <td style="text-align: center;">
        	<img src="${ctp}/dbShop/${vo.thumbImg}" class="thumb" width="150px"/>
        </td>
        <td align="left">
        	<br/>
	        <p style="color: navy; font-weight: bold;">${vo.productName}n></p>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p style="font-size: 0.8em;">
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	          &nbsp;&nbsp;${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach>
	        </p>
	      </td>
        <td style="text-align: center;">
        	<br/>
          <p><fmt:formatNumber value="${vo.totalPrice}"/>원</p>
        </td>
        <td style="text-align: center;">
        	<br/>
          <button type="button" onclick="orderProcess('${vo.orderIdx}','${vo.orderStatus}')" class="btn btn-info btn-sm">${vo.orderStatus}</button>
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
			    <li class="page-item"><a href="${ctp}/dbShop/dbOrderProcess?pag=1" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbOrderProcess?pag=${(curBlock-1)*blockSize + 1}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			    <c:if test="${i == pag && i <= totPage}">
			      <li class="page-item active"><a href='${ctp}/dbShop/dbOrderProcess?pag=${i}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pag && i <= totPage}">
			      <li class="page-item"><a href='${ctp}/dbShop/dbOrderProcess?pag=${i}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${curBlock < lastBlock}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbOrderProcess?pag=${(curBlock+1)*blockSize + 1}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pag != totPage}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbOrderProcess?pag=${totPage}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
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