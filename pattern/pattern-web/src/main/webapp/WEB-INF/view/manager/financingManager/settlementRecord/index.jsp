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
	<title>商户结算记录列表</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
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
		<select id ="settleStatusParam" class="selectpicker" style="width: 150px">
			<option value="">全部</option>
			<option value="0">未结算</option>
			<option value="1">已结算</option>
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
		url: '${basePath}/settlementRecord/list',	//获取表格数据的url
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
		idField: 'transAgentSettleId',	//指定主键列
		maintainSelected: true,
		detailView: false, //是否开启子table
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			/*{field: 'ck', checkbox: true},*/
			{field: 'transAgentSettleId', title: '结算记录ID', align: 'center'},
            {field: 'agentId', title: '商户Id', align: 'center'},
            {field: 'agentName', title: '商户名称', align: 'center'},
            {field: 'agentPayAmountSum', title: '商户支付总额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'agentRealAmount', title: '商户待结算总额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'agentProundage', title: '商户手续费总额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'thirdRealAmount', title: '第三方到账总额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'thirdProundage', title: '第三方手续费总额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'saleProduage', title: '销售手续费总额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'settleStatus', title: '结算状态', align: 'center', formatter: 'settleStatusFormatter'},
            {field: 'balanceType', title: '结算类型', align: 'center', formatter: 'balanceTypeFormatter'},
            {field: 'payType', title: '支付类型', align: 'center', formatter: 'payTypeFormatter'},
            {field: 'payChannelId', title: '支付渠道ID', align: 'center'},
            {field: 'payChannelAccountId', title: '渠道账户ID', align: 'center'},
            {field: 'operator', title: '结算操作人', align: 'center'},
            {field: 'settleCreateDate', title: '结算生成时间', align: 'center'},
			{field: 'action', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		]
	});
});

// 操作按钮
function actionFormatter(value, row, index) {
    if(row.settleStatus == 0){
        return [
            '<shiro:hasPermission name="pattern:settlementRecord:update"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="affirmSettleRow(\''+row.transAgentSettleId+'\')" title="确认结算">确认结算</button></shiro:hasPermission>'
        ].join('');
    }
}

function query(){
    $table.bootstrapTable('refresh');
}

//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        agentId: $('#agentIdParam').val(),
        settleStatus: $("#settleStatusParam").val()
    }
}

function moneyFormatter(value) {
	if(value != null){
	    return value / 100;
	}
}

function settleStatusFormatter(value){
    if(value == 0){
        return '<label style="color:red">未结算</label>';
    }else if(value == 1){
        return '已结算';
    }else if(value == 2){
        return '取消结算';
    }
}

function balanceTypeFormatter(value){
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

function payTypeFormatter(value){
    if(value == 41){
        return '微信';
    }else if(value == 42){
        return '支付宝';
    }else if(value == 43){
        return 'QQ钱包';
    }else if(value == 52){
        return '网银银行';
    }else if(value == 60){
        return '京东钱包';
    }else if(value == 61){
        return '银行二维码';
    }else if(value == 62){
        return '微信H5';
    }else if(value == 63){
        return 'QQH5';
    }
}

//更新提现状态
var affirmSettleDialog;
function affirmSettleRow(transAgentSettleId) {
    affirmSettleDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确定要结算吗？结算后相应结算金额会追加到商户余额中',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/settlementRecord/affirmSettlement/' + transAgentSettleId,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    affirmSettleDialog.close();
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

</script>
</body>
</html>