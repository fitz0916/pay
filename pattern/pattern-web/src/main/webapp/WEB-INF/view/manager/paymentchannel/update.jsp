<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="updateDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<input type="hidden" name="paymentChannelId" value="${paymentChannel.paymentChannelId}">
		<div class="form-group">
			<label for="channelName">渠道名称：</label>
			<input id="channelName" type="text" value="${paymentChannel.channelName}" class="form-control" name="channelName" maxlength="50">
		</div>
		<div class="form-group">
			<label for="thirdChannelName">三方渠道名称：</label>
			<input id="thirdChannelName" type="text" class="form-control" value="${paymentChannel.thirdChannelName}" name="thirdChannelName" maxlength="50">
		</div>
		<div class="radio">
			<div class="radio radio-inline radio-info">
				<input id="status_1" type="radio" name="status" value="1" <c:if test="${paymentChannel.status == 1}">checked</c:if>>
				<label for="status_1">启用 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="status_0" type="radio" name="status" value="0" <c:if test="${paymentChannel.status == 0}">checked</c:if>>
				<label for="status_0">锁定 </label>
			</div>
		</div>
		<div class="radio">
			<div class="radio radio-inline radio-info">
				<input id="settlementType_0" type="radio" name="settlementType" value="0" <c:if test="${paymentChannel.settlementType == 0}">checked</c:if>>
				<label for="settlementType_0">D0 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="settlementType_1" type="radio" name="settlementType" value="1" <c:if test="${paymentChannel.settlementType == 1}">checked</c:if>>
				<label for="settlementType_1">D1 </label>
			</div>
			<div class="radio radio-inline radio-info">
				<input id="settlementType_2" type="radio" name="settlementType" value="2" <c:if test="${paymentChannel.settlementType == 2}">checked</c:if>>
				<label for="settlementType_2">T0 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="settlementType_3" type="radio" name="settlementType" value="3" <c:if test="${paymentChannel.settlementType == 3}">checked</c:if>>
				<label for="settlementType_3">T1 </label>
			</div>
		</div>
		<div class="form-group">
		
		</div>
		<div class="form-group">
		  <div>
		     <select name="payType"  class="form-control">
		         <option value="-1">请选择渠道</option>
		         <option value="0" <c:if test="${paymentChannel.payType == 0}">selected="selected"</c:if>>微信-扫码</option>
		         <option value="1" <c:if test="${paymentChannel.payType == 1}">selected="selected"</c:if>>支付宝-扫码</option>
		         <option value="2" <c:if test="${paymentChannel.payType == 2}">selected="selected"</c:if>>快捷支付</option>
		     </select>
		  </div>
		</div>
		
		<div class="form-group">
			<label for="businessContacts">商务联系人：</label>
			<input id="businessContacts" type="text" class="form-control" value="${paymentChannel.businessContacts}" name="businessContacts" maxlength="50">
		</div>
		
		<div class="form-group">
			<label for="qq">qq：</label>
			<input id="qq" type="text" class="form-control" value="${paymentChannel.qq}" name="qq" maxlength="50">
		</div>
		
		<div class="form-group">
			<label for="wechat">微信：</label>
			<input id="wechat" type="text" class="form-control" value="${paymentChannel.wechat}" name="wechat" maxlength="50">
		</div>
		
		<div class="form-group">
			<label for="mobile">手机号码：</label>
			<input id="mobile" type="text" class="form-control" value="${paymentChannel.mobile}" name="mobile" maxlength="50">
		</div>
		
		<div class="form-group">
			<textarea rows="5" cols="5" name="remark"  class="form-control" placeholder="备注">${paymentChannel.remark}</textarea>
		</div>
		
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
		</div>
	</form>
</div>
<script type="text/javascript">
function updateSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/manage/paymentchannel/update',
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
				updateDialog.close();
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