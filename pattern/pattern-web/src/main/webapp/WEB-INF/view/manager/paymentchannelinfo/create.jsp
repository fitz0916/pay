<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
		<input type="hidden" id="customerId" name="customerId" value="${customer.customerId}">
	    <input type="hidden" id="customerNo" name="customerNo" value="${customer.customerNo}">
		<div class="form-group">
			<label for="customerName">商户名称：</label>
			<input id="customerName" type="text" class="form-control" name="customerName" value="${customer.customerName}" readonly="readonly">
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
		<div class="radio">
			<div class="radio radio-inline radio-info">
				<input id="settlementType_0" type="radio" name="settlementType" value="702" checked>
				<label for="settlementType_0">D0 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="settlementType_1" type="radio" name="settlementType" value="703">
				<label for="settlementType_1">D1 </label>
			</div>
			<div class="radio radio-inline radio-info">
				<input id="settlementType_2" type="radio" name="settlementType" value="700">
				<label for="settlementType_2">T0 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="settlementType_3" type="radio" name="settlementType" value="701">
				<label for="settlementType_3">T1 </label>
			</div>
		</div>
		<div class="form-group">
		
		</div>
		<div class="form-group col-sm-10">
		   <div class="col-sm-2">
		     <label for="settlementType">支付渠道： </label>
		   </div>
			<div class="col-sm-4">
				<select name="paymentChannelId" class="form-control">
		             <option value="">请选择渠道</option>
		             <c:forEach items="${paymentChannelList}" var="paymentChannel">
		             		<option value="${paymentChannel.paymentChannelId}">${paymentChannel.channelName}</option>
		             </c:forEach>
		    	 </select>
			</div>
		</div>
		<div class="form-group">
		
		</div>
		<div class="form-group">
			<textarea rows="5" cols="5" name="remark" class="form-control" placeholder="备注"></textarea>
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createCustomerPaymentChannelInfoSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createCustomerChannelInfoDialog.close();">取消</a>
		</div>
	</form>
</div>
<script type="text/javascript">

function createCustomerPaymentChannelInfoSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/manage/customerpaymentchannelinfo/create',
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
				createCustomerChannelInfoDialog.close();
				var customerId = $('#customerId').val();
				var childTableId = '#child_customerpaymentchannelinfo_table' + customerId
				var $childCustomerChannelInfoTable = $(childTableId);
				$childCustomerChannelInfoTable.bootstrapTable('refresh');
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