<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>문의내역</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" rel="stylesheet">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		// 게시글 삭제
    function delCheck() {
    	var ans = confirm("게시글을 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/board/boardDelete?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}";
    }
    
    // 댓글 입력처리
    function replyCheck() {
    	var boardIdx = "${vo.idx}";
    	var mid = "${sMid}";
    	var content = replyForm.content.value;
    	if(content=="") {
    		alert("댓글을 입력하세요.");
    		replyForm.content.focus();
    		return false;
    	}
    	var query = {
    			boardIdx : boardIdx,
    			mid : mid,
    			content : content
    	}
    	
    	$.ajax({
    		type : "post",
    		url : "${ctp}/board/boardReplyInsert",
    		data : query,
    		success:function() {
    			location.reload();
    		}
    	});
    }
    
    // 답변글(부모댓글의 댓글.. 답변...)
    function insertReply(idx,level,levelOrder,mid) {
			var insReply = "";
			insReply += "<table style='width:90%' class='text-left'>";
			insReply += "<tr>";
			insReply += "<td>";
			insReply += "<div class='form-group'>";
			insReply += "<label for='content'>답변달기</label> &nbsp;";
			insReply += "<input type='text'	name='mid' size='6' value='${sMid}' readonly />";
			insReply += "<textarea row='3' class='form-control' name='content' id='content"+idx+"'>@"+mid+"\n</textarea>";
			insReply += "</div>";
			insReply += "</td>";
			insReply += "<td>";
			insReply += "<input type='button' value='답글달기' onclick='replyCheck2("+idx+","+level+","+levelOrder+")'/>";
			insReply += "</td>";
			insReply += "</tr>";
			insReply += "</table>";
			insReply += "<hr style='margin:0px'/>";
			
			$("#replyBoxOpenBtn"+idx).hide();
			$("#replyBoxCloseBtn"+idx).show();
			$("#replyBox"+idx).slideDown(500);
			$("#replyBox"+idx).html(insReply);
		}
    
    // 대댓글 입력폼 닫기 처리(대댓글에 해당하는 가상 테이블을 보이지 않게.)
    function closeReply(idx) {
			$("#replyBoxOpenBtn" + idx).show();
			$("#replyBoxCloseBtn" + idx).hide();
			$("#replyBox"+idx).slideUp(500);
		}
    
    // 대댓글 저장하기
    function replyCheck2(idx,level,levelOrder) {
    	var boardIdx = "${vo.idx}";
    	var mid = "${sMid}";
    	var content = "content" + idx;
    	var contentVal = $("#"+content).val();
    	
    	if(content=="") {
    		alert("답글을 입력하세요.");
    		$("#"+content).focus();
    		return false;
    	}
    	var query = {
    			boardIdx : boardIdx,
    			mid : mid,
    			content : contentVal,
    			level : level,
    			levelOrder : levelOrder
    	}
    	
    	$.ajax({
    		type : "post",
    		url : "${ctp}/board/boardReplyInsert2",
    		data : query,
    		success:function() {
    			location.reload();
    		}
    	});
		}
    
    // 댓글삭제처리
    function replyDelCheck(replyIdx) {
			var ans = confirm("선택한 댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url : "${ctp}/board/boardReplyDelete",
				data : {replyIdx:replyIdx},
				success:function() {
					location.reload();
				},
				error : function() {
					alert("전송오류");
				}
			});
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
	<h2 style="text-align:center"><b>문 의 내 역</b></h2>
	<br/>
	<table class="table table-bordered">
		<tr>
			<th>작성자</th>
      <td>${vo.mid}</td>
      <th>작성일</th>
      <td>${fn:substring(vo.WDate,0,10)}</td>
		</tr>
		<tr>
      <th>E-mail</th>
      <td>${vo.email}</td>
      <th>조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <th>제목</th>
      <td>${vo.title}</td>
      <th>접속IP</th>
      <td>${vo.hostIp}</td>
    </tr>
    <tr>
      <th>문의내용</th>
      <td colspan="3" style="height:200px">${fn:replace(vo.content,newLine,'<br/>')}</td>
    </tr>
	</table>
	<div class="text-center">
    <c:if test="${sw != 'search'}">
    	<c:if test="${sLevel == 0}">
      	<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adBoardList';" class="btn btn-secondary"/>
      </c:if>
      <c:if test="${sLevel==1 || sLevel==2 || sLevel==3 || sLevel==4}">
    		<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}&lately=${lately}';" class="btn btn-secondary"/>
    	</c:if>
      	<c:if test="${sMid == vo.mid}">
        	<input type="button" value="수정하기" onclick="location.href='${ctp}/board/boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}';" class="btn btn-secondary"/>
        	<input type="button" value="삭제하기" onclick="delCheck()" class="btn btn-secondary"/>
      	</c:if>
    </c:if>
    <c:if test="${sw == 'search'}">
    	<input type="button" value="돌아가기" onclick="history.back()" class="btn btn-secondary"/>
    </c:if>
  </div>
	
	<c:if test="${sw != 'search'}">
  <!-- 이전글/다음글 처리 -->
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        <c:if test="${!empty pnVos[1]}">
		        ▲ <a href="${ctp}/board/boardContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">다음글 : ${pnVos[1].title}</a><br/>
	        </c:if>
	        <c:if test="${!empty pnVos[0]}">
		        ▼ <a href="${ctp}/board/boardContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">이전글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	      </td>
	    </tr>
	  </table>
  </c:if>
  <br/>
  <!-- 댓글 출력 -->
  <div id="reply">
	  <table class="table table-hover text-center">
	    <tr>
	    	<th colspan="4">댓 글 내 역</th>
	    </tr>
	    <c:forEach var="rVo" items="${rVos}">
	      <tr>
	      	<c:if test="${rVo.level<=0}">  <!-- 부모댓글은 들여쓰기 하지 않음. -->
	      		<td class="text-left">
	      			${rVo.mid}
	      			<c:if test="${rVo.mid==sMid}">
	      				<a href="javascript:replyDelCheck(${rVo.idx});"><i class="fas fa-times"></i></a>
	      			</c:if>
	      		</td>
	      	</c:if>
	      	<c:if test="${rVo.level>0}">  <!-- 하위댓글은 들여쓰기 -->
		      	<td class="text-left">
		      		<c:forEach var="i" begin="1" end="${rVo.level}">&nbsp;&nbsp; </c:forEach>
		      			└ ${rVo.mid}
		      		<c:if test="${rVo.mid==sMid}">
		      			<a href="javascript:replyDelCheck(${rVo.idx});"><i class="fas fa-times"></i></a>
		      		</c:if>
		      	</td>
		      </c:if>
	      	<td class="text-left" style="width:50%">
	      		${rVo.content}
	      	</td>
	      	<td>${rVo.WDate}</td>
	      	<td>
						<input type="button" value="답글" onclick="insertReply('${rVo.idx}','${rVo.level}','${rVo.levelOrder}','${rVo.mid}')" id="replyBoxOpenBtn${rVo.idx}"/>
						<input type="button" value="닫기" onclick="closeReply(${rVo.idx})" id="replyBoxCloseBtn${rVo.idx}" class="replyBoxClose" style="display:none"/>
					</td>
	      </tr>
	      <tr>
	      	<td colspan="5"><div id="replyBox${rVo.idx}"></div></td>
	      </tr>
	    </c:forEach>
	  </table>
  </div>
  
  <!-- 댓글 입력 -->
  <form name="replyForm">
	  <table class="table">
	  	<tr>
	  	  <td style="width:90%">
	  	    <b>[댓글입력]</b>
	  	    <textarea rows="4" name="content" id="content" class="form-control"></textarea>
	  	  </td>
	  	  <td style="width:10%">
	  	    <br/><p><b>[작성자]</b><br/>${sMid}</p>
	  	    <p>
	  	      <input type="button" value="댓글달기" onclick="replyCheck()"/>
	  	    </p>
	  	  </td>
	  	</tr>
	  </table>
	  <input type="hidden" name="boardIdx" value="${vo.idx}"/>
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	  <input type="hidden" name="lately" value="${lately}"/>
  </form>
  
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>