<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<html>
<head>
  <title>장바구니</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <%-- <link rel="stylesheet" href="${ctp}/css/cart.css?after"> --%>
  <script>
    function onTotal(){
      var total = 0;
      var maxIdx = document.getElementById("maxIdx").value;
      for(var i=1;i<=maxIdx;i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      
      if(total>=50000||total==0){
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=2500;
      }
      var lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);  // 화면에 보여주는 주문 총금액
      document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice);  // 값을 넘겨주는 '주문 총 금액 필드'
    }
    
    function onCheck(){
      var maxIdx = document.getElementById("maxIdx").value;

      var cnt=0;
      for(var i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          cnt++;
          break;
        }
      }
      if(cnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();
    }
    
    function allCheck(){
      var maxIdx = document.getElementById("maxIdx").value;
      if(document.getElementById("allcheck").checked){
        for(var i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(var i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();
    }
    
    // cart에 들어있는 품목 삭제하기
    function cartDel(idx){
    	if(!document.getElementById("idx"+idx).checked) {
    		alert("현재 상품을 삭제하시려면 현상품의 체크박스에 체크해주세요.");
    		return false;
    	}
      var ans = confirm("선택하신 현재상품을 장바구니에서 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/dbShop/dbCartDel",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("전송에러");
        }
      });
    }
    
    function order(){
      //구매하기위해 체크한 장바구니에만 아이디가 check인 필드의 값을 1로 셋팅. 체크하지 않은것은 check아이디필드의 기본값은 0이다.
      var maxIdx = document.getElementById("maxIdx").value;
      for(var i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){
          document.getElementById("checkItem"+i).value="1";
        }
      }
      //배송비넘기기
      if(document.getElementById("lastPrice").value==0){
        alert("장바구니에서 상품을 선택해주세요.");
        return false;
      } 
      else {
        document.myform.submit();
      }
    }
    
    // 천단위마다 쉼표 표시하는 함수
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
<hr/><hr/>
<p><br/></p>
<div class="container">
	<h3><b>장바구니</b></h3>
	<hr color="black"/>
	<br/>
	<form name="myform" method="post">
		<table class="table table-borderless" style="width:100%; border-bottom: 1px solid #ccc; border-top: 1px solid #ccc;">
		  <tr class="text-center" style="border-bottom: 1px solid #ccc; background-color: aliceblue">
		    <td><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></td>
		    <td colspan="2" style="border:1px solid #ccc;"><b>상품정보</b></td>
		    <td style="border:1px solid #ccc;"><b>상품금액</b></td>
		    <td><b>삭제</b></td>
		  </tr>
		  <!-- 장바구니 목록출력 -->
		  <c:set var="maxIdx" value="0"/>
		  <c:forEach var="listVo" items="${cartListVos}">
		    <tbody>
		    <tr align="center">
		      <td style="border-bottom: 1px solid #ccc;">
		      	<br/>
		      	<input type="checkbox" name="idxChecked" id="idx${listVo.idx}" value="${listVo.idx}" onClick="onCheck()" />
		      </td>
		      <td style="width:20%; border:1px solid #ccc;">
		      	<img src="${ctp}/dbShop/${listVo.thumbImg}" class="thumb" style="width:80%"/>
		      </td>
		      <td style="width:60%; border-bottom: 1px solid #ccc;" align="left">
		        <br/>
		        <p class="contFont">
		          <span style="color:navy;font-weight:bold;">${listVo.productName}</span>
		        </p>
		        <c:set var="optionNames" value="${fn:split(listVo.optionName,',')}"/>
		        <c:set var="optionPrices" value="${fn:split(listVo.optionPrice,',')}"/>
		        <c:set var="optionNums" value="${fn:split(listVo.optionNum,',')}"/>
		        <p class="contFont" style="font-size:0.8em;">
		          <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
		            &nbsp;${optionNames[i]} / <fmt:formatNumber value="${optionPrices[i]}"/>원 / ${optionNums[i]}개<br/>
		          </c:forEach>
		        </p>
		      </td>
		      <td style="width:10%; border:1px solid #ccc;">
		      	<br/>
		        <div class="totalFont">
			        <b><fmt:formatNumber value="${listVo.totalPrice}" pattern='#,###원'/></b><br/><br/>
			        <input type="hidden" id="totalPrice${listVo.idx}" value="${listVo.totalPrice}"/>
		        </div>
		      </td>
		      <td style="width:10%; border-bottom: 1px solid #ccc;">
		      	<br/>
		        <button type="button" class="btn btn-outline-secondary btn-light btn-sm btnFont" onClick="cartDel(${listVo.idx})">X</button>
		        <input type="hidden" name="checkItem" value="0" id="checkItem${listVo.idx}"/>
		        <input type="hidden" name="idx" value="${listVo.idx }"/>
		        <input type="hidden" name="thumbImg" value="${listVo.thumbImg}"/>
		        <input type="hidden" name="productName" value="${listVo.productName}"/>
		        <input type="hidden" name="mainPrice" value="${listVo.mainPrice}"/>
		        <input type="hidden" name="optionName" value="${optionNames}"/>
		        <input type="hidden" name="optionPrice" value="${optionPrices}"/>
		        <input type="hidden" name="optionNum" value="${optionNums}"/>
		        <input type="hidden" name="totalPrice" value="${listVo.totalPrice}"/>
		        <input type="hidden" name="mid" value="${smid}"/>
		      </td>
		    </tr>
		    </tbody>
		    <c:set var="maxIdx" value="${listVo.idx}"/>
		  </c:forEach>
		</table>
	  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
	  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
	</form>
	<p><br/></p><p><br/></p>
	<div style="text-align:center;font-size: 0.9em; color:#8C8C8C;margin-bottom: 5px;">50,000원 이상 구매시 무료배송입니다.</div>
	<table class="table table-borderless" style="width:100%;border-bottom: 1px solid #ccc;border-top: 1px solid #ccc;">
		<tr class="text-center" style="border-bottom: 1px solid #ccc; background-color: aliceblue">
			<th style="width:33%;">총상품금액</th>
			<th style="width:33%;">배송비</th>
			<th>총결제금액</th>
		</tr>
		<tr class="text-center">
			<td><input type="text" id="total" value="0" class="totSubBox" style="border:none; color:gray;outline:none; font-size:1.5em;text-align:center; width: 100%;" readonly/></td>
			<td><b>+</b><input type="text" id="baesong" value="0" class="totSubBox" style="border:none; color:gray;outline:none; font-size:1.5em;text-align:center; width: 80%;" readonly/></td>
			<td><b>=</b><input type="text" id="lastPrice" value="0" class="totSubBox" style="border:none; color:gray;outline:none; font-size:1.5em;text-align:center; width: 80%;" readonly/></td>
		</tr>
	</table>	
	<p><br/></p>
	<div align="center" style="clear:both;">
		<input type="button" value="주문하기" class="btn btn-primary" style="width:300px;" onclick="order()">
  	<input type="button" value="쇼핑 계속하기" class="btn btn-light" style="width:300px;" onclick="location.href='${ctp}/';">
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>