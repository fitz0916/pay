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
	<title>门店管理</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:shop:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增门店</a>
		</shiro:hasPermission>
		&nbsp;&nbsp;&nbsp;&nbsp;商户：<select id ="queryAgentId" class="selectpicker" style="width: 150px">
			<option value="0">全部</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a onclick="query()" class="btn btn-success pull-right">查询</a>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');
$(function() {
	$.ajax({
	    type:"GET",
	    url:'${basePath}/agent/all?role=1',
	    success:function(result){
	        for(var i=0;i<result.length;i++){
	            var option = $("<option value="+ result[i].agentId +">" + result[i].companyName +"</option>");
	            $("#queryAgentId").append(option);
	        }
	    }
	});
	
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/shop/list',
		height: getHeight(),
		striped: true,
		cache: false,
		search: false,
		showRefresh: true,
		showColumns: true,
		minimumCountColumns: 2,
		clickToSelect: false,
		pagination: true,
		paginationLoop: false,
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: true,
		idField: 'shopId',
		maintainSelected: true,
		toolbar: '#toolbar',
		queryParams:queryParams,
		columns: [
			{field:'shopId',title:'门店ID',align:'center'},
			{field:'topid', visible:false},
			{field:'agentId', visible:false},
			{field:'brand',title:'品牌',align:'center'},
			{field:'shopName',title:'门店名称',align:'center'},
			{field:'shopNo',title:'门店编号',align:'center'},
			{field:'agent.companyName',title:'所属商户名称',align:'center'},
            {field:'isLock',title:'使用状态',align:'center', formatter: 'isLockFormatter'},
            {field:'createTime',title:'创建时间',align:'center'},
			{field:'action',align:'center', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		]
	});
});


//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        agentId: $('#queryAgentId').val()==0 ? null : $('#queryAgentId').val()
    }
}

/**
 * 查询
 */
function query(){
    $table.bootstrapTable('refresh');
}

// 格式化操作按钮
function actionFormatter(value, row, index) {
    return [
		'<shiro:hasPermission name="pattern:shop:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.shopId+')">修改</button></shiro:hasPermission>'
    ].join('');
}

function isLockFormatter(value) {
    if(value == 0){
        return "启用";
    }else if(value == 1){
        return '<label style="color:red">禁用<label>';
    }
}

//编辑行
function updateRow(id){
    updateDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑门店',
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
        content: 'url:${basePath}/shop/update/' + id,
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
        content: '确认删除该门店吗？',
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
							ids.push(rows[i].shopId);
						}
                    }
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/shop/delete/' + ids.join("-"),
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
// 新增
var createDialog;
function createAction() {
	createDialog = $.dialog({
		animationSpeed: 300,
        columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
		title: '新增门店',
		content: 'url:${basePath}/shop/create',
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