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
	<title>支付通道列表</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<style>
	.update_dialog{
		width: 120%;
		margin-left: -10%;
		margin-top: 5%;
	}
</style>

<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:payChannelInfo:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增支付通道</a>
		</shiro:hasPermission>

		&nbsp;&nbsp;&nbsp;&nbsp;渠道账户：
		<select id ="payChannelAccountIdParam" class="selectpicker" style="width: 150px">
			<option value="">全部</option>
			<c:forEach var="payChannelAccount" items="${payChannelAccountList}">
				<option value="${payChannelAccount.payChannelAccountId}">${payChannelAccount.simpleName}</option>
			</c:forEach>
		</select>

		&nbsp;&nbsp;&nbsp;&nbsp;支付类型：
		<select id ="payTypeIdParam" class="selectpicker" style="width: 150px">
			<option value="">全部</option>
			<c:forEach var="payType" items="${payTypeList}">
				<option value="${payType.payTypeId}">${payType.payname}</option>
			</c:forEach>
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
		url: '${basePath}/payChannelInfo/list',	//获取表格数据的url
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
		idField: 'payChannelInfoId',	//指定主键列
		maintainSelected: true,
		detailView: true, //是否开启子table
		toolbar: '#toolbar',
		queryParams: queryParams,
		columns: [
			/*{field: 'ck', checkbox: true},*/
            {field: 'payChannelInfoId', title: '支付通道ID', align: 'center'},
            {field: 'channelInfoName', title: '支付通道名称', align: 'center'},
            {field: 'payChannelAccount.simpleName', title: '所属渠道账户', align: 'center'},
            {field: 'payType.payname', title: '支付类型', align: 'center'},
            {field: 'fee', title: '接入费率', align: 'center'},
            {field: 'salefee', title: '销售费率', align: 'center'},
            {field: 'isLock', title: '使用状态', align: 'center', formatter: 'isLockFormatter'},
            {field: 'remark', title: '备注信息', align: 'center'},
            {field: 'createTime', title: '创建时间', align: 'center'},
            {field: 'action', title: '操作', align: 'center', width: 200, formatter: 'actionFormatter', events: 'actionEvents'}
		],
		//子table触发事件
        onExpandRow:function(index,row,$element){
			var riskTable = $element.html('<table id="child_table'+row.payChannelInfoId+'"></table>').find('table');
            $(riskTable).bootstrapTable({
                url: '${basePath}/payChannelInfo/riskList/'+row.payChannelInfoId+'/'+row.payTypeId,	//获取表格数据的url
                striped: true,	//是否启用行间隔色
                cache: false,	//是否使用缓存，默认为true
                search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
                searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
                minimumCountColumns: 2,	//最少允许的列数
                clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
                detailFormatter: 'detailFormatter',
                pagination: false,	//在表格底部显示分页组件，默认false
                paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
                sidePagination: 'server',
                silentSort: false,
                smartDisplay: false,
                escape: true,
                idField: 'payChannelInfoRiskId',	//指定主键列
                maintainSelected: true,
                columns: [
                    {field: 'payChannelInfoRiskId', title: '风控ID', align: 'center'},
                    {field: 'payChannelInfoId', title: '支付通道ID', align: 'center'},
                    {field: 'allowTime', title: '允许支付时间', align: 'center'},
                    {field: 'payInterval', title: '交易时间间隔(秒)', align: 'center', formatter: 'defaultFormatter'},
                    {field: 'allowNum', title: '交易次数限制', align: 'center', formatter: 'defaultFormatter'},
                    {field: 'singleMoney', title: '单笔交易金额限制(元)', align: 'center'},
                    {field: 'dayMoney', title: '交易日限额(元)', align: 'center', formatter: 'defaultFormatter'},
                    {field: 'userMostNumber', title: '允许终端用户支付最多次数', align: 'center', formatter: 'defaultFormatter'},
                    {field: 'remark', title: '备注信息', align: 'center'},
                    {field: 'action', title: '操作', align: 'center', width: 150, formatter: 'actionRiskFormatter', events: 'actionEvents'}
                ]
            });
		}
	});
});
// 操作按钮
function actionFormatter(value, row, index) {
    if(row.isExistRisk == true){
        return [
            '<shiro:hasPermission name="pattern:payChannelInfo:create"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.payChannelAccountId+')" title="查看或修改支付通道">查看通道</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:payChannelInfo:risk"><button type="button" class="btn btn-info  btn-sm" style="margin-right:10px;padding:0 10px;" onclick="examineRiskRow('+index+')">查看风控</button></shiro:hasPermission>',
        ].join('');
	}else{
        return [
            '<shiro:hasPermission name="pattern:payChannelInfo:create"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.payChannelAccountId+')" title="查看或修改支付通道">查看通道</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:payChannelInfo:risk"><button type="button" class="btn btn-danger  btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createRiskRow('+row.payChannelInfoId+','+row.payTypeId+')">设置风控</button></shiro:hasPermission>',
        ].join('');
	}
}

// 参数列表操作按钮
function actionRiskFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:payChannelInfo:risk"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRiskRow('+row.payChannelInfoRiskId+')">修改</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:payChannelInfo:risk"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" onclick="deleteRiskRow('+row.payChannelInfoRiskId+')">删除</button></shiro:hasPermission>'
    ].join('');
}

function query(){
    $table.bootstrapTable('refresh');
}

function defaultFormatter(value){
    if(value){
        return value;
	}else{
        return '';
	}
}

//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        payChannelAccountId: $('#payChannelAccountIdParam').val(),
        payTypeId: $('#payTypeIdParam').val()
    }
}

function isLockFormatter(value) {
    if(value == 0){
        return "启用";
    }else if(value == 1){
        return "<label style='color:red'>禁用</label>";
    }
}

//查看支付通道风控
function examineRiskRow(index) {
    //加载子table
    $('tr[data-index="'+index+'"]').find('.detail-icon').click();
}

//新增支付通道
var createDialog;
function createAction() {
	createDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        title: '新增支付通道',
        content: 'url:${basePath}/payChannelInfo/create',
        onContentReady: function () {
            initMaterialInput();
        }
    });
}


//查看或修改支付通道
var updateDialog;
function updateRow(payChannelAccountId){
	updateDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'update_dialog',
        title: '开通或修改支付通道',
        content: 'url:${basePath}/payChannelInfo/lookOrUpdate/'+payChannelAccountId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//新增风控
function createRiskRow(payChannelInfoId,payTypeId){
    createDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        title: '新增支付渠道风控',
        content: 'url:${basePath}/payChannelInfo/createRisk/'+payChannelInfoId+'/'+payTypeId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//编辑风控
function updateRiskRow(payChannelInfoRiskId){
    updateDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        title: '修改支付渠道风控',
        content: 'url:${basePath}/payChannelInfo/updateRisk/'+payChannelInfoRiskId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}


//删除风控
var deleteDialog;
function deleteRiskRow(payChannelInfoRiskId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该支付渠道风控吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/payChannelInfo/deleteRisk/' + payChannelInfoRiskId,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    deleteDialog.close();
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