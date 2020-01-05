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
	<title>查看商户冻结记录</title>
</head>
<body>
<div id="frozenRecordMain">
	<table id="frozenRecordTable"></table>
</div>
<script>
var $frozenRecordTable = $('#frozenRecordTable');
$(function() {
    $($frozenRecordTable).bootstrapTable({
        url: '${basePath}/frozenRecord/list/${agentId}',	//获取表格数据的url
        height: 523,	//行高，如果没有设置height属性，表格自动根据记录条数决定表格高度
        striped: true,	//是否启用行间隔色
        search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
        cache: false,	//是否使用缓存，默认为true
        searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
        minimumCountColumns: 2,	//最少允许的列数
        clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
        detailFormatter: 'detailFormatter',
        pagination: true,	//在表格底部显示分页组件，默认false
        paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
        sidePagination: 'server',
        silentSort: false,
        smartDisplay: false,
        escape: true,
        idField: 'frozenRecordId',	//指定主键列
        detailView: true, //是否开启子table
        maintainSelected: true,
        columns: [
            {field: 'frozenRecordId', title: '冻结记录ID', align: 'center'},
            {field: 'agentId', title: '商户ID', align: 'center'},
            {field: 'orderId', title: '冻结订单号', align: 'center'},
            {field: 'money', title: '冻结金额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'unfreezeMoney', title: '已解冻金额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'waitUnfreezeMoney', title: '待解冻金额(元)', align: 'center', formatter: 'moneyFormatter'},
            {field: 'status', title: '冻结状态', align: 'center', formatter: 'statusFormatter'},
            {field: 'operator', title: '操作人', align: 'center'},
            {field: 'remark', title: '冻结说明', align: 'center'},
            {field: 'createTime', title: '冻结时间', align: 'center'},
            /*{field: 'updateTime', title: '最近解冻时间', align: 'center'},*/
            {field: 'action', title: '操作', width: 155, formatter: 'actionFrozenFormatter', events: 'actionEvents'}
        ],
        //子table触发事件
        onExpandRow:function(index,row,$element){
            var childTable = $element.html('<table id="child_table'+row.frozenRecordId+'"></table>').find('table');
            $(childTable).bootstrapTable({
                url: '${basePath}/frozenRecord/unfreezeRecordList/'+row.frozenRecordId,	//获取表格数据的url
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
                idField: 'unfreezeRecordId',	//指定主键列
                maintainSelected: true,
                columns: [
                    {field: 'unfreezeRecordId', title: '解冻记录ID', align: 'center'},
                    {field: 'frozenRecordId', title: '冻结记录ID', align: 'center'},
                    {field: 'agentId', title: '商户ID', align: 'center'},
                    {field: 'unfreezeMoney', title: '解冻金额', align: 'center', formatter: 'moneyFormatter'},
                    {field: 'operator', title: '操作人', align: 'center'},
                    {field: 'remark', title: '解冻说明', align: 'center'},
                    {field: 'createTime', title: '解冻时间', align: 'center'},
                ]
            });
        }
    });
});


function actionFrozenFormatter(value, row, index) {
    if(row.status == 0){
        return [
            '<shiro:hasPermission name="pattern:frozenRecord:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="unfreezeRecordRow('+index+')" title="查看解冻记录">解冻记录</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:frozenRecord:update"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="unfreezeRow('+row.frozenRecordId+')" title="解冻">解冻</button></shiro:hasPermission>'
        ].join('');
    }
    if(row.status == 1){
        return [
            '<shiro:hasPermission name="pattern:frozenRecord:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="unfreezeRecordRow('+index+')" title="查看解冻记录">解冻记录</button></shiro:hasPermission>'
        ].join('');
    }
    if(row.status == 2){
        return [
            '<shiro:hasPermission name="pattern:frozenRecord:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="unfreezeRecordRow('+index+')" title="查看解冻记录">解冻记录</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:frozenRecord:update"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="unfreezeRow('+row.frozenRecordId+')" title="解冻">解冻</button></shiro:hasPermission>'
        ].join('');
    }
}

function moneyFormatter(value) {
    if(value){
        return value / 100;
	}else{
        return value;
	}
}

function statusFormatter(value){
    if(value == 0){
        return '<label style="color:red">冻结中</label>';
    }else if(value == 1){
        return '已解冻';
    }else if(value == 2){
        return '<label style="color:red">已解冻部分</label>';
    }
}

function unfreezeRecordRow(index) {
    //加载子table
    $('tr[data-index="'+index+'"]').find('.detail-icon').click();
}

//解冻功能
var unfreezeDialog;
function unfreezeRow(frozenRecordId) {
    unfreezeDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-5 frozen-diglog-left',
        title: '商户余额解冻',
        content: 'url:${basePath}/frozenRecord/createUnfreeze/'+frozenRecordId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

</script>
</body>
</html>