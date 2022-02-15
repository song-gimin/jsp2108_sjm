<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품리스트</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		function pageCheck() {
    	var pageSize = document.getElementById().value;
    	location.href = "${ctp}/admin/dbProductList";
    	/* var pageSize = document.getElementById("pageSize").value;
     	location.href = "${ctp}/admin/dbProductList?pag=${pag}&pageSize="+pageSize; */
    }
		
		// 상품 검색
		function cateSearch() {
			
		}
	</script>
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
<div class="container">
<jsp:include page="/WEB-INF/views/include/adMenu.jsp"/>
	<br/>
	<h3 class="text-center">상품리스트</h3>
	<br/>
	<table class="table table-borderless">
		<tr>
			<td>
        <a href="${ctp}/dbShop/dbProduct" class="btn btn-outline-dark btn-secondary btn-sm text-white">상품등록</a>
      </td>
			<td style="text-align:right">
				<input type="button" value="전체" onClick="location.href='${ctp}/admin/dbProductList';" style="width:45px;height:25px;font-size: 0.9em;padding-top: 2px;padding-left: 8px;" class="btn btn-outline-secondary"/>&nbsp;&nbsp;
    		<select name="categoryMainNames" id="categoryMainNames" style="width:100px;">
          <option value="대분류">대분류</option>
    			<option>야외용품</option>
    			<option>패션</option>
    			<option>리빙</option>
    			<option>장난감</option>
    			<option>훈련용품</option>
    			<option>푸드</option>
    			<option>문구·도서</option>
       	</select>&nbsp;
      	<select name="categoryMiddleNames" id="categoryMiddleNames" style="width:100px;">
          <option value="중분류">중분류</option>
       	</select>&nbsp;
      	<input type="button" value="보기" onClick="cateSearch()" style="width:45px;height:25px;font-size: 0.9em;padding-top: 2px;padding-left: 8px;" class="btn btn-outline-secondary"/>		
				&nbsp;&nbsp;&nbsp;
				<select name="pageSize" id="pageSize" onchange="pageCheck()" class="p-0 m-0">
					<option value="5"  ${pageSize==5 ? 'selected' : ''}>5건</option>
          <option value="10" ${pageSize==10 ? 'selected' : ''}>10건</option>
          <option value="15" ${pageSize==15 ? 'selected' : ''}>15건</option>
          <option value="20" ${pageSize==20 ? 'selected' : ''}>20건</option>
				</select>
			</td>
		</tr>
	</table>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>NO</th>
			<th>대분류</th>
			<th>중분류</th>
			<th>상품명</th>
			<th>상품가격</th>
			<th>수정/삭제</th>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>	
</div>

<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
<div class="container">
	<ul class="pagination justify-content-center">
		<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
		<c:if test="${totPage != 0}">
		  <c:if test="${pag != 1}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbProductList?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${curBlock > 0}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbProductList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
		    <c:if test="${i == pag && i <= totPage}">
		      <li class="page-item active"><a href='${ctp}/dbShop/dbProductList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i != pag && i <= totPage}">
		      <li class="page-item"><a href='${ctp}/dbShop/dbProductList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${curBlock < lastBlock}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbProductList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
		  </c:if>
		  <c:if test="${pag != totPage}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbProductList?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
		  </c:if>
		</c:if>
	</ul>
</div>
<!-- 블록 페이징처리 끝 -->

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>