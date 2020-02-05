<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html lang="zh-cn">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>订单查询</title>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link href="../resources/plugins/fullPage/jquery.fullPage.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="${basePath}/resources/css/H-ui.min.css" />
	<script type="text/javascript" src="${basePath}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="${basePath}/resources/js/scan-pay.js"></script>
	<style type="text/css">
	.ui-sortable .panel-header{ cursor:move}
	</style>
</head>
<body>
	
	<div class="panel panel-default">
				<div class="panel-header">brokenes【扫码】订单查询</div>
				<div class="panel-body">
					<form action="${basePath}/pay" method="post" class="form form-horizontal responsive" id="payform" novalidate="novalidate">
						<div class="row cl">
							<label class="form-label col-xs-3">商户号customerNo：</label>
							<div class="formControls col-xs-8">
								<input type="text" class="input-text valid"  name="customerNo" id="customerNo" autocomplete="off" value="10086877891">
							</div>
						</div>
						<div class="row cl">
							<label class="form-label col-xs-3">商户秘钥：</label>
							<div class="formControls col-xs-8">
								<input type="text" class="input-text valid"  name="merKey" id="merKey" autocomplete="off" value="YrDpbi">
							</div>
						</div>
						<div class="row cl">
							<label class="form-label col-xs-3">订单号：</label>
							<div class="formControls col-xs-8">
								<input type="text" class="input-text"  name="payAmount" id="payAmount" value="1">
							</div>
						</div>
						<div class="row cl">
							<div class="col-xs-8 col-xs-offset-3">
								<input class="btn btn-primary" type="button" value="&nbsp;&nbsp;提交&nbsp;&nbsp;" id="payBtn">
							</div>
						</div>
					</form>
				</div>
			</div>

</body>

