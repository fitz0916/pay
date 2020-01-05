<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html lang="zh-cn">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>查看商户代付类型手续费</title>
</head>
<body>
<style type="text/css">
    .diglog-left{
        margin-left: 30%;
    }
</style>
<div id="agentPayoutTypeFeeMain">
	<div class="panel panel-default">
		<form class="form-horizontal" id="payoutTypeFeeForm">
			<div class="panel-body">
				<div class="row pd-bottom-2">
					<div style="width: 8%;float: left;">
						<h5>&nbsp;&nbsp;&nbsp;起始金额</h5>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<input type="text" id ="initialAmount" name="initialAmount" class="form-control" maxlength="8" placeholder="单位元" onpaste="return false" onkeyup="keyupDaymoney(this)"/>
						</div>
					</div>
					<div style="width: 8%;float: left;">
						<h5>&nbsp;&nbsp;&nbsp;结束金额</h5>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<input type="text" id ="terminatedAmount" name="terminatedAmount" class="form-control" maxlength="8" placeholder="单位元" onpaste="return false" onkeyup="keyupDaymoney(this)"/>
						</div>
					</div>
					<div style="width: 8%;float: left;">
						<h5>&nbsp;&nbsp;&nbsp;手续费率%</h5>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<input type="text" id ="rate" name="rate" class="form-control" maxlength="10" placeholder="0.00000000" onpaste="return false" onkeyup="keyupRate(this)"/>
						</div>
					</div>
					<div style="width: 8%;float: left;">
						<h5>&nbsp;&nbsp;&nbsp;手续费</h5>
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<input type="text" id ="fee" name="fee" class="form-control" maxlength="10" placeholder="单位元" onpaste="return false" onkeyup="keyupInputMoney(this)"/>
						</div>
					</div>
					<div class="col-md-3">
					</div>
				</div>
				<div class="col-md-12 text-right ">
                    <input type="hidden" id="payoutTypeId" name="payoutTypeId" value="${payoutTypeId}">
                    <input type="hidden" id="agentId" name="agentId" value="${agentId}">
					<a onclick="createFeeSubmit()" class="btn btn-danger pull-right" style="margin-right:10px;" >保存</a>
				</div>
			</div>
		</form>
	</div>

	<table id="agentPayoutTypeFeeTable"></table>
</div>
<script>
var $agentPayoutTypeFeeTable = $('#agentPayoutTypeFeeTable');
$(function() {
	// bootstrap table初始化
    $agentPayoutTypeFeeTable.bootstrapTable({
		url: '${basePath}/agentPayoutChannelInfo/payoutTypeFeeList/${agentId}/${payoutTypeId}',	//获取表格数据的url
		height: 523,	//行高，如果没有设置height属性，表格自动根据记录条数决定表格高度
		cache: false,	//是否使用缓存，默认为true
		striped: true,	//是否启用行间隔色
		search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
		showRefresh: false,	//是否显示刷新按钮
		showColumns: false,	//是否显示所有的列
		minimumCountColumns: 2,	//最少允许的列数
		clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
		pagination: true,	//在表格底部显示分页组件，默认false
		paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
		idField: 'agentPayoutTypeFeeId',	//指定主键列
		maintainSelected: true,
		detailView: false, //是否开启子table
		//toolbar: '#toolbar',
		columns: [
            {field: 'agentId', title: '商户Id', align: 'center'},
            {field: 'payoutTypeId', title: '代付类型', align: 'center', formatter: 'payoutTypeIdFormatters'},
            {field: 'initialAmount', title: '起始金额(元)', align: 'center', formatter: 'moneyFeeFormatter'},
            {field: 'terminatedAmount', title: '结束金额(元)', align: 'center', formatter: 'moneyFeeFormatter'},
            {field: 'rate', title: '手续费率%', align: 'center'},
            {field: 'fee', title: '单笔手续费(元)', align: 'center', formatter: 'moneyFeeFormatter'},
            {field: 'createTime', title: '创建时间', align: 'center'},
            {field: 'action', title: '操作', width: 150, formatter: 'actionPayoutTypeFeeFormatter', events: 'actionEvents'}
		],
	});
});

