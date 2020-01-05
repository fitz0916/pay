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
	<title>代付通道管理</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:payoutChannel:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增代付通道</a>
		</shiro:hasPermission>
		
		&nbsp;&nbsp;&nbsp;&nbsp;渠道账户：<select id ="payChannelAccountIdParam" class="selectpicker" style="width: 150px">
			<option value="0">全部</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a onclick="query()" class="btn btn-success ">查询</a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a onclick="refresh()" class="btn btn-warning">更新全部通道余额</a>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');
$(function() {
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/payoutChannel/list',
		height: getHeight(),	//行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
		cache: true,	//是否使用缓存，默认为true
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
		idField: 'payoutChannel',	//指定主键列
		maintainSelected: true,
		detailView: true, //是否开启子table
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			{field: 'payoutChannelId', align:'center', title: '代付通道ID'},
			{field: 'channelName',align:'center', title: '代付通道名称'},
            {field: 'account.simpleName',align:'center', title: '所属渠道账户'},
            {field: 'payoutTypeIds',align:'center', title: '代付类型'},
			{field: 'limitmoney',align:'center', title: '单笔额度'},
			{field: 'moneyD',align:'center', title: '通道余额'},
            {field: 'isLock',align:'center', title: '使用状态', formatter: function (value, row, index) { return (value==1)?'<label style="color: red">禁用</label>':'启用'; }},
			{field: 'updatetime',align:'center', title: '更新时间'},
			{field: 'action', title: '操作', align: 'center', width: 380, formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		],
		//子table触发事件
	    onExpandRow:function(index,row,$element){
			var paraTable = $element.html('<table id="child_table'+row.payoutChannelId+'"></table>').find('table');
	        $(paraTable).bootstrapTable({
	            url: '${basePath}/payoutChannel/listFee/'+row.payoutChannelId,	//获取表格数据的url
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
	            idField: 'id',	//指定主键列
	            maintainSelected: true,
	            columns: [
	                {field: 'id', visible:false},
	                {field: 'payoutChannelId', visible:false},
	                {field: 'initialAmount', title: '起始金额(元)', align: 'center'},
	                {field: 'terminatedAmount', title: '终止金额(元)', align: 'center'},
	                {field: 'feeStr', title: '手续费(元)', align: 'center'},
	                {field: 'rate', title: '费率', align: 'center'},
	                {field: 'action', title: '操作', align: 'center', width: 200, formatter: 'actionParaFormatter', events: 'actionEvents'}
	            ]
	        });
		}
	});
	

	$.ajax({
	    type:"GET",
	    url:'${basePath}/payChannelAccount/all',
	    success:function(result){
	        for(var i=0;i<result.length;i++){
	            var option = $("<option value="+ result[i].payChannelAccountId +">" + result[i].simpleName +"</option>");
	            $("#payChannelAccountIdParam").append(option);
	        }
	    }
	});
});


/**
 * 查询
 */
function query(){
    $table.bootstrapTable('refresh');
}

/**
 * 更新余额
 */
function refresh(id){
	var url ="";
	if(id!=null){
		url = '${basePath}/payoutChannel/refresh?payoutChannelId='+id;
	}else{
		url = '${basePath}/payoutChannel/refresh';
	}
	
	$.ajax({
	    type:"GET",
	    url:url,
	    success:function(result){
	    	if (result.success) {
                layer.msg(result.model,{icon:1,time:1000},function () {
                    $table.bootstrapTable('refresh');
                });
			} else {
				if(result.errorCode!=-1){
	                layer.msg(result.errorCode,{icon:0,time:2000});
				}else{
	                layer.alert(result.errorMsg,{icon:2});
				}
			}
	    }
	});
}


//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        payChannelAccountId: $('#payChannelAccountIdParam').val()==0 ? null : $('#payChannelAccountIdParam').val()
    }
}


// 格式化操作按钮
function actionFormatter(value, row, index) {
    return [
		'<shiro:hasPermission name="pattern:payoutChannel:fee:create"><button type="button" class="btn btn-success  btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createFee('+row.payoutChannelId+')">添加手续费</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:payoutChannel:fee:create"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="showFee('+index+')">查看手续费</button></shiro:hasPermission>',
		'<shiro:hasPermission name="pattern:payoutChannel:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.payoutChannelId+')">修改</button></shiro:hasPermission>',
		'<shiro:hasPermission name="pattern:payoutChannel:update"><button type="button" class="btn btn-warning btn-sm" style="margin-right:10px;padding:0 10px;" onclick="refresh('+row.payoutChannelId+')">更新余额</button></shiro:hasPermission>'
    ].join('');
}

