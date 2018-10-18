<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>购物车</title>
<script src="js/jquery-1.11.3.min.js"></script>
<script>
	function delProFromCart(pid) {
		if (confirm("您是否要删除该项?")) {
			location.href = "${pageContext.request.contextPath}/product?method=delProFromCart&pid=" + pid;
		}
	}
	
	function clearCart() {
		if (confirm("您是否要清空购物车?")) {
			location.href = "${pageContext.request.contextPath}/product?method=clearCart";
		}
	}
</script>
</head>
<body>
	<!-- 引入header.jsp -->
	<jsp:include page="header.jsp"></jsp:include>
	<!-- 判断购物车中是否有商品 -->
	<c:if test="${not empty cart.cartItems}">
	<table style="text-align: center;margin: 20px auto">
		
		<thead>
			<tr>
				<th>图片</th>
				<th>商品</th>
				<th>价格</th>
				<th>数量</th>
				<th>小计</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach  items="${cart.cartItems}" var="entry">
			<tr>
				<td width="60" width="40%">
					<input type="hidden" name="id" value="22">
				<img src="${pageContext.request.contextPath}/${entry.value.product.pimage}" width="70" height="60">
				</td>
				<td width="30%">
					<a target="_blank">${entry.value.product.pname}</a>
				</td>
				<td width="20%">
					${entry.value.product.price} CNY
				</td>
				<td width="10%">
					${entry.value.buyNum }
				</td>
				<td width="15%">
					<span>${entry.value.subtotal }</span>
				</td>
				<td>
					<a href="javascript:;" onclick="delProFromCart('${entry.value.product.pid}')" >删除</a>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
<div style="text-align: right;margin-right:200px">
		<span>总计:${cart.total}</span>元 <br>
		<a href="javascript:;" onclick="clearCart()"><span>清空购物车</span></a> &nbsp;
		<a href="${pageContext.request.contextPath}/product?method=submitOrder"><input type="button" value="提交"></a>
	</div>
	</c:if>
	<c:if test="${empty cart.cartItems }">
		<div style="text-align:center;">
			<a href="${pageContext.request.contextPath}/">
			<img src="${pageContext.request.contextPath}/image/cart-empty.png" width="35%" height="30%" style="margin:20px auto;">
			</a>
		</div>
	</c:if>
	  <jsp:include page="foot.jsp"></jsp:include>
</body>
</html>