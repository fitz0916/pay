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
	<title>短信通道管理</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:smsSet:update">
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateSmsSet()"><i class="zmdi zmdi-plus"></i> 短信全局参数</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="pattern:smsChannel:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增短信通道</a>
		</shiro:hasPermission>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');

//新增
var createDialog;

//编辑
var updateDialog;

//编辑全局参数
var updateGlobalSetDialog;

//删除
var deleteDialog;

//设置参数
var channelParamDialog;

$(function() {
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/smsChannel/list',
		height: getHeight(),
		striped: true,
		search: false,
		showRefresh: true,
		showColumns: true,
		minimumCountColumns: 2,
		clickToSelect: true,
		// detailView: true,
		detailFormatter: 'detailFormatter',
		pagination: true,
		paginationLoop: false,
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: true,
		idField: 'smsChannelId',
		maintainSelected: true,
		toolbar: '#toolbar',
		columns: [
			{field:'smsChannelId', visible:false},
			{field:'isDefault', visible:false},
			{field:'channelName',title:'通道名称',align:'center'},
			{field:'vendorName',title:'短信服务商名称',align:'center'},
			{field:'remarks',title:'备注信息',align:'center'},
			{field:'isEnabled',title:'是否启用',align:'center', formatter: function (value, row, index) { return (value=='1')?'已启用':'未启用'; }},
			{field:'action',align:'center', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		]
	});
});




// 格式化操作按钮
var isDefaultBtn=''; 
function actionFormatter(value, row, index) {
	if(row.isDefault==1){
		isDefaultBtn = '<button type="button" class="btn btn-success btn-sm" style="margin-right:10px;padding:0 10px;" disabled>已默认</button>';
	}else{
		isDefaultBtn = '<shiro:hasPermission name="pattern:smsChannel:update"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="setDefault('+row.smsChannelId+')">默　认</button></shiro:hasPermission>'; 
	}
	
	
    return [
    	isDefaultBtn,
		'<shiro:hasPermission name="pattern:smsChannel:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.smsChannelId+')">修　改</button></shiro:hasPermission>',
		'<shiro:hasPermission name="pattern:smsChannel:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="openChannelParamDialog('+row.smsChannelId+')">设置参数</button></shiro:hasPermission>',
		'<shiro:hasPermission name="pattern:smsChannel:delete"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" onclick="deleteRow('+row.smsChannelId+',null)">删　除</button></shiro:hasPermission>'
    ].join('');
}


//新增行
function setDefault(id) {
	$.ajax({
		type : "get",
		url : "${basePath}/smsChannel/setDefault/"+id,   
		success: function(result) {
			if (result.model.code == 1) {
                 layer.msg(result.model.data,{icon:1,time:1000},function () {
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


//新增行
function createAction() {
	createDialog = $.dialog({
		animationSpeed: 300,
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
		title: '新增短信通道',
		content: 'url:${basePath}/smsChannel/create',
		onContentReady: function () {
			initMaterialInput();
		}
	});
}
//编辑行
function updateRow(id){
    updateDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
        title: '编辑短信通道',
        content: 'url:${basePath}/smsChannel/update/' + id,
        onContentReady: function () {
			initMaterialInput();
        }
    });
}
//编辑短信全局参数
function updateSmsSet(){
    updateGlobalSetDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
        title: '短信配置全局参数',
        content: 'url:${basePath}/smsSet/update',
        onContentReady: function () {
			initMaterialInput();
        }
    });
}
//编辑短信通道参数
function openChannelParamDialog(id){
	channelParamDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-12',
        title: '短信通道参数',
        content: 'url:${basePath}/smsChannelParam/index/'+id,
        onContentReady: function () {
			initMaterialInput();
        }
    });
}
//删除行
function deleteRow(id,rows) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该短信通道吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    if(id){
	                    $.ajax({
	                        type: 'get',
	                        url: '${basePath}/smsChannel/delete/' + id,
	                        success: function(result) {
	                			if (result.model.code == 1) {
	                                 layer.msg(result.model.data,{icon:1,time:1000},function () {
	                                	 deleteDialog.close();
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