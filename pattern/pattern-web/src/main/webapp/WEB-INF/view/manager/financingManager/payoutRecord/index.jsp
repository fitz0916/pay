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
	<title>商户代付记录列表</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<style>
    .refuse-diglog-left{
        margin-left: 30%;
    }
</style>

<div id="main">
	<div id="toolbar">
		&nbsp;&nbsp;&nbsp;&nbsp;商户：
		<select id ="agentIdParam" class="selectpicker" style="width: 150px">
			<option value="">全部</option>
			<c:forEach var="agent" items="${agentList}">
				<option value="${agent.agentId}">${agent.companyName}</option>
			</c:forEach>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;状态：
		<select id ="payoutStatusParam" class="selectpicker" style="width: 150px">
			<option value="">全部</option>
			<option value="0">申请提现中</option>
			<option value="1">待审核</option>
            <option value="2">审核不通过</option>
            <option value="3">提现成功</option>
            <option value="4">提现失败</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="query()" class="btn btn-success pull-right">查询</a>
	</div>

	<table id="table"></table>
</div>
<jsp:include page="../../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');
$(function() {
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/agentPayoutOrder/list',	//获取表格数据的url
		height: getHeight(),	//行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
		cache: false,	//是否使用缓存，默认为true
		striped: true,	//是否启用行间隔色
		search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
		showRefresh: true,	//是否显示刷新按钮
		showColumns: true,	//是否显示所有的列
		minimumCountColumns: 2,	//最少允许的列数
		clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
		pagination: true,	//在表格底部显示分页组件，默认false
		paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
		idField: 'agentPayoutOrderId',	//指定主键列
		maintainSelected: true,
		detailView: true, //是否开启子table
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			/*{field: 'ck', checkbox: true},*/
            {field: 'agentPayoutOrderId', title: '提现订单号', align: 'center'},
			{field: 'agentId', title: '商户ID', align: 'center'},
            {field: 'agent.companyName', title: '商户名称', align: 'center'},
            {field: 'agent.name', title: '联系人', align: 'center'},
            {field: 'agent.phone', title: '联系电话', align: 'center'},
            {field: 'payoutAmount', title: '申请提现金额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'payoutAmountReality', title: '实际到账金额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'payoutProundage', title: '手续费(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'payoutStatus', title: '提现状态', align: 'center', formatter: 'statusFormatter'},
            {field: 'payoutWay', title: '代付方式', align: 'center', formatter: 'payoutWayFormatter'},
            {field: 'payoutTypeId', title: '代付类型', align: 'center', formatter: 'payoutTypeIdFormatter'},
            {field: 'orderGenerateDate', title: '申请时间', align: 'center'},
            {field: 'orderFinishDate', title: '完成时间', align: 'center'},
			{field: 'action', title: '操作', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		],
        //子table触发事件
        onExpandRow:function(index,row,$element){
            var childTable = $element.html('<table id="child_table'+row.agentPayoutOrderId+'"></table>').find('table');
            $(childTable).bootstrapTable({
                url: '${basePath}/agentPayoutOrder/getPayoutOrderDetails/'+row.agentPayoutOrderId,	//获取表格数据的url
                cache: false,	//是否使用缓存，默认为true
                striped: true,	//是否启用行间隔色
                search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
                showRefresh: false,	//是否显示刷新按钮
                showColumns: false,	//是否显示所有的列
                minimumCountColumns: 2,	//最少允许的列数
                clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
                pagination: false,	//在表格底部显示分页组件，默认false
                paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
                sidePagination: 'server',
                silentSort: false,
                smartDisplay: false,
                escape: true,
                searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
                idField: 'agentPayoutOrderId',	//指定主键列
                maintainSelected: true,
                columns: [
                    {field: 'agentPayoutOrderId', title: '提现订单号', align: 'center'},
                    {field: 'agentId', title: '商户ID', align: 'center'},
                    {field: 'bankcardAccountName', title: '持卡人姓名', align: 'center'},
                    {field: 'bankcardAccountPhone', title: '银行手机号', align: 'center'},
                    {field: 'idcardNo', title: '身份证', align: 'center'},
                    {field: 'bankcardName', title: '银行名称', align: 'center'},
                    {field: 'bankcardAccount', title: '银行卡号', align: 'center'},
                    {field: 'bankcardAccountProvince', title: '收款银行省', align: 'center'},
                    {field: 'bankcardAccountCity', title: '收款银行市', align: 'center'},
                    {field: 'accType', title: '银行卡类型', align: 'center', formatter: 'accTypeFormatter'},
                    {field: 'operator', title: '操作人', align: 'center'},
                    {field: 'remark', title: '备注信息', align: 'center'},
                ]
            });
        }
	});
});

