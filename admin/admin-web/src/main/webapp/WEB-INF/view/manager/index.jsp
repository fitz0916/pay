<%@ page contentType="text/html; charset=utf-8"%>
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

	<link href="../resources/plugins/fullPage/jquery.fullPage.css" rel="stylesheet"/>
	<link href="../resources/plugins/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
	<link href="../resources/plugins/material-design-iconic-font-2.2.0/css/material-design-iconic-font.min.css" rel="stylesheet"/>
	<link href="../resources/plugins/waves-0.7.5/waves.min.css" rel="stylesheet"/>
	<link href="../resources/plugins/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
	<link href="../resources/css/admin.css" rel="stylesheet"/>
	
	<style>
		/** skins 
		<c:forEach var="adminSystemtem" items="${adminSystems}">
			 #header {background: ${adminSystemtem.theme};}
			 .content_tab{background: ${adminSystemtem.theme};}
			 .s-profile>a{background: url(${adminSystemtem.banner}) left top no-repeat;}
		</c:forEach>
		**/
		 #header {background: #29A176;}
		.content_tab{background: #29A176;}
		.s-profile>a{background: url(/resources/images/zheng-upms.png) left top no-repeat;}
	</style>
</head>
<body>
<header id="header">
	<ul id="menu">
		<li id="guide" class="line-trigger">
			<div class="line-wrap">
				<div class="line top"></div>
				<div class="line center"></div>
				<div class="line bottom"></div>
			</div>
		</li>
		<li id="logo" class="hidden-xs">
			<a href="index.html">
				<img src=""/>
			</a>
			<span id="system_title">权限管理系统</span>
		</li>
		<li class="pull-right">
			<ul class="hi-menu">
				<li class="dropdown">
					<a class="waves-effect waves-light" data-toggle="dropdown" href="javascript:;">
						<i class="him-icon zmdi zmdi-more-vert"></i>
					</a>
					<ul class="dropdown-menu dm-icon pull-right">
						<li class="hidden-xs">
							<a class="waves-effect" data-ma-action="fullscreen" href="javascript:fullPage();"><i class="zmdi zmdi-fullscreen"></i> 全屏模式</a>
						</li>
						<li>
							<a class="waves-effect" href="${basePath}/logout"><i class="zmdi zmdi-run"></i> 退出登录</a>
						</li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>
</header>
<section id="main">
	<!-- 左侧导航区 -->
	<aside id="sidebar">
		<!-- 个人资料区 -->
		<div class="s-profile">
			<a class="waves-effect waves-light" href="javascript:;">
				<div class="sp-pic">
					<img src="${adminUser.avatar}"/>
				</div>
				<div class="sp-info">
					${adminUser.realName}，您好！
					<i class="zmdi zmdi-caret-down"></i>
				</div>
			</a>
			<ul class="main-menu">
				<li>
					<a class="waves-effect" href="${basePath}/logout"><i class="zmdi zmdi-run"></i> 退出登录</a>
				</li>
			</ul>
		</div>
		<!-- /个人资料区 -->
		<!-- 菜单区 -->
		<ul class="main-menu">
			<li>
				<a class="waves-effect" href="javascript:Tab.addTab('首页', 'home');"><i class="zmdi zmdi-home"></i> 首页</a>
			</li>
			<c:forEach var="adminPermission" items="${adminPermissions}" varStatus="status">
				<c:if test="${adminPermission.parentId == 0}">
				<li class="sub-menu">
					<a class="waves-effect" href="javascript:;"><i class="${adminPermission.icon}"></i> ${adminPermission.name}</a>
					<ul>
						<c:forEach var="subadminPermission" items="${adminPermissions}">
							<c:if test="${subadminPermission.parentId == adminPermission.permissionId}">
								<c:forEach var="adminSystem" items="${adminSystems}">
									<c:if test="${subadminPermission.systemId == adminSystem.systemId}">
									<c:set var="systemBasePath" value="${adminSystem.basepath}"/></c:if>
								</c:forEach>
								<li><a class="waves-effect" href="javascript:Tab.addTab('${subadminPermission.name}', '${systemBasePath}${subadminPermission.uri}');">${subadminPermission.name}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				</c:if>
			</c:forEach>
		</ul>
		<!-- /菜单区 -->
	</aside>
	<!-- /左侧导航区 -->
	<section id="content">
		<div class="content_tab">
			<div class="tab_left">
				<a class="waves-effect waves-light" href="javascript:;"><i class="zmdi zmdi-chevron-left"></i></a>
			</div>
			<div class="tab_right">
				<a class="waves-effect waves-light" href="javascript:;"><i class="zmdi zmdi-chevron-right"></i></a>
			</div>
			<ul id="tabs" class="tabs">
				<li id="tab_home" data-index="home" data-closeable="false" class="cur">
					<a class="waves-effect waves-light" href="javascript:;">首页</a>
				</li>
			</ul>
		</div>
		<div class="content_main">
			<div id="iframe_home" class="iframe cur">
				<p><h4>欢迎使用权限系统</h4></p>
			</div>
		</div>
	</section>
</section>
<footer id="footer"></footer>

<script src="../resources/plugins/jquery.1.12.4.min.js"></script>
<script src="../resources/plugins/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script src="../resources/plugins/waves-0.7.5/waves.min.js"></script>
<script src="../resources/plugins/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="../resources/plugins/BootstrapMenu.min.js"></script>
<script src="../resources/plugins/device.min.js"></script>
<script src="../resources/plugins/fullPage/jquery.fullPage.min.js"></script>
<script src="../resources/plugins/fullPage/jquery.jdirk.min.js"></script>
<script src="../resources/plugins/jquery.cookie.js"></script>
<script src="../resources/js/common/sessionTimeout.js"></script>
<script src="../resources/js/common/admin.js"></script>
</body>
</html>