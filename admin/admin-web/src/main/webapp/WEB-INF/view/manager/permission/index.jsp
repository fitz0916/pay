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
	<title>权限管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
		<div class="panel panel-default">
    <form class="form-horizontal">
        <div class="panel-body">
            <div class="row pd-bottom-2">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="col-md-4 control-label text-right">权限名称：</label>
                        <div class="col-md-8">
                            <input class="form-control"  id="permissionName">
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="col-md-4 control-label">所属系统：</label>
                        <div class="col-md-8">
                            <select id ="systemId" class="selectpicker" style="width: 150px">
								<option value="0">请选择</option>
							</select>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="col-md-4 control-label">所属上级：</label>
                        <div class="col-md-8 padTop-7">
                            <select id ="parentId" class="selectpicker" style="width: 150px">
								<option value="-1">请选择</option>
							</select>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 
                <div class="col-md-12 text-right ">
                    <div params="vm.searchParams" class="ng-isolate-scope">
						<button type="button" class="btn btn-success" onclick="query()"><span class="glyphicon glyphicon-search"></span>搜索</button>
						<a onclick="reset()" class="btn btn-danger pull-right">重置</a>
					</div>
                </div>
                 -->
            </div>
        </form>
     </div>


	<div id="toolbar">
		<shiro:hasPermission name="admin:permission:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增权限</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="admin:permission:update">
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i class="zmdi zmdi-edit"></i> 编辑权限</a>
			</shiro:hasPermission>
		<shiro:hasPermission name="admin:permission:delete">
			<a class="waves-effect waves-button" href="javascript:;" onclick="deleteAction()"><i class="zmdi zmdi-close"></i> 删除权限</a>
		</shiro:hasPermission>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');
$(function() {
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/manage/permission/list',
		height: getHeight(),
		method:'post',
		dataType:'json',
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
		pageSize:'10',
		offSet:'1',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: true,
		idField: 'permissionId',
		maintainSelected: true,
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			{field: 'ck', checkbox: true},
			{field: 'permissionId', title: '编号', sortable: true, align: 'center'},
            {field: 'name', title: '权限名称', align: 'center'},
            {field: 'parentName', title: '所属上级', align: 'center'},
            {field: 'systemTitle', title: '所属系统', align: 'center'},
			{field: 'type', title: '类型', formatter: 'typeFormatter', align: 'center'},
			{field: 'permissionValue', title: '权限值', align: 'center'},
			{field: 'uri', title: '路径', align: 'center'},
			{field: 'icon', title: '图标', align: 'center', formatter: 'iconFormatter'},
			{field: 'status', title: '状态', sortable: true, align: 'center', formatter: 'statusFormatter'},
			{field: 'action', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		]
	});
    $table.bootstrapTable('hideColumn', 'systemId');
});

// 格式化操作按钮
function actionFormatter(value, row, index) {
    return [
		'<shiro:hasPermission name="admin:permission:update"><a class="update" href="javascript:;" onclick="updateRow('+row.permissionId+')" data-toggle="tooltip" title="Edit"><i class="glyphicon glyphicon-edit"></i></a></shiro:hasPermission>　',
		'<shiro:hasPermission name="admin:permission:delete"><a class="delete" href="javascript:;" onclick="deleteRow('+row.permissionId+')" data-toggle="tooltip" title="Remove"><i class="glyphicon glyphicon-remove"></i></a></shiro:hasPermission>'
    ].join('');
}

$.ajax({
    type:"GET",
    url:'${basePath}/manage/system/all',
    success:function(result){
    	var data = result.data;
        for(var i=0;i<data.length;i++){
            var option = $("<option value="+ data[i].systemId +">" + data[i].title +"</option>");
            $("#systemId").append(option);
        }
    }
});

$('#systemId').change(function(){
	var systemId = $(this).val();
	permission(systemId);
	
});

function permission(systemId){
	$.ajax({
	    type:"GET",
	    url:'${basePath}/manage/permission/list/' + systemId,
	    success:function(result){
	    	var data = result.data;
	    	if(systemId == 0 || data.length == 0){
	    		var option = $("<option value='-1'>请选择</option>");
	    		$("#parentId").html('');
	    		$("#parentId").append(option);
	    	}else{
	    		for(var i = 0;i < data.length;i++){
		            var option = $("<option value="+ data[i].permissionId +">" + '菜单-' + data[i].name + "</option>");
		            if(data[i].type == 1){
		                option = $("<option value="+ data[i].permissionId +">" + "目录-" + data[i].name + "</option>")
		            }
		            $("#parentId").append(option);
		        }
	    	}
	    }
	});
}


