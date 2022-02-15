<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>비밀번호찾기</title>
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
  <h2><b>비밀번호 찾기</b></h2>
  <hr/>
  <form method="post">
  	<table class="table table-bordered">
  		<tr>
  			<th>아이디</th>
  			<td><input type="text" name="mid" placeholder="아이디를 입력하세요." class="form-control"/></td>
  		</tr>
  		<tr>
  			<th>E-mail</th>
  			<td><input type="text" name="toMail" placeholder="회원가입시 입력한 이메일주소를 입력하세요." class="form-control"/></td>
  		</tr>
  		<tr>
  			<td colspan="2">
  				<button type="button" onclick="location.href='${ctp}/member/memLogin';" class="btn btn-secondary">돌아가기</button> &nbsp;
  				<button type="submit" class="btn btn-secondary">임시비밀번호발급</button> &nbsp;
  				<button type="reset" class="btn btn-secondary">다시입력</button>
  			</td>
  		</tr>
  	</table>
  </form>
</div>
<p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>