<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>아이디찾기</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  	input:read-only {background-color: lightgray}
  
  	a:link {color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black; text-decoration: none;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr/><hr/>
<p><br/></p><p><br/></p><p><br/></p>
<div class="container text-center">
  <h2><b>검색된 아이디 리스트</b></h2>
  <hr/>
  <p>※ 입력하신 이메일주소(<font color="red">${vos[0].email}</font>)로 검색된 아이디는 아래와 같습니다.</p>
  <hr/>
	<div>
  <c:forEach var="vo" items="${vos}" varStatus="st">
    <c:set var="mid1" value="${fn:substring(vo.mid,0,2)}"/>
    <c:set var="mid2" value="${fn:substring(vo.mid,5,fn:length(vo.mid))}"/>
    <p>${st.count}. <font color="blue">${mid1}***${mid2}</font></p>
  </c:forEach>
  <hr/>
  <p>
  	<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/idConfirm';" class="btn btn-secondary"/> &nbsp;
  	<input type="button" value="로그인창으로이동" onclick="location.href='${ctp}/member/memLogin';" class="btn btn-secondary"/> &nbsp;
  	<input type="button" value="비밀번호찾기" onclick="location.href='${ctp}/member/pwdConfirm';" class="btn btn-secondary"/>
  </p>
	</div>
</div>
<p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>