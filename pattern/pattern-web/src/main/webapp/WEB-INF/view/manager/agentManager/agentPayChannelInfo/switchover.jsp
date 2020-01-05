<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<div id="switchoverDialog" class="crudDialog">
	<form id="form" method="post">
		<div class="form-group">
			<select id="payTypeId" name="payTypeId" class="form-control" onchange="queryPayChannelInfo()">
				<option value="">请选择交易类型</option>
				<c:forEach var="payType" items="${payTypeList}">
					<option value="${payType.payTypeId}">${payType.payname}</option>
				</c:forEach>
			</select>
		</div>

		<div class="form-group">
			<select id="oldPayChannelInfoId" name="oldPayChannelInfoId" class="form-control">
				<option value="">需切换的支付通道</option>
			</select>
		</div>

		<div class="form-group">
			<select id="newPayChannelInfoId" name="newPayChannelInfoId" class="form-control">
				<option value="">切换后的支付通道</option>
			</select>
		</div>

		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="switchSubmit();">确认批量切换</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
		</div>

	</form>
</div>
<script>

//根据支付类型ID查询商户已开通的支付通道
function queryPayChannelInfo() {
    var payTypeId = $("#payTypeId").val();
	if(payTypeId != ''){
        $.ajax({
            type: 'get',
            url: '${basePath}/agentPayChannelInfo/queryAgentPayChannelInfo/'+payTypeId,
            success: function(result) {
                var oldArray = new Array();
                oldArray.push('<option value="">需切换的支付通道</option>');
                var newArray = new Array();
                newArray.push('<option value="">切换后的支付通道</option>');
				$.each(result,function (i,item) {
                    oldArray.push('<option value="'+item.payChannelInfoId+'">'+item.payChannelInfo.channelInfoName+'</option>')
                    newArray.push('<option value="'+item.payChannelInfoId+'">'+item.payChannelInfo.channelInfoName+'</option>')
                })
                $("#oldPayChannelInfoId").html(oldArray.join(''));
                $("#newPayChannelInfoId").html(newArray.join(''));
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                layer.alert(textStatus,{icon:2});
            }
        });
	}
}

function switchSubmit() {
    layer.msg("该功能暂未开放...",{icon:0});
}

</script>