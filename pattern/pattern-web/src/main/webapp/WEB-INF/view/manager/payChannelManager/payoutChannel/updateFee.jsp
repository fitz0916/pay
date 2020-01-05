<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="updateFeeDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<label for="initialAmount">起始金额(元)</label>
							<input id="initialAmount" type="text" class="form-control" name="initialAmount" maxlength="11" value="${payoutChannelFee.initialAmount}" onpaste="return false" onkeyup="keyupDaymoney(this)" readonly>
							<input id="payoutChannelId" type="hidden" name="payoutChannelId" value="${payoutChannelFee.payoutChannelId}">
						</div>
						<div class="form-group">
							<label for="terminatedAmount">终止金额(元)</label>
							<input id="terminatedAmount" type="text" class="form-control" name="terminatedAmount" maxlength="11" value="${payoutChannelFee.terminatedAmount}" onpaste="return false" onkeyup="keyupDaymoney(this)">
						</div>
						<div class="form-group">
							<label for="feeStr">手续费(元)</label>
							<input id="feeStr" type="text" class="form-control" name="feeStr" maxlength="11" value="${payoutChannelFee.feeStr}" onpaste="return false" onkeyup="keyupInputMoney(this)">
						</div>
						<div class="form-group">
							<label for="rate">费率</label>
							<input id="rate" type="text" class="form-control" name="rate" maxlength="10" value="<fmt:formatNumber value ="${payoutChannelFee.rate}" pattern="0.########"/>" onpaste="return false" onkeyup="keyupRate(this)">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit(${payoutChannelFee.payoutChannelId});">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateFeeDialog.close();">取消</a>
		</div>
	</form>
</div>

<script>

function updateSubmit(payoutChannelId) {
    $.ajax({
        type: 'post',
        url: '${basePath}/payoutChannel/updateFee/${payoutChannelFee.payoutChannelFeeId}',
        data: $('#updateForm').serialize(),
        beforeSend: function() {
			if ($('#initialAmount').val() == '') {
				$('#initialAmount').focus();
				return false;
			}
			if ($('#terminatedAmount').val() == '') {
				$('#terminatedAmount').focus();
				return false;
			}
			if ($('#feeStr').val() == ''&&$('#rate').val() == '') {
				$('#feeStr').focus();
				return false;
			}
        },
        success: function(result) {
        	if (result.model.code == 1) {
                layer.msg(result.model.data,{icon:1,time:1000},function () {
                	updateFeeDialog.close();
                    $('#child_table'+payoutChannelId).bootstrapTable('refresh');
                });
			} else {
                if (result.model.data instanceof Array) {
                    $.each(result.model.data, function(index, value) {
                        layer.alert(value.errorMsg,{icon:2})
                    });
                } else {
                    layer.alert(result.model.data,{icon:2});
                }
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