<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>고객센터</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		function pageCheck() {
    	var pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/board/boardList?pag=${pag}&pageSize="+pageSize;
    }
	
		// 최근게시글 검색
    function latelyCheck() {
    	var lately = document.getElementById("lately").value;
    	if(lately == "") {
    		alert("검색일자를 선택하세요");
    	}
    	else {
    		location.href="${ctp}/board/boardList?page=${pag}&pageSize=${pageSize}&lately="+lately;
    	}
    }
    
    // 검색콤보상자 선택시 커서를 검색어 입력창으로 이동하기
    function searchChange() {
    	searchForm.searchString.focus();
    }
    
    // 검색버튼 클릭시 수행할 내용
    function searchCheck() {
    	var searchString = searchForm.searchString.value;
    	if(searchString == "") {
    		alert("검색어를 입력하세요.");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
    }
	</script>
	<style>
  	a:link {color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black; text-decoration: none;}
    th, td {
      text-align: center;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr/><hr/>
<p><br/></p><br/>
<div class="container text-center">
	<h1><b>Q&A</b></h1>
	<br/>
	<table class="table table-borderless">
		<tr>
      <td class="text-left p-0">
        <a href="${ctp}/board/boardInput" class="btn btn-warning btn-sm btn-outline-dark">문의하기</a> &nbsp;
      </td>
      <td class="text-right p-0">
    		<select name="lately" id="lately" onchange="latelyCheck()">
          <option value="0">최근자료순</option>
          <c:forEach var="i" begin="1" end="30">
	          <option value="${i}" ${lately==i ? 'selected' : ''}>${i}일전</option>
          </c:forEach>
        </select>
        <select name="pageSize" id="pageSize" onchange="pageCheck()" class="p-0 m-0">
          <option value="5"  ${pageSize==5 ? 'selected' : ''}>5건</option>
          <option value="10" ${pageSize==10 ? 'selected' : ''}>10건</option>
          <option value="15" ${pageSize==15 ? 'selected' : ''}>15건</option>
          <option value="20" ${pageSize==20 ? 'selected' : ''}>20건</option>
        </select>
      </td>
    </tr>
	</table>
	<table class="table table-hover">
    <tr class="text-center" style="border-bottom: 1px solid #ccc; background-color: lightsteelblue">
      <th>NO</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>조회수</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
	    <tr>
	      <td>${curScrStrarNo}</td>
	      <td>
	        <a href="${ctp}/board/boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">${vo.title}</a>
	        <c:if test="${vo.diffTime <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
	        <c:if test="${vo.replyCount != 0}">(${vo.replyCount})</c:if>
	      </td>
	      <td>${vo.mid}</td>
	     	<td>
	        <c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
	        <c:if test="${vo.diffTime >  24}">${fn:substring(vo.WDate,0,10)}</c:if>
	      </td>
	      <td>${vo.readNum}</td>
	    </tr>
	    <c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
  
  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
<div class="container">
	<ul class="pagination justify-content-center">
		<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
		<c:if test="${totPage != 0}">
		  <c:if test="${pag != 1}">
		    <li class="page-item"><a href="${ctp}/board/boardList?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${curBlock > 0}">
		    <li class="page-item"><a href="${ctp}/board/boardList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
		    <c:if test="${i == pag && i <= totPage}">
		      <li class="page-item active"><a href='${ctp}/board/boardList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i != pag && i <= totPage}">
		      <li class="page-item"><a href='${ctp}/board/boardList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${curBlock < lastBlock}">
		    <li class="page-item"><a href="${ctp}/board/boardList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
		  </c:if>
		  <c:if test="${pag != totPage}">
		    <li class="page-item"><a href="${ctp}/board/boardList?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
		  </c:if>
		</c:if>
	</ul>
</div>
<!-- 블록 페이징처리 끝 -->

<!-- 검색기 처리 시작 -->
<div class="container text-center">
  <form name="searchForm" method="post" action="${ctp}/board/boardSearch">
    <select name="search" onchange="searchChange()">
      <option value="title">글제목</option>
      <option value="mid">글쓴이</option>
      <option value="content">글내용</option>
    </select>
    <input type="text" name="searchString"/>
    <input type="button" value="검색" onclick="searchCheck()"/>
    <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
  </form>
</div>
<!-- 검색기 처리 끝 -->
  
</div>
<p><br/></p><p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>