<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>배송지정보</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h2><i class="fas fa-truck"></i>&nbsp;배송지정보</h2>
  <hr/>
  <p><i class="fas fa-check"></i>&nbsp;주문번호 : <b>${vo.orderIdx}</b></p>
  <p><i class="fas fa-check"></i>&nbsp;주문자 : ${vo.name}</p>
  <p><i class="fas fa-check"></i>&nbsp;연락처 : ${vo.tel}</p>
  <p><i class="fas fa-check"></i>&nbsp;주소 : ${vo.address}</p>
  <p><i class="fas fa-check"></i>&nbsp;배송메세지 : ${vo.message}</p>
  <c:if test="${fn:substring(vo.payment,0,1) == 'C'}"><c:set var="payMethod" value="카드결제"/></c:if>
  <c:if test="${fn:substring(vo.payment,0,1) == 'B'}"><c:set var="payMethod" value="무통장입금"/></c:if>
  <c:if test="${fn:substring(vo.payment,0,1) == 'P'}"><c:set var="payMethod" value="핸드폰결제"/></c:if>
  <p><i class="fas fa-check"></i>&nbsp;결제방법 : ${payMethod}&nbsp;(${fn:substring(vo.payment,1,fn:length(vo.payment))})</p>
  <hr/>
  <p class="text-center"><input type="button" value="창닫기" onclick="window.close()"/></p>
</div>
</body>
</html>