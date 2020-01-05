<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../../common/inc/head.jsp" flush="true"/>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<label for="payChannelTemplateId">代付通道名称</label>
					<select id=payChannelTemplateId name="payChannelTemplateId" class="form-control">
						<option value="0">请选择代付通道</option>
						<c:forEach var="payOutChannel" items="${payOutChannelList}">
							<option value="${payOutChannel.payoutChannelId}" >
									${payOutChannel.channelName}
							</option>
						</c:forEach>
					</select>
				</div>
				
				<div class="form-group">
					<label for="cyberBankId">银行名称</label>
					<select id=cyberBankId name="cyberBankId" class="form-control">
						<option value="0">请选择银行</option>
						<c:forEach var="bank" items="${bankList}">
							<option value="${bank.cyberBankId}" data-hover="${bank.bankType}" >
									${bank.bankName}-
									<c:if test="${bank.bankType==1}">借记卡</c:if>
									<c:if test="${bank.bankType==2}">信用卡</c:if>
							</option>
						</c:forEach>
					</select>
				</div>

				
				<div class="form-group">
					<label for="cyberBankCode">银行编号</label>
					<input id="cyberBankCode" type="text" class="form-control" name="cyberBankCode" maxlength="10">
				</div>
				
				<div class="form-group">
					<label for="notes">备注信息</label>
					<input id="notes" type="text" class="form-control" name="notes" maxlength="255">
				</div>
				
				<div class="radio">
					<div class="radio radio-inline radio-success">
						<input id="isOk_1" type="radio" name="isOk" value="1" style="margin-left: 11px;" checked>
						<label for="isOk_1">启用</label>
					</div>
					<div class="radio radio-inline radio-info">
						<input id="isOk_0" type="radio" name="isOk" value="0" style="margin-left: 11px;" >
						<label for="isOk_0">禁用</label>
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
<jsp:include page="../../common/inc/dialog_footer.jsp" flush="true"/>
<script>
    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/cashBankChannel/create',
            data: $('#createForm').serialize(),
            beforeSend: function() {
                if($('#payChannelTemplateId').val()==0){
    				$('#payChannelTemplateId').focus();
    				return false;
				}
                if($('#cyberBankId').val()==0){
    				$('#cyberBankId').focus();
    				return false;
				}
                if ($('#cyberBankCode').val() == '') {
                    $('#cyberBankCode').focus();
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
            	layer.alert(textStatus,{icon:2})
            }
        });
    }

   
</script>
