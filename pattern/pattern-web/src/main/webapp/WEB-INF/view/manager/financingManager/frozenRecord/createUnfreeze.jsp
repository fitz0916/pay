<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<div id="createFrozenDialog" class="crudDialog">
    <form id="unfreezeForm" method="post">
        <div class="form-group">
            <label for="unfreezeMoney">解冻金额(单位元)</label>
            <input id="unfreezeMoney" type="text" class="form-control" name="unfreezeMoney" value="${frozenRecord.waitUnfreezeMoney / 100}" maxlength="30" onpaste="return false" onkeyup="keyupInputMoney(this)">
        </div>

        <div class="form-group">
            <label for="remark">解冻说明(必填)</label>
            <input id="remark" type="text" class="form-control" name="remark" maxlength="50">
        </div>

        <input type="hidden" id="agentId" name="agentId" value="${frozenRecord.agentId}">
        <input type="hidden" id="frozenRecordId" name="frozenRecordId" value="${frozenRecord.frozenRecordId}">
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="unfreezeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function createSubmit() {
        var frozenRecordId = $('#frozenRecordId').val();
        var agentId = $('#agentId').val();
        var unfreezeAmount = $('#unfreezeMoney').val().trim();
        var remark = $('#remark').val().trim();

        var dataJson = {'agentId':agentId,'frozenRecordId':frozenRecordId,'remark':remark,'unfreezeAmount':unfreezeAmount};

        $.ajax({
            type: 'post',
            url: '${basePath}/frozenRecord/createUnfreeze',
            data: dataJson,
            beforeSend: function () {
                if(frozenRecordId == ''){
                    layer.msg('冻结记录ID获取失败', {icon: 0, time: 1000});
                    return false;
                }
                if(agentId == ''){
                    layer.msg('商户ID获取失败', {icon: 0, time: 1000});
                    return false;
                }
                if (unfreezeAmount == '') {
                    $('#unfreezeMoney').focus();
                    return false;
                }

                var regex =  /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
                if(!regex.test(unfreezeAmount)){
                    layer.msg('解冻金额格式输入不正确', {icon: 0, time: 1000});
                    return false;
                }

                if ($('#remark').val().trim() == '') {
                    $('#remark').focus();
                    return false;
                }
            },
            success: function (result) {
                if (result.code == 1) {
                    layer.msg(result.data, {icon: 1, time: 1000}, function () {
                        unfreezeDialog.close();
                        $frozenRecordTable.bootstrapTable('refresh');
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