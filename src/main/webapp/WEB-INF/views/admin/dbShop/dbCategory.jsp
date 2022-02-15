<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>상품분류등록</title>
  <!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" rel="stylesheet"> -->
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
		//대분류 등록하기 
	  function categoryMainCheck() {
	  	var categoryMainCode = categoryMainForm.categoryMainCode.value;
	  	var categoryMainName = categoryMainForm.categoryMainName.value;
	  	if(categoryMainCode == "") {
	  		alert("대분류코드를 입력하세요.");
	  		categoryMainForm.categoryMainCode.focus();
	  		return false;
	  	}
	  	if(categoryMainName == "") {
	  		alert("대분류명을 입력하세요.");
	  		categoryMainForm.categoryMainName.focus();
	  		return false;
	  	}
	  	$.ajax({
	  		type : "post",
	  		url  : "${ctp}/dbShop/categoryMainInput",
	  		data : {
	  			categoryMainCode : categoryMainCode,
	  			categoryMainName : categoryMainName
	  		},
	  		success:function(data) {
	  			if(data == "0") alert("같은 상품이 등록되어있습니다.\n확인 후 다시 입력해주세요.");
	  			else location.reload();
	  		},
	  		error : function() {
	  			alert("전송오류");
	  		}
	  	});
	  }
	  
	  // 중분류 등록하기 
	  function categoryMiddleCheck() {
	  	var categoryMainCode = categoryMiddleForm.categoryMainCode.value;
	  	var categoryMiddleCode = categoryMiddleForm.categoryMiddleCode.value;
	  	var categoryMiddleName = categoryMiddleForm.categoryMiddleName.value;
	  	if(categoryMainCode == "") {
	  		alert("대분류명을 선택하세요.");
	  		return false;
	  	}
	  	if(categoryMiddleCode == "") {
	  		alert("중분류코드를 입력하세요.");
	  		categoryMiddleForm.categoryMiddleCode.focus();
	  		return false;
	  	}
	  	if(categoryMiddleName == "") {
	  		alert("중분류명을 입력하세요.");
	  		categoryMiddleForm.categoryMiddleName.focus();
	  		return false;
	  	}
	  	$.ajax({
	  		type : "post",
	  		url  : "${ctp}/dbShop/categoryMiddleInput",
	  		data : {
	  			categoryMainCode   : categoryMainCode,
	  			categoryMiddleCode : categoryMiddleCode,
	  			categoryMiddleName : categoryMiddleName
	  		},
	  		success:function(data) {
	  			if(data == "0") {
	  				alert("같은 상품이 등록되어있습니다.\n확인 후 다시 입력해주세요.");
	  			}
	  			else {
	  				location.reload();
	  			}
	  		},
	  		error : function() {
	  			alert("전송오류");
	  		}
	  	});
	  }
	  
    // 대분류 삭제
    function delCategoryMain(categoryMainCode) {
    	var ans = confirm("대분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/delCategoryMain",
    		data : {categoryMainCode : categoryMainCode},
    		success:function(data) {
    			if(data == 0) {
    				alert("하위항목이 존재합니다. \n하위항목 삭제 후 다시 작업을 진행해주세요.");
    			}
    			else {
    				alert("대분류항목이 삭제되었습니다.");
    				location.reload();
    			}
    		}
    	});
    }
    
    // 중분류 삭제
    function delCategoryMiddle(categoryMiddleCode) {
    	var ans = confirm("중분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/delCategoryMiddle",
    		data : {categoryMiddleCode : categoryMiddleCode},
    		success:function(data) {
    			if(data == 0) {
    				alert("하위항목이 존재합니다. \n하위항목 삭제 후 다시 작업을 진행해주세요.");
    			}
    			else {
    				alert("중분류항목이 삭제되었습니다.");
    				location.reload();
    			}
    		}
    	});
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
  <h3 class="text-center">상품 분류 등록/삭제</h3>
  <br/><br/>
  <form name="categoryMainForm">
  	<h5><b>대분류 관리</b></h5><p></p>
  	대분류코드&nbsp;&nbsp;<input type="text" name="categoryMainCode"/>&nbsp;&nbsp;&nbsp;&nbsp;
  	대분류명&nbsp;&nbsp;<input type="text" name="categoryMainName"/>
  	<input type="button" value="등록" onclick="categoryMainCheck()" class="btn btn-secondary btn-sm"/>
	  <table class="table table-hover m-3">
	    <tr class="table-dark text-dark text-center">
	      <th>대분류코드</th>
	      <th>대분류명</th>
	      <th>삭제</th>
	    </tr>
	    <c:forEach var="mainVo" items="${mainVos}" varStatus="st">
	    	<tr class="text-center">
	    	  <td>${mainVo.categoryMainCode}</td>
	    	  <td>${mainVo.categoryMainName}</td>
	    	  <td><a href="javascript:delCategoryMain('${mainVo.categoryMainCode}');">✖</a></td>
	    	</tr>
	    </c:forEach>
	  </table>
  </form>
	<hr/>
	
