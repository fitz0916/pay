<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<style>
	.radio-inline-overwrite{
		width: 10%;
		height: 100%;
		line-height: 20px;
		display: inline-block;
		padding-left: 20px;
		margin-bottom: 0;
		font-weight: 400;
		vertical-align: middle;
		cursor: pointer;
	}
</style>

<div id="createOrUpdateDialog" class="crudDialog">
	<form id="form" method="post">
		<div class="form-group">
			<select id="payChannelId" name="payChannelId" class="form-control" onchange="changePayChannelId()" <c:if test="${not empty payChannelAccount}">disabled</c:if>>
				<option value="">请选择支付渠道</option>
				<c:choose>
					<c:when test="${not empty payChannelAccount}">
						<c:forEach var="payChannel" items="${payChannelList}">
							<option value="${payChannel.payChannelId}" <c:if test="${payChannelAccount.payChannelId == payChannel.payChannelId}">selected</c:if>>${payChannel.channelName}</option>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach var="payChannel" items="${payChannelList}">
							<c:choose>
								<c:when test="${payChannel.isParaSet == true}">
									<option value="${payChannel.payChannelId}">${payChannel.channelName}</option>
								</c:when>
								<c:otherwise>
									<option value="" style="color: red" disabled>${payChannel.channelName}（未设置支付渠道参数）</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</select>
		</div>
		<div class="form-group">
			<label id="simpleNameLabel" for="simpleName">账户简称（命名格式：渠道名称-账户简称）</label>
			<input id="simpleName" type="text" class="form-control" name="simpleName" maxlength="20" value="${payChannelAccount.simpleName}">
		</div>
		<div class="form-group">
			<label for="fullName">账户全称</label>
			<input id="fullName" type="text" class="form-control" name="fullName" maxlength="30" value="${payChannelAccount.fullName}">
		</div>

		<div class="form-group">
			<label for="businessManager">商务联系人</label>
			<input id="businessManager" type="text" class="form-control" name="businessManager" maxlength="20" value="${payChannelAccount.businessManager}">
		</div>
		<div class="form-group">
			<label for="mobile">手机号码</label>
			<input id="mobile" type="text" class="form-control" name="mobile" maxlength="11" value="${payChannelAccount.mobile}"
				   onpaste="return false" onkeyup="value=value.replace(/[^\d]/g,'')">
		</div>
		<div class="form-group">
			<label for="qq">QQ号码</label>
			<input id="qq" type="text" class="form-control" name="qq" maxlength="15" value="${payChannelAccount.qq}">
		</div>
		<div class="form-group">
			<label for="wechat">微信号码</label>
			<input id="wechat" type="text" class="form-control" name="wechat" maxlength="15" value="${payChannelAccount.wechat}">
		</div>
		<div class="form-group">
			<label for="remark">备注</label>
			<input id="remark" type="text" class="form-control" name="remark" maxlength="50" value="${payChannelAccount.remark}">
		</div>

		<div style="margin-bottom: 20px">
			<label class="radio-inline-overwrite" style="width: 10%;color: red">支持类型：</label>
			<label class="radio-inline-overwrite">
				<input type="checkbox" name="supportTypes" value="1" <c:if test="${payChannelAccount.supportTypes.indexOf('1') > -1}">checked</c:if>> 支付
			</label>
			<label class="radio-inline-overwrite">
				<input type="checkbox" name="supportTypes" value="2" <c:if test="${payChannelAccount.supportTypes.indexOf('2') > -1}">checked</c:if>> 代付
			</label>
		</div>

		<c:choose>
			<c:when test="${empty payChannelAccount}">
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
				</div>
			</c:when>
			<c:otherwise>
				<input type="hidden" id="payChannelAccountId" name="payChannelAccountId" value="${payChannelAccount.payChannelAccountId}">
				<!-- 由于支付渠道不允许修改，使用了disabled禁止编辑，但该属性会导致表单提交时无法获取到payChannelId的值，特下列重新对payChannelId进行赋值 -->
				<input type="hidden" name="payChannelId" value="${payChannelAccount.payChannelId}">

				<div style="margin-bottom: 20px">
					<label class="radio-inline-overwrite" style="width: 10%; color: red">使用状态：</label>
					<label class="radio-inline-overwrite">
						<input type="radio" name="isLock" value="0" <c:if test="${payChannelAccount.isLock == false}">checked</c:if>> 启用
					</label>
					<label class="radio-inline-overwrite">
						<input type="radio" name="isLock" value="1" <c:if test="${payChannelAccount.isLock == true}">checked</c:if>> 禁用
					</label>
				</div>

				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">更新</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
				</div>
			</c:otherwise>
		</c:choose>

	</form>
</div>
<script>

    function changePayChannelId(){
        if($('#payChannelId option:selected').val() != ''){
            var channelName = $('#payChannelId option:selected').html();
            $("#simpleName").val(channelName+'-');
            $("#simpleNameLabel").addClass('active');
        }
    }

//新增渠道账户
function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelAccount/create',
        data: $('#form').serialize(),
        beforeSend: function() {
            if ($('#payChannelId option:selected').val() == '') {
               layer.msg('请选择支付渠道',{icon:0,time:2000});
                return false;
            }
            if ($('#simpleName').val().trim() == '') {
                $('#simpleName').focus();
                return false;
            }
            var channelName = $('#payChannelId option:selected').html() + '-';
            if($('#simpleName').val().trim() == channelName || $('#simpleName').val().trim().indexOf(channelName) <= -1){
                layer.msg('账户简称格式不正确',{icon:0,time:2000});
                return false;
			}
            if($("#mobile").val() != ''){
                var mobileRegex = /^[1][0-9]{10}$/;
                if(!mobileRegex.test($("#mobile").val())){
                    layer.msg('手机号码格式不正确',{icon:0,time:2000});
                    return false;
				}
			}

            if(!$('input[name="supportTypes"]').is(':checked')){
                layer.msg('请选择支持类型',{icon:0,time:2000});
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


//更新渠道账户
function updateSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelAccount/update',
        data: $('#form').serialize(),
        beforeSend: function() {
            if($('#payChannelAccountId').val().trim() == ''){
                layer.msg('渠道账户ID获取失败',{icon:0,time:2000});
                return false;
			}
            if ($('#payChannelId option:selected').val() == '') {
                layer.msg('请选择支付渠道',{icon:0,time:2000});
                return false;
            }
            if ($('#simpleName').val().trim() == '') {
                $('#simpleName').focus();
                return false;
            }
            if($("#mobile").val() != ''){
                var mobileRegex = /^[1][0-9]{10}$/;
                if(!mobileRegex.test($('#mobile').val())){
                    layer.msg('手机号码格式不正确',{icon:0,time:2000});
                    return false;
                }
            }
            if(!$('input[name="supportTypes"]').is(':checked')){
                layer.msg('请选择支持类型',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    updateDialog.close();
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