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
	<title>商户冻结记录列表</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<style type="text/css">
	.frozen-diglog-left{
		margin-left: 30%;
	}
	.update_dialog{
		width: 120%;
		margin-top: 5%;
		margin-left: -10%;
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
		url: '${basePath}/frozenRecord/agentList',	//获取表格数据的url
		height: getHeight(),	//行高，如果没有设置height属性，表格自动根据记录条数决定表格高度
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
		idField: 'agentId',	//指定主键列
		maintainSelected: true,
		detailView: false, //是否开启子table
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			/*{field: 'ck', checkbox: true},*/
			{field: 'agentId', title: '商户ID', align: 'center'},
            {field: 'companyName', title: '商户名称', align: 'center'},
            {field: 'name', title: '联系人', align: 'center'},
            {field: 'phone', title: '联系电话', align: 'center'},
            {field: 'amount', title: '可用余额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'frozenAmountSum', title: '冻结总额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'unfreezeAmount', title: '已解冻总额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'frozenAmount', title: '待解冻总额(元)', align: 'center', formatter: 'moneyFormatter'},
			{field: 'action', title: '操作', align: 'center', width: 120, formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		],
	});
});
// 操作按钮
function actionFormatter(value, row, index) {
	return [
		'<shiro:hasPermission name="pattern:frozenRecord:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="lookFrozenRow('+row.agentId+')" title="查看冻结记录">冻结记录</button></shiro:hasPermission>'
	].join('');
}

function query(){
    $table.bootstrapTable('refresh');
}

//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        agentId: $('#agentIdParam').val()
    }
}

function moneyFormatter(value) {
	if(value){
	    return value / 100;
	}else{
        return value;
    }
}

//查看冻结记录
var lookFrozenDialog;
function lookFrozenRow(agentId) {
    lookFrozenDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'update_dialog',
        title: '查看商户冻结记录',
        content: 'url:${basePath}/frozenRecord/lookFrozenRecord/'+agentId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

</script>
</body>
</html>