<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<style>
    .radio-inline-overwrite{
        width: 8%;
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
    <form id="createOrUpdateForm" method="post">

        <div class="form-group">
            <select id="payChannelAccountId" name="payChannelAccountId" class="form-control" <c:if test="${not empty payoutChannel}">disabled</c:if>>
                <option value="">请选择渠道账户</option>
                <c:choose>
                    <c:when test="${not empty payoutChannel}">
                        <c:forEach var="payChannelAccount" items="${payChannelAccountList}">
                            <option value="${payChannelAccount.payChannelAccountId}" <c:if test="${payChannelAccount.payChannelAccountId == payoutChannel.payChannelAccountId}">selected</c:if>>${payChannelAccount.simpleName}</option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="payChannelAccount" items="${payChannelAccountList}">
                            <c:choose>
                                <c:when test="${payChannelAccount.isParaSet == true}">
                                    <option value="${payChannelAccount.payChannelAccountId}">${payChannelAccount.simpleName}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="" style="color: red" disabled>${payChannelAccount.simpleName}（未设置渠道账户参数）</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </select>
        </div>

        <div style="margin-bottom: 20px">
            <label class="radio-inline-overwrite" style="width: 10%;margin-left: 10px">代付类型：</label>
            <label class="radio-inline-overwrite">
                <input type="checkbox" name="payoutTypeIds" value="700" <c:if test="${payoutChannel.payoutTypeIds.indexOf('700') > -1}">checked</c:if>> T0
            </label>
            <label class="radio-inline-overwrite">
                <input type="checkbox" name="payoutTypeIds" value="701" <c:if test="${payoutChannel.payoutTypeIds.indexOf('701') > -1}">checked</c:if>> T1
            </label>
            <label class="radio-inline-overwrite">
                <input type="checkbox" name="payoutTypeIds" value="702" <c:if test="${payoutChannel.payoutTypeIds.indexOf('702') > -1}">checked</c:if>> D0
            </label>
            <label class="radio-inline-overwrite">
                <input type="checkbox" name="payoutTypeIds" value="703" <c:if test="${payoutChannel.payoutTypeIds.indexOf('703') > -1}">checked</c:if>> D1
            </label>
        </div>

        <div class="form-group">
            <label for="channelName">代付通道名称</label>
            <input id="channelName" type="text" class="form-control" name="channelName" maxlength="30" value="${payoutChannel.channelName}">
        </div>

        <div class="form-group">
            <label for="limitmoney">单笔代付额度上限(元)</label>
            <input id="limitmoney" type="text" class="form-control" name="limitmoney" value="${payoutChannel.limitmoney}" maxlength="100" onpaste="return false" onkeyup="keyupDaymoney(this)">
        </div>

        <div style="margin-top: 10px;margin-bottom: 25px">
            <label style="margin-left: 28px;margin-right: 5px">选择允许代付时间范围</label>
            <input type="text" id="payoutTime" style="cursor: pointer" placeholder="hh:mm:ss-hh:mm:ss">
        </div>

        <div class="form-group">
            <label id="limitTimeLabel" for="limitTime">允许代付时间范围(格式hh:mm:ss-hh:mm:ss 24小时制 多条用|隔开 不输入则不限制)</label>
            <input id="limitTime" type="text" class="form-control" name="limitTime" value="${payoutChannel.limitTime}" maxlength="100" onpaste="return false" onkeyup="keyupAllowTime(this)">
        </div>

        <div class="form-group">
            <label for="remark">备注信息</label>
            <input id="remark" type="text" class="form-control" name="remark" maxlength="100" value="${payoutChannel.remark}">
        </div>

        <c:choose>
            <c:when test="${empty payoutChannel}">
                <div class="form-group text-right dialog-buttons">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
                    <a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
                </div>
            </c:when>
            <c:otherwise>
                <div style="margin-bottom: 20px">
                    <label class="radio-inline-overwrite" style="width: 10%; color: red">使用状态：</label>
                    <label class="radio-inline-overwrite">
                        <input type="radio" name="isLock" value="0" <c:if test="${payoutChannel.isLock == 0}">checked</c:if>> 启用
                    </label>
                    <label class="radio-inline-overwrite">
                        <input type="radio" name="isLock" value="1" <c:if test="${payoutChannel.isLock == 1}">checked</c:if>> 禁用
                    </label>
                </div>

                <input type="hidden" id="payoutChannelId" name="payoutChannelId" value="${payoutChannel.payoutChannelId}">
                <div class="form-group text-right dialog-buttons">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">更新</a>
                    <a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
                </div>
            </c:otherwise>
        </c:choose>

    </form>
</div>

<script>

    //初始化时间选择器
    laydate.render({
        elem: '#payoutTime' //指定元素
        ,type: 'time'
        ,range: true
        ,done: function(value, date, endDate){
            /*console.log(value); //得到日期生成的值，如：2017-08-18
            console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。*/
            if(value != ''){
                //去除所有空格
                value = value.replace(/\s/g, "");
                var limitTime = $("#limitTime").val().trim();
                if(limitTime == ''){
                    $("#limitTime").val(value);
                    $("#limitTimeLabel").addClass('active');
                }else{
                    $("#limitTime").val(limitTime + '|' + value);
                    $("#limitTimeLabel").addClass('active');
                }
            }
        }
    });

    //验证允许支付时间，允许代付时间等
    function keyupAllowTime(event){
        var value = $(event).val();
        var regex = /[^\d-:|]/g;

        //只能输入数字和符号-:|
        if(regex.test(value)){
            $(event).val($(event).val().replace(/[^\d-:|]/g,''));
        }else{
            //不能输入已-:|为开头的字符
            if(value == '-'){
                $(event).val($(event).val().substr(0,value.length-1));
            }
            if(value == ':'){
                $(event).val($(event).val().substr(0,value.length-1));
            }
            if(value == '|'){
                $(event).val($(event).val().substr(0,value.length-1));
            }
        }
    }

    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/payoutChannel/create',
            data: $('#createOrUpdateForm').serialize(),
            beforeSend: function () {
                if ($('#payChannelAccountId option:selected').val() == '') {
                    layer.msg('请选择渠道账户',{icon:0,time:2000});
                    return false;
                }

                if(!$('input[name="payoutTypeIds"]').is(':checked')){
                    layer.msg('请选择代付类型',{icon:0,time:2000});
                    return false;
                }

                if ($('#channelName').val().trim() == '') {
                    $('#channelName').focus();
                    return false;
                }

                if($('#limitmoney').val().trim() == ''){
                    $('#limitmoney').focus();
                    return false;
                }

                var limitTime = $('#limitTime').val().trim();
                if(limitTime != ''){
                    var regex = /(^(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]))-(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$))|(\|(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]))-(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$))/;
                    if(!regex.test(limitTime)){
                        layer.msg('允许代付时间格式不正确！',{icon:0,time:2000});
                        return false;
                    }
                }
            },
            success: function (result) {
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
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.alert(textStatus, {icon: 2})
            }
        });
    }


    function updateSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/payoutChannel/update',
            data: $('#createOrUpdateForm').serialize(),
            beforeSend: function() {
                if ($('#payoutChannelId').val() == '') {
                    layer.msg('代付通道ID获取失败',{icon:0,time:2000});
                    return false;
                }

                if(!$('input[name="payoutTypeIds"]').is(':checked')){
                    layer.msg('请选择代付类型',{icon:0,time:2000});
                    return false;
                }

                if ($('#channelName').val().trim() == '') {
                    $('#channelName').focus();
                    return false;
                }

                if($('#limitmoney').val().trim() == ''){
                    $('#limitmoney').focus();
                    return false;
                }

                var limitTime = $('#limitTime').val().trim();
                if(limitTime != ''){
                    var regex = /(^(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]))-(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$))|(\|(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]))-(([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$))/;
                    if(!regex.test(limitTime)){
                        layer.msg('允许代付时间格式不正确！',{icon:0,time:2000});
                        return false;
                    }
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