//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
	var permissionName = $.trim($('#permissionName').val());
	var name = null;
	if(permissionName != ''){
		name = permissionName;
	}
	var systemId = $('#systemId').val() == 0 ? null : $('#systemId').val();
	var parentId = $('#parentId').val() ==  -1 ? null : $('#parentId').val();
    return {
        name:name,
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        systemId:systemId,
        parentId:parentId
    }
}

//编辑行
function updateRow(permissionId) {
    updateDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑权限',
        content: 'url:${basePath}/manage/permission/update/' + permissionId,
        onContentReady: function () {
            initMaterialInput();
            $('select').select2();
            initType();
            initSelect2();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        }
    });
}
//删除行
function deleteRow(permissionId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该权限吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    var ids = new Array();
                        ids.push(permissionId);
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/manage/permission/delete/' + ids.join("-"),
                        success: function(result) {
                            if (result.code != 1) {
                                if (result.data instanceof Array) {
                                    $.each(result.data, function(index, value) {
                                        $.confirm({
                                            theme: 'dark',
                                            animation: 'rotateX',
                                            closeAnimation: 'rotateX',
                                            title: false,
                                            content: value.errorMsg,
                                            buttons: {
                                                confirm: {
                                                    text: '确认',
                                                    btnClass: 'waves-effect waves-button waves-light'
                                                }
                                            }
                                        });
                                    });
                                } else if(result.code == '10110'){
                                	layer.msg(result.msg);
                                    location:top.location.href = '${basePath}/login';
                                }else {
                                    $.confirm({
                                        theme: 'dark',
                                        animation: 'rotateX',
                                        closeAnimation: 'rotateX',
                                        title: false,
                                        content: result.msg,
                                        buttons: {
                                            confirm: {
                                                text: '确认',
                                                btnClass: 'waves-effect waves-button waves-light',
                                                location:top.location.href = location.href
                                            }
                                        }
                                    });
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

// 格式化图标
function iconFormatter(value, row, index) {
    return '<i class="' + value + '"></i>';
}
// 格式化类型
function typeFormatter(value, row, index) {
	if (value == 1) {
		return '目录';
	}
	if (value == 2) {
		return '菜单';
	}
	if (value == 3) {
		return '按钮';
	}
	return '-';
}
// 格式化状态
function statusFormatter(value, row, index) {
	if (value == 1) {
		return '<span class="label label-success">正常</span>';
	} else {
		return '<span class="label label-default">锁定</span>';
	}
}
// 新增
var createDialog;
function createAction() {
	createDialog = $.dialog({
		animationSpeed: 300,
		title: '新增权限',
		content: 'url:${basePath}/manage/permission/create',
		onContentReady: function (data, status, xhr) {
			initMaterialInput();
			$('select').select2();
		},
		contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
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
		updateDialog = $.dialog({
			animationSpeed: 300,
			title: '编辑权限',
			content: 'url:${basePath}/manage/permission/update/' + rows[0].permissionId,
			onContentReady: function (data, status, xhr) {
				initMaterialInput();
				$('select').select2();
				initType();
				initSelect2();
			},
			contentLoaded: function(data, status, xhr){
	            if(data.code == '10110'){
	            	layer.msg(data.msg);
	                location:top.location.href = '${basePath}/login';
	            }
	        }
		});
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
		deleteDialog = $.confirm({
			type: 'red',
			animationSpeed: 300,
			title: false,
			content: '确认删除该权限吗？',
			buttons: {
				confirm: {
					text: '确认',
					btnClass: 'waves-effect waves-button',
					action: function () {
						var ids = new Array();
						for (var i in rows) {
							ids.push(rows[i].permissionId);
						}
						$.ajax({
							type: 'get',
							url: '${basePath}/manage/permission/delete/' + ids.join("-"),
							success: function(result) {
								if (result.code != 1) {
									if (result.data instanceof Array) {
										$.each(result.data, function(index, value) {
											$.confirm({
												theme: 'dark',
												animation: 'rotateX',
												closeAnimation: 'rotateX',
												title: false,
												content: value.errorMsg,
												buttons: {
													confirm: {
														text: '确认',
														btnClass: 'waves-effect waves-button waves-light'
													}
												}
											});
										});
									} else if(result.code == '10110'){
	                                	layer.msg(result.msg);
	                                    location:top.location.href = '${basePath}/login';
	                                } else {
										$.confirm({
											theme: 'dark',
											animation: 'rotateX',
											closeAnimation: 'rotateX',
											title: false,
											content: result.msg,
											buttons: {
												confirm: {
													text: '确认',
													btnClass: 'waves-effect waves-button waves-light',
                                                    location:top.location.href = location.href
												}
											}
										});
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
}
</script>
</body>
</html>