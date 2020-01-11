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
	<title>代理商管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="agentMain">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:agent:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i class="zmdi zmdi-plus"></i> 编辑</a>
			<!-- 
			<a class="waves-effect waves-button" href="javascript:;" onclick="deleteAction()"><i class="zmdi zmdi-plus"></i> 删除</a>
			 -->
		</shiro:hasPermission>
	</div>
	<table id="agentTable"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
var $agentTable = $('#agentTable');


$(function() {
	initMyTable();
});


function initMyTable(){
	// bootstrap table初始化
	$agentTable.bootstrapTable({
		url: '${basePath}/manage/agent/list',
		height: getHeight(),
		method:'post',
		dataType:'json',
		striped: true,
		search: false,
		showRefresh: true,
		showColumns: true,
		minimumCountColumns: 2,
		clickToSelect: false,
		detailFormatter: 'detailFormatter',
		pagination: true,
		paginationLoop: false,
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: true,
		idField: 'agentId',
		maintainSelected: true,
		toolbar: '#toolbar',
		queryParams:queryParams,
		detailView: true,
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
			{field: 'ck', checkbox: true},
			{field:'agentId',title:'代理商ID',align:'center'},
			{field:'agentName',title:'代理商名称',align:'center'},
			{field:'agentNo',title:'代理商编号',align:'center'},
			{field:'businessLicense',title:'营业执照号',align:'center'},
			{field:'registryDate',title:'注册时间',align:'center',formatter: 'changeDateFormat'},
            {field: 'status', title: '状态', align: 'center',formatter: 'statusFormatter'},
            {field:'phone',title:'联系人手机',align:'center'},
            {field:'qq',title:'QQ',align:'center'},
            {field:'email',title:'Email',align:'center'},
            {field:'wechat',title:'微信',align:'center'},
			{field:'type',title:'公司性质',align:'center', formatter: function (value, row, index) { return value == 1 ? '个体' : '公司/企业';}},
            {field: 'action', title: '操作', align: 'center',formatter: 'actionFormatter'}
		],
		//子table触发事件
	    onExpandRow:function(index,row,$element){
			var paraTable = $element.html('<table id="child_table'+row.agentId+'"></table>').find('table');
	        $(paraTable).bootstrapTable({
	            url: '${basePath}/manage/shop/list?agentId='+row.agentId,	//获取表格数据的url
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
	            idField: 'shopId',	//指定主键列
	            maintainSelected: true,
	            columns: [
	            	{field:'shopId',title:'门店ID',align:'center'},
	    			{field:'shopName',title:'门店名称',align:'center'},
	    			{field:'shopNo',title:'门店编号',align:'center'},
                    {field:'brand',title:'门店品牌',align:'center'},
                    {field:'phone',title:'手机号码',align:'center'},
	    			{field:'address',title:'地址',align:'center'},
	    			{field:'status',title:'状态',align:'center', formatter:'statusFormatter'},
                    {field:'createTime',title:'创建时间',align:'center', formatter: 'changeDateFormat'},
	                {field: 'action', title: '操作', align: 'center',formatter: function(value, row, index){
                		 return [
                			 '<shiro:hasPermission name="pattern:shop:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateShopRow(' + row.shopId + ')">编辑门店</button></shiro:hasPermission>',
               				 '<shiro:hasPermission name="pattern:customer:create"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createCustomerRow(' + row.shopId +')">新增商户</button></shiro:hasPermission>',
							 '<shiro:hasPermission name="pattern:customer:red"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="viewCustomerRow(' + row.shopId + ')">查看商户</button></shiro:hasPermission>'
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
	        });
		}
	});
}

// 格式化操作按钮
function actionFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:shop:create"><a class="add" href="javascript:;" onclick="createShopRow('+row.agentId+')" data-toggle="tooltip" title="新增门店"><i class="zmdi zmdi-plus"></i>新增商户</a></shiro:hasPermission>　',
    ].join('');
}

//格式化状态
function statusFormatter(value, row, index) {
	if (value == 1) {
		return '<span class="label label-success">正常</span>';
	} else {
		return '<span class="label label-default">锁定</span>';
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

var updateDialog;
//编辑行
function updateRow(agentId){
    updateDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑代理商',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/agent/update/'+agentId,
        onContentReady:function(){
        	initMaterialInput();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        }
    });
}

var viewCustomerDialog;
function viewCustomerRow(shopId){
	viewCustomerDialog = $.dialog({
        animationSpeed: 300,
        title: '查看商户',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/customer/index/' + shopId,
        onContentReady:function(){
        	initMaterialInput();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        }
    });
}
  


var createShopDialog;
function createShopRow(agentId){
	createShopDialog = $.dialog({
        animationSpeed: 300,
        title: '新增门店',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/shop/create/'+agentId,
        onContentReady:function(){
        	initMaterialInput();
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        }
    });
}

var updateShopDialog;
function updateShopRow(shopId){
	updateShopDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑门店',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/shop/update/'+shopId,
        onContentReady:function(){
        	initMaterialInput();
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
function deleteRow(userId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该用户吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    var ids = new Array();
                    ids.push(userId);
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/manage/agent/delete/' + ids.join("-"),
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
                                $agentTable.bootstrapTable('refresh');
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
//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset)
    }
}



//新增_对话框
var createDialog;
function createAction() {
    createDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        containerFluid: true,
        title: '新增代理',
        content: 'url:${basePath}/manage/agent/create',
        onContentReady: function () {
           
        },
        contentLoaded: function(data, status, xhr){
            if(data.code == '10110'){
            	layer.msg(data.msg);
                location:top.location.href = '${basePath}/login';
            }
        }
    });
}


//编辑
var updateDialog;
function updateAction() {
    var rows = $agentTable.bootstrapTable('getSelections');
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
            title: '编辑代理商',
            columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
            content: 'url:${basePath}/manage/agent/update/'+rows[0].agentId,
            onContentReady:function(){
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




//删除
var deleteDialog;
function deleteAction() {
	var rows = $agentTable.bootstrapTable('getSelections');
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
			content: '确认删除该系统吗？',
			buttons: {
				confirm: {
					text: '确认',
					btnClass: 'waves-effect waves-button',
					action: function () {
						var ids = new Array();
						for (var i in rows) {
							ids.push(rows[i].systemId);
						}
						$.ajax({
							type: 'get',
							url: '${basePath}/manage/agent/delete/' + ids.join("-"),
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
											content: result.data,
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
									$agentTable.bootstrapTable('refresh');
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

//删除行
function deleteRow(agentId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该系统吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    var ids = new Array();
                        ids.push(systemId);
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/manage/agent/delete/' + agentId,
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
                                        content: result.data,
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
                                $agentTable.bootstrapTable('refresh');
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