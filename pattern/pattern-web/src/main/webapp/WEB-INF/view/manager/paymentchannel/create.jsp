<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
		<div class="form-group">
			<label for="channelName">渠道名称：</label>
			<input id="channelName" type="text" class="form-control" name="channelName" maxlength="50">
		</div>
		<div class="form-group">
			<label for="thirdChannelName">三方渠道名称：</label>
			<input id="thirdChannelName" type="text" class="form-control" name="thirdChannelName" maxlength="50">
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
		<div class="select">
		     <select name="payType">
		         <option value="-1">请选择</option>
		         <option value="0">微信-扫码</option>
		         <option value="1">支付宝-扫码</option>
		         <option value="2">快捷支付</option>
		     </select>
		</div>
		
		<div class="form-group">
			<label for="businessContacts">商务联系人：</label>
			<input id="businessContacts" type="text" class="form-control" name="businessContacts" maxlength="50">
		</div>
		
		<div class="form-group">
			<label for="qq">qq：</label>
			<input id="qq" type="text" class="form-control" name="qq" maxlength="50">
		</div>
		
		<div class="form-group">
			<label for="wechat">微信：</label>
			<input id="wechat" type="text" class="form-control" name="wechat" maxlength="50">
		</div>
		
		<div class="form-group">
			<label for="mobile">手机号码：</label>
			<input id="mobile" type="text" class="form-control" name="mobile" maxlength="50">
		</div>
		
		<div class="form-group">
			<label for="remark">备注：</label>
			<textarea rows="5" cols="5" name="remark" class="form-control"></textarea>
		</div>
		
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
		</div>
	</form>
</div>
<script type="text/javascript">
function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/manage/paymentchannel/create',
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
				createDialog.close();
				$table.bootstrapTable('refresh');
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