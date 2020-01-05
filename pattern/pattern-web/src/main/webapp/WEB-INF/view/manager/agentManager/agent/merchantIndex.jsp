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
	<title>商户管理</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
	<style type="text/css">
		.agent-main-class{
			width: 80%;
			margin-top: 5%;
		}
		.frozen-diglog-left{
			margin-left: 30%;
		}
		.pan_labTitle{
			float:left;
		}
		.pan_inp{
			margin-left: 0 !important;
		}
		.fl{
			float:left;
		}
		.clearFix{
			zoom:1;
		}
		.clearFix:after{
			width:0;
			height:0;
			content:'';
			visibility:hidden;
			clear:both;
			display:block;
		}
	</style>
</head>
<body>
<div id="main">
	<div class="panel panel-default">
	    <form class="form-horizontal">
	        <div class="panel-body">
	            <div class="row pd-bottom-2">
	                <div class="col-md-4 clearFix">
                    	<h5 class="pan_labTitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商户名称:</h5>
                    	<div class="form-group fl pan_inp">
							<input type="text" id ="companyNameLike" class="form-control" maxlength="50"/>
                    	</div>
	                </div>
	                <div class="col-md-4 clearFix">
	                    <h5 class="pan_labTitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联系人姓名:</h5>
                    	<div class="form-group fl pan_inp">
							<input type="text" id ="queryName" class="form-control" maxlength="20"/>
	                    </div>
	                </div>
	                <div class="col-md-4 clearFix">
	                    <h5 class="pan_labTitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联系人手机:</h5>
                    	<div class="form-group fl pan_inp">
							<input type="text" id ="queryPhone" class="form-control" maxlength="11" onpaste="return false" onkeyup="value=value.replace(/[^\d]/g,'')"/>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-12 text-right ">
					<a onclick="query()" class="btn btn-success" style="margin-right:10px;"><span class="glyphicon glyphicon-search"></span>搜索</a>
					<a onclick="reset()" class="btn btn-danger pull-right" style="margin-right:10px;" >重置</a>
	            </div>
	        </div>
		</form>
	</div>

	<div id="toolbar">
		<shiro:hasPermission name="pattern:agent:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增商户</a>
		</shiro:hasPermission>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');

//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
    	role: 1,
    	name:$('#queryName').val(),
    	phone:$('#queryPhone').val(),
    	companyNameLike:$('#companyNameLike').val()
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
	$('#queryName').val('');
	$('#companyNameLike').val('');
	$('#queryPhone').val('');
}


//显示商户
var isopen = true;
function showBusiness(index){
	if(isopen){
		$table.bootstrapTable('expandRow', index);
	}else{
		$table.bootstrapTable('collapseRow', index);
	}
	isopen=(!isopen);
}



$(function() {
	initMyTable();
});

function initMyTable(){
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/agent/list',
		height: getHeight(),
		striped: true,
		search: false,
		showRefresh: true,
		showColumns: true,
		minimumCountColumns: 2,
		clickToSelect: true,
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
		columns: [
	            	{field:'agentId',title:'商户ID',align:'center'},
	    			{field:'companyName',title:'商户名称',align:'center'},
                    {field:'name',title:'联系人姓名',align:'center'},
                    {field:'phone',title:'联系人手机',align:'center'},
	    			{field:'custType',title:'银行账户类型',align:'center', visible:false, formatter: function (value, row, index) { return value==1?'对公':'个人';}},
	    			{field:'amount',title:'可用余额(元)',align:'center', formatter: function (value, row, index) {
	    				if(value!=null&&value!=''){
	    					return value/100;
	    				}else{
                            return value;
                        }
	    			}},
                    {field:'fortheAmount',title:'待结算总额(元)',align:'center', formatter: function (value, row, index) {
                            if(value!=null&&value!=''){
                                return value/100;
                            }else{
                               return value;
							}
                        }},
                    {field:'frozenAmount',title:'冻结总额(元)',align:'center', formatter: function (value, row, index) {
                            if(value!=null&&value!=''){
                                return value/100;
                            }else{
                                return value;
                            }
                     }},
	    			{field:'trade',title:'行业',align:'center',visible:false,},
	    			{field:'pushTimes',title:'推送消息次数',align:'center',visible:false,},
	    			{field:'isHolidayCash',title:'节假日出款',align:'center', formatter: function (value, row, index) {return value==0?"不可":"可以";}},
            		{field:'payoutWay',title:'代付方式',align:'center', formatter: function (value, row, index){
                    	if(value == 0){
                        	return '自动代付';
                    	}else if(value == 1){
                        	return '人工代付';
                    	}
                	}},
					{field:'payIpEnabled',title:'支付白名单',align:'center', formatter: function (value, row, index) {
                            if(value==0){
                                return '<button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" disabled>禁用</button>';
                            }else if(value==1){
                                return '<shiro:hasPermission name="pattern:payWhiteList:read"><button type="button" class="btn btn-warning btn-sm" style="padding:0 10px;" onclick="showPayWhiteList('+row.agentId+')">启用</button></shiro:hasPermission>';
                            }
                        }},
	    			{field:'payoutIpEnabled',title:'代付白名单',align:'center', formatter: function (value, row, index) {
	    				if(value==0){
	    					return '<button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" disabled>禁用</button>';
	    				}else if(value==1){
	            			return '<shiro:hasPermission name="pattern:payoutWhiteList:read"><button type="button" class="btn btn-warning btn-sm" style="padding:0 10px;" onclick="showPayoutWhiteList('+row.agentId+')">启用</button></shiro:hasPermission>'; 
	    				}
	    			}},
                    {field:'payStatus',title:'支付状态',align:'center', formatter: 'payStatusFormatter'},
                    {field:'payoutStatus',title:'代付状态',align:'center', formatter: 'payoutStatusFormatter'},
	                {field: 'action', title: '操作', align: 'center', width: 210, formatter: function(value, row, index){
                		 return [
               				'<shiro:hasPermission name="pattern:agent:update"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.agentId+')">编辑详情</button></shiro:hasPermission>',
							'<shiro:hasPermission name="pattern:rechargeRecord:create"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="showRechargeRow('+row.agentId+')">充值</button></shiro:hasPermission>',
							 '<shiro:hasPermission name="pattern:frozenRecord:create"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="showFrozenRow('+row.agentId+')">冻结</button></shiro:hasPermission>'
             			].join('');
	                }, events: 'actionEvent'}
	     ]
    });
}

