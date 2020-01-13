<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
	    <input type="hidden" id="paymentChannelAccountId" name="paymentChannelAccountId" value="${paymentChannelAccountId}">
		<div class="form-group">
			<label for="name">参数名称：</label>
			<input id="name" type="text" class="form-control" name="name" maxlength="50">
		</div>
		<div class="form-group">
			<label for="value">参数值：</label>
			<input id="value" type="text" class="form-control" name="value" maxlength="50">
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
			<textarea rows="5" cols="5" name="remark" class="form-control" placeholder="备注"></textarea>
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAccountParaSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAccountParaRowDialog.close();">取消</a>
		</div>
	</form>
</div>
<script type="text/javascript">
function createAccountParaSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/manage/paymentchannelaccountpara/create',
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
				createAccountParaRowDialog.close();
				var paymentChannelAccountId = $('#paymentChannelAccountId').val();
				var $childAccountParaTable = $('#child_para_table'+paymentChannelAccountId);
				$childAccountParaTable.bootstrapTable('refresh');
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