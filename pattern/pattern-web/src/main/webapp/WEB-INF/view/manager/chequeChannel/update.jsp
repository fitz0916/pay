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
							<label for="payChannelId">收款通道名称</label>
							<select id=payChannelId name="payChannelId" class="form-control">
								<option value="0">请选择收款通道</option>
								<c:forEach var="payChannel" items="${payChannelList}">
									<option value="${payChannel.payChannelId}"
											<c:if test="${payChannel.payChannelId==chequeChannel.payChannelId}">selected="selected"</c:if>>
											${payChannel.channelName}
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
											<c:if test="${bank.cyberBankId==chequeChannel.cyberBankId}">selected="selected"</c:if>>
											${bank.bankName}-
											<c:if test="${bank.bankType==1}">借记卡</c:if>
											<c:if test="${bank.bankType==2}">信用卡</c:if>
									</option>
								</c:forEach>
							</select>
						</div>

						
						<div class="form-group">
							<label for="bankNum">第三方银行编码</label>
							<input id="bankNum" type="text" class="form-control" name="bankNum" maxlength="30" value="${chequeChannel.bankNum}">
						</div>
						
						<div class="form-group">
							<label for="notes">备注信息</label>
							<input id="notes" type="text" class="form-control" name="notes" maxlength="255" value="${chequeChannel.notes}">
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
        url: '${basePath}/chequeChannel/update/${chequeChannel.id}',
        data: $('#updateForm').serialize(),
        beforeSend: function() {
            if($('#payChannelId').val()==0){
				$('#payChannelId').focus();
				return false;
			}
            if($('#cyberBankId').val()==0){
				$('#cyberBankId').focus();
				return false;
			}
            if ($('#bankNum').val() == '') {
                $('#bankNum').focus();
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