function payStatusFormatter(value,row){
    if(value == 0){
        return '<shiro:hasPermission name="pattern:agent:update"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" title="禁用支付" onclick="payStatusRow('+row.agentId+','+row.payStatus+','+row.parentId+')">禁用</button></shiro:hasPermission>';
	}else if(value == 1){
        return '<shiro:hasPermission name="pattern:agent:update"><button type="button" class="btn btn-warning btn-sm" style="padding:0 10px;" title="启用支付" onclick="payStatusRow('+row.agentId+','+row.payStatus+','+row.parentId+')">启用</button></shiro:hasPermission>';
	}
}

function payoutStatusFormatter(value,row){
    if(value == 0){
        return '<shiro:hasPermission name="pattern:agent:update"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" title="禁用代付" onclick="payoutStatusRow('+row.agentId+','+row.payoutStatus+','+row.parentId+')">禁用</button></shiro:hasPermission>';
    }else if(value == 1){
        return '<shiro:hasPermission name="pattern:agent:update"><button type="button" class="btn btn-warning btn-sm" style="padding:0 10px;" title="启用代付" onclick="payoutStatusRow('+row.agentId+','+row.payoutStatus+','+row.parentId+')">启用</button></shiro:hasPermission>';
    }
}

//新增_对话框
var createDialog;
function createAction() {
    createDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-18',
        containerFluid: true,
        title: '新增商户',
        content: 'url:${basePath}/agent/create/1',
        onContentReady: function () {
            initMaterialInput();
            init();
        }
    });
}


//编辑_对话框
var updateDialog;
function updateRow(id){
  updateDialog = $.dialog({
      animationSpeed: 300,
      columnClass: 'col-md-16',
      containerFluid: true,
      title: '编辑商户',
      content: 'url:${basePath}/agent/update/' + id,
      onContentReady: function () {
          initMaterialInput();
          init();
      }
  });
}


//支付白名单_对话框
var payWhiteListDialog;
function showPayWhiteList(id){
	payWhiteListDialog = $.dialog({
        animationSpeed: 300,
        title: '商户支付白名单',
        columnClass: 'agent-main-class',
        content: 'url:${basePath}/payWhiteList/index/' + id,
        onContentReady: function () {
			initMaterialInput();
            init();
        }
    });
}

//弹窗代付白名单
var payoutWhiteListDialog;
function showPayoutWhiteList(id){
	payoutWhiteListDialog = $.dialog({
		animationSpeed: 300,
		title: '商户代付白名单',
		columnClass: 'agent-main-class',
		content: 'url:${basePath}/payoutWhiteList/index/' + id,
		onContentReady: function () {
			initMaterialInput();
            init();
		}
	});
}


//删除_对话框
var deleteDialog;
function deleteRow(id,rows) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该商户吗？',
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
							ids.push(rows[i].agentId);
						}
                    }
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/agent/delete/' + ids.join("-"),
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
                        	layer.alert(textStatus,{icon:2})
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


//商户冻结功能
var frozenDialog;
function showFrozenRow(agentId) {
  frozenDialog = $.dialog({
      animationSpeed: 300,
      columnClass: 'col-md-5 frozen-diglog-left',
      title: '商户余额冻结',
      content: 'url:${basePath}/frozenRecord/create/'+agentId,
      onContentReady: function () {
          initMaterialInput();
      }
  });
}

//商户充值功能
var rechargeDialog;
function showRechargeRow(agentId) {
 rechargeDialog = $.dialog({
      animationSpeed: 300,
      columnClass: 'col-md-5 frozen-diglog-left',
      title: '商户余额充值',
      content: 'url:${basePath}/rechargeRecord/create/'+agentId,
      onContentReady: function () {
          initMaterialInput();
      }
  });
}

//修改支付状态
function payStatusRow(agentId,payStatus,parentId) {
    var msg = '确认禁用该商户支付吗？禁用后该商户将无法支付！';
    if(payStatus == 1){
        msg = '确认启用该商户支付吗？启用后该商户将可以支付！';
	}

    updateDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: msg,
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/agent/updatePayStatus/'+agentId+'/'+payStatus,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    updateDialog.close();
                                    $('#child_table'+parentId).bootstrapTable('refresh');
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
                            layer.alert(textStatus,{icon:2})
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


//修改代付状态
function payoutStatusRow(agentId,payoutStatus,parentId) {
    var msg = '确认禁用该商户代付吗？禁用后该商户将无法代付！';
    if(payoutStatus == 1){
        msg = '确认启用该商户代付吗？启用后该商户将可以代付！';
    }

    updateDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: msg,
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/agent/updatePayoutStatus/'+agentId+'/'+payoutStatus,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    updateDialog.close();
                                    $('#child_table'+parentId).bootstrapTable('refresh');
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
                            layer.alert(textStatus,{icon:2})
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