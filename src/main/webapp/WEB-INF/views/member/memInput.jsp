<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
  Date today = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String sToday = sdf.format(today);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	 <!-- 아래는 다음 주소 API를 활용한 우편번호검색 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	var idCheckOn = 0;
  	var nickCheckOn = 0;
  
  	// 아이디중복체크
  	function idCheck() {
  		var mid = $("#mid").val();
    	if(mid=="" || $("#mid").val().length<5 || $("#mid").val().length>15) {
    		alert("5~15자 이내의 아이디를 입력하세요.");
    		myform.mid.focus();
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url : "${ctp}/member/idCheck",
    		data : {mid:mid},
    		success : function(data) {
					if(data=="1") {
						alert("이미 사용중인 아이디입니다.");
						$("#mid").focus();
					}
					else {
						alert("사용가능한 아이디입니다.");
						idCheckOn = 1; 
					}
				},
				error : function() {
					alert("전송오류");
				}
    	});
    }
    
  	// 닉네임 중복체크(aJax처리)
    function nickCheck() {
    	var nickName = $("#nickName").val();
    	if(nickName=="" || $("#nickName").val().length<2 || $("#nickName").val().length>10) {
    		alert("2~10자 이내의 닉네임을 입력하세요.");
    		myform.nickName.focus();
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url : "${ctp}/member/nickNameCheck",
    		data : {nickName:nickName},
    		success : function(data) {
					if(data=="1") {
						alert("이미 사용중인 닉네임입니다.");
						$("#nickName").focus();
					}
					else {
						alert("사용가능한 닉네임입니다.");
						nickCheckOn = 1; 
					}
				},
				error : function() {
					alert("전송오류");
				}
    	});
    }
  	
  	function idReset() {
  		idCheckOn = 0;
  	}
  	
  	function nickReset() {
  		nickCheckOn = 0;
  	}
  	
  	// 회원가입폼체크
  	function fCheck() {
  		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; // 이메일 체크

    	var mid = myform.mid.value;
    	var pwd = myform.pwd.value;
    	var nickName = myform.nickName.value;
    	var name = myform.name.value;
    	var email = myform.email1.value + "@" + myform.email2.value;
    	var tel = myform.tel1.value + "-" + myform.tel2.value + "-" + myform.tel3.value;
			
    	if(mid == "") {
    		alert("아이디를 입력하세요.");
    		myform.mid.focus();
    	}
    	else if(pwd == "") {
    		alert("비밀번호를 입력하세요.");
    		myform.pwd.focus();
    	}
    	else if(nickName == "") {
    		alert("닉네임을 입력하세요.");
    		myform.nickName.focus();
    	}
    	else if(name == "") {
    		alert("성명을 입력하세요.");
    		myform.name.focus();
    	}
    	else if(!regExpEmail.test(email)) {
    		alert("이메일을 확인하세요.");
    		myform.email.focus();
    	}
    	else if(tel == "") {
    		alert("전화번호를 입력하세요.");
    		myform.tel.focus();
    	}
    	else {
    		if(idCheckOn == 1 && nickCheckOn == 1) {
    			var postcode = myform.postcode.value;
    			var roadAddress = myform.roadAddress.value;
    			var detailAddress = myform.detailAddress.value;
    			var extraAddress = myform.extraAddress.value;
    			var address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
    			if(address=="///") address="";
    			myform.address.value = address;
    			myform.email.value = email;
    			myform.tel.value = tel;
    			
    			myform.submit();
    		}
    		else {
    			if(idCheckOn == 0) {
    				alert("아이디 중복체크버튼을 눌러주세요.");
    			}
    			else {
    				alert("닉네임 중복체크버튼을 눌러주세요.");
    			}
    		}
    	}
    }
  </script>
  <style>
  	input:read-only {background-color: lightgray}
  
  	a:link {color: black; text-decoration: none}
    a:visited {color: black; text-decoration: none;}
    a:hover {color: black; text-decoration: none;}
    a:active {color: black; text-decoration: none;}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<hr/><hr/>
<p><br/></p>
<div class="container" style="padding: 30px;">
	<form name="myform" method="post" class="was-validated">
		<h2 class="text-center"><b>JOIN</b></h2>
		<hr/><br/>
		<div class="form-group">
			<label for="mid">▶아이디 &nbsp; &nbsp;<input type="button" value="중복확인" class="btn btn-secondary btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control" id="mid" onkeyup="idReset()" placeholder="5~15자 이내의 아이디를 입력하세요." name="mid" required autofocus/>
    </div>
		<div class="form-group">
      <label for="pwd">▶비밀번호</label>
     	<input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요. (최대12자)" name="pwd" maxlength="12" required/>
   	</div>
   	<div class="form-group">
      <label for="nickname">▶닉네임 &nbsp; &nbsp;<input type="button" value="중복확인" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" onkeyup="nickReset()"  placeholder="2~10자 이내의 닉네임을 입력하세요." name="nickName" required/>
    </div>
 		<div class="form-group">
      <label for="name">▶성명</label>
    	<input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" maxlength="30" required/>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자">여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">▶생년월일</label>
			<input type="date" name="birthday" value="<%=sToday%>" class="form-control"/>
    </div>
    <div class="form-group">
   	 <label for=tel>▶전화번호</label>
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
			      <select name="tel1" class="custom-select">
					    <option value="010" selected>010</option>
					    <option value="011">011</option>
					    <option value="016">016</option>
					    <option value="017">017</option>
					    <option value="018">018</option>
					    <option value="019">019</option>
					    <option value="02">서울</option>
					    <option value="031">경기</option>
					    <option value="032">인천</option>
					    <option value="041">충남</option>
					    <option value="042">대전</option>
					    <option value="043">충북</option>
			        <option value="051">부산</option>
			        <option value="052">울산</option>
			        <option value="061">전북</option>
			        <option value="062">광주</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="email">▶E-mail</label>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Email" id="email1" name="email1" required/>
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="naver.com" selected>naver.com</option>
					    <option value="hanmail.net">hanmail.net</option>
					    <option value="hotmail.com">hotmail.com</option>
					    <option value="gmail.com">gmail.com</option>
					    <option value="nate.com">nate.com</option>
					    <option value="yahoo.com">yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
    <div class="form-group">
      <label for="address">▶주소</label>
      <input type="hidden" class="form-control" name="address"/>
      <input type="text" name="postcode" id="sample4_postcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="roadAddress" id="sample4_roadAddress" size="50" placeholder="도로명주소">
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="detailAddress" id="sample4_detailAddress" size="30" placeholder="상세주소">
			<input type="text" name="extraAddress" id="sample4_extraAddress" placeholder="참고항목">
    </div>
		<br/>
		<div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>&nbsp;&nbsp; 
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
			  </label>
			</div>
    </div>		
		<br/><hr/>
		<p class="text-center">
			<button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/member/memLogin';">돌아가기</button>
			<button type="button" class="btn btn-secondary" onclick="fCheck()">가입하기</button>
			<button type="reset" class="btn btn-secondary">다시작성</button>
			<input type="hidden" name="email"/>
   	 <input type="hidden" name="tel"/>
		</p>
	</form>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>