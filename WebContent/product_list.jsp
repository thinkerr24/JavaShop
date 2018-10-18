<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品列表</title>
<style>
	#pageDiv{
		margin-top:10px;
		height:600px;
		width:100%;
		border:1px solid black;
		padding: 25px;
	}
	#pageNums{
		text-align: center;
		margin-bottom: 5px;
		margin-top:50px;
	}
	
	#pageNums a{
		padding:5px;
		border:1px solid blue;
	}
	.ProductItem{
		 
		 float:left;
		 margin:5px;
		 width:23%;
		 heigth:80px;
	}
</style>

<script src="js/jquery-1.11.3.min.js"></script>



</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div id="pageDiv">
		<c:forEach items="${pageBean.list}" var="Pro">
   			 <div class="ProductItem">
   			 <a href="${pageContext.request.contextPath}/product?method=productInfo&pid=${Pro.pid}">
    			<img src="${pageContext.request.contextPath}/${Pro.pimage}" style="width:23%;heigth:50px"> <br>
    		 </a>	
    			<div>${Pro.pname}</div>
    			<div>${Pro.price}元</div>
   			 </div>
   			
   		</c:forEach>
   		<div style="clear: both;"></div>
   		<!-- 分页开始 -->
		<div id="pageNums">
			<c:if test="${pageBean.currentPage == 1 }">
			 <a href="javascript:void(0);" ><</a>
			</c:if>
			
			<c:if test="${pageBean.currentPage != 1 }">
			 <a href="${pageContext.request.contextPath}/product?method=productsByCid&cid=${cid}&currentPage=${pageBean.currentPage - 1}"><</a>
			</c:if>
			
			<c:forEach begin="1" end="${pageBean.totalPage}" var="page"> 
					<c:if test="${page == pageBean.currentPage}">
						<a href="javascript:;" style="background-color: lightblue">${page}</a>
					</c:if>
					<c:if test="${page != pageBean.currentPage}">
						<a href="${pageContext.request.contextPath}/product?method=productsByCid&cid=${cid}&currentPage=${page}">${page}</a>
					</c:if>
			</c:forEach>
			
			<c:if test="${pageBean.currentPage == pageBean.totalPage}">
			 <a href="javascript:void(0);" >></a>
			</c:if>
			
			<c:if test="${pageBean.currentPage != pageBean.totalPage}">
			 <a href="${pageContext.request.contextPath}/product?method=productsByCid&cid=${cid}&currentPage=${pageBean.currentPage + 1}">></a>
			</c:if>
			<!--  <a href="#" class="pageNum" ><</a>
			 <a href="#" class="pageNum" style="background-color: lightblue;" onclick="return false;">1</a>
			 <a href="#" class="pageNum" >2</a>
			 <a href="#" class="pageNum" >></a>  -->
		</div>

	</div>
       <jsp:include page="foot.jsp"></jsp:include>
</body>
</html>