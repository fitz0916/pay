<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
<div id="updateGlobalSetDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<div class="row">
			<div class="col-sm-12">
				<input type="hidden" name="proxyId" value="${user.proxyId}" id="proxyId">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<label for="smsSign">短信签名</label>
							<input id="smsSign" type="text" class="form-control" name="smsSign" maxlength="12"  value="${smsSet.smsSign}">
						</div>
						<div class="form-group">
							<label for="validTime">验证码有效期(秒)</label>
							<input id="validTime" type="text" class="form-control" name="validTime" maxlength="3"  value="${smsSet.validTime}" onpaste="return false" onkeyup="value=value.replace(/[^\d]/g,'')">
							<input id="smsSetId" type="hidden" name="smsSetId" value="${smsSet.smsSetId}">
						</div>
					</div>
				</div>
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">保存</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateGlobalSetDialog.close();">取消</a>
				</div>
			</div>
		</div>
	</form>
</div>
<jsp:include page="../../../common/inc/dialog_footer.jsp" flush="true"/>
<script>

$(document).on('ready', function() {


});

function updateSubmit() {
    $.ajax({
        type: 'post',
		url: '${basePath}/smsSet/update',
        data: $('#updateForm').serialize(),
        beforeSend: function() {
			if ($('#smsSign').val() == '') {
				$('#smsSign').focus();
				return false;
			}
			if ($('#validTime').val() == '') {
				$('#validTime').focus();
				return false;
			}
        },
        success: function(result) {
			if (result.model.code == 1) {
                layer.msg(result.model.data,{icon:1,time:1000},function () {
                	updateGlobalSetDialog.close();
                    $table.bootstrapTable('refresh');
                });
			} else {
                if (result.model.data instanceof Array) {
                    $.each(result.model.data, function(index, value) {
                        layer.alert(value.errorMsg,{icon:2})
                    });
                } else {
                    layer.alert(result.model.data,{icon:2});
                }
			}
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
        	layer.alert(textStatus,{icon:2});
        }
    });
}
</script>