//参数列表操作按钮
function actionParaFormatter(value, row, index) {
    return [
		'<shiro:hasPermission name="pattern:payoutChannel:fee:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateFeeRow('+row.payoutChannelFeeId+')">修改</button></shiro:hasPermission>',
		'<shiro:hasPermission name="pattern:payoutChannel:fee:delete"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" onclick="deleteFeeRow('+row.payoutChannelFeeId+','+row.payoutChannelId+')">删除</button></shiro:hasPermission>'
    ].join('');
}


//查看手续费
function showFee(index) {
    //加载子table
	$('tr[data-index="'+index+'"]').find('.detail-icon').click();
}


//设置费率
var createFeeDialog;
function createFee(id){
	createFeeDialog = $.dialog({
        animationSpeed: 300,
        title: '设置手续费',
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
        content: 'url:${basePath}/payoutChannel/createFee/' + id,
        onContentReady: function () {
			initMaterialInput();
        }
    });
}


//修改费率
var updateFeeDialog;
function updateFeeRow(id){
	updateFeeDialog = $.dialog({
        animationSpeed: 300,
        title: '修改手续费',
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
        content: 'url:${basePath}/payoutChannel/updateFee/' + id,
        onContentReady: function () {
			initMaterialInput();
        }
    });
}

//删除费率
function deleteFeeRow(id,payoutChannelId){
	deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    var ids = new Array();
                    if(id){
                        ids.push(id);
                    }
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/payoutChannel/deleteFee/' + ids.join("-"),
                        success: function(result) {
                        	if (!jQuery.isEmptyObject(result.errorList)) {
                        		if (result.errorList instanceof Array) {
                                    $.each(result.errorList, function(index, value) {
                                    	layer.alert(value,{icon:2})
                                    });
                                } else {
                                    layer.alert(result.errorMsg,{icon:2})
                				}
                            } else {
                                deleteDialog.close();
                                $('#child_table'+payoutChannelId).bootstrapTable('refresh');
                            }
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            $.confirm({
                                theme: 'dark',
                                animation: 'rotateX',
                                closeAnimation: 'rotateX',
                                title: false,
                                content: textStatus,
                                buttons: {
                                    confirm: {
                                        text: '确认',
                                        btnClass: 'waves-effect waves-button waves-light'
                                    }
                                }
                            });
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


//新增
var createDialog;
function createAction() {
	createDialog = $.dialog({
		animationSpeed: 300,
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
		title: '新增代付通道',
		content: 'url:${basePath}/payoutChannel/create',
		onContentReady: function () {
			initMaterialInput();
		}
	});
}


// 编辑
var updateDialog;
function updateAction() {
	var rows = $table.bootstrapTable('getSelections');
	if (rows.length != 1) {
		$.confirm({
			title: false,
			content: '请选择一条记录！',
			autoClose: 'cancel|3000',
			backgroundDismiss: true,
			buttons: {
				cancel: {
					text: '取消',
					btnClass: 'waves-effect waves-button'
				}
			}
		});
	} else {
		updateRow(rows[0].payoutChannelId);
	}
}
//编辑行
function updateRow(id){
    updateDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑代付通道',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
        content: 'url:${basePath}/payoutChannel/update/' + id,
        onContentReady: function () {
			initMaterialInput();
        }
    });
}


// 删除
var deleteDialog;
function deleteAction() {
	var rows = $table.bootstrapTable('getSelections');
	if (rows.length == 0) {
		$.confirm({
			title: false,
			content: '请至少选择一条记录！',
			autoClose: 'cancel|3000',
			backgroundDismiss: true,
			buttons: {
				cancel: {
					text: '取消',
					btnClass: 'waves-effect waves-button'
				}
			}
		});
	} else {
		deleteRow(null,rows);
	}
}

//删除行
function deleteRow(id,rows) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该代付通道吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    var ids = new Array();
                    if(id){
                        ids.push(id);
                    }
                    if(rows){
                    	for (var i in rows) {
							ids.push(rows[i].payoutChannelId);
						}
                    }
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/payoutChannel/delete/' + ids.join("-"),
                        success: function(result) {
                        	if (!jQuery.isEmptyObject(result.errorList)) {
                        		if (result.errorList instanceof Array) {
                                    $.each(result.errorList, function(index, value) {
                                    	layer.alert(value,{icon:2})
                                    });
                                } else {
                                    layer.alert(result.errorMsg,{icon:2})
                				}
                            } else {
                                deleteDialog.close();
                                $table.bootstrapTable('refresh');
                            }
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            $.confirm({
                                theme: 'dark',
                                animation: 'rotateX',
                                closeAnimation: 'rotateX',
                                title: false,
                                content: textStatus,
                                buttons: {
                                    confirm: {
                                        text: '确认',
                                        btnClass: 'waves-effect waves-button waves-light'
                                    }
                                }
                            });
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