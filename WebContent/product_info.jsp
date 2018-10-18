<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详情</title>
<style>
	.product {
		float:left;
	}
	#pimage{
		margin:20px 200px;
	}
</style>
<script src="js/jquery-1.11.3.min.js"></script>
<script>
	function addCart() {
		// 获得购买商品数量
		var buyNum = $("#buyNum").val();
		location.href = "${pageContext.request.contextPath}/product?method=addProductToCart&pid=${product.pid}&buyNum=" + buyNum;
	}
</script>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include> <br><br>
	<div style="border:solid 1px black;width:100%;height:400px">
		<div class="product" id="pimage">
			 <img  src="${pageContext.request.contextPath}/${product.pimage}">
			
		</div>
		<div class="product">
			<br>
			<br>
			<span>${product.pname}</span> <br> <br>
			<span>${product.price}元/台</span> <br> <br>
			<textarea rows="5" cols="51" disabled="disabled">${product.pdesc}</textarea> <br> <br> <br>
			<div class="product">
				<span>购买数量:</span>&nbsp;&nbsp;
				<input type="text" maxlength="4" value="1" size="5" id="buyNum" name="buyNum"> &nbsp;&nbsp;&nbsp;&nbsp; 
				<a href="javascript:void(0);" onclick="addCart()">
				<input  type="button" value="加入购物车" >
				</a>
			</div>
		</div>
		
	</div>
	<div style="clear: both"></div>
	   <jsp:include page="foot.jsp"></jsp:include>
</body>
</html>