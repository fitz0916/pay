<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<style>
    .radio-inline-overwrite{
        width: 20%;
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

<div id="createRechargeDialog" class="crudDialog">
    <form id="rechargeForm" method="post">
        <div class="form-group">
            <label>商户名称</label>
            <input type="text" class="form-control" value="${agent.companyName}" maxlength="30" readonly>
        </div>

        <div class="form-group">
            <label for="money">操作金额(充值/错账 单位元)</label>
            <input id="money" type="text" class="form-control" name="money" maxlength="30" onpaste="return false" onkeyup="keyupInputMoney(this)">
        </div>

        <div class="form-group">
            <label for="remark">操作说明(必填)</label>
            <input id="remark" type="text" class="form-control" name="remark" maxlength="50">
        </div>

        <div style="margin-bottom: 20px">
            <label class="radio-inline-overwrite" style="color: red">操作类型：</label>
            <label class="radio-inline-overwrite">
                <input type="radio" name="rechargeType" value="0" checked> 充值
            </label>
            <label class="radio-inline-overwrite">
                <input type="radio" name="rechargeType" value="1"> 错账
            </label>
        </div>

        <input type="hidden" id="agentId" name="agentId" value="${agent.agentId}">
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="rechargeDialog.close();">取消</a>
        </div>

    </form>
</div>
<script>
    function createSubmit() {
        var agentId = $('#agentId').val();
        var rechargeAmount = $('#money').val().trim();
        var remark = $('#remark').val().trim();
        var rechargeType = $('input[name="rechargeType"]:checked').val();

        var dataJson = {'agentId':agentId,'rechargeType':rechargeType,'remark':remark,'rechargeAmount':rechargeAmount};

        $.ajax({
            type: 'post',
            url: '${basePath}/rechargeRecord/create',
            data: dataJson,
            beforeSend: function () {
                if($('#agentId').val().trim() == ''){
                    layer.msg('商户ID获取失败', {icon: 0, time: 1000});
                    return false;
                }

                if (rechargeAmount == '') {
                    $('#money').focus();
                    return false;
                }

                var regex =  /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
                if(!regex.test(rechargeAmount)){
                    layer.msg('操作金额格式输入不正确', {icon: 0, time: 1000});
                    return false;
                }

                if (remark == '') {
                    $('#remark').focus();
                    return false;
                }

                if(rechargeType == ''){
                    layer.msg('请选择操作类型', {icon: 0, time: 1000});
                    return false;
                }
            },
            success: function (result) {
                if (result.code == 1) {
                    layer.msg(result.data, {icon: 1, time: 1000}, function () {
                        rechargeDialog.close();
                    });
                } else {
                    if (result.data instanceof Array) {
                        $.each(result.data, function (index, value) {
                            layer.alert(value.errorMsg, {icon: 2})
                        });
                    } else {
                        layer.alert(result.data, {icon: 2});
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.alert(textStatus, {icon: 2});
            }
        });
    }
</script>