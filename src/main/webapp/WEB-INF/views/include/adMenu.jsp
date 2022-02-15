<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	.dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0;
	}
</style>
<div>
	<h2 style="text-align:center;">관리자 페이지</h2>
	<br/>
</div>
<div>
  <ul class="nav justify-content-center">
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">상품관리<i class="fa fa-caret-down"></i></a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${ctp}/dbShop/dbProductList">상품리스트</a>
        <a class="dropdown-item" href="${ctp}/dbShop/dbProduct">상품등록</a>
        <a class="dropdown-item" href="${ctp}/dbShop/dbOption">상품옵션등록</a>
        <a class="dropdown-item" href="${ctp}/dbShop/dbCategory">상품설정</a>
      </div>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/dbShop/dbOrderProcess">주문관리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/adMemberList">회원관리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/adBoardList">게시판관리</a>
    </li>
  </ul>
  <hr color="black"/>
</div>