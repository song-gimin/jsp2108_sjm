<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>주문하기</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <%-- <link rel="stylesheet" href="${ctp}/css/cart.css?after"> --%>
  <!-- 아래는 다음 주소 API를 활용한 우편번호검색 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
	  $(document).ready(function(){
		  $(".nav-tabs a").click(function(){
		    $(this).tab('show');
		  });
		  $('.nav-tabs a').on('shown.bs.tab', function(event){
		    var x = $(event.target).text();         // active tab
		    var y = $(event.relatedTarget).text();  // previous tab
		  });
		});
  
	  // 결제하기
    function order() {
		  
    	/* var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; // 이메일 체크
    	var regExpTel2 = /^[0-9]{3,4}$/gm;
    	var regExpTel3 = /^[0-9]{3,4}$/gm;
    	var regExpPayMethodCard = /^[0-9]{3,4}$/gm; */
    	
    	/* var tel = document.getElementById("tel1") + "-" + document.getElementById("tel2") + "-" + document.getElementById("tel3");
    	document.myform.value = tel; */
    	
    	var tel1 = myform.tel1.value;
    	var tel2 = myform.tel2.value;
    	var tel3 = myform.tel3.value;
    	var tel = tel1 + "-" + tel2 + "-" + tel3;
    	myform.tel.value = tel;
    	
    	var postcode = myform.postcode.value;
			var roadAddress = myform.roadAddress.value;
			var detailAddress = myform.detailAddress.value;
			var extraAddress = myform.extraAddress.value;
			var address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
			if(address=="///") address="";
			myform.address.value = address;
			
    	
		  var paymentCard = document.getElementById("paymentCard").value;
    	var payMethodCard1 = myform.payMethodCard1.value;
    	var payMethodCard2 = myform.payMethodCard2.value;
    	var payMethodCard3 = myform.payMethodCard3.value;
    	var payMethodCard4 = myform.payMethodCard4.value;
    	var payMethodCard = payMethodCard1 + "-" + payMethodCard2 + "-" + payMethodCard3 + "-" + payMethodCard4;
    	document.myform.value = payMethodCard;
    	/* var payMethodCard = document.getElementById("payMethodCard").value; */
		  var paymentBank = document.getElementById("paymentBank").value;
    	var payMethodBank = document.getElementById("payMethodBank").value;
		  var paymentPhone = document.getElementById("paymentPhone").value;
		  var payMethodPhone1 = myform.payMethodPhone1.value;
    	var payMethodPhone2 = myform.payMethodPhone2.value;
    	var payMethodPhone3 = myform.payMethodPhone3.value;
    	var payMethodPhone = payMethodPhone1 + "-" + payMethodPhone2 + "-" + payMethodPhone3;
    	document.myform.value = payMethodPhone;
    	/* var payMethodPhone = document.getElementById("payMethodPhone").value; */
			
    	if(paymentCard == "" && paymentBank == "" && paymentPhone == "") {
    		alert("결제방식을 선택해주세요.");
    		return false;
    	}
    	if(paymentCard != "" && payMethodCard1 == "" && payMethodCard2 == "" && payMethodCard3 == "" && payMethodCard4 == "") {
    		alert("카드번호를 입력해주세요.");
    		document.getElementById("payMethodCard").focus();
    		return false;
    	}
    	else if(paymentBank != "" && payMethodBank == "") {
    		alert("입금자명을 입력해주세요.");
    		return false;
    	}
    	else if(paymentPhone != "" && payMethodPhone1 == "" && payMethodPhone2 == "" && payMethodPhone3 == "") {
    		alert("핸드폰번호를 입력해주세요.");
    		return false;
    	}
    	var ans = confirm("결제하시겠습니까?");
    	if(ans) {
    		if(paymentCard != "" && payMethodCard != "") {
    			document.getElementById("payment").value = "C"+paymentCard;
    			document.getElementById("payMethod").value = payMethodCard;
    		}
    		else if(paymentBank != "" && payMethodBank != "") {
    			document.getElementById("payment").value = "B"+paymentBank;
    			document.getElementById("payMethod").value = payMethodBank;
    		}
    		else {
    			document.getElementById("payment").value = "P"+paymentPhone;
    			document.getElementById("payMethod").value = payMethodPhone;
    		}
	    	myform.action = "${ctp}/dbShop/orderInput";
	    	myform.submit();
    	}
    }
	  
  	//배송지 정보 라디오버튼 선택시
    function bsChange() {
    	if($('input:radio[id=oribs]').is(':checked')){
    		document.getElementById("name").value = "${memberVo.name}";
    		document.getElementById("sample4_postcode").value = "${fn:split(memberVo.address,'/')[0]}";
    		document.getElementById("sample4_roadAddress").value = "${fn:split(memberVo.address,'/')[1]}";
    		document.getElementById("sample4_detailAddress").value = "${fn:split(memberVo.address,'/')[2]}";
    		document.getElementById("sample4_extraAddress").value = "${fn:split(memberVo.address,'/')[3]}";
    		document.getElementById("tel1").value = "${fn:split(memberVo.tel,'-')[0]}";
    		document.getElementById("tel2").value = "${fn:split(memberVo.tel,'-')[1]}";
    		document.getElementById("tel3").value = "${fn:split(memberVo.tel,'-')[2]}";
    		document.getElementById("email").value = "${mamberVo.email}";
    	}
    	else if($('input:radio[id=newbs]').is(':checked')){
    		document.getElementById("name").value = "";
    		document.getElementById("sample4_postcode").value = "";
    		document.getElementById("sample4_roadAddress").value = "";
    		document.getElementById("sample4_detailAddress").value = "";
    		document.getElementById("sample4_extraAddress").value = "";
    		document.getElementById("tel1").value = "";
    		document.getElementById("tel2").value = "";
    		document.getElementById("tel3").value = "";
    		document.getElementById("email").value = "";
    	}
    }
	  
		//포인트 전액사용버튼 클릭시
    function pointAll() {
    	var point = "";
    	
    	if(point<1000){
    		alert("1,000Point 이상일 때 사용가능합니다.");
    		return false;
    	}
    	else{
    		
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
<hr/>
<p><br/></p>
<div class="container">
	<h3><b>주문하기</b></h3>
	<hr color="black"/>
	<br/>
	<table class="table table-borderless" style="width:100%; border:1px solid #ccc;">
	  <tr class="text-center" style="border-bottom: 1px solid #ccc; background-color: aliceblue">
	  	<td><b>주문번호</b></td>
	    <td colspan="2" style="border:1px solid #ccc;"><b>상품내역</b></td>
	    <td><b>총상품금액</b></td>
	  </tr>
	  <!-- 주문서 목록출력 -->
	  <c:set var="orderTotalPrice" value="0"/>
	  <c:forEach var="vo" items="${orderVos}">
	    <tbody>
	    <tr align="center">
	    	<td style="border-bottom: 1px solid #ccc;">${orderIdx}</td>
	      <td style="width:20%; border:1px solid #ccc;"><img src="${ctp}/dbShop/${vo.thumbImg}" class="thumb" style="width:80%"/></td>
	      <td style="width:60%; border:1px solid #ccc; border-bottom: 1px solid #ccc;" align="left">
	        <p style="color:navy; font-weight:bold;">${vo.productName}</p>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p style="font-size:0.9em;">
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp;&nbsp;${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach> 
	        </p>
	      </td>
	      <td style="border-bottom: 1px solid #ccc;">
	        <b><fmt:formatNumber value="${vo.totalPrice}" pattern='#,###원'/></b>
	      </td>
	    </tr>
	    </tbody>
	    <c:set var="orderTotalPrice" value="${orderTotalPrice + vo.totalPrice}"/>
	  </c:forEach>
	  <tr class="text-right">
	  	<td colspan="4">총 상품 주문 금액 : <b><fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/></b></td>
	  </tr>
	</table>
	<p><br/></p>
	<form name="myform" method="post">
		<h5><b>배송 정보</b></h5>
		<table class="table table-borderless" style="width:100%; border:1px solid #ccc;">
			<tr>
				<th class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">배송지 선택</th>
				<td style="border: 1px solid #ccc;">
					<input type="radio" name="bs" id="oribs" onchange="bsChange()" checked /> 회원 정보와 동일 &nbsp;&nbsp;
					<input type="radio" name="bs" id="newbs" onchange="bsChange()"/> 신규 배송지
				</td>
			</tr>
			<tr>
				<th class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">받는사람<font color="red">*</font></th>
				<td style="border: 1px solid #ccc;"><input type="text" name="name" id="name" value="${memberVo.name}" required/></td>
			</tr>
			<tr>
				<th class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">주소 <font color="red">*</font></th>
				<td style="border: 1px solid #ccc;">
					<input type="text" id="sample4_postcode" name="postcode" size=6 placeholder="우편번호" value="${fn:split(memberVo.address,'/')[0]}" readonly required />&nbsp;
					<input type="button" class="btn btn-secondary btn-sm" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="font-size: 0.8em;"/><br/><br/>
					<input type="text" id="sample4_roadAddress" name="roadAddress" size=50 placeholder="도로명주소" value="${fn:split(memberVo.address,'/')[1]}" readonly style="width:300px;" required /><br/><br/>
					<input type="text" id="sample4_detailAddress" name="detailAddress" size=50 placeholder="상세주소" value="${fn:split(memberVo.address,'/')[2]}" style="width:300px;"/>
					<input type="text" id="sample4_extraAddress" name="extraAddress" size=50 placeholder="(참고항목)" value="${fn:split(memberVo.address,'/')[3]}" style="width:300px;"/>
				</td>
			</tr>
			<tr>
				<th class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">휴대전화 <font color="red">*</font></th>
				<td style="border: 1px solid #ccc;">
					<select name="tel1" id="tel1">
						<c:set var="tel1" value="${fn:split(memberVo.tel,'-')[0]}"/>
						<option value="010" selected >010</option>
						<option value="011" >011</option>
						<option value="02">02</option>
						<option value="031" >031</option>
						<option value="032" >032</option>
						<option value="033" >033</option>
						<option value="041" >041</option>
						<option value="042" >042</option>
						<option value="043" >043</option>
						<option value="044" >044</option>
						<option value="051" >051</option>
						<option value="052" >052</option>
						<option value="053" >053</option>
						<option value="054" >054</option>
						<option value="055" >055</option>
						<option value="061" >061</option>
						<option value="062" >062</option>
						<option value="063" >063</option>
						<option value="064" >064</option>
					</select>
					-<input type="text" name="tel2" id="tel2" size=3 maxlength=4 class="text-center" value="${fn:split(memberVo.tel,'-')[1]}"/>
					-<input type="text" name="tel3" id="tel3" size=3 maxlength=4 class="text-center" value="${fn:split(memberVo.tel,'-')[2]}"/>
				</td>
			</tr>
			<tr>
				<th class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">이메일<font color="red">*</font></th>
				<td style="border: 1px solid #ccc;">
					<input type="text" name="email" id="email" value="${memberVo.email}" style="width:300px;"/><br/>
					<span style="font-size: 0.9em;color:#747474;">이메일로 주문 처리 과정을 보내드립니다.&nbsp;&nbsp;수신 가능한 이메일 주소를 입력해주세요.</span>
				</td>
			</tr>
			<tr>
				<th class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">배송메세지</th>
				<td style="border: 1px solid #ccc;">
					<textarea id="message" name="message" style="width:100%;"></textarea>
				</td>
			</tr>
		</table>
		<p><br/></p>
		<h5><b>할인 정보</b></h5>
		<table class="table table-borderless" style="width:100%; border:1px solid #ccc;">
			<tr>
				<th class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">포인트 사용</th>
				<td style="border: 1px solid #ccc;">
					<input type="text" name="usePoint" id="usePoint" placeholder="사용할 적립금을 입력하세요." style="width:250px; text-align: center;"/>&nbsp;
					<input type="button" onclick="pointAll()" value="전액 사용" class="btn btn-secondary btn-sm" style="font-size: 0.8em;"/><br/>
					<span style="font-size: 0.9em;color:gray;">(현재 적립금 : <b>${memberVo.point}</b>Point)&nbsp;&nbsp;&nbsp;<b><font color=red>*</font></b>최소 1,000Point 이상일 때 사용 가능합니다.</span>
				</td>
			</tr>
			<tr>
				<th class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">쿠폰 사용</th>
				<td style="border: 1px solid #ccc;">
					<select>
						<option value="">사용할 쿠폰을 선택해주세요.</option>
					</select>&nbsp;
					<input type="button" value="적용하기" class="btn btn-secondary btn-sm" style="font-size: 0.8em;"/><br/>
					<span style="font-size: 0.9em;color:gray;">(구매 상품 취소, 환불시 사용한 쿠폰의 환불은 불가합니다.)</span>
				</td>
			</tr>
		</table>
		<p><br/></p>
		<h5><b>결제 금액</b></h5>
		<table class="table table-borderless" style="width:100%; border:1px solid #ccc;">
			<tr class="text-center" style="border: 1px solid #ccc; background-color: aliceblue">
				<th>총 주문 금액</th>
				<th style="border: 1px solid #ccc;">총 할인 금액</th>
				<th>총 결제 예정 금액</th>
			</tr>
			<tr class="text-center">
				<td>
					<fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/>
					<input type="hidden" value="${orderTotalPrice}" readonly/>
				</td>
				<td>
					-&nbsp;&nbsp;<fmt:formatNumber value="${memberVo.point}" pattern='#,###원'/>
					<input type="hidden"/>
				</td>
				<td>
					=&nbsp;&nbsp;<fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/>
					<input type="hidden" value=""/>
				</td>
			</tr>
		</table>
		<p class="text-center"><b>*</b>적립 예정 포인트 : <b>${memberVo.point}</b>Point&nbsp;&nbsp;(<font size="2">결제 금액의 1%가 적립됩니다.</font>)</p>
		<p><br/></p>
		<h5><b>결제 수단</b></h5>
		<p></p>
		<!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist">
		  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">신용카드</a></li>
		  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">무통장입금</a></li>
		  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#phone">휴대폰결제</a></li>
		</ul>
		<!-- Tab panes -->
	  <div class="tab-content">
	    <div id="card" class="container tab-pane active"><br/>
	      <p>카드선택 &nbsp;&nbsp;
	        <select name="paymentCard" id="paymentCard">
	          <option value="">선택해주세요.</option>
	          <option value="BC">BC</option>
	          <option value="LG">LG</option>
	          <option value="국민">국민</option>
	          <option value="농협">농협</option>
	          <option value="롯데">롯데</option>
	          <option value="삼성">삼성</option>
	          <option value="신한">신한</option>
	          <option value="현대">현대</option>
	        </select>
	      </p>
	      <p>카드번호 &nbsp;&nbsp;
					<input type="text" name="payMethodCard1" id="payMethodCard1" size=3 maxlength=4 class="text-center" placeholder="0000"/>
					-&nbsp;<input type="text" name="payMethodCard2" id="payMethodCard2" size=3 maxlength=4 class="text-center" placeholder="0000"/>
					-&nbsp;<input type="text" name="payMethodCard3" id="payMethodCard3" size=3 maxlength=4 class="text-center" placeholder="0000"/>
					-&nbsp;<input type="text" name="payMethodCard4" id="payMethodCard4" size=3 maxlength=4 class="text-center" placeholder="0000"/>
<!-- 					<input type="text" name="payMethodCard1" id="payMethodCard1" size=3 maxlength=4 class="text-center" placeholder="0000"/>
					-&nbsp;<input type="text" name="payMethodCard2" id="payMethodCard2" size=3 maxlength=4 class="text-center" placeholder="0000"/>
					-&nbsp;<input type="text" name="payMethodCard3" id="payMethodCard3" size=3 maxlength=4 class="text-center" placeholder="0000"/>
					-&nbsp;<input type="text" name="payMethodCard4" id="payMethodCard4" size=3 maxlength=4 class="text-center" placeholder="0000"/> -->
				</p>
	    </div>
	    <div id="bank" class="container tab-pane fade"><br/>
	      <p>입금은행 &nbsp;&nbsp;
	        <select name="paymentBank" id="paymentBank">
	          <option value="">선택해주세요.</option>
	          <option value="국민은행">국민은행</option>
	          <option value="농협은행">농협은행</option>
	          <option value="신한은행">신한은행</option>
	          <option value="우리은행">우리은행</option>
	          <option value="하나은행">하나은행</option>
	        </select>
	      </p>
				<p>입금자명 &nbsp;&nbsp;
					<input type="text" name="payMethodBank" id="payMethodBank" placeholder="입금자명을 입력하세요."/>
				</p>
	    </div>
		  <div id="phone" class="container tab-pane fade"><br/>
		  	<p>&nbsp;&nbsp;&nbsp;&nbsp;통신사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <select name="paymentPhone" id="paymentPhone">
	          <option value="">선택해주세요.</option>
	          <option value="SKT">SKT</option>
	          <option value="KT">KT</option>
	          <option value="LGU+">LGU+</option>
	          <option value="알뜰폰">알뜰폰</option>
	        </select>
	      </p>
				<p>핸드폰 번호 &nbsp;&nbsp;
					<select name="payMethodPhone1" id="payMethodPhone1">
						<option value="" >선택</option>
						<option value="010" >010</option>
						<option value="011" >011</option>
						<option value="016" >016</option>
						<option value="017" >017</option>
						<option value="018" >018</option>
						<option value="019" >019</option>
					</select>
					-&nbsp;<input type="text" name="payMethodPhone2" id="payMethodPhone2" size=2 maxlength=4 class="text-center"/>
					-&nbsp;<input type="text" name="payMethodPhone3" id="payMethodPhone3" size=2 maxlength=4 class="text-center"/>
				</p>
		    <font size="2">* 결제금액이 통신사 휴대폰 요금에 청구됩니다.<br/>* 월 결제 한도는 최대 50만원입니다.</font>
		  </div>
	  </div>
		<hr/><br/>
		<div align="center">
			<input type="button" value="결제하기" class="btn btn-primary" style="width:300px;" onclick="order()">
  		<input type="button" value="돌아가기" class="btn btn-light" style="width:300px;" onclick="location.href='${ctp}/dbShop/dbCartList';">
		</div>
		<input type="hidden" name="orderVos" value="${orderVos}"/>
	  <input type="hidden" name="orderIdx" value="${orderIdx}"/>
	  <input type="hidden" name="orderTotalPrice" value="${orderTotalPrice}"/>
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="payment" id="payment"/>
	  <input type="hidden" name="payMethod" id="payMethod"/>
	  <input type="hidden" name="tel" id="tel"/>
	  <input type="hidden" name="address" id="address"/>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>