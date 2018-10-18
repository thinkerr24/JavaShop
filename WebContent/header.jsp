<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
	.clear{
		clear:both;
	}
	.top {
		height:70px;
		float:left;
		width:25%;
		margin-top:24px;
		margin-left:24px;
	}
	.mid{
		height:70px;
		float:left;
		margin-top:24px;
	}
	#userLoginDiv{
	    padding-top: 30px;
	   text-align: center;
	}
	a{
		text-decoration: none;
	}
	ul{
		padding:4px
	}
	li{
		float:left;
	}
</style>
<script>
	$(function(){
		var content = "";
		$.post(
			"${pageContext.request.contextPath}/product?method=categoryList",
			function(data){
				for (var i = 0; i < data.length; i++) {
					content += "<a href='${pageContext.request.contextPath}/product?method=productsByCid&cid=" + data[i].cid + "'>" + data[i].cname + "</a> &nbsp;&nbsp;"
				}
				$("#categoryList").html(content);
			},
			"json"
		);
	});
</script>
<div style="border:1px solid black;width:100%;height:100px;">
	<div class="top">
		<a style="font-size: 24px" href="${pageContext.request.contextPath}/product?method=index">爪洼商城</a>
	</div>
	 <div class="mid"  id="categoryList">
		
	</div> 
	<c:if test="${empty currentUser }">
		<div id="userLoginDiv">
		<a href="login.jsp">登录</a>
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="register.jsp">注册</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="login.jsp">购物车</a>
		</div>
	</c:if>
	<c:if test="${not empty currentUser }">
			<div id="userLoginDiv">
				<a href="${pageContext.request.contextPath}/product?method=myOrders">${currentUser.username}</a>
	   				 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="${pageContext.request.contextPath}/user?method=logout">注销</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="${pageContext.request.contextPath}/cart.jsp">购物车</a>
			</div>
		</c:if>
	
	
</div>
	<div class="clear"></div>