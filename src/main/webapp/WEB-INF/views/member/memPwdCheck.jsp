<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원정보수정</title>
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
<p><br/></p><p><br/></p><p><br/></p><p><br/></p>
<div class="container text-center">
	<form method="post">
	  <h4><b>※비밀번호를 다시 한번 입력해주세요.※</b></h4>
	  <hr/>
	  <table class="table table-border">
	  	<tr>
	  		<th>비밀번호</th>
	  		<td><input type="password" name="pwd" class="form-control" autofocus required /></td>
	  	</tr>
	  	<tr>
	  		<td colspan="2">
	  			<input type="button" value="돌아가기" class="btn btn-dark" onclick="location.href='${ctp}/';"/> &nbsp;
	  			<input type="submit" value="비밀번호확인" class="btn btn-dark"/> &nbsp;
	  			<input type="reset" value="다시입력"  class="btn btn-dark"/>
	  		</td>
	  	</tr>
	  </table>
  </form>
</div>
<p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>