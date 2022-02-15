<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
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
<hr/><hr/>
<p><br/></p><p><br/></p>
<div class="container">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container" style="padding: 30px;">
				<h2 class="text-center"><b>LOGIN</b></h2>
				<hr/>
				<form name="myform" method="post" class="was-validated">
				  <div class="form-group">
				    <input type="text" class="form-control" id="mid" placeholder="아이디" name="mid" value="${mid}" required autofocus />
				    <div class="valid-feedback">※정확한 아이디를 입력하세요.</div>
				    <div class="invalid-feedback">※아이디는 필수입력사항입니다.</div>
				  </div>
				  <div class="form-group">
				    <input type="password" class="form-control" id="pwd" placeholder="비밀번호" name="pwd" maxlength="9" required />
				    <div class="valid-feedback">※정확한 비밀번호를 입력하세요.</div>
				    <div class="invalid-feedback">※비밀번호는 필수입력사항입니다.</div>
				  </div>
				  <div class="row" style="font-size:12px;">
				  	<span class="col mt-3"><input type="checkbox" name="idCheck" checked/> 아이디 저장</span>
				  	<span class="col mt-3 text-right"><a href="${ctp}/member/idConfirm">아이디찾기</a> | <a href="${ctp}/member/pwdConfirm">비밀번호찾기</a></span>
				  </div>	
					<button type="submit" class="btn btn-dark btn-block btn-lg mt-3">로그인</button>
					<hr/><br/>
					<p class="text-center" style="font-size: 12px;"><b>아직 회원이 아니신가요?</b></p>
					<p class="text-center"><input type="button" value="회원가입" onclick="location.href='${ctp}/member/memInput';"  style="font-size: 12px; width: 300px;" class="btn btn-outline-dark"/></p>
				</form>
			</div>
		</div>
	</div>
</div>
<p><br/></p><p><br/></p><br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>