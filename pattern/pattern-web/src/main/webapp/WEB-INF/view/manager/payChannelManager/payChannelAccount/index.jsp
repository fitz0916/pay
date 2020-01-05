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
	<title>渠道账户列表</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:payChannelAccount:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i>新增渠道账户</a>
		</shiro:hasPermission>

		&nbsp;&nbsp;&nbsp;&nbsp;支付渠道：
		<select id ="payChannelIdParam" class="selectpicker" style="width: 150px" onchange="changePayChannel()">
			<option value="">全部</option>
			<c:forEach var="payChannel" items="${payChannelList}">
				<option value="${payChannel.payChannelId}">${payChannel.channelName}</option>
			</c:forEach>
		</select>

		&nbsp;&nbsp;&nbsp;&nbsp;渠道账户：
		<select id ="payChannelAccountIdParam" class="selectpicker" style="width: 150px">
			<option value="">全部</option>
			<c:forEach var="payChannelAccount" items="${payChannelAccountList}">
				<option value="${payChannelAccount.payChannelAccountId}">${payChannelAccount.simpleName}</option>
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
		url: '${basePath}/payChannelAccount/list',	//获取表格数据的url
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
		idField: 'payChannelAccountId',	//指定主键列
		maintainSelected: true,
		detailView: true, //是否开启子table
		toolbar: '#toolbar',
		queryParams: queryParams,
		columns: [
			/*{field: 'ck', checkbox: true},*/
			{field: 'payChannelAccountId', title: '渠道账户ID', align: 'center'},
			{field: 'simpleName', title: '账户简称', align: 'center'},
            {field: 'payChannelId', title: '所属支付渠道', align: 'center', formatter: 'payChannelIdFormatter'},
            {field: 'supportTypes', title: '支持类型', align: 'center', formatter: 'supportTypesFormatter'},
            {field: 'isLock', title: '使用状态', align: 'center', formatter: 'isLockFormatter'},
            {field: 'remark', title: '备注信息', align: 'center'},
            {field: 'createTime', title: '创建时间', align: 'center'},
			{field: 'action', title: '操作', align: 'center', width: 240, formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		],
        //子table触发事件
        onExpandRow:function(index,row,$element){
            var paraTable = $element.html('<table id="child_table'+row.payChannelAccountId+'"></table>').find('table');
            $(paraTable).bootstrapTable({
                url: '${basePath}/payChannelAccount/paraList/'+row.payChannelId+'/'+row.payChannelAccountId,	//获取表格数据的url
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
                idField: 'payChannelAccountParaId',	//指定主键列
                maintainSelected: true,
                columns: [
                    {field: 'payChannelPara.payChannelParaId', title: '参数ID', align: 'center'},
                    {field: 'payChannelPara.chName', title: '参数描述', align: 'center'},
                    {field: 'payChannelPara.enName', title: '参数名称', align: 'center'},
                    {field: 'value', title: '参数值', align: 'center', formatter: 'valueFormatter'},
                    {field: 'payChannelPara.remark', title: '备注信息', align: 'center'},
                    {field: 'action', title: '操作', align: 'center', width: 150, formatter: 'actionParaFormatter', events: 'actionEvents'}
                ]
            });
        }
	});
});

// 操作按钮
function actionFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:payChannelAccount:para"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="examineParaRow('+index+')" title="查看与设置渠道账户参数">设置参数</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:payChannelAccount:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.payChannelAccountId+')">修改</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:payChannelAccount:delete"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" onclick="deleteRow('+row.payChannelAccountId+')">删除</button></shiro:hasPermission>'
    ].join('');
}

