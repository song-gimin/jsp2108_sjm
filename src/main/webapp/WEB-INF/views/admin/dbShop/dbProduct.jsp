<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>상품등록</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
    function fCheck() {
    	var categoryMainCode = myform.categoryMainCode.value;
    	var categoryMiddleCode = myform.categoryMiddleCode.value;
    	var productName = myform.productName.value;
			var mainPrice = myform.mainPrice.value;
			var detail = myform.detail.value;
			var file = myform.file.value;												// 파일명
			var ext = file.substring(file.lastIndexOf(".")+1);  // 확장자 구하기
			var uExt = ext.toUpperCase();
			var regExpPrice = /^[0-9|_]*$/;   // 가격은 숫자로만 입력받음
			// var disPrice = myform.disPrice.value;
			
			if(categoryMainCode == "") {
				alert("상품 대분류를 입력하세요.");
				return false;
			}
			else if(categoryMiddleCode == "") {
				alert("상품 중분류를 입력하세요.");
				return false;
			}
			else if(product == "") {
				alert("상품명을 입력하세요.");
				return false;
			}
			else if(file == "") {
				alert("상품이미지를 등록하세요.");
				return false;
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(mainPrice == "" || !regExpPrice.test(mainPrice)) {
				alert("상품금액은 숫자로만 입력하세요.");
				return false;
			}
			/* else if(disPrice == "" || !regExpPrice.test(disPrice)) {
				alert("할인금액은 숫자로만 입력하세요.");
				return false;
			} */
			else if(detail == "") {
				alert("상품설명을 입력하세요.");
				return false;
			}
			else if(document.getElementById("file").value != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var fileSize = document.getElementById("file").files[0].size;
				if(fileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요.");
					return false;
				}
				else {
					myform.submit();
				}
			}
    }
    
    // 상품 입력창에서 대분류 선택(Change)시 중분류가져와서 중분류 선택박스에 뿌리기
    function categoryMainChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categoryMiddleName",
				data : {categoryMainCode : categoryMainCode},
				success:function(data) {
					var str = "";
					str += "<option value=''>중분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categoryMiddleCode+"'>"+data[i].categoryMiddleName+"</option>";
					}
					$("#categoryMiddleCode").html(str);
				},
				error : function() {
					alert("전송오류");
				}
			});
  	}
    
    // 할인가격 입력하기
    
    
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
<div class="container-lg p-3">
<jsp:include page="/WEB-INF/views/include/adMenu.jsp"/>
  <div id="product">
	<br/>
    <h3 class="text-center">상품등록</h3>
    <br/><br/>
    <form name="myform" method="post" enctype="multipart/form-data">
      <div class="form-group" style="width: 30%;">
        <label for="categoryMainCode"><b>대분류</b></label>
        <select id="categoryMainCode" name="categoryMainCode" class="form-control" onchange="categoryMainChange()">
          <option value="">대분류를 선택하세요.</option>
          <c:forEach var="mainVo" items="${mainVos}">
          	<option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
          </c:forEach>
        </select>
      </div>
      <div class="form-group" style="width: 30%;">
        <label for="categoryMiddleCode"><b>중분류</b></label>
        <select id="categoryMiddleCode" name="categoryMiddleCode" class="form-control">
          <option value="">중분류를 선택하세요.</option>
		  	  <c:forEach var="middleVo" items="${middleVos}">
		  	    <option value=""></option>
		  	  </c:forEach>
        </select>
      </div>
      <div class="form-group" style="width: 90%;">
        <label for="productName"><b>상품명</b></label>
        <input type="text" name="productName" id="productName" class="form-control" placeholder="상품명을 입력하세요." required/>
      </div>
      <div class="form-group" style="width: 90%;">
        <label for="file"><b>메인이미지</b></label>
        <input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required/>
        <h6>(업로드 가능한 파일: jpg, jpeg, gif, png)</h6>
      </div>
      <div class="form-group" style="width: 30%;">
      	<label for="mainPrice"><b>상품가격</b></label>
      	<input type="text" name="mainPrice" id="mainPrice" class="form-control" placeholder="상품가격을 입력하세요." required/>
      </div>
      <!-- <div class="form-group">
        <label for="disprice"><b>할인가격</b></label>
        <br/>
        <input type="radio" name="dis" value="없음" onclick="inputDis(this.value)" id="disno" checked/> 없음 &nbsp;&nbsp;
        <input type="radio" name="dis" value="0.03" onclick="inputDis(this.value)"/> 3% &nbsp;&nbsp;
        <input type="radio" name="dis" value="0.05" onclick="inputDis(this.value)"/> 5% &nbsp;&nbsp;
        <input type="radio" name="dis" value="0.1" onclick="inputDis(this.value)"/> 10% &nbsp;&nbsp;
        <input type="radio" name="dis" value="0.15" onclick="inputDis(this.value)"/> 15% &nbsp;&nbsp;
        <input type="radio" name="dis" value="0.2" onclick="inputDis(this.value)"/> 20% &nbsp;&nbsp;
        <input type="radio" name="dis" value="직접입력" onclick="inputDis(this.value)"/> 직접입력 
        <input type="text" class="form-control" id="disprice" placeholder="할인가격입력" name="disprice" style="width: 43%;" readonly/>
    	</div>    -->
      <div class="form-group">
      	<label for="detail"><b>상품기본설명</b></label>
      	<input type="text" name="detail" id="detail" class="form-control" placeholder="상품설명을 입력하세요." required/>
      </div>
      <div class="form-group">
      	<label for="content"><b>상품상세사진</b></label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/dbShop/imageUpload",     /* 그림파일 드래그&드롭 처리 */
		    	filebrowserUploadUrl: "${ctp}/dbShop/imageUpload",  /* 이미지 업로드 */
		    	height:460
		    });
		  </script>
		  <div style="text-align: center;">
		  	<br/>
		  	<input type="button" value="등록" onclick="fCheck()" class="btn btn-secondary" style="width:120px;"/>
			</div>
    </form>
  </div>
</div>
<p><br/></p><p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>