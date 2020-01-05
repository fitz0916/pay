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
	<title>代付银行管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:cashBankChannel:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增代付银行</a>
		</shiro:hasPermission>
		&nbsp;&nbsp;&nbsp;&nbsp;付款通道：<select id ="queryPayChannel" class="selectpicker" style="width: 150px">
			<option value="0">请选择</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;银行名称：<select id ="queryBank" class="selectpicker" style="width: 250px">
			<option value="0">请选择</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a onclick="query()" class="btn btn-success pull-right">查询</a>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');
$(function() {
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/cashBankChannel/list',
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
		idField: 'id',
		maintainSelected: true,
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			{field: 'id',align:'center', visible:false},
			{field: 'cyberBankId',align:'center', visible:false},
			{field: 'payChannelTemplateId',align:'center', visible:false},
			{field: 'channelName',align:'center', title: '代付通道名称'},
			{field: 'bankLogo',align:'center', title: '银行', formatter: function (value, row, index) { return '<img src='+ value +' style="width:126px;height:36px;"/>' }},
			{field: 'bankType',align:'center', title: '所属分类', formatter: function (value, row, index) { return (value=='1')?'借记卡':'信用卡'; }},
			{field: 'cyberBankCode',align:'center', title: '银行编号'},
			{field: 'isOk',align:'center', title: '使用状态', formatter: function (value, row, index) { return (value==1)?'启用':'禁用'; }},
            {field: 'notes',align:'center', title: '备注信息'},
			{field: 'action', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		]
	});
	
	
	$.ajax({
	    type:"GET",
	    url:'${basePath}/payoutChannel/all',
	    success:function(result){
	        for(var i=0;i<result.length;i++){
	            var option = $("<option value="+ result[i].payoutChannelId +">" + result[i].channelName +"</option>");
	            $("#queryPayChannel").append(option);
	        }
	    }
	});
	
	
	$.ajax({
	    type:"GET",
	    url:'${basePath}/cyberBank/all',
	    success:function(result){
	    	var bankType;
	        for(var i=0;i<result.length;i++){
	        	bankType = (result[i].bankType==1)?'借记卡':'信用卡';
	            var option = $("<option value="+ result[i].cyberBankId +">" + result[i].bankName+'-'+bankType +"</option>");
	            $("#queryBank").append(option);
	        }
	    }
	});
});


//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        payChannelId: $('#queryPayChannel').val()==0 ? null : $('#queryPayChannel').val(),
        cyberBankId: $('#queryBank').val()==0 ? null : $('#queryBank').val()
    }
}

/**
 * 查询
 */
function query(){
    $table.bootstrapTable('refresh');
}

/**
 * 重置
 */
function reset(){
    $("#queryBank").find("option[text='请选择']").attr("selected",true);
    console.log($("#queryBank"));
}



// 格式化操作按钮
function actionFormatter(value, row, index) {
    return [
		'<shiro:hasPermission name="pattern:cashBankChannel:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.id+')">修改</button></shiro:hasPermission>',
		'<shiro:hasPermission name="pattern:cashBankChannel:delete"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" onclick="deleteRow('+row.id+',null)">删除</button></shiro:hasPermission>'
    ].join('');
}
//编辑行
function updateRow(id){
    updateDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑银行编码',
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
        content: 'url:${basePath}/cashBankChannel/update/' + id,
        onContentReady: function () {
			initMaterialInput();
        }
    });
}

//新增
var createDialog;
function createAction() {
	createDialog = $.dialog({
		animationSpeed: 300,
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
		title: '新增银行编码',
		content: 'url:${basePath}/cashBankChannel/create',
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
        content: '确认删除该银行编码吗？',
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
							ids.push(rows[i].id);
						}
                    }
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/cashBankChannel/delete/' + ids.join("-"),
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
		updateRow(rows[0].id);
	}
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

</script>
</body>
</html>