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
	<title>商户充值记录列表</title>
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
		&nbsp;&nbsp;&nbsp;&nbsp;类型：
		<select id ="rechargeTypeParam" class="selectpicker" style="width: 150px">
			<option value="">全部</option>
			<option value="0">充值</option>
			<option value="1">错账</option>
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
		url: '${basePath}/rechargeRecord/list',	//获取表格数据的url
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
		idField: 'rechargeRecordId',	//指定主键列
		maintainSelected: true,
		detailView: false, //是否开启子table
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			/*{field: 'ck', checkbox: true},*/
			{field: 'rechargeRecordId', title: '充值记录ID', align: 'center'},
            {field: 'agentId', title: '商户ID', align: 'center'},
            {field: 'agent.companyName', title: '商户名称', align: 'center'},
            {field: 'agent.name', title: '联系人', align: 'center'},
            {field: 'agent.phone', title: '联系电话', align: 'center'},
            {field: 'money', title: '充值金额', align: 'center', formatter: 'moneyFormatter'},
            {field: 'rechargeType', title: '操作类型', align: 'center', formatter: 'statusFormatter'},
            {field: 'operator', title: '操作人', align: 'center'},
            {field: 'createTime', title: '操作时间', align: 'center'},
            {field: 'remark', title: '操作说明', align: 'center'},
			/*{field: 'action', title: '操作', align: 'center', width: 280, formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}*/
		]
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
        rechargeType: $("#rechargeTypeParam").val()
    }
}

function statusFormatter(value){
    if(value == 0){
        return '充值';
	}else if(value == 1){
        return '<label style="color:red">错账</label>';
	}
}

function moneyFormatter(value) {
	if(value != null){
	    return value / 100;
	}else{
	    return value;
	}
}
</script>
</body>
</html>