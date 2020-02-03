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
		<div class="form-group">
			<div class="col-sm-6">
			  <label>支付类型:</label>
			</div>
			<div class="col-sm-6">
				<select id="payType" name="payType" class="form-control">
		             <option value="">请选择支付类型</option>
		             <option value="41">微信-扫码</option>
		             <option value="42">支付宝-扫码</option>
		             <option value="43">QQ扫码支付</option>
		             <option value="52">网银银行</option>
		             <option value="60">京东钱包</option>
		             <option value="61">银联二维码</option>
		             <option value="62">微信H5</option>
		             <option value="63">QQH5</option>
		    	 </select>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-6">
			  <label>渠道模板:</label>
			</div>
			<div class="col-sm-6">
			   <select id="paymentTemplateId" name="paymentTemplateId" class="form-control">
			   			<option value="">请选择渠道模板</option>
			   </select>
			</div>
		</div>
		<div class="form-group">
		
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
			<!-- 
			<label for="remark">备注：</label>
			 -->
			<textarea rows="5" cols="5" name="remark" class="form-control" title="备注" placeholder="备注"></textarea>
		</div>
		
		
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
		</div>
	</form>
</div>
<script type="text/javascript">

$('#payType').bind('change',function(){
	var payTypeVal = $(this).val();
	if($.trim(payTypeVal) == ''){
		$('#paymentTemplateId').html("<option value=''>请选择渠道模板</option>");
		return;
	}
	$.ajax({
    		type: "post",
            url : "${basePath}/manage/paymenttemplate/list/" + payTypeVal,
            success:function (result) {
            	var array = new Array();
            	array.push("<option value=''>请选择渠道模板</option>")
                for (var i = 0; i < result.data.length; i ++) {
                    var paymentTemplateId = result.data[i].paymentTemplateId;
                    var templateDesc = result.data[i].templateDesc;
                    array.push("<option value='" +  paymentTemplateId + "'>" + templateDesc + "</option>");
                }
                $('#paymentTemplateId').html("");
                $('#paymentTemplateId').html(array.join(""));
            },
            error:function (message) {
            	$('#paymentTemplateId').html("");
                $('#paymentTemplateId').html("<option value=''>请选择渠道模板</option>");
            }
     });
});



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