// 操作按钮
function actionPayoutTypeFeeFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:agentPayoutType"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateFeeRow('+row.agentPayoutTypeFeeId+')">修改</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:agentPayoutType"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="deleteFeeRow('+row.agentPayoutTypeFeeId+')">删除</button></shiro:hasPermission>'
    ].join('');
}

function payoutTypeIdFormatters(value){
    if(value == 700){
        return 'T0结算';
    }else if(value == 701){
        return 'T1结算';
    }else if(value == 702){
        return 'D0结算';
    }else if(value == 703){
        return 'D1结算';
    }
}

function moneyFeeFormatter(value){
    if(value){
        return value / 100;
    }else{
        return value;
    }
}

//修改手续费
var updateFeeDialog;
function updateFeeRow(agentPayoutTypeFeeId) {
    updateFeeDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-5 diglog-left',
        title: '修改手续费',
        content: 'url:${basePath}/agentPayoutChannelInfo/updatePayoutTypeFee/'+agentPayoutTypeFeeId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//删除手续费
var deleteFeeDialog;
function deleteFeeRow(agentPayoutTypeFeeId) {
    deleteFeeDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该条手续费设置吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/agentPayoutChannelInfo/deletePayoutTypeFee/' + agentPayoutTypeFeeId,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    deleteFeeDialog.close();
                                    $agentPayoutTypeFeeTable.bootstrapTable('refresh');
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
            },
            cancel: {
                text: '取消',
                btnClass: 'waves-effect waves-button'
            }
        }
    });
}

function createFeeSubmit() {
    var payoutTypeId = $('#payoutTypeId').val();
    var agentId = $('#agentId').val();
    var initialAmount = $('#initialAmount').val().trim();
    var terminatedAmount = $('#terminatedAmount').val().trim();
    var rate = $('#rate').val().trim();
    var fee = $('#fee').val().trim();

    var dataJson = {'payoutTypeId':payoutTypeId,'agentId':agentId,'initialAmount':initialAmount,'terminatedAmount':terminatedAmount,'rate':rate,'feeAmount':fee};

    $.ajax({
        type: 'post',
        url: '${basePath}/agentPayoutChannelInfo/createPayoutTypeFee',
        data: dataJson,
        beforeSend: function() {
            if(payoutTypeId == ''){
                layer.msg('代付类型ID获取失败',{icon:0,time:2000});
                return false;
            }

            if(agentId == ''){
                layer.msg('商户ID获取失败',{icon:0,time:2000});
                return false;
            }

            if (initialAmount == '') {
                $('#initialAmount').focus();
                return false;
            }
            if (terminatedAmount == '') {
                $('#terminatedAmount').focus();
                return false;
            }

            if(Number(initialAmount) >= Number(terminatedAmount)){
                layer.msg('起始金额不能大于等于结束金额',{icon:0,time:2000});
                return false;
            }

            if (rate == '' && fee == '') {
                layer.msg('请填写手续费率或者手续费',{icon:0,time:2000});
                return false;
            }

            if(rate == '' && fee != '' && Number(fee) == 0){
                layer.msg('没填写手续费率时手续费不能为0',{icon:0,time:2000});
                return false;
            }

            if(fee != ''){
                var regex =  /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
                if(!regex.test(fee)){
                    layer.msg('手续费格式输入不正确', {icon: 0, time: 1000});
                    return false;
                }
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $agentPayoutTypeFeeTable.bootstrapTable('refresh');
                    //表单提交初始化
                    $('#initialAmount').val('');
                    $('#terminatedAmount').val('');
                    $('#rate').val('');
                    $('#fee').val('');
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
</body>
</html>