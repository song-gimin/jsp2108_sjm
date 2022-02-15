<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Bodeum_sjm</title>
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
<div id="demo" class="carousel slide" data-ride="carousel">
	<ul class="carousel-indicators">
	  <li data-target="#demo" data-slide-to="0" class="active"></li>
	  <li data-target="#demo" data-slide-to="1"></li>
	  <li data-target="#demo" data-slide-to="2"></li>
	  <li data-target="#demo" data-slide-to="3"></li>
	  <li data-target="#demo" data-slide-to="4"></li>
	</ul>
	<div class="carousel-inner">
	  <div class="carousel-item active">
	    <a href="#"><img src="${ctp}/images/main1.PNG" alt="main1" width="2200" height="550"/></a>
	  </div>
	  <div class="carousel-item">
	    <a href="#"><img src="${ctp}/images/main2.PNG" alt="main2"  width="2200" height="550"/></a>
	  </div>
	  <div class="carousel-item">
	    <a href="#"><img src="${ctp}/images/main3.PNG" alt="main3"  width="2200" height="550"/></a>
	  </div>
	  <div class="carousel-item">
	    <a href="#"><img src="${ctp}/images/main4.PNG" alt="main4"  width="2200" height="550"/></a>
	  </div>
	  <div class="carousel-item">
	    <a href="#"><img src="${ctp}/images/main5.PNG" alt="main5"  width="2200" height="550"/></a>
	  </div>
	</div>
</div>
<p><br/></p>
<div class="container">
	<table class="table table-borderless text-center">
		<tr>
			<td colspan="4"><h2><b>NEW</b></h2></td>
		</tr>
		<tr>
			<td>
				<a href="#"><img src="${ctp}/goods/goods1.png" width="350"></a>
			</td>
			<td>
				<a href="#"><img src="${ctp}/goods/goods2.png" width="350"></a>
			</td>
			<td>
				<a href="#"><img src="${ctp}/goods/goods3.png" width="350"></a>
			</td>
			<td>
				<a href="#"><img src="${ctp}/goods/goods4.jpg" width="350"></a>
			</td>
		</tr>
		<tr class="text-left">
			<td><b>뮤니쿤트 니스 강아지 노즈워크</b></td>
			<td><b>로얄테일즈 뉴 그레이스 모던 강아지 유모차 반려차</b></td>
			<td><b>로얄테일즈 뉴 그레이스 클래식 강아지 유모차 반려차</b></td>
			<td><b>고위드테일 치킨 크런칩 85g</b></td>
		</tr>
		<tr style="color:navy;">
			<td><h5><b>19,000원</b></h5></td>
			<td><h5><b>650,000원</b></h5></td>
			<td><h5><b>700,000원</b></h5></td>
			<td><h5><b>11,000원</b></h5></td>
		</tr>
		<tr>
			<td colspan="4"><a href="#" class="btn btn-primary" style="color:white;">&nbsp;&nbsp;&nbsp;상품더보기 +&nbsp;&nbsp;&nbsp;</a></td>
		</tr>
	</table>
</div>
<p><br/></p>
<p><br/></p>
<div class="container">
	<table class="table table-borderless text-center">
		<tr>
			<td colspan="4"><h2><b>BEST SELLER</b></h2></td>
		</tr>
		<tr>
			<td>
				<a href="#"><img src="${ctp}/goods/goods5.jpg" width="350"></a>
			</td>
			<td>
				<a href="#"><img src="${ctp}/goods/goods6.gif" width="350"></a>
			</td>
			<td>
				<a href="#"><img src="${ctp}/goods/goods7.jpg" width="350"></a>
			</td>
			<td>
				<a href="#"><img src="${ctp}/goods/goods8.png" width="350"></a>
			</td>
		</tr>
		<tr class="text-left">
			<td><b>보듬 가슴줄 어드벤처 라인</b></td>
			<td><b>보듬 후크형 가슴줄 어드벤처 라인</b></td>
			<td><b>보듬 리드줄 어드벤처 라인</b></td>
			<td><b>[헐티] 울트라 입마개</b></td>
		</tr>
		<tr style="color:navy;">
			<td><h5><b>28,000원</b></h5></td>
			<td><h5><b>29,000원</b></h5></td>
			<td><h5><b>17,000원</b></h5></td>
			<td><h5><b>23,000원</b></h5></td>
		</tr>
		<tr>
			<td colspan="4"><a href="#" class="btn btn-primary" style="color:white;">&nbsp;&nbsp;&nbsp;상품더보기 +&nbsp;&nbsp;&nbsp;</a></td>
		</tr>
	</table>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<div>
	<a href="#"><img src="${ctp}/images/main6.PNG" width="2200" height="400"/></a>
</div>
<p><br/></p>
<p><br/></p>
<div class="container">
	<table class="table table-borderless">
		<tr>
			<td rowspan="2"><a href="#"><img src="${ctp}/images/main7.png" width="600"/></a></td>
			<td><a href="#"><img src="${ctp}/images/main8.png" width="600"/></a></td>		
		</tr>
		<tr>
			<td><a href="#"><img src="${ctp}/images/main9.jpg" width="600"/></a></td>
		</tr>
	</table>
</div>
<p><br/></p>
<div class="container">
	<table class="table table-borderless">
		<tr>
			<td colspan="2"><a href="#"><img src="${ctp}/images/main10.PNG" width="600"/></a></td>
			<td><a href="#"><img src="${ctp}/images/main11.PNG" width="300"/></a></td>		
			<td><a href="#"><img src="${ctp}/images/main12.PNG" width="300"/></a></td>
		</tr>
	</table>
</div>
<div class="container" style="padding: 20px;">
	<table class="table table-borderless">
		<tr>
			<td>
				<h4><b>다양한 채널</b>을 통해 <b>보듬의 소식</b>을 받아보실 수 있습니다.</h4>
			</td>
			<td>
				<a href="https://www.youtube.com/channel/UCee1MvXr6E8qC_d2WEYTU5g" target="_blank"><img src="${ctp}/images/sns1.png" alt="유튜브"></a>&nbsp;&nbsp;
				<a href="https://www.facebook.com/bodeum0527" target="_blank"><img src="${ctp}/images/sns2.png" alt="페이스북"></a>&nbsp;&nbsp;
				<a href="http://blog.naver.com/hunter527" target="_blank"><img src="${ctp}/images/sns3.png" alt="네이버 블로그"></a>&nbsp;&nbsp;
				<a href="http://tv.naver.com/bodeum" target="_blank"><img src="${ctp}/images/sns4.png" alt="네이버 TV"></a>&nbsp;&nbsp;
				<a href="http://storefarm.naver.com/bodeum" target="_blank"><img src="${ctp}/images/sns5.png" alt="스토어팜"></a>
			</td>
		</tr>
	</table>
</div>
<hr/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>