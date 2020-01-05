<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<div id="updateFeeDialog" class="crudDialog">
    <form id="updateFeeForm" method="post">
        <div class="form-group">
            <label for="initialAmounts">起始金额(必填 单位元)</label>
            <input type="text" id ="initialAmounts" name="initialAmounts" value="${agentPayoutTypeFee.initialAmount}" class="form-control" maxlength="8" onpaste="return false" onkeyup="keyupDaymoney(this)"/>
        </div>

        <div class="form-group">
            <label for="terminatedAmounts">结束金额(必填 单位元)</label>
            <input type="text" id ="terminatedAmounts" name="terminatedAmounts" value="${agentPayoutTypeFee.terminatedAmount}" class="form-control" maxlength="8" onpaste="return false" onkeyup="keyupDaymoney(this)"/>
        </div>

        <div class="form-group">
            <label for="rates">手续费率(0.00000000)</label>
            <input type="text" id ="rates" name="rates" class="form-control" value="${agentPayoutTypeFee.rate}" maxlength="10" onpaste="return false" onkeyup="keyupRate(this)"/>
        </div>

        <div class="form-group">
            <label for="rates">手续费(单位元)</label>
            <input type="text" id ="fees" name="fees" class="form-control" <c:if test="${not empty agentPayoutTypeFee.fee && agentPayoutTypeFee.fee > 0}">value="${agentPayoutTypeFee.fee/100}"</c:if>
                   <c:if test="${not empty agentPayoutTypeFee.fee && agentPayoutTypeFee.fee == 0}">value="${agentPayoutTypeFee.fee}"</c:if>
                   maxlength="10" onpaste="return false" onkeyup="keyupInputMoney(this)"/>
        </div>

        <input type="hidden" id="agentPayoutTypeFeeIds" name="agentPayoutTypeFeeIds" value="${agentPayoutTypeFee.agentPayoutTypeFeeId}">
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="updateFeeSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="updateFeeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function updateFeeSubmit() {
        var agentPayoutTypeFeeId = $('#agentPayoutTypeFeeIds').val();
        var initialAmount = $('#initialAmounts').val().trim();
        var terminatedAmount = $('#terminatedAmounts').val().trim();
        var rate = $('#rates').val().trim();
        var fee = $('#fees').val().trim();

        var dataJson = {'agentPayoutTypeFeeId':agentPayoutTypeFeeId,'initialAmount':initialAmount,'terminatedAmount':terminatedAmount,'rate':rate,'feeAmount':fee};

        $.ajax({
            type: 'post',
            url: '${basePath}/agentPayoutChannelInfo/updatePayoutTypeFee',
            data: dataJson,
            beforeSend: function() {
                if(agentPayoutTypeFeeId == ''){
                    layer.msg('代付类型手续费ID获取失败',{icon:0,time:2000});
                    return false;
                }

                if (initialAmount == '') {
                    $('#initialAmounts').focus();
                    return false;
                }
                if (terminatedAmount == '') {
                    $('#terminatedAmounts').focus();
                    return false;
                }

                if(Number(initialAmount) >= Number(terminatedAmount)){
                    layer.msg('起始金额不能大于等于结束金额',{icon:0,time:2000});
                    return false;
                }

                if (rate == '' && fee == '') {
                    layer.msg('请填写手续费率或者手续费',{icon:0,time:2000});
                    return false;
                }

                if(rate == '' && fee != '' && Number(fee) == 0){
                    layer.msg('没填写手续费率时手续费不能为0',{icon:0,time:2000});
                    return false;
                }

                if(fee != ''){
                    var regex =  /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
                    if(!regex.test(fee)){
                        layer.msg('手续费格式输入不正确', {icon: 0, time: 1000});
                        return false;
                    }
                }
            },
            success: function(result) {
                if (result.code == 1) {
                    layer.msg(result.data,{icon:1,time:1000},function () {
                        updateFeeDialog.close();
                        $agentPayoutTypeFeeTable.bootstrapTable('refresh');
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