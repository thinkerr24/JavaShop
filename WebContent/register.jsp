<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员注册</title>
<style type="text/css">
.error{
	color:red
}
</style>
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script type="text/javascript">
	// 自定义验证规则
	$.validator.addMethod(
		// 规则的名称
		"isExist",
		// 检验的函数(value:输入的内容 element:被校检的元素对象 params:规则对应的参数值)
		function(value, element, param) {
			var flag = true;
		
			// 目的:对输入的username进行ajax校验
			$.ajax({
				"async":false,
				"data":{"username":value},
				"type":"POST",
				"url":"${pageContext.request.contextPath}/user?method=checkUsername",
				"dataType":"json",
				"success":function(data){
					flag = data.isExist;
				}
			});
			return !flag;
		}
	);
	$(function(){
		$("#registerform").validate({
			rules:{
				"username":{
					"required":true,
					"isExist":true,
				},
				"password":{
					"required":true,
					"rangelength":[6, 12],
				},
				"repassword":{
					"required":true,
					"rangelength":[6, 12],
					"equalTo":"#psd"
				},
				"email":{
					"required":true,
					"email":true
				},
				"sex":{
					"required":true
				}
			},
			messages:{
				"username":{
					"required":"用户名不能为空",
					"isExist":"该用户名已存在"
				},
				"password":{
					"required":"密码不能为空",
					"rangelength":"密码长度6-12位"
				},
				"repassword":{
					"required":"确认密码不能为空",
					"rangelength":"密码长度6-12位",
					"equalTo":"两次密码不一致"
				},
				"email":{
					"required":"邮件不能为空",
					"email":"邮件格式不正确"
				},
				"sex":{
					"required":"还没有选择性别"
				}
			}
		});
	});
	
	function changImg(obj) {
		obj.src = "${pageContext.request.contextPath }/checkImg?time=" + new Date().getTime();
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<form id="registerform" method="post" action="${pageContext.request.contextPath}/user?method=register">
		<span>用户名:</span><input type="text" name="username"> <br>
		<span>密码:</span><input type="password" name="password" id="psd"> <br>
		<span>确认密码:</span><input type="password" name="repassword" ><br>
		<span>邮箱:</span><input type="email" name="email"> <br>
		<span>姓名:</span><input type="text" name="name"> <br>
		<span>性别:</span><input type="radio" name="sex" value="男">男
						  <input type="radio" name="sex" value="女">女 &nbsp;&nbsp;&nbsp;&nbsp;<label class="error" for="sex" style="display:none">还没有选择性别</label>	<br>
						  
        <span>出生日期:</span><input type="date" name="birthday"> <br><br>
        <span>验证码:</span><input type="text" name="code">	<img alt="验证码" onclick="changImg(this)" src="${pageContext.request.contextPath }/checkImg"><br>
	
		<input type="submit" value="注册">       <span style="color: red">${regError }</span>
	</form>
	   <jsp:include page="foot.jsp"></jsp:include>	
</body>
</html>