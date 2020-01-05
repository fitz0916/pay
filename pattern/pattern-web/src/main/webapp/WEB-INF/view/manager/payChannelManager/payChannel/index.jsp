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
	<title>支付渠道列表</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:payChannel:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增支付渠道</a>
		</shiro:hasPermission>

		&nbsp;&nbsp;&nbsp;&nbsp;支付渠道：
		<select id ="payChannelIdParam" class="selectpicker" style="width: 150px">
			<option value="">全部</option>
			<c:forEach var="payChannel" items="${payChannelList}">
				<option value="${payChannel.payChannelId}">${payChannel.channelName}</option>
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
		url: '${basePath}/payChannel/list',	//获取表格数据的url
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
		idField: 'payChannelId',	//指定主键列
		maintainSelected: true,
		detailView: true, //是否开启子table
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			/*{field: 'ck', checkbox: true},*/
			{field: 'payChannelId', title: '渠道ID', align: 'center'},
			{field: 'channelName', title: '渠道简称', align: 'center'},
            {field: 'templateName', title: '渠道模板英文名', align: 'center'},
            {field: 'fullName', title: '渠道全称', align: 'center'},
            {field: 'remark', title: '备注信息', align: 'center'},
			{field: 'action', title: '操作', align: 'center', width: 280, formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		],
		/*onClickCell:function(fidId,value,row,$element){
		    //点击某一列时加载子table，显示相关渠道参数
			if(fidId != 'action'){
                $element.parent().find('.detail-icon').click();
			}
		},*/
		//子table触发事件
        onExpandRow:function(index,row,$element){
			var paraTable = $element.html('<table id="child_table'+row.payChannelId+'"></table>').find('table');
            $(paraTable).bootstrapTable({
                url: '${basePath}/payChannel/paraList/'+row.payChannelId,	//获取表格数据的url
                striped: true,	//是否启用行间隔色
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
                idField: 'payChannelParaId',	//指定主键列
                maintainSelected: true,
                columns: [
                    {field: 'payChannelParaId', title: '参数ID', align: 'center'},
                    {field: 'payChannelId', title: '渠道ID', align: 'center'},
                    {field: 'chName', title: '参数描述', align: 'center'},
                    {field: 'enName', title: '参数名称', align: 'center'},
                    {field: 'remark', title: '备注信息', align: 'center'},
                    {field: 'action', title: '操作', align: 'center', width: 200, formatter: 'actionParaFormatter', events: 'actionEvents'}
                ]
            });
		}
	});
});
// 操作按钮
function actionFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:payChannel:para"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createParaRow('+row.payChannelId+')" title="设置模板参数">设置参数</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:payChannel:para"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="examineParaRow('+index+')" title="查看模板参数">查看参数</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:payChannel:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.payChannelId+')">修改</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:payChannel:delete"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" onclick="deleteRow('+row.payChannelId+')">删除</button></shiro:hasPermission>'
    ].join('');
}

// 参数列表操作按钮
function actionParaFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:payChannel:para"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateParaRow('+row.payChannelParaId+','+row.payChannelId+')">修改</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:payChannel:para"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" onclick="deleteParaRow('+row.payChannelParaId+','+row.payChannelId+')">删除</button></shiro:hasPermission>'
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
        payChannelId: $('#payChannelIdParam').val()
    }
}

//新增
var createDialog;
function createAction() {
	createDialog = $.dialog({
        animationSpeed: 300,
        title: '新增支付渠道',
        content: 'url:${basePath}/payChannel/create',
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//编辑
var updateDialog;
function updateRow(payChannelId){
    updateDialog = $.dialog({
        animationSpeed: 300,
        title: '修改支付渠道',
        content: 'url:${basePath}/payChannel/update/' + payChannelId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//删除
var deleteDialog;
function deleteRow(payChannelId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该支付渠道吗？删除后其他关联数据也将被删除！',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/payChannel/delete/' + payChannelId,
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


//新增支付渠道模板参数
function createParaRow(payChannelId) {
    createDialog = $.dialog({
        animationSpeed: 300,
        title: '新增支付渠道参数',
        content: 'url:${basePath}/payChannel/createPara/'+payChannelId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//查看渠道模板参数
function examineParaRow(index) {
    //加载子table
	$('tr[data-index="'+index+'"]').find('.detail-icon').click();
}

//修改支付渠道模板参数
function updateParaRow(payChannelParaId) {
    updateDialog = $.dialog({
        animationSpeed: 300,
        title: '修改渠道模板参数',
        content: 'url:${basePath}/payChannel/updatePara/'+payChannelParaId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}


//删除渠道参数
function deleteParaRow(payChannelParaId,payChannelId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该渠道参数吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/payChannel/deletePara/' + payChannelParaId,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    deleteDialog.close();
									$("#child_table"+payChannelId).bootstrapTable('refresh');
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