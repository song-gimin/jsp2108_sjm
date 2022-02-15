<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
  // 상품코드에서 대분류(A,B,C, ...) 이거 : 드롭다운 때문에 에러 생겨서 onclick으로 따로 뺌
  function mainKeyCheck(mainKey, title) {
	  location.href="${ctp}/menu/mainMenu?mainKey="+mainKey+"&mainTitle="+title;
	  //location.href="${ctp}/menu/mainMenu?mainKey="+mainKey;
  }
  // 상품코드에서 중분류
  function middleKeyCheck(middleKey, title) {
	  location.href="${ctp}/menu/middleMenu?middleKey="+middleKey+"&middleTitle="+title;
	  //location.href="${ctp}/menu/middleMenu?middleTitle="+title;
  }
</script>
<style>
	.dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0;
	}
</style>
<div class="text-center">
  <ul class="nav justify-content-center">
		<li class="nav-item">
			<a class="nav-link"  href="${ctp}/">HOME</a>
		</li>
		<li class="nav-item">
			<a class="nav-link"  href="${ctp}/">NEW</a>
		</li>
		<li class="nav-item dropdown mr-2">
		  <a class="nav-link" data-toggle="dropdown" href="#" onclick="mainKeyCheck('A','야외용품')">야외용품</a>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('01','가슴줄')">가슴줄</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('02','리드줄')">리드줄</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('03','목줄')">목줄</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('04','안전용품')">안전용품</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('05','산책용품')">산책용품</a>
		   </div>
		</li>
		<li class="nav-item dropdown mr-2">
		  <a class="nav-link" data-toggle="dropdown" href="#" onclick="mainKeyCheck('B','패션')">패션</a>
		   <div class="dropdown-menu">
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('06','SUMMER')">SUMMER</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('07','아우터')">아우터</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('08','티셔츠')">티셔츠</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('09','악세서리')">악세서리</a>
		   </div>
		</li>
		<li class="nav-item dropdown mr-2">
		  <a class="nav-link" data-toggle="dropdown" href="#" onclick="mainKeyCheck('C','리빙')">리빙</a>
		   <div class="dropdown-menu">
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('10','이동장')">이동장</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('11','안전문')">안전문</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('12','방석·매트·계단')">방석·매트·계단</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('13','식기·보관')">식기·보관</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('14','목욕·위생')">목욕·위생</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('15','탈취·소독')">탈취·소독</a>
		   </div>
		</li>
		<li class="nav-item dropdown mr-2">
		  <a class="nav-link" data-toggle="dropdown" href="#" onclick="mainKeyCheck('D','장난감')">장난감</a>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('16','노즈워크')">노즈워크</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('17','터그')">터그</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('18','공')">공</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('19','사운드')">사운드</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('20','소프트토이')">소프트토이</a>
		  </div>
		</li>
		<li class="nav-item dropdown mr-2">
		  <a class="nav-link" data-toggle="dropdown" href="#" onclick="mainKeyCheck('E','훈련용품')">훈련용품</a>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('21','트릿백·가방')">트릿백·가방</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('22','클리커')">클리커</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('23','어질리티·피트니스')">어질리티·피트니스</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('24','트레이너의류')">트레이너의류</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('25','원반')">원반</a>
		  </div>
		</li>
		<li class="nav-item dropdown mr-2">
		  <a class="nav-link" data-toggle="dropdown" href="#" onclick="mainKeyCheck('F','푸드')">푸드</a>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('26','자연식·습식')">자연식·습식</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('27','사료·건식')">사료·건식</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('28','간식')">간식</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('29','파우더')">파우더</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('30','영양제')">영양제</a>
		  </div>
		</li>
		<li class="nav-item dropdown mr-2">
		  <a class="nav-link" data-toggle="dropdown" href="#" onclick="mainKeyCheck('G','문구·도서')">문구·도서</a>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('31','도서')">도서</a>
		    <a class="dropdown-item" href="#" onclick="middleKeyCheck('32','문구')">문구</a>
		  </div>
		</li>
		<li class="nav-item">
			<a class="nav-link"  href="${ctp}/">BODEUM</a>
		</li>
  </ul>
</div> 
<hr/>