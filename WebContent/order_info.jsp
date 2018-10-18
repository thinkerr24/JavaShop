<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>提交订单</title>
<script src="js/jquery-1.11.3.min.js"></script>
<script>
	function confirmOrder() {
		$("#confirmForm").submit();
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
	<c:if test="${not empty order }">
	<strong style="margin: 20px 200px 20px 200px">订单详情</strong>
	<div>
		<table style="text-align: center;margin: 20px auto">
			<tbody>
				<tr>
					<td>订单编号: ${order.oid}</td>
				</tr>
				
			<tr>
				<th>图片</th>
				<th>商品</th>
				<th>价格</th>
				<th>数量</th>
				<th>小计</th>
			</tr>
		   <c:forEach items="${order.orderItems}" var="orderItem">
		   		<tr>
		   			<td width="30%">
		   			 	<img src="${pageContext.request.contextPath}/${orderItem.product.pimage}" width="70" height="60">	   			
		   			</td>
		   			<td width="30%">
		   				<a target="_blank" width="30%">${orderItem.product.pname}</a>
		   			</td>
		   			<td width="20%">
		   				￥${orderItem.product.price }
		   			</td>
		   			<td width="10%">
		   				${orderItem.num }
		   			</td>
		   			<td width="15%">
		   				${orderItem.subtotal}
		   			</td>
		   		</tr>
		   </c:forEach>
		
			
		</tbody>
		</table>
	</div>
	<div style="margin: 20px auto auto 80px">
	<form id="confirmForm" action="${pageContext.request.contextPath}/product" method="post">
		<!-- 通过隐藏区域指定访问product中的method -->
		<input type="hidden" name="method" value="confirmOrder">
		<input type="hidden" name="oid" value="${order.oid}">
		<label for="address">地址:</label>&nbsp;<input type="text" id="address" name="address" placeholder="请输入收货地址"> <br>
		<label for="name">收货人:</label>&nbsp;<input type="text" id="name" name="name" value="${currentUser.username}" placeholder="请输收货人"> <br>
		<label for="telephone">联系方式:</label>&nbsp;<input type="text" id="telephone" name="telephone" value="${currentUser.telephone}" placeholder="请输入联系方式"> <br>
		<label for="state">已付款?</label> 
		付款<input type="radio"  name="state" value="1">&nbsp;&nbsp;
		未付款<input type="radio" name="state" value="0" checked="checked"> <br>
		<a href="javascript:;" onclick="confirmOrder()">确认订单</a>
	</form>
	</div>
	</c:if>
	<c:if test="${empty order}">
		<div style="text-align: center;">
			<span>您的订单空空如野!</span>
		</div>
	</c:if>
	   <jsp:include page="foot.jsp"></jsp:include>
</body>
</html>