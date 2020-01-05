<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<div id="refusePayoutDialog" class="crudDialog">
    <form id="refuseForm" method="post">
        <div class="form-group">
            <label for="agentPayoutOrderId">提现订单号</label>
            <input id="agentPayoutOrderId" name="agentPayoutOrderId" value="${agentPayoutOrderId}" type="text" class="form-control" readonly>
        </div>

        <div class="form-group">
            <select id="remark" name="remark" class="form-control">
                <option value="">请选择拒绝原因</option>
                <option value="拒绝原因测试">拒绝原因测试</option>
                <option value="商户异常">商户异常</option>
            </select>
        </div>

        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="refuseSubmit();">提交</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="refuseDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function refuseSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/agentPayoutOrder/rejectPayoutOrder',
            data: $('#refuseForm').serialize(),
            beforeSend: function () {
                if($('#agentPayoutOrderId').val().trim() == ''){
                    layer.msg('提现订单号获取失败', {icon: 0, time: 1000});
                    return false;
                }
                if ($('#remark option:selected').val().trim() == '') {
                    layer.msg('请选择拒绝说明', {icon: 0, time: 2000});
                    return false;
                }
            },
            success: function (result) {
                if (result.code == 1) {
                    layer.msg(result.data, {icon: 1, time: 1000}, function () {
                        refuseDialog.close();
                        $table.bootstrapTable('refresh');
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