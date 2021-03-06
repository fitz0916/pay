<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
		<input type="hidden" id="paymentChannelId" name="paymentChannelId" value="${paymentChannel.paymentChannelId}">
		<input type="hidden" id="customerId" name="customerId" value="${customer.customerId}">
		<div class="form-group">
			<label for="customerName">商户名称：</label>
			<input id="customerName" type="text" class="form-control" value ="${customer.customerName}" name="customerName" maxlength="50" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="channelName">渠道名称：</label>
			<input id="channelName" type="text" class="form-control" value ="${paymentChannel.channelName}" name="channelName" maxlength="50" readonly="readonly">
		</div>
		<div class="radio">
			<div class="radio radio-inline radio-info">
				<input id="status_1" type="radio" name="status" value="1" checked>
				<label for="status_1">启用 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="status_0" type="radio" name="status" value="0">
				<label for="status_0">锁定 </label>
			</div>
		</div>
		<div class="form-group">
		
		</div>
		<div class="form-group">
			<label for="thirdRate">接入费率(‰),格式如：0.028</label>
			<input id="thirdRate" type="text" class="form-control"  name="thirdRate"  maxlength="50">
		</div>
		<div class="form-group">
			<label for="customerRate">代理商费率(‰),格式如：0.038</label>
			<input id="customerRate" type="text" class="form-control" name="agentRate" maxlength="50">
		</div>
		<div class="form-group">
			<label for="customerRate">门店费率(‰),格式如：0.048</label>
			<input id="customerRate" type="text" class="form-control" name="shopRate" maxlength="50">
		</div>
		<div class="form-group">
			<label for="customerRate">商户费率(‰),格式如：0.058</label>
			<input id="customerRate" type="text" class="form-control" name="customerRate" maxlength="50">
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createCustomerChannelFeeSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createCustomerChannelFeeDialog.close();">取消</a>
		</div>
	</form>
</div>
<script type="text/javascript">
function createCustomerChannelFeeSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/manage/customerpaymentchannelfee/create',
        data: $('#createForm').serialize(),
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
                }  else {
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
				createCustomerChannelFeeDialog.close();
				var customerId = $('#customerId').val();
				var childTableId = '#child_customerpaymentchannelinfo_table' + customerId
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