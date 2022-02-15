<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>상품옵션등록</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    var cnt = 1;
    
    // 옵션항목 추가
    function addOption() {
    	var strOption = "";
    	var test = "t" + cnt; 
    	
    	strOption += '<div id="'+test+'"><hr size="5px"/>';
    	strOption += '<br/><font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;';
    	strOption += '<input type="button" value="옵션삭제" class="btn btn-outline-secondary btn-sm" onclick="removeOption('+test+')"/><br/><br/>'
    	strOption += '<b>상품옵션이름</b>';
    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="form-control"/>';
    	strOption += '<div class="form-group">';
    	strOption += '<b>상품옵션가격</b>';
    	strOption += '<input type="text" name="optionPrice" id="optionPrice'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div><br/>';
    	$("#optionType").append(strOption);
    	cnt++;
    }
    
    // 옵션항목 삭제
    function removeOption(test) {
    	$("#"+test.id).remove();
    }
    
    // 옵션체크 후 등록 전송
    function fCheck() {
    	for(var i=1; i<=cnt; i++) {
    		if($("#t"+i).length != 0 && document.getElementById("optionName"+i).value=="") {
    			alert("빈칸없이 옵션명을 입력해주세요.");
    			return false;
    		}
    		else if($("#t"+i).length != 0 && document.getElementById("optionPrice"+i).value=="") {
    			alert("빈칸없이 옵션가격을 입력해주세요.");
    			return false;
    		}
    	}
    	if(document.getElementById("optionName").value=="") {
    		alert("옵션이름을 등록하세요.");
    		return false;
    	}
    	else if(document.getElementById("optionPrice").value=="") {
    		alert("옵션가격을 등록하세요.");
    		return false;
    	}
    	else if(document.getElementById("productName").value=="") {
    		alert("상품명을 선택하세요.");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
    }
    
    // 상품명을 선택하면 상품의 설명을 띄워준다.
    function productNameCheck() {
    	var productName = document.getElementById("productName").value;
    	$.ajax({
    		type:"post",
    		url : "${ctp}/dbShop/getProductInfor",
    		data: {productName : productName},
    		success:function(data) {
    			str = '<hr>';
					str += '대분류명 : '+data[0].categoryMainName+'<br>';
    			str += '중분류명 : '+data[0].categoryMiddleName+'<br>';
    			str += '상 품 명  : '+data[0].productName+'<br>';
    			str += '상품코드 : '+data[0].idx+'<br>';
    			str += '상품가격 : '+numberWithCommas(data[0].mainPrice)+'원<br>';
    			str += '<hr>';
    			$("#demo").html(str);
    			document.myform.productIdx.value = data[0].idx;
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 콤마찍기
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
<hr/><hr/><br/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adMenu.jsp"/>
	<br/>
  <h3 class="text-center">상품 옵션 등록</h3>
  <br/><br/>
  <form name="myform" method="post">
    <div class="form-group">
      <label for="productName"><b>상품명</b></label>
      <select name="productName" id="productName" class="form-control" onchange="productNameCheck()">
        <option value="">상품선택</option>
        <c:forEach var="productName" items="${productNames}">
          <option value="${productName}">${productName}</option>
        </c:forEach>
      </select>
      <div id="demo"></div>
    </div>
    <br/><hr/><br/>
    <font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;
    <input type="button" value="옵션추가" onclick="addOption()" class="btn btn-secondary btn-sm"/><br/><br/>
    <div class="form-group">
      <label for="optionName"><b>상품옵션이름</b></label>
      <input type="text" name="optionName" id="optionName" class="form-control"/>
    </div>
    <div class="form-group">
      <label for="optionPrice"><b>상품옵션가격</b></label>
      <input type="text" name="optionPrice" id="optionPrice" class="form-control"/>
    </div>
    <br/>
    <div id="optionType"></div>
    <input type="button" value="옵션등록" onclick="fCheck()" class="btn btn-secondary"/>
    <input type="hidden" name="productIdx">
  </form>
</div>
<p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>