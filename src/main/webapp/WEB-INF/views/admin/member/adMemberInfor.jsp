<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adMemberInfor.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  	th {background-color: lightgray;}
  	a:link {color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black; text-decoration: none;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr/><hr/><br/>
<jsp:include page="/WEB-INF/views/include/adMenu.jsp"/>
<div class="modal-dialog"  style="text-align:center">
	<h3><b>◈회 원 정 보◈</b></h3>
	<br/>
	<table class="table">
		<tr>
			<th>회원등급</th>
			<td> 
				<c:choose>
					<c:when test="${vo.level==1}"><c:set var="level" value="VVIP"/></c:when>
					<c:when test="${vo.level==2}"><c:set var="level" value="VIP"/></c:when>
					<c:when test="${vo.level==3}"><c:set var="level" value="GOLD"/></c:when>
					<c:when test="${vo.level==0}"><c:set var="level" value="관리자"/></c:when>
					<c:otherwise><c:set var="level" value="SILVER"/></c:otherwise>
				</c:choose>
				${level}
			</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${vo.mid}</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${vo.nickName}</td>
		</tr>
		<tr>
			<th>성명</th>
			<td>${vo.name}</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>${vo.gender}</td>
		</tr>
		<tr>
			<th>생일</th>
			<td>${fn:substring(vo.birthday,0,10)}</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${vo.tel}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${vo.address}</td>
		</tr>
		<tr>
			<th>E-mail</th>
			<td>${vo.email}</td>
		</tr>
		<tr>
			<th>Point</th>
			<td><fmt:formatNumber value="${vo.point}"/></td>
		</tr>
		<tr>
			<th>정보공개여부</th>
			<td>${vo.userInfor}</td>
		</tr>
		<tr>
			<th>총방문수</th>
			<td>${vo.visitCnt}</td>
		</tr>
    <tr>
    	<th>최초가입일</th>
    	<td>${vo.startDate}</td>
    </tr>
    <tr>
    	<th>최종접속일</th>
    	<td>${vo.lastDate}</td>
    </tr>
    <tr>
    	<th>오늘방문수</th>
    	<td>${vo.todayCnt}</td>
    </tr>
		<tr>
			<th>회원탈퇴여부</th>
			<td> 
				<c:if test="${vo.userDel eq 'NO'}">가입중</c:if>
				<c:if test="${vo.userDel ne 'NO'}"><font color="red">탈퇴신청</font></c:if>
			</td>
		</tr>
	</table>
<hr/>
  <a href="${ctp}/admin/adMemberList" class="btn btn-secondary">돌아가기</a>
</div>
<p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>