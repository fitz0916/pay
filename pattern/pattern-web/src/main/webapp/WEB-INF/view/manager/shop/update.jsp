<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="updateDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<input type="hidden" value="${shop.agentId}">
		<div class="form-group">
			<label for="shopName">门店名称：</label>
			<input id="shopName" type="text" class="form-control" value="${shop.shopName}" name="shopName" maxlength="50">
		</div>
		<div class="form-group">
			<label for="brand">门店品牌：</label>
			<input id="brand" type="text" class="form-control" value="${shop.brand}" name="brand" maxlength="50">
		</div>
		<div class="radio">
			状态：
			<div class="radio radio-inline radio-info">
				<input id="status_1" type="radio" name="status" value="1" <if test="${shop.status == 1}">checked</if>>
				<label for="status_1">启用 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="status_0" type="radio" name="status" value="0" <if test="${shop.status == 0}">checked</if>>
				<label for="status_0">锁定 </label>
			</div>
		</div>
		<div class="form-group">
			<label for="phone">手机号码：</label>
			<input id="phone" type="text" class="form-control" value="${shop.phone}" name="phone" maxlength="20">
		</div>
		<div class="form-group">
			<label for="address">门店地址</label>
			<input id="address" type="text" class="form-control" value="${shop.address}" name="address" maxlength="100">
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
		</div>
	</form>
</div>
