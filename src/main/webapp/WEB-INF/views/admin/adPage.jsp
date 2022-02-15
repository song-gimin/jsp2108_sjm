<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자페이지</title>
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
<hr/><hr/><br/>
<div class="container-lg p-3">
<jsp:include page="/WEB-INF/views/include/adMenu.jsp"/>
	<div class="form-group">
	<p><br/></p><p><br/></p><p><br/></p><p><br/></p><br/>
	<p align="center"><b>상위메뉴를 선택해주세요.</b></p>
	</div>
</div>
<p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>