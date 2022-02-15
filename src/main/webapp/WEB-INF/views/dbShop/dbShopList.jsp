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
	<title>상품목록</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
  	a:link {color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black; text-decoration: none;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <%-- <h3 class="text-center">${vos[0].categoryMainName} ${vos[0].categoryMiddleName}</h3> --%>
  <h3 class="text-center">${mainTitle} ${middleTitle}</h3>
  <hr color="black"/>
  <div class="row">
	  <c:set var="pCnt" value="0"/>
	  <c:forEach var="vo" items="${vos}" varStatus="st">
	    <c:if test="${pCnt < 4}">
	      <div class="col">
	        <p><a href="${ctp}/dbShop/dbShopContent?idx=${vo.idx}"><img src="${ctp}/data/dbShop/product/${vo.FSName}" width="250px"/></a></p>
	        <p><a href="${ctp}/dbShop/dbShopContent?idx=${vo.idx}"><font size="2.5"><b>${vo.productName}</b></font></a></p>
	       	<p><font size="3" color="navy"><b><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/></b></font><font size="3"><b>원</b></font></p>
	      </div>
	      <c:set var="pCnt" value="${pCnt + 1}"/>
	    </c:if>
	    <c:if test="${pCnt >= 4}">
	      </div><div class="row">
	      <c:set var="pCnt" value="0"/>
			</c:if>
	  </c:forEach>
	  <div class="container text-center"><p><br/></p><p><br/></p>
		  <c:if test="${fn:length(vos) == 0}"><h6><b>상품 준비중입니다.</b></h6></c:if>
	  <p><br/></p><p><br/></p>
	  </div>
  </div>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>