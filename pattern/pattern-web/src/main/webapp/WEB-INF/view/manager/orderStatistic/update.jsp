 
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="orderStatusDialog" class="crudDialog">
	<form id="orderStatusForm" method="post">
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<h4>状态更改为：支付成功</h4>
						</div>
						<div class="form-group">
							<label for="sysRemark">备注</label>
							<input id="sysRemark" type="text" class="form-control" name="sysRemark" maxlength="255">
						</div>
					</div>
				</div>
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="createPayWhiteListSubmit();">保存</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="orderStatusDialog.close();">取消</a>
				</div>
			</div>
		</div>
	</form>
</div>
<script>

function createPayWhiteListSubmit() {
    $.ajax({
        type: 'post',
		url: '${basePath}/orderStatistic/update/${transPayOrderId}',
        data: $('#orderStatusForm').serialize(),
        beforeSend: function() {
			if ($('#sysRemark').val() == '') {
				$('#sysRemark').focus();
				return false;
			}
        },
        success: function(result) {
        	if (result.success) {
                layer.msg(result.model,{icon:1,time:1000},function () {
                	orderStatusDialog.close();
                    $table.bootstrapTable('refresh');
                });
			} else {
                layer.alert(result.errorMsg,{icon:2});
			}
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
        	layer.alert(textStatus,{icon:2});
        }
    });
}
</script>