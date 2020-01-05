<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<label for="channelName">通道名称</label>
							<input id="channelName" type="text" class="form-control" name="channelName" maxlength="20">
						</div>
						<div class="form-group">
							<label for="vendorName">短信服务商名称</label>
							<input id="vendorName" type="text" class="form-control" name="vendorName" maxlength="20">
						</div>
						<div class="row">
							<div class="col-sm-3">
								<div class="form-group" style="margin-top: 3px;margin-left: 19px;">
									<select id="channelUrlMethod" name="channelUrlMethod" style="width:100px">
										<option value="">请选择</option>
										<option value="GET">GET</option>
										<option value="POST">POST</option>
									</select>
								</div>
							</div>
							<div class="col-sm-9">
								<div class="form-group">
									<label for="channelUrl">短信服务URL地址</label>
									<input id="channelUrl" type="text" class="form-control" name="channelUrl" maxlength="255">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="phoneKey">手机号参数名</label>
									<input id="phoneKey" type="text" class="form-control" name="phoneKey" maxlength="30">
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="msgKey">短信内容参数名</label>
									<input id="msgKey" type="text" class="form-control" name="msgKey" maxlength="30">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="remarks">备注信息</label>
							<input id="remarks" type="text" class="form-control" name="remarks" maxlength="255">
						</div>
						<div class="radio">
							<div class="radio radio-inline radio-success">
								<input id="isEnabled_1" type="radio" name="isEnabled" value="1" style="margin-left: 11px;">
								<label for="isEnabled_1">启用</label>
							</div>
							<div class="radio radio-inline radio-info">
								<input id="isEnabled_0" type="radio" name="isEnabled" value="0" style="margin-left: 11px;" checked>
								<label for="isEnabled_0">未启用</label>
							</div>
						</div>
					</div>
				</div>
			</div>	
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
		</div>
	</form>
</div>
<jsp:include page="../../../common/inc/dialog_footer.jsp" flush="true"/>
<script>
$(document).on('ready', function() {

    
});

    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/smsChannel/create',
            data: $('#createForm').serialize(),
            beforeSend: function() {
    			if ($('#channelName').val() == '') {
    				$('#channelName').focus();
    				return false;
    			}
    			if ($('#phoneKey').val() == '') {
    				$('#phoneKey').focus();
    				return false;
    			}
    			if ($('#msgKey').val() == '') {
    				$('#msgKey').focus();
    				return false;
    			}
    			if ($('#vendorName').val() == '') {
    				$('#vendorName').focus();
    				return false;
    			}
				if ($('#channelUrl').val() == '') {
    				$('#channelUrl').focus();
    				return false;
    			}
    			if ($('#channelUrlMethod').val() == '') {
    				$('#channelUrlMethod').focus();
    				return false;
    			}
            },
            success: function(result) {
    			if (result.model.code == 1) {
                    layer.msg(result.model.data,{icon:1,time:1000},function () {
                        createDialog.close();
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
