<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>爪哇商城</title>
<style>
	#hotProductList{
		border:1px solid black;
		width:100%;
		height:500px;
		padding:25px;
	}
	#newProductList{
		border:1px solid black;
		width:100%;
		height:500px;
		padding:25px;
		
	}
	.ProductItem{
		 
		 float:left;
		 margin:5px;
		 width:23%;
		 heigth:80px;
	}
	
</style>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script>

</script>
</head>
<body>
	<!-- 引入头部jsp -->
   <jsp:include page="header.jsp"></jsp:include>
   <div><span>热门商品</span></div>
   <div id="hotProductList">
   		<c:forEach items="${hotProducts}" var="hotPro">
   			 <div class="ProductItem">
   			 <a href="${pageContext.request.contextPath}/product?method=productInfo&pid=${hotPro.pid}">
    			<img src="${pageContext.request.contextPath}/${hotPro.pimage}" style="width:23%;heigth:50px"> <br>
    		 </a>	
    			<div>${hotPro.pname}</div>
    			<div>${hotPro.price}元</div>
   			 </div>
   			
   		</c:forEach>
   </div>
   <div style="clear:both"></div>
   <div><span>最新商品</span></div>
   <div id="newProductList">
   			<c:forEach items="${newProducts}" var="newPro">
   			 <div class="ProductItem">
   			 	<a href="${pageContext.request.contextPath}/product?method=productInfo&pid=${newPro.pid}">
    			<img  src="${pageContext.request.contextPath}/${newPro.pimage}" style="width:23%;heigth:50px" onclick="productInfo()"> <br>
    			</a>
    			<div>${newPro.pname}</div>
    			<div>${newPro.price}元</div>
    		
   			 </div>
   		</c:forEach>
   </div>
   <jsp:include page="foot.jsp"></jsp:include>
</body>
</html>