<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
<div class="container">
	<ul class="pagination justify-content-center">
		<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
		<c:if test="${totPage != 0}">
		  <c:if test="${pag != 1}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbCategory?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${curBlock > 0}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbCategory?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
		    <c:if test="${i == pag && i <= totPage}">
		      <li class="page-item active"><a href='${ctp}/dbShop/dbCategory?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i != pag && i <= totPage}">
		      <li class="page-item"><a href='${ctp}/dbShop/dbCategory?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${curBlock < lastBlock}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbCategory?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
		  </c:if>
		  <c:if test="${pag != totPage}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbCategory?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
		  </c:if>
		</c:if>
	</ul>
</div>
<!-- 블록 페이징처리 끝 -->
	
	<br/>
  <form name="categoryMiddleForm">
  	<h5><b>중분류 관리</b></h5><p></p>
  	<select name="categoryMainCode">
  	  <option value="">대분류명</option>
  	  <c:forEach var="mainVo" items="${mainVos}">
  	    <option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
  	  </c:forEach>
  	</select> &nbsp; &nbsp;
  	중분류코드&nbsp;&nbsp;<input type="text" name="categoryMiddleCode"/>&nbsp;&nbsp;&nbsp;&nbsp;
  	중분류명&nbsp;&nbsp;<input type="text" name="categoryMiddleName"/>
  	<input type="button" value="등록" onclick="categoryMiddleCheck()" class="btn btn-secondary btn-sm"/>
	  <table class="table table-hover m-3">
	    <tr class="table-dark text-dark text-center">
	      <th>대분류코드</th>
	      <th>중분류코드</th>
	      <th>중분류명</th>
	      <th>삭제</th>
	    </tr>
	    <c:forEach var="middleVo" items="${middleVos}" varStatus="st">
	    	<tr class="text-center">
	    	  <td>${middleVo.categoryMainCode}</td>
	    	  <td>${middleVo.categoryMiddleCode}</td>
	    	  <td>${middleVo.categoryMiddleName}</td>
	    	  <td><a href="javascript:delCategoryMiddle('${middleVo.categoryMiddleCode}');">✖</a></td>
	    	</tr>
	    </c:forEach>
	  </table>
  </form>
  <hr/>
  
<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
<div class="container">
	<ul class="pagination justify-content-center">
		<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
		<c:if test="${totPage != 0}">
		  <c:if test="${pag != 1}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbCategory?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${curBlock > 0}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbCategory?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
		    <c:if test="${i == pag && i <= totPage}">
		      <li class="page-item active"><a href='${ctp}/dbShop/dbCategory?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i != pag && i <= totPage}">
		      <li class="page-item"><a href='${ctp}/dbShop/dbCategory?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${curBlock < lastBlock}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbCategory?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
		  </c:if>
		  <c:if test="${pag != totPage}">
		    <li class="page-item"><a href="${ctp}/dbShop/dbCategory?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
		  </c:if>
		</c:if>
	</ul>
</div>
<!-- 블록 페이징처리 끝 -->
  
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>