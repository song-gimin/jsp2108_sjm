<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원관리</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
		//회원등급변경을 ajax로 처리
	  function levelCheck(obj) {
			var ans = confirm("회원등급을 변경하시겠습니까?");
			if(!ans) {
				location.reload();
				return false;
			}
			var str = $(obj).val();
			var query = {
					idx : str.substring(1),
					level : str.substring(0,1)
			}
			
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/adMemberLevel",
				data : query,
				error:function() {
					alert("처리실패");
				}
			});
		}
	
		// 회원 탈퇴처리(회원정보삭제)
		function memberReset(idx) {
			var ans = confirm("정말로 탈퇴처리 하시겠습니까?");
			if(ans) location.href="${ctp}/admin/adMemberReset?idx="+idx;
		}
		
		// 회원등급별 검색
		function levelSearch() {
			var level = adminForm.level.value;
			location.href = "${ctp}/admin/adMemberList?level="+level;
		}
		
		// 개별회원 검색
		function midSearch() {
			var mid = adminForm.mid.value;
			if(mid == "") {
				alert("아이디를 입력하세요.");
				adminForm.mid.focus();
			}
			else {
				location.href = "${ctp}/admin/adMemberList?mid="+mid;
			}
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
	<form name="adminForm">
		<table class="table table-borderless m-0">
			<tr>
				<td colspan="2">
					<c:choose>
						<c:when test="${level==99}"><c:set var="title" value="전체"/></c:when>
						<c:when test="${level==1}"><c:set var="title" value="VVIP"/></c:when>
						<c:when test="${level==2}"><c:set var="title" value="VIP"/></c:when>
						<c:when test="${level==3}"><c:set var="title" value="GOLD"/></c:when>
						<c:when test="${level==4}"><c:set var="title" value="SILVER"/></c:when>
					</c:choose>
					<c:if test="${!empty mid}"><c:set var="title" value="${mid}"/></c:if>
					<br/>
					<h3 style="text-align:center;">${title}회원 리스트</h3>
				</td>
			</tr>
			<tr>
				<td style="text-align:left">
					<input type="text" name="mid" value="${mid}" placeholder="검색할아이디입력"/>
					<input type="button" value="개별검색" onclick="midSearch()"/>
					<input type="button" value="전체보기" onclick="location.href='${ctp}/admin/adMemberList';" class="btn btn-secondary btn-sm"/>
				</td>
				<td style="text-align:right">회원등급별조회
					<select name="level" onchange="levelSearch()">
						<option value="99" <c:if test="${level==99}">selected</c:if>>전체회원</option>
						<option value="1" <c:if test="${level==1}">selected</c:if>>VVIP</option>
						<option value="2" <c:if test="${level==2}">selected</c:if>>VIP</option>
						<option value="3" <c:if test="${level==3}">selected</c:if>>GOLD</option>
						<option value="4" <c:if test="${level==4}">selected</c:if>>SILVER</option>
					</select>
				</td>
			</tr>
		</table>
	</form>
	<br/>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>NO</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>성명</th>
			<th>성별</th>
			<th>방문횟수</th>	
			<th>Point</th>	
			<th>최종접속일</th>	
			<th>회원등급</th>	
			<th>정보공개유무</th>	
			<th>탈퇴유무</th>	
		</tr>
    <c:forEach var="vo" items="${vos}">
    	<tr class="text-center">
    	  <td>${curScrStrarNo}</td>
    	  <td>${vo.mid}</td>
    	  <td>${vo.nickName}</td>
    	  <td><a href="${ctp}/admin/adMemberInfor?idx=${vo.idx}">${vo.name}</a></td>
    	  <td>${vo.gender}</td>
    	  <td>${vo.visitCnt}</td>
    	  <td>${vo.point}</td>
    	  <td>${vo.lastDate}</td>
    	  <td>
		      <select name="level" onchange="levelCheck(this)">
		        <option value="1${vo.idx}" <c:if test="${vo.level==1}">selected</c:if>>VVIP</option>
		        <option value="2${vo.idx}" <c:if test="${vo.level==2}">selected</c:if>>VIP</option>
		        <option value="3${vo.idx}" <c:if test="${vo.level==3}">selected</c:if>>GOLD</option>
		        <option value="4${vo.idx}" <c:if test="${vo.level==4}">selected</c:if>>SILVER</option>
		        <option value="0${vo.idx}" <c:if test="${vo.level==0}">selected</c:if>>관리자</option>
		      </select>
    	  </td>
    	  <td>${vo.userInfor=='비공개'?'<font color=blue>비공개</font>':'공개'}</td>
    	  <td>
    	    <c:if test="${vo.userDel=='OK'}"><a href="javascript:memberReset(${vo.idx})"><font color=red>탈퇴신청</font></a></c:if>
    	    <c:if test="${vo.userDel!='OK'}">활동중</c:if>
    	  </td>
    	</tr>
    	<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
</div>
<br/>
<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
<div class="container">
	<ul class="pagination justify-content-center">
		<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
		<c:if test="${totPage != 0}">
		  <c:if test="${pag != 1}">
		    <li class="page-item"><a href="${ctp}/admin/adMemberList?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${curBlock > 0}">
		    <li class="page-item"><a href="${ctp}/admin/adMemberList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
		    <c:if test="${i == pag && i <= totPage}">
		      <li class="page-item active"><a href='${ctp}/admin/adMemberList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i != pag && i <= totPage}">
		      <li class="page-item"><a href='${ctp}/admin/adMemberList?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${curBlock < lastBlock}">
		    <li class="page-item"><a href="${ctp}/admin/adMemberList?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
		  </c:if>
		  <c:if test="${pag != totPage}">
		    <li class="page-item"><a href="${ctp}/admin/adMemberList?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
		  </c:if>
		</c:if>
	</ul>
</div>
<!-- 블록 페이징처리 끝 -->
<p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>