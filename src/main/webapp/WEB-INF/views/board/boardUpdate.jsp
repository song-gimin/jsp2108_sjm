<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>문의수정</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<script>
    function fCheck() {
    	var title = myform.title.value;
    	var content = myform.content.value;
    	
    	if(title.trim() == "") {
    		alert("게시글 제목을 입력하세요");
    		myform.title.focus();
    	}
    	/*
    	else if(content.trim() == "") {
    		alert("글내용을 입력하세요");
    		myform.content.focus();
    	}
    	*/
    	else {
    		myform.oriContent.value = document.getElementById("oriContent").innerHTML;
    		myform.submit();
    	}
    }
  </script>
  <style>
  	a:link {color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black; text-decoration: none;}
    th {
    	text-align: center;
    	background-color: lightgray;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr/><hr/>
<p><br/></p>
<div class="container">
  <form name="myform" method="post">
	  <table class="table table-borderless">
	    <tr>
	      <td class="text-center"><h2><b>문 의 내 역 수 정</b></h2></td>
	    </tr>
	  </table>
	  <table class="table">
	    <tr>
	      <th>작성자</th>
	      <td>${sMid}</td>
	    </tr>
	    <tr>
	      <th>제목</th>
	      <td><input type="text" name="title" value="${vo.title}" class="form-control" autofocus required /></td>
	    </tr>
	    <tr>
	      <th>E-mail</th>
	      <td><input type="text" name="email" value="${vo.email}" class="form-control"/></td>
	    </tr>
	    <tr>
	      <th>문의내용</th>
	      <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
	      <script>
	      	CKEDITOR.replace("content",{
	      		uploadUrl : "${ctp}/imageUpload",             // 여러개의 그림파일을 드래그&드롭으로 처리하기
	      		filebrowserUploadUrl : "${ctp}/imageUpload",  // 파일(이미지) 업로드 시 처리
	      		height : 500
	      	});
	      </script>
	    </tr>
	    <tr>
	      <td colspan="2" style="text-align:center">
	        <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}';" class="btn btn-secondary"/> &nbsp;
	        <input type="button" value="수정하기" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
	        <input type="reset" value="다시입력" class="btn btn-secondary"/>
	      </td>
	    </tr>
	  </table>
	  <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	  <input type="hidden" name="idx" value="${vo.idx}"/>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	  <input type="hidden" name="lately" value="${lately}"/>
	  <input type="hidden" name="oriContent"/>
	  <div id="oriContent" style="display:none;">${vo.content}</div>
  </form>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>