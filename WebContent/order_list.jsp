<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>我的订单</title>
<script src="js/jquery-1.11.3.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div>
	<table >
		<c:forEach items="${orders}" var="order">
	   <tbody style="text-align: center;">
		<tr>
			<th>图片</th>
			<th>商品</th>
			<th>价格</th>
			<th>数量</th>
			<th>小计</th>
			<th style="font-style: inherit;"><c:if test="${order.state == 0}">未付款</c:if>
			<c:if test="${order.state == 1}">已付款</c:if></th>
		</tr>
		
		    <c:forEach items="${order.orderItems }" var="item">
			<tr>
				<td  width="20%" width="15%">
					<img  src="${pageContext.request.contextPath}/${item.product.pimage}" width="50%" height="60%">
				</td>
				<td width="20%">${item.product.pname}</td>
				<td width="20%">￥${item.product.price}</td>
				<td width="10%">${item.num}</td>
				<td width="15%">${item.subtotal}</td>
			</tr>
			</c:forEach>
		
		</tbody>
		<br>
		</c:forEach>
	</table>
</div>
   <jsp:include page="foot.jsp"></jsp:include>
</body>
</html>