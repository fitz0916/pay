<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<div id="createOrUpdateDialog" class="crudDialog">
	<form id="form" method="post">
		<div class="form-group">
			<select id="payChannelAccountId" name="payChannelAccountId" class="form-control" onchange="changePayChannelId()">
				<option value="">请选择渠道账户</option>
				<c:forEach var="payChannelAccount" items="${payChannelAccountList}">
					<c:choose>
						<c:when test="${payChannelAccount.isParaSet == true}">
							<option value="${payChannelAccount.payChannelAccountId}" paychannelid="${payChannelAccount.payChannelId}">${payChannelAccount.simpleName}</option>
						</c:when>
						<c:otherwise>
							<option value="" style="color: red" disabled>${payChannelAccount.simpleName}（未设置渠道账户参数）</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</div>
		<div class="form-group">
			<select id="payTypeId" name="payTypeId" class="form-control" onchange="changeChannelInfoName()">
				<option value="">请选择交易类型</option>
				<c:forEach var="payTypeList" items="${payTypeList}">
					<option value="${payTypeList.payTypeId}">${payTypeList.payname}</option>
				</c:forEach>
			</select>
		</div>
		<div class="form-group">
			<label for="channelInfoName" id="channelInfoNameLabel">支付通道名称</label>
			<input id="channelInfoName" type="text" class="form-control" name="channelInfoName" maxlength="20">
		</div>
		<div class="form-group">
			<label for="fee">接入费率%</label>
			<input id="fee" type="text" class="form-control" name="fee" maxlength="20" onpaste="return false" onkeyup="keyupRate(this)">
		</div>
		<div class="form-group">
			<label for="salefee">销售费率%</label>
			<input id="salefee" type="text" class="form-control" name="salefee" maxlength="30" onpaste="return false" onkeyup="keyupRate(this)">
		</div>
		<div class="form-group">
			<label for="remark">备注</label>
			<input id="remark" type="text" class="form-control" name="remark" maxlength="50">
		</div>

		<input type="hidden" id="payChannelId" name="payChannelId" value="">
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
		</div>
	</form>
</div>
<script>

//根据选择的渠道账户赋值相应的支付渠道ID
function changePayChannelId(){
    $("#payChannelId").val($('#payChannelAccountId option:selected').attr('paychannelid'));

    if($('#payTypeId option:selected').val() != ''){
        var payTypeName = $('#payTypeId option:selected').html();
        var payChannelAccountName = $('#payChannelAccountId option:selected').html();
        $("#channelInfoName").val(payTypeName+'-'+payChannelAccountName);
        $("#channelInfoNameLabel").addClass('active');
	}
}

//根据所选的渠道账户和交易类型自定义支付通道名称
function changeChannelInfoName(){
    if($('#payChannelAccountId option:selected').val() != ''){
        var payTypeName = $('#payTypeId option:selected').html();
        var payChannelAccountName = $('#payChannelAccountId option:selected').html();
        $("#channelInfoName").val(payTypeName+'-'+payChannelAccountName);
        $("#channelInfoNameLabel").addClass('active');
	}
}

//新增支付通道
function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelInfo/create',
        data: $('#form').serialize(),
        beforeSend: function() {
            if ($('#payChannelAccountId option:selected').val() == '') {
               layer.msg('请选择渠道账户',{icon:0,time:2000});
                return false;
            }
            if ($('#payChannelAccountId option:selected').attr('paychannelid') == '') {
                layer.msg('支付渠道ID获取失败',{icon:0,time:2000});
                return false;
            }
            if ($('#payTypeId option:selected').val() == '') {
                layer.msg('请选择交易类型',{icon:0,time:2000});
                return false;
            }
            if ($('#channelInfoName').val().trim() == '') {
                $('#channelInfoName').focus();
                return false;
            }
            if ($('#fee').val().trim() == '') {
                $('#fee').focus();
                return false;
            }
            if ($('#salefee').val().trim() == '') {
                $('#salefee').focus();
                return false;
            }
        },
        success: function(result) {
			if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    createDialog.close();
                    $table.bootstrapTable('refresh');
                });
			} else {
                if (result.data instanceof Array) {
                    $.each(result.data, function(index, value) {
                        layer.alert(value.errorMsg,{icon:2})
                    });
                } else {
                    layer.alert(result.data,{icon:2});
                }
			}
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
			layer.alert(textStatus,{icon:2});
        }
    });
}

</script>