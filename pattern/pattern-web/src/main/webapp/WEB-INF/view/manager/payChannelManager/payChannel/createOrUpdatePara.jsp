<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="createOrUpdateDialogs" class="crudDialog">
	<form id="form" method="post">
		<div class="form-group">
			<label for="chName">中文描述</label>
			<input id="chName" type="text" class="form-control" name="chName" maxlength="20" value="${payChannelPara.chName}">
		</div>
		<div class="form-group">
			<label for="enName">参数名称(英文)</label>
			<input id="enName" type="text" class="form-control" name="enName" maxlength="20" value="${payChannelPara.enName}">
		</div>
		<div class="form-group">
			<label for="remark">备注信息</label>
			<input id="remark" type="text" class="form-control" name="remark" maxlength="50" value="${payChannelPara.remark}">
		</div>

		<c:choose>
			<c:when test="${empty payChannelPara}">
				<input type="hidden" id="payChannelId" name="payChannelId" value="${payChannelId}">
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
				</div>
			</c:when>
			<c:otherwise>
				<input type="hidden" id="payChannelParaId" name="payChannelParaId" value="${payChannelPara.payChannelParaId}">
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit(${payChannelPara.payChannelId});">更新</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
				</div>
			</c:otherwise>
		</c:choose>

	</form>
</div>
<script>
function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/payChannel/createPara',
        data: $('#form').serialize(),
        beforeSend: function() {
            if ($('#chName').val().trim() == '') {
                $('#chName').focus();
                return false;
            }
            var enName = $('#enName').val().trim();
            if (enName == '') {
                $('#enName').focus();
                return false;
            }
            if(enName.length < 1 || enName.length > 20){
                layer.msg('参数名称长度必须介于1~20之间！',{icon:0,time:3000});
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


//更新
function updateSubmit(payChannelId) {
    $.ajax({
        type: 'post',
        url: '${basePath}/payChannel/updatePara',
        data: $('#form').serialize(),
        beforeSend: function() {
            if ($('#payChannelParaId').val() == '') {
                layer.msg('渠道参数ID获取失败',{icon:0,time:2000});
                return false;
            }
            if ($('#chName').val().trim() == '') {
                $('#chName').focus();
                return false;
            }
            var enName = $('#enName').val().trim();
            if (enName == '') {
                $('#enName').focus();
                return false;
            }
            if(enName.length < 1 || enName.length > 20){
                layer.msg('参数名称长度必须介于1~20之间！',{icon:0,time:3000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    updateDialog.close();
                    $("#child_table"+payChannelId).bootstrapTable('refresh');
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