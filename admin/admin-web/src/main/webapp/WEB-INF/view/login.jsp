<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html lang="zh-cn">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>用户权限管理系统</title>

	<link href="resources/plugins/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
	<link href="resources/plugins/material-design-iconic-font-2.2.0/css/material-design-iconic-font.min.css" rel="stylesheet"/>
	<link href="resources/plugins/waves-0.7.5/waves.min.css" rel="stylesheet"/>
	<link href="resources/plugins/checkbix/css/checkbix.min.css" rel="stylesheet"/>
	<link href="resources/css/login.css" rel="stylesheet"/>
</head>
<body>
<div id="login-window">
	<div class="input-group m-b-20">
		<span class="input-group-addon"><i class="zmdi zmdi-account"></i></span>
		<div class="fg-line">
			<input id="username" type="text" class="form-control" name="username" placeholder="帐号" required autofocus>
		</div>
	</div>
	<div class="input-group m-b-20">
		<span class="input-group-addon"><i class="zmdi zmdi-male"></i></span>
		<div class="fg-line">
			<input id="password" type="password" class="form-control" name="password" placeholder="密码" required>
		</div>
	</div>
 	<div class="input-group m-b-20">
		<span class="input-group-addon"><i class="zmdi zmdi-cloud"></i></span>
		<div class="fg-line">
			<input id="captcha" type="text" class="form-control" name="captcha" placeholder="验证码" required>
		</div>
	</div>
	<div class="input-group m-b-20">
		<span class="input-group-addon"><i class="zmdi"></i></span>
		<img id="img" src="${basePath}/captcha" />
		<a href='#' onclick="javascript:changeImg()"><label style="color:green;">看不清？</label></a>
	</div> 
	<div class="clearfix">
	</div>
	<a id="login-bt" href="javascript:;" class="waves-effect waves-button waves-float"><i class="zmdi zmdi-arrow-forward"></i></a>
</div>
<script src="resources/plugins/jquery.1.12.4.min.js"></script>
<script src="resources/plugins/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script src="resources/plugins/waves-0.7.5/waves.min.js"></script>
<script src="resources/plugins/checkbix/js/checkbix.min.js"></script>

<script src="resources/js/common/sessionTimeout.js"></script>
<script src="resources/js/common/login.js"></script>
<script src="${basePath}/resources/plugins/layer/layer.js"></script>
<script type="text/javascript">
	
	function changeImg(){
        var img = document.getElementById("img"); 
        img.src = "${basePath}/captcha?date=" + new Date();;
    }
    if (self != top) {
        top.location.href = location.href;
    }
</script>
</body>
</html>