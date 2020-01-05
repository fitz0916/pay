<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
	<style type="text/css">
	.cMaringB{
	    margin-bottom: 33px;
	}
	.cMaringB-combo{
	    margin-bottom: 26px;
	}
	</style>
<div id="updateDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group cMaringB-combo">
						<c:forEach var="temp" items="${agentlist}">
							<c:if test="${temp.agentId==shop.agentId}">
								<label for="temp">所属商户</label>
								<input id="temp" type="text" class="form-control" value="${temp.companyName}" readonly>
							</c:if>
						</c:forEach>
						</div>
						<div class="form-group">
							<label for="shopName">门店名称</label>
							<input id="shopName" type="text" class="form-control" name="shopName" maxlength="50"  value="${shop.shopName}">
						</div>
						<div class="form-group">
							<label for="shopNo">门店编号</label>
							<input id="shopNo" type="text" class="form-control" name="shopNo" maxlength="15"  value="${shop.shopNo}">
						</div>
						<div class="form-group">
							<label for="brand">品牌</label>
							<input id="brand" type="text" class="form-control" name="brand" maxlength="25"  value="${shop.brand}">
						</div>
						<div class="form-group">
							<label for="adress">门店地址</label>
							<input id="adress" type="text" class="form-control" name="adress" maxlength="100"  value="${shop.adress}">
						</div>
						<div class="form-group">
							<label for="name">联系人姓名</label>
							<input id="name" type="text" class="form-control" name="name" maxlength="15"  value="${shop.name}">
						</div>
						<div class="form-group">
							<label for="tel">联系人电话</label>
							<input id="tel" type="text" class="form-control" name="tel" maxlength="11"  value="${shop.tel}" onpaste="return false" onkeyup="value=value.replace(/[^\d]/g,'')">
						</div>
						<div class="radio">
							<div class="radio radio-inline radio-success">
								<input id="isLock_0" type="radio" name="isLock" value="0" style="margin-left: 11px;" <c:if test="${shop.isLock==0}">checked</c:if>>
								<label for="isLock_0">启用</label>
							</div>
							<div class="radio radio-inline radio-info">
								<input id="isLock_1" type="radio" name="isLock" value="1" style="margin-left: 11px;" <c:if test="${shop.isLock==1}">checked</c:if>>
								<label for="isLock_1">禁用</label>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
				</div>
			</div>
		</div>
	</form>
</div>
<jsp:include page="../../../common/inc/dialog_footer.jsp" flush="true"/>
<script>

function createSubmit() {
    $.ajax({
        type: 'post',
		url: '${basePath}/shop/update/${shop.shopId}',
        data: $('#updateForm').serialize(),
        beforeSend: function() {
			if ($('#shopName').val() == '') {
				$('#shopName').focus();
				return false;
			}
			if ($('#shopNo').val() == '') {
				$('#shopNo').focus();
				return false;
			}
			if ($('#brand').val() == '') {
				$('#brand').focus();
				return false;
			}
			if ($('#adress').val() == '') {
				$('#adress').focus();
				return false;
			}
			if ($('#name').val() == '') {
				$('#name').focus();
				return false;
			}
			if ($('#tel').val() == '') {
				$('#tel').focus();
				return false;
			}
			if($("#tel").val() != ''){
                var mobileRegex = /^[1][0-9]{10}$/;
                if(!mobileRegex.test($("#tel").val())){
                    layer.msg('手机号码格式不正确',{icon:0,time:2000});
                    return false;
				}
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
        	layer.alert(textStatus,{icon:2});
        }
    });
}
</script>