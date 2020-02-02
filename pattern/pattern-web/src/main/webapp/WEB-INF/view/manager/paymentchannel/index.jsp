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
	<title>支付渠道</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:paymentchannel:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增渠道</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="pattern:paymentchannel:update">
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i class="zmdi zmdi-edit"></i> 编辑渠道</a>
		</shiro:hasPermission>
	</div>
	<input id="tableAccountParamId" type="hidden">
	<table id="table"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');
$(function() {
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/manage/paymentchannel/list',
		height: getHeight(),
		method:'post',
		dataType:'json',
		striped: true,
		search: true,
		showRefresh: true,
		showColumns: true,
		minimumCountColumns: 2,
		clickToSelect: true,
		detailView: true,
		detailFormatter: 'detailFormatter',
		pagination: true,
		paginationLoop: false,
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: true,
		idField: 'paymentChannelId',
		maintainSelected: true,
		toolbar: '#toolbar',
		responseHandler:function(result){
			if(result.code == '10110'){
            	layer.msg(result.msg);
                location:top.location.href = '${basePath}/login';
            }
			return{                            //return bootstrap-table能处理的数据格式
		        "total":result.total,
		        "rows":result.rows
		    }
		},
		columns: [
			{field: 'ck', checkbox: true, align: 'center'},
			{field: 'paymentChannelId', title: '编号', sortable: true, align: 'center'},
			{field: 'channelName', title: '渠道名称', align: 'center'},
			{field: 'templateName', title: '渠道模板名称', align: 'center'},
			{field: 'payType', title: '渠道类型', align: 'center',formatter:'paymentTypeFormatter'},
			{field: 'thirdChannelName', title: '三方渠道名称', align: 'center'},
            {field: 'status', title: '状态', align: 'center',formatter: 'statusFormatter'},
            {field: 'businessContacts', title: '联系人', align: 'center'},
            {field: 'wechat', title: '微信', align: 'center'},
            {field: 'mobile', title: '手机号码', align: 'center'},
			{field: 'action', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
		]
		,
		//子table触发事件
	    onExpandRow:onAccountExpandRow
	});
});

function paymentTypeFormatter(value, row, index){
	if(value == 0) {
		return '<span class="label label-primary">微信-扫码</span>';
	}else if(value == 1){
		return '<span class="label label-success">支付宝-扫码</span>';
	}else if(value == 2){
		return '<span class="label label-info">银联扫码支付</span>';
	}else if(value == 3){
		return '<span class="label label-warning">QQ扫码支付</span>';
	}else if(value == 4){
		return '<span class="label label-danger">京东钱包扫码支付</span>';
	}else if(value == 5){
		return '<span class="label label-warning">快捷支付</span>';
	}else{
		return '<span class="label label-default">其他</span>';
	}
}

function onAccountExpandRow(index,row,$element){
	var paraTable = $element.html('<table id="child_account_table'+row.paymentChannelId+'"></table>').find('table');
    $(paraTable).bootstrapTable({
        url: '${basePath}/manage/paymentchannelaccount/list?paymentChannelId='+row.paymentChannelId,	//获取表格数据的url
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
        smartDisplay:false,
        escape: true,
        detailView: true,
        idField: 'paymentChannelAccountId',	//指定主键列
        maintainSelected: true,
        columns: [
        	{field:'paymentChannelAccountId',title:'账号ID',align:'center'},
			{field:'accountName',title:'账号名称',align:'center'},
			{field:'status',title:'状态',align:'center', formatter:'statusFormatter'},
            {field:'createTime',title:'创建时间',align:'center', formatter: 'changeDateFormat'},
            {field:'remark',title:'备注',align:'center'},
            {field: 'action', title: '操作', align: 'center',formatter: function(value, row, index){
        		 return [	
        			 '<shiro:hasPermission name="pattern:paymentchannelaccount:create"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createAccountParaRow(' + row.paymentChannelAccountId +')">新增渠道账号参数</button></shiro:hasPermission>',
        			 '<shiro:hasPermission name="pattern:paymentchannelaccount:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateAccountRow(' + row.paymentChannelAccountId + ')">编辑渠道账号</button></shiro:hasPermission>'
     			].join('');
            }, events: 'actionEvent'}
        ],
        responseHandler:function(result){
			if(result.code == '10110'){
            	layer.msg(result.msg);
                location:top.location.href = '${basePath}/login';
            }
			return{                            //return bootstrap-table能处理的数据格式
		        "rows":result.data
		    }
		},
		//子table触发事件
	    onExpandRow:onAccountParaExpandRow
    });
}

