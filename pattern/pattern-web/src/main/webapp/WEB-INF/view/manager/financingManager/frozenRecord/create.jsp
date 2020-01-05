<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<div id="createFrozenDialog" class="crudDialog">
    <form id="frozenForm" method="post">
        <div class="form-group">
            <label>商户名称</label>
            <input type="text" class="form-control" value="${agent.companyName}" maxlength="30" readonly>
        </div>

        <div class="form-group">
            <label for="orderId">交易订单号(可不填，如果填写则必须是真实的订单)</label>
            <input id="orderId" type="text" class="form-control" name="orderId" maxlength="30">
        </div>

        <div class="form-group">
            <label for="money">冻结金额(单位元)</label>
            <input id="money" type="text" class="form-control" name="money" maxlength="30" onpaste="return false" onkeyup="keyupInputMoney(this)">
        </div>

        <div class="form-group">
            <label for="remark">冻结事件说明(必填)</label>
            <input id="remark" type="text" class="form-control" name="remark" maxlength="50">
        </div>

        <input type="hidden" id="agentId" name="agentId" value="${agent.agentId}">
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="frozenDialog.close();">取消</a>
        </div>

    </form>
</div>
<script>
    function createSubmit() {
        var agentId = $('#agentId').val().trim();
        var orderId = $('#orderId').val().trim();
        var frozenAmount = $('#money').val().trim();
        var remark = $('#remark').val().trim();

        var dataJson = {'agentId':agentId,'orderId':orderId,'remark':remark,'frozenAmount':frozenAmount};

        $.ajax({
            type: 'post',
            url: '${basePath}/frozenRecord/create',
            data: dataJson,
            beforeSend: function () {
                if(agentId == ''){
                    layer.msg('商户ID获取失败', {icon: 0, time: 1000});
                    return false;
                }
                if (frozenAmount == '') {
                    $('#money').focus();
                    return false;
                }
                var regex =  /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
                if(!regex.test(frozenAmount)){
                    layer.msg('冻结金额格式输入不正确', {icon: 0, time: 1000});
                    return false;
                }
                if (remark == '') {
                    $('#remark').focus();
                    return false;
                }
            },
            success: function (result) {
                if (result.code == 1) {
                    layer.msg(result.data, {icon: 1, time: 1000}, function () {
                        frozenDialog.close();
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