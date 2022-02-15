<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel"); 
%>
<script>
function back() {
	alert("로그인 후 이용해주세요.");
}
</script>

<div class="text-center"  style="margin: 30px;" >
	<h6 class="text-left">▶송지민 spring 프로젝트</h6>
  <a href="${ctp}/"><img src="${ctp}/images/logo.png"/></a>

  <div class="text-right">
		<c:if test="${empty sLevel}">
			<a href="${ctp}/member/memLogin">로그인 | </a>
			<a href="${ctp}/member/memInput">회원가입 | </a>
			<a href="${ctp}/member/memLogin" onclick="back()">고객센터 | </a>
			<a href="${ctp}/member/memLogin" onclick="back()">주문조회 | </a>
			<a href="${ctp}/member/memLogin" onclick="back()">장바구니</a>
		</c:if>
		<c:if test="${sLevel==1 || sLevel==2 || sLevel==3 || sLevel==4 || sLevel==0}">
			<a href="${ctp}/member/memLogout">로그아웃 | </a>
		</c:if>
		<c:if test="${sLevel == 0}"><a href="${ctp}/admin/adPage">관리자전용</a></c:if>
		<c:if test="${sLevel==1 || sLevel==2 || sLevel==3 || sLevel==4}">
			<a href="${ctp}/member/memPwdCheck">회원정보수정 | </a>
			<a href="${ctp}/board/boardList">고객센터 | </a>
			<a href="${ctp}/dbShop/dbMyOrder">주문조회 | </a>
			<a href="${ctp}/dbShop/dbCartList">장바구니</a>
		</c:if>
		
  </div>
</div>