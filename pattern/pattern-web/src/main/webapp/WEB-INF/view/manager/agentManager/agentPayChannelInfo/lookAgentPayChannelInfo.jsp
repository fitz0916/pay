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
	<title>查看商户支付通道</title>
</head>
<body>
<div id="agentPayChannelInfoMain">
	<table id="agentPayChannelInfoTable"></table>
</div>
<script>
var $agentPayChannelInfoTable = $('#agentPayChannelInfoTable');
$(function() {
	// bootstrap table初始化
    $agentPayChannelInfoTable.bootstrapTable({
		url: '${basePath}/agentPayChannelInfo/agentPayChannelInfoListAll/${agentId}',	//获取表格数据的url
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
		idField: 'agentPayChannelInfoId',	//指定主键列
		maintainSelected: true,
		detailView: false, //是否开启子table
		//toolbar: '#toolbar',
		columns: [
            {field: 'agentPayChannelInfoId', title: '商户支付通道ID', align: 'center'},
            {field: 'payType.payname', title: '支付类型', align: 'center'},
            {field: 'payChannelInfo.channelInfoName', title: '支付通道名称', align: 'center'},
            {field: 'payChannelInfo.salefee', title: '销售费率', align: 'center'},
            {field: 'payChannelInfo.daymoney', title: '交易日限额', align: 'center'},
            {field: 'priority', title: '优先级[从大到小]', align: 'center'},
            {field: 'payChannelInfo.isLock', title: '支付通道状态', align: 'center', formatter: 'isLockInfoFormatters'},
            {field: 'payChannelInfo.remark', title: '备注信息', align: 'center'}
		],
	});
});

function isLockInfoFormatters(value){
    if(value == 0){
        return '启用';
    }
    if(value == 1){
        return '<label style="color:red">禁用</label>';
    }
}
</script>
</body>
</html>