function query(){
    $table.bootstrapTable('refresh');
}

//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        agentId: $('#agentIdParam').val(),
        payoutStatus: $("#payoutStatusParam").val()
    }
}

// 操作按钮
function actionFormatter(value, row, index) {
	if(row.payoutStatus == 0){
        return [
            '<shiro:hasPermission name="pattern:agentPayoutOrder:read"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="detailsRow('+index+')" title="查看详情">查看详情</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:agentPayoutOrder:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="refreshRow(\''+row.agentPayoutOrderId+'\')" title="更新提现状态">更新提现状态</button></shiro:hasPermission>',
        ].join('');
    }else if(row.payoutStatus == 1 && row.payoutWay == 1){
        return [
            '<shiro:hasPermission name="pattern:agentPayoutOrder:read"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="detailsRow('+index+')" title="查看详情">查看详情</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:agentPayoutOrder:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="affirmRow(\''+row.agentPayoutOrderId+'\')" title="确认提现">确认提现</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:agentPayoutOrder:update"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="refuseRow(\''+row.agentPayoutOrderId+'\')" title="拒绝提现">拒绝提现</button></shiro:hasPermission>'
        ].join('');
    }else{
        return [
            '<shiro:hasPermission name="pattern:agentPayoutOrder:read"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="detailsRow('+index+')" title="查看详情">查看详情</button></shiro:hasPermission>',
        ].join('');
	}
}

function detailsRow(index) {
    //加载子table
    $('tr[data-index="'+index+'"]').find('.detail-icon').click();
}

function statusFormatter(value){
    if(value == 0){
        return '申请提现中';
	}else if(value == 1){
        return '待审核';
    }else if(value == 2){
        return '审核不通过';
    }else if(value == 3){
        return '提现成功';
	}else if(value == 4){
        return '提现失败';
    }else if(value == 5){
        return '被三方冻结';
    }
}

function payoutTypeIdFormatter(value){
    if(value == 700){
        return 'T0';
    }else if(value == 701){
        return 'T1';
    }else if(value == 702){
        return 'D0';
    }else if(value == 703){
        return 'D1';
    }
}

function payoutWayFormatter(value){
    if(value == 0){
        return '自动代付';
    }else if(value == 1){
        return '人工代付';
    }
}

function moneyFormatter(value) {
	if(value != null){
	    return value / 100;
	}
}

function accTypeFormatter(value){
    if(value == '01'){
        return '借记卡';
    }else if(value == '02'){
        return '贷记卡';
    }else if(value == '03'){
        return '存折';
    }else if(value == '04'){
        return '公司账号';
    }
}

//更新提现状态
var refreshDialog;
function refreshRow(agentPayoutOrderId) {
    refreshDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确定要获取当前代付最新状态吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/agentPayoutOrder/refreshPayoutOrder/' + agentPayoutOrderId,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    refreshDialog.close();
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
            },
            cancel: {
                text: '取消',
                btnClass: 'waves-effect waves-button'
            }
        }
    });
}

//确定提现
var affirmDialog;
function affirmRow(agentPayoutOrderId) {
    affirmDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确定该笔代付审核通过吗？确定后商户银行卡将会收到相应提现金额',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/agentPayoutOrder/affirmPayoutOrder/' + agentPayoutOrderId,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    affirmDialog.close();
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
            },
            cancel: {
                text: '取消',
                btnClass: 'waves-effect waves-button'
            }
        }
    });
}


//拒绝提现
var refuseDialog;
function refuseRow(agentPayoutOrderId) {
    refuseDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-5 refuse-diglog-left',
        title: '拒绝提现操作',
        content: 'url:${basePath}/agentPayoutOrder/rejectPayoutOrder/'+agentPayoutOrderId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

</script>
</body>
</html>