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
	<title>会话管理</title>
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
				<div class="panel-header">brokenes【扫码】支付测试</div>
				<div class="panel-body">
					<form action="${basePath}/wechatpay" method="post" class="form form-horizontal responsive" id="payform" novalidate="novalidate">
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
							<label class="form-label col-xs-3">支付金额(单位元)：</label>
							<div class="formControls col-xs-8">
								<input type="text" class="input-text"  name="payAmount" id="payAmount" value="1">
							</div>
						</div>
						<div class="row clearfix">
							<label class="form-label col-xs-3">交易类型：</label>
							<div class="formControls col-xs-8">
								<div class="row clearfix" style="margin-top:0">
									<div class="col-xs-6">
										<span class="select-box">
											<select class="select" size="1" name="payType" id="payType">
												<option value="" selected="">选择交易类型</option>
									             <option value="41">微信-扫码</option>
									             <option value="42">支付宝-扫码</option>
									             <option value="43">QQ扫码支付</option>
									             <option value="52">网银银行</option>
									             <option value="60">京东钱包</option>
									             <option value="61">银联二维码</option>
									             <option value="62">微信H5</option>
									             <option value="63">QQH5</option>
											</select>
										</span>
									</div>
								</div>
							</div>
						</div>
						<div class="row cl">
							<label class="form-label col-xs-3">异步回调：</label>
							<div class="formControls col-xs-8">
								<input type="text" class="input-text" placeholder="http://" name="notifyUrl" id="notifyUrl" value="http://localhost:8080/payment-trans-api-test/pay/payment">
							</div>
						</div>
						<div class="row cl">
							<label class="form-label col-xs-3">同步回调：</label>
							<div class="formControls col-xs-8">
								<input type="text" class="input-text" placeholder="http://" name="returnUrl" id="returnUrl" value="http://localhost:8080/payment-trans-api-test/pay/payment">
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

