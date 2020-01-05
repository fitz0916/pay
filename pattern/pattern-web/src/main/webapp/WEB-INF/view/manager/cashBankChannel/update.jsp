<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<jsp:include page="../../common/inc/head.jsp" flush="true"/>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="updateDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<div class="row">
			<input type="hidden" name="proxyId" value="${user.proxyId}" id="proxyId">
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<label for="payChannelTemplateId">代付通道名称</label>
							<select id=payChannelTemplateId name="payChannelTemplateId" class="form-control">
								<option value="0">请选择代付通道</option>
								<c:forEach var="payOutChannel" items="${payOutChannelList}">
									<option value="${payOutChannel.payoutChannelId}"
											<c:if test="${payOutChannel.payoutChannelId==cashBankChannel.payChannelTemplateId}">selected="selected"</c:if>>
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
									<option value="${bank.cyberBankId}" data-hover="${bank.bankType}"
											<c:if test="${bank.cyberBankId==cashBankChannel.cyberBankId}">selected="selected"</c:if>>
											${bank.bankName}-
											<c:if test="${bank.bankType==1}">借记卡</c:if>
											<c:if test="${bank.bankType==2}">信用卡</c:if>
									</option>
								</c:forEach>
							</select>
						</div>

						
						<div class="form-group">
							<label for="cyberBankCode">银行编号</label>
							<input id="cyberBankCode" type="text" class="form-control" name="cyberBankCode" maxlength="10" value="${cashBankChannel.cyberBankCode}">
						</div>
						
						<div class="form-group">
							<label for="notes">备注信息</label>
							<input id="notes" type="text" class="form-control" name="notes" maxlength="255" value="${cashBankChannel.notes}">
						</div>
						
						<div class="radio">
							<div class="radio radio-inline radio-success">
								<input id="isOk_1" type="radio" name="isOk" value="1" style="margin-left: 11px;" <c:if test="${cashBankChannel.isOk==1}">checked</c:if>>
								<label for="isOk_1">启用</label>
							</div>
							<div class="radio radio-inline radio-info">
								<input id="isOk_0" type="radio" name="isOk" value="0" style="margin-left: 11px;" <c:if test="${cashBankChannel.isOk==0}">checked</c:if>>
								<label for="isOk_0">禁用</label>
							</div>
						</div>
						
					</div>
				</div>
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">保存</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
				</div>
			</div>
		</div>
	</form>
</div>
<jsp:include page="../../common/inc/dialog_footer.jsp" flush="true"/>
<script>


function updateSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/cashBankChannel/update/${cashBankChannel.id}',
        data: $('#updateForm').serialize(),
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
                	updateDialog.close();
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