function actionParaFormatter(value, row, index) {
    //封装参数提交数据
	var payChannelAccountParaId = row.payChannelAccountParaId;
	var payChannelParaId = row.payChannelPara.payChannelParaId;
	var payChannelAccountId = row.payChannelAccountId;

	if(payChannelAccountParaId == undefined || payChannelAccountParaId == ''){
        return [
            '<shiro:hasPermission name="pattern:payChannelAccount:para"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createParaRow('+payChannelAccountParaId+','+payChannelAccountId+','+payChannelParaId+')">保存</button></shiro:hasPermission>',
        ].join('');
	}else{
        return [
            '<shiro:hasPermission name="pattern:payChannelAccount:para"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateParaRow('+payChannelAccountParaId+','+payChannelAccountId+','+payChannelParaId+')">更新</button></shiro:hasPermission>',
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
        payChannelAccountId: $('#payChannelAccountIdParam').val(),
        payChannelId: $('#payChannelIdParam').val()
    }
}

//根据支付渠道动态获取渠道账户
function changePayChannel(){
    var payChannelId = $('#payChannelIdParam option:checked').val();
    if(payChannelId == ''){
        payChannelId = 0;
    }
    $.ajax({
        type : 'get',
        url : '${basePath}/payChannelAccount/queryPayChannelAccount/'+payChannelId,
        success : function (result) {
            var array = new Array();
            array.push('<option value="">全部</option>');
            $.each(result,function(i,item){
                array.push('<option value="'+item.payChannelAccountId+'">'+item.simpleName+'</option>');
            })
            $('#payChannelAccountIdParam').html(array);
        }
    })
}

function valueFormatter(value, row, index) {
    if(value){
        return '<input id="'+row.payChannelAccountId+'_'+row.payChannelPara.payChannelParaId+'_value" type="text" style="height:25px" class="form-control" value="'+value+'">' +
            '<input id="'+row.payChannelAccountId+'_'+row.payChannelPara.payChannelParaId+'_name" type="hidden" class="form-control" value="'+row.payChannelPara.enName+'">'
	}else{
        return '<input id="'+row.payChannelAccountId+'_'+row.payChannelPara.payChannelParaId+'_value" type="text" style="height:25px" class="form-control" value="">' +
            '<input id="'+row.payChannelAccountId+'_'+row.payChannelPara.payChannelParaId+'_name" type="hidden" class="form-control" value="'+row.payChannelPara.enName+'">'
	}
}

function payChannelIdFormatter(value, row, index) {
    if(row.payChannel){
        return row.payChannel.channelName + '[' + row.payChannel.templateName + ']';
	}else{
        return value;
	}
}

function isLockFormatter(value) {
    if(value == 0){
        return "启用";
    }else if(value == 1){
        return "<label style='color:red'>禁用</label>";
    }
}

function supportTypesFormatter(value) {
	if(value.indexOf('1') > -1 && value.indexOf('2') > -1){
	    return '支付,代付';
	}else{
	    if(value.indexOf('1') > -1){
	        return '支付';
		} else if(value.indexOf('2') > -1){
            return '代付';
        }
	}
}

//新增渠道账户
var createDialog;
function createAction() {
	createDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        title: '新增渠道账户',
        content: 'url:${basePath}/payChannelAccount/create',
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//编辑
var updateDialog;
function updateRow(payChannelAccountId){
    updateDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        title: '修改渠道账户',
        content: 'url:${basePath}/payChannelAccount/update/' + payChannelAccountId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//查看渠道账户参数
function examineParaRow(index) {
    //加载子table
    $('tr[data-index="'+index+'"]').find('.detail-icon').click();
}

//删除
var deleteDialog;
function deleteRow(payChannelAccountId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该渠道账户吗？删除后其他关联数据也将被删除！',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/payChannelAccount/delete/' + payChannelAccountId,
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

//新增渠道账户参数
function createParaRow(payChannelAccountParaId,payChannelAccountId,payChannelParaId){
    var name = $("#"+payChannelAccountId+'_'+payChannelParaId+"_name").val();
	var value = $("#"+payChannelAccountId+'_'+payChannelParaId+"_value").val().trim();
	var dataJson = {'payChannelAccountId':payChannelAccountId,'payChannelParaId':payChannelParaId,'name':name,'value':value};
    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelAccount/createPara',
        data: dataJson,
        beforeSend: function() {
			if(payChannelAccountId == undefined || payChannelAccountId == ''){
                layer.msg('渠道账户ID获取失败！',{icon:0,time:1000});
                return false;
			}
            if(payChannelParaId == undefined || payChannelParaId == ''){
                layer.msg('支付渠道参数ID获取失败！',{icon:0,time:1000});
                return false;
            }
            if(name == undefined || name == ''){
                layer.msg('参数名称获取失败！',{icon:0,time:1000});
                return false;
            }
            if(value == undefined || value == ''){
                layer.msg('请输入参数值！',{icon:0,time:1000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $("#child_table"+payChannelAccountId).bootstrapTable('refresh');
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

//更新渠道账户参数
function updateParaRow(payChannelAccountParaId,payChannelAccountId,payChannelParaId){
    var name = $("#"+payChannelAccountId+'_'+payChannelParaId+"_name").val();
    var value = $("#"+payChannelAccountId+'_'+payChannelParaId+"_value").val().trim();
    var dataJson = {'payChannelAccountParaId':payChannelAccountParaId,'name':name,'value':value};
    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelAccount/updatePara',
        data: dataJson,
        beforeSend: function() {
            if(payChannelAccountParaId == undefined || payChannelAccountParaId == ''){
                layer.msg('渠道账户参数ID获取失败！',{icon:0,time:1000});
                return false;
            }
            if(name == undefined || name == ''){
                layer.msg('参数名称获取失败！',{icon:0,time:1000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $("#child_table"+payChannelAccountId).bootstrapTable('refresh');
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