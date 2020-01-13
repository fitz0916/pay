<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="updateDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<input type="hidden" id="agentId" name="agentId" value="${customer.agentId}">
	    <input type="hidden" id="shopId" name="shopId" value="${customer.shopId}">
	    <input type="hidden" id="customerId" name="customerId" value="${customer.customerId}">
		<div class="form-group">
			<label for="customerName">商户名称：</label>
			<input id="customerName" type="text" class="form-control" value="${customer.customerName}" name="customerName" maxlength="50">
		</div>
		<div class="form-group">
			<label for="customerNo">商户号：</label>
			<input id="customerNo" type="text" class="form-control" value="${customer.customerNo}" name="customerNo" maxlength="50" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="amount">可用金额：</label>
			<input id="amount" type="text" class="form-control" value="${customer.amount}" name="amount" maxlength="50" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="settlement">待结算金额：</label>
			<input id="settlement" type="text" class="form-control" value="${customer.settlement}" name="settlement" maxlength="50" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="frozenAmount">冻结金额：</label>
			<input id="frozenAmount" type="text" class="form-control" value="${customer.frozenAmount}" name="frozenAmount" maxlength="50" readonly="readonly">
		</div>
		
		<div class="radio">
			<div class="radio radio-inline radio-info">
				<input id="status_1" type="radio" name="status" value="1" <c:if test="${customer.status == 1}">checked</c:if>>
				<label for="status_1">启用 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="status_0" type="radio" name="status" value="0" <c:if test="${customer.status == 0}">checked</c:if>>
				<label for="status_0">锁定 </label>
			</div>
		</div>
		<div class="radio">
			<div class="radio radio-inline radio-info">
				<input id="payoutWay_0" type="radio" name="payoutWay" value="0" <c:if test="${customer.payoutWay == 0}">checked</c:if>>
				<label for="payoutWay_0">自动代付 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="payoutWay_1" type="radio" name="payoutWay" value="1" <c:if test="${customer.payoutWay == 1}">checked</c:if>>
				<label for="payoutWay_1">人工代付 </label>
			</div>
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateCustomerSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateCustomerDialog.close();">取消</a>
		</div>
	</form>
</div>
<script>
function updateCustomerSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/manage/customer/update',
        data: $('#updateForm').serialize(),
        beforeSend: function() {
        },
        success: function(result) {
			if (result.code != 1) {
				if (result.data instanceof Array) {
					$.each(result.data, function(index, value) {
						$.confirm({
							theme: 'dark',
							animation: 'rotateX',
							closeAnimation: 'rotateX',
							title: false,
							content: value.errorMsg,
							buttons: {
								confirm: {
									text: '确认',
									btnClass: 'waves-effect waves-button waves-light'
								}
							}
						});
					});
				} else if(result.code == '10110'){
                	layer.msg(result.msg);
                    location:top.location.href = '${basePath}/login';
                } else {
						$.confirm({
							theme: 'dark',
							animation: 'rotateX',
							closeAnimation: 'rotateX',
							title: false,
							content: result.msg,
							buttons: {
								confirm: {
									text: '确认',
									btnClass: 'waves-effect waves-button waves-light'
								}
							}
						});
				}
			} else {
				updateCustomerDialog.close();
				var shopId = $('#shopId').val();
				var childTableId = '#child_customer_table' + shopId
				var $childCustomerTable = $(childTableId);
				$childCustomerTable.bootstrapTable('refresh');
			}
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
			$.confirm({
				theme: 'dark',
				animation: 'rotateX',
				closeAnimation: 'rotateX',
				title: false,
				content: textStatus,
				buttons: {
					confirm: {
						text: '确认',
						btnClass: 'waves-effect waves-button waves-light'
					}
				}
			});
        }
    });
}
</script>