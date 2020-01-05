<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<div id="createOrUpdateDialog" class="crudDialog">
    <form id="payChannelForm" method="post">
        <c:choose>
            <c:when test="${empty payChannel}">
                <div class="form-group">
                    <select id="channelName" name="channelName" class="form-control" onchange="changeChannelName()">
                        <option value="">请选择支付渠道</option>
                        <c:forEach var="payChannelEnum" items="${payChannelEnumList}">
                            <option value="${payChannelEnum.desc}"
                                    templateName="${payChannelEnum.templateName}">${payChannelEnum.desc}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label id="templateNameLabel" for="templateName">渠道模板英文名</label>
                    <input id="templateName" type="text" class="form-control" name="templateName" value="${payChannel.templateName}" readonly>
                </div>
            </c:when>
            <c:otherwise>
                <div class="form-group">
                    <label for="channelName">支付渠道简称</label>
                    <input type="text" class="form-control" value="${payChannel.channelName}" disabled>
                </div>
                <div class="form-group">
                    <label>渠道模板英文名</label>
                    <input type="text" class="form-control" value="${payChannel.templateName}" disabled>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="form-group">
            <label for="fullName">中文全称</label>
            <input id="fullName" type="text" class="form-control" name="fullName" maxlength="30"
                   value="${payChannel.fullName}">
        </div>

        <div class="form-group">
            <label for="remark">备注</label>
            <input id="remark" type="text" class="form-control" name="remark" maxlength="50"
                   value="${payChannel.remark}">
        </div>

        <c:choose>
            <c:when test="${empty payChannel}">
                <div class="form-group text-right dialog-buttons">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
                    <a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
                </div>
            </c:when>
            <c:otherwise>
                <input type="hidden" id="payChannelId" name="payChannelId" value="${payChannel.payChannelId}">
                <div class="form-group text-right dialog-buttons">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">更新</a>
                    <a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
                </div>
            </c:otherwise>
        </c:choose>

    </form>
</div>
<script>

    function changeChannelName() {
        var templateName = $('#channelName option:checked').attr('templateName');
        if (templateName != '') {
            $("#templateName").val(templateName);
            $("#templateNameLabel").addClass('active');
        }
    }

    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/payChannel/create',
            data: $('#payChannelForm').serialize(),
            beforeSend: function () {
                if ($('#channelName option:checked').val() == '') {
                    layer.msg('请选择支付渠道', {icon: 0, time: 1000});
                    return false;
                }
                var templateName = $('#templateName').val().trim();
                if (templateName == '') {
                    layer.msg('渠道模板英文名获取失败', {icon: 0, time: 2000});
                    return false;
                }
            },
            success: function (result) {
                if (result.code == 1) {
                    layer.msg(result.data, {icon: 1, time: 1000}, function () {
                        createDialog.close()
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


    //更新
    function updateSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/payChannel/update',
            data: $('#payChannelForm').serialize(),
            beforeSend: function () {
                if ($('#payChannelId').val() == '') {
                    layer.msg('渠道ID获取失败', {icon: 0, time: 2000});
                    return false;
                }
            },
            success: function (result) {
                if (result.code == 1) {
                    layer.msg(result.data, {icon: 1, time: 1000}, function () {
                        updateDialog.close();
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