<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员登录</title>
<style type="text/css">
	#pstext{
		margin-left: 16px;
	}
</style>
<script src="js/jquery-1.11.3.min.js"></script>
</head>
<body>
		
	    <jsp:include page="header.jsp"></jsp:include>
		<form action="${pageContext.request.contextPath}/user?method=login" method="POST">
			<span>用户名:</span><input type="text" name="username"> <br>
			<span id="pstext">密码:</span><input type="password" name="password"> <br>
			<span>记住密码?</span><input type="checkbox" name="autoLogin" value="autoLogin">
			&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="登录">&nbsp;&nbsp;&nbsp;&nbsp;
			<span style="color: red">${loginFailMsg }</span>
		</form>
	
   <jsp:include page="foot.jsp"></jsp:include>
</body>
</html>