function onAccountParaExpandRow(index,row,$element){
	var paraTable = $element.html('<table id="child_para_table'+row.paymentChannelAccountId+'"></table>').find('table');
    $(paraTable).bootstrapTable({
        url: '${basePath}/manage/paymentchannelaccountpara/list?paymentChannelAccountId='+row.paymentChannelAccountId,	//获取表格数据的url
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
        smartDisplay:false,
        escape: true,
        detailView: false,
        idField: 'paymentChannelAccountParaId',	//指定主键列
        maintainSelected: true,
        columns: [
        	{field:'paymentChannelAccountParaId',title:'参数ID',align:'center'},
			{field:'name',title:'参数名称',align:'center'},
			{field:'value',title:'参数值',align:'center'},
			{field:'status',title:'状态',align:'center', formatter:'statusFormatter'},
            {field:'createTime',title:'创建时间',align:'center', formatter: 'changeDateFormat'},
            {field:'remark',title:'备注',align:'center'},
            {field: 'action', title: '操作', align: 'center',formatter: function(value, row, index){
        		 return [	
        			 '<shiro:hasPermission name="pattern:paymentchannelaccountpara:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateAccountParaRow(' + row.paymentChannelAccountParaId + ')">编辑渠道账号参数</button></shiro:hasPermission>',
        			 '<shiro:hasPermission name="pattern:paymentchannelaccountpara:delete"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="deleteAccountParaRow(' + row.paymentChannelAccountParaId + ',' + row.paymentChannelAccountId + ')">删除渠道账号参数</button></shiro:hasPermission>'
     			].join('');
            }, events: 'actionEvent'}
        ],
        responseHandler:function(result){
			if(result.code == '10110'){
            	layer.msg(result.msg);
                location:top.location.href = '${basePath}/login';
            }
			return{                            //return bootstrap-table能处理的数据格式
		        "rows":result.data
		    }
		}
    });
}


// 格式化操作按钮
function actionFormatter(value, row, index) {
    return [
    	'<shiro:hasPermission name="pattern:paymentchannelaccount:create"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createAccountRow(' + row.paymentChannelId +')">新增渠道账号</button></shiro:hasPermission>',
    ].join('');
}

//格式化状态
function statusFormatter(value, row, index) {
	if (value == 1) {
		return '<span class="label label-success">正常</span>';
	} else {
		return '<span class="label label-danger">锁定</span>';
	}
}

function changeDateFormat(value) {
	  if(value == '' || value == undefined){
	      return value;
      }
	  var myDate = new Date(value);
	  //获取当前年
	  var year=myDate.getFullYear();
	  //获取当前月
	  var month = myDate.getMonth()+1;
	      month = month < 10 ? "0"+month : month;
	  //获取当前日
	  var date=myDate.getDate();
	      date = date < 10 ? "0"+date : date;
	  var h=myDate.getHours();       //获取当前小时数(0-23)
	      h = h < 10 ? "0"+h : h;
	  var m=myDate.getMinutes();     //获取当前分钟数(0-59)
	      m = m < 10 ? "0"+m : m;
	  var s= myDate.getSeconds();
	      s = s < 10 ? "0"+s : s;
	  var time = year+'-'+month+"-"+date;
	  return time;
}

//编辑渠道账号参数
var updateAccountParaRowDialog;
function updateAccountParaRow(paymentChannelAccountParaId){
	updateAccountParaRowDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑渠道账号参数',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/paymentchannelaccountpara/update/' + paymentChannelAccountParaId,
        onContentReady: function () {
            initMaterialInput();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        },
    });
}

//删除行
var deleteAccountParaDialog;
function deleteAccountParaRow(paymentChannelAccountParaId,paymentChannelAccountId) {
	$('#tableAccountParamId').val(paymentChannelAccountId);
	deleteAccountParaDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除账号渠道吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/manage/paymentchannelaccountpara/delete/' + paymentChannelAccountParaId,
                        success: function(result) {
                            if (result.code != 1) {
                                if (result.code == 0 && result.data instanceof Array) {
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
                                }else if(result.code == '10110'){
                                	layer.msg(result.msg);
                                    location:top.location.href = '${basePath}/login';
                                }else{
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
                            	var paymentChannelAccountId = $('#tableAccountParamId').val();
                				var $childAccountParaTable = $('#child_para_table' + paymentChannelAccountId);
                				$childAccountParaTable.bootstrapTable('refresh');
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


//新增渠道账号参数
var createAccountParaRowDialog;
function createAccountParaRow(paymentChannelAccountId){
	createAccountParaRowDialog = $.dialog({
        animationSpeed: 300,
        title: '创建渠道账号',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/paymentchannelaccountpara/create/' + paymentChannelAccountId,
        onContentReady: function () {
            initMaterialInput();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        },
    });
}

var createAccountRowDialog;
function createAccountRow(paymentChannelId){
	createAccountRowDialog = $.dialog({
        animationSpeed: 300,
        title: '创建渠道账号',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/paymentchannelaccount/create/' + paymentChannelId,
        onContentReady: function () {
            initMaterialInput();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        },
    });
}
var updateAccountDialog;
function updateAccountRow(paymentChannelAccountId){
	updateAccountDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑渠道账号',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/paymentchannelaccount/update/' + paymentChannelAccountId,
        onContentReady: function () {
            initMaterialInput();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        },
    });
}

//编辑行
function updateRow(paymentChannelId){
    updateDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑渠道',
        content: 'url:${basePath}/manage/paymentchannel/update/' + paymentChannelId,
        onContentReady: function () {
            initMaterialInput();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        },
    });
}
//删除行
function deleteRow(paymentChannelId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该角色吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    var ids = new Array();
                        ids.push(paymentChannelId);
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/manage/paymentchannel/delete/' + ids.join("-"),
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
                                }else if(result.code == '10110'){
                                	layer.msg(result.msg);
                                    location:top.location.href = '${basePath}/login';
                                }else {
                                    $.confirm({
                                        theme: 'dark',
                                        animation: 'rotateX',
                                        closeAnimation: 'rotateX',
                                        title: false,
                                        content: result.data.errorMsg,
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
// 新增
var createDialog;
function createAction() {
	createDialog = $.dialog({
		animationSpeed: 300,
		columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
		title: '新增渠道',
		content: 'url:${basePath}/manage/paymentchannel/create',
		onContentReady: function () {
			//initMaterialInput();
		},
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
	            layer.msg(msg);
	            location:top.location.href = '${basePath}/login';
            }
        },
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
			columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
			title: '编辑渠道',
			content: 'url:${basePath}/manage/paymentchannel/update/' + rows[0].paymentChannelId,
			onContentReady: function () {
				initMaterialInput();
			},
            contentLoaded: function(data, status, xhr){
                if(data.code == '10110'){
                	layer.msg(data.msg);
                    location:top.location.href = '${basePath}/login';
                }
            },
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
			content: '确认删除该角色吗？',
			buttons: {
				confirm: {
					text: '确认',
					btnClass: 'waves-effect waves-button',
					action: function () {
						var ids = new Array();
						for (var i in rows) {
							ids.push(rows[i].roleId);
						}
						$.ajax({
							type: 'get',
							url: '${basePath}/manage/role/delete/' + ids.join("-"),
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
									} else {
										$.confirm({
											theme: 'dark',
											animation: 'rotateX',
											closeAnimation: 'rotateX',
											title: false,
											content: result.data.errorMsg,
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
// 角色权限
var permissionDialog;
var roleId;
function permissionAction() {
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
		roleId = rows[0].roleId;
		permissionDialog = $.dialog({
			animationSpeed: 300,
			title: '角色权限',
			content: 'url:${basePath}/manage/role/permission/' + roleId,
			onContentReady: function () {
				initMaterialInput();
				initTree();
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

</script>
</body>
</html>