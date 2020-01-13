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
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增代理商</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i class="zmdi zmdi-plus"></i> 编辑代理商</a>
			<!-- 
			<a class="waves-effect waves-button" href="javascript:;" onclick="deleteAction()"><i class="zmdi zmdi-plus"></i> 删除</a>
			 -->
		</shiro:hasPermission>
	</div>
	<table id="agentTable"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script type="text/javascript">

var $agentTable = $('#agentTable');


$(function() {
	var shopId = '${shopId}';
	initMyTable();
});

function initMyTable(){
	$agentTable.bootstrapTable({
		url: '${basePath}/manage/agent/list',	//获取表格数据的url
		method:'post',
		height: 700,
		dataType:'json',
		height: 523,	//行高，如果没有设置height属性，表格自动根据记录条数决定表格高度
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
		idField: 'agentId',	//指定主键列
		maintainSelected: true,
		detailView: true, //是否开启子table
		queryParams:queryParams,
		rowStyle:rowStyle,//通过自定义函数设置行样式
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
	    onExpandRow:onExpandShopRow
		
	});
}

/* function rowStyle(row, index) {
    var classes = ['active', 'success', 'info', 'warning', 'danger'];
    if (index % 2 === 0 && index / 2 < classes.length) {
        return {
            classes: classes[index / 2]
        };
    }
    return {};
 } */
 
function rowStyle(row, index) {
    var classes = ['active', 'success', 'info', 'warning', 'danger'];
    return {
        classes: classes[1]
    };
 }

function rowShopStyle(row, index) {
    var classes = ['active', 'success', 'info', 'warning', 'danger'];
    return {
        classes: classes[4]
    };
 }
 
function rowCustomerStyle(row, index) {
    var classes = ['active', 'success', 'info', 'warning', 'danger'];
    return {
        classes: classes[3]
    };
 }

function onExpandCustomerRow(index,row,$element){
	var paraTable = $element.html('<table id="child_customer_table'+row.shopId+'"></table>').find('table');
    $(paraTable).bootstrapTable({
        url: '${basePath}/manage/customer/list',	//获取表格数据的url
        method:'post',
		dataType:'json',
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
        idField: 'customerId',	//指定主键列
        maintainSelected: true,
        rowStyle:rowCustomerStyle,//通过自定义函数设置行样式
        queryParams:function(){
        	 return {
        	        limit: 100000, // 每页显示数量
        	        offset: 0,
        	        shopId:row.shopId
        	    }
        },
        columns: [
			{field:'customerId',title:'商户ID',align:'center'},
			{field:'customerName',title:'商户名称',align:'center'},
			{field:'customerNo',title:'商户编号',align:'center'},
			{field:'amount',title:'金额',align:'center'},
			{field:'frozenAmount',title:'冻结金额',align:'center'},
			{field:'settlement',title:'待结算金额',align:'center'},
			{field:'createDate',title:'创建时间',align:'center',formatter: 'changeDateFormat'},
            {field: 'status', title: '状态', align: 'center',formatter: 'statusFormatter'},
            {field: 'payoutWay', title: '代付方式', align: 'center',formatter: 'payoutFormatter'},
            {field: 'action', title: '操作', align: 'center',formatter: function(value, row, index){
        		 return [
        			 '<shiro:hasPermission name="pattern:customer:update"><button type="button" class="btn btn-danger" style="margin-right:10px;padding:0 10px;" onclick="updateCustomerRow(' + row.customerId + ')">编辑商户</button></shiro:hasPermission>',
       				 '<shiro:hasPermission name="pattern:customer:red"><button type="button" class="btn btn-warning" style="margin-right:10px;padding:0 10px;" onclick="viewCustomerChannelRow(' + row.shopId + ')">查看商户渠道</button></shiro:hasPermission>'
     			].join('');
            }, events: 'actionEvent'}
        ],
        responseHandler:function(result){
			if(result.code == '10110'){
            	layer.msg(result.msg);
                location:top.location.href = '${basePath}/login';
            }
			return{                            //return bootstrap-table能处理的数据格式
		        "rows":result.rows
		    }
		}
    });
}

function onExpandShopRow(index,row,$element){
	var paraTable = $element.html('<table id="child_shop_table'+row.agentId+'"></table>').find('table');
    $(paraTable).bootstrapTable({
        url: '${basePath}/manage/shop/list',	//获取表格数据的url
        method:'post',
		dataType:'json',
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
        detailView: true, //是否开启子table
        idField: 'shopId',	//指定主键列
        maintainSelected: true,
        rowStyle:rowShopStyle,//通过自定义函数设置行样式
        queryParams:function(){
       	 return {
       	        limit: 100000, // 每页显示数量
       	        offset: 0,
       	     	agentId:row.agentId
       	    }
       },
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
        			 '<shiro:hasPermission name="pattern:customer:create"><button type="button" class="btn btn-success" style="margin-right:10px;padding:0 10px;" onclick="createCustomerRow(' + row.shopId +')">新增商户</button></shiro:hasPermission>',
        			 '<shiro:hasPermission name="pattern:shop:update"><button type="button" class="btn btn-info" style="margin-right:10px;padding:0 10px;" onclick="updateShopRow(' + row.shopId + ')">编辑门店</button></shiro:hasPermission>',
     			].join('');
            }, events: 'actionEvent'}
        ],
        responseHandler:function(result){
			if(result.code == '10110'){
            	layer.msg(result.msg);
                location:top.location.href = '${basePath}/login';
            }
			return{                            //return bootstrap-table能处理的数据格式
		        "rows":result.rows
		    }
		},
		onExpandRow:onExpandCustomerRow
		
    });
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


var createCustomerDialog;
function createCustomerRow(shopId){
	createCustomerDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑商户',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/customer/create/'+shopId,
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

var updateCustomerDialog;
function updateCustomerRow(customerId){
	updateCustomerDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑商户',
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        content: 'url:${basePath}/manage/customer/update/'+customerId,
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

// 格式化操作按钮
function actionFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:shop:create"><a class="add" href="javascript:;" onclick="createShopRow('+row.agentId+')" data-toggle="tooltip" title="新增门店"><i class="zmdi zmdi-plus"></i>新增门店</a></shiro:hasPermission>'
    ].join('');
}

//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        shopId:'${shopId}'
    }
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

//格式化状态
function statusFormatter(value, row, index) {
	if (value == 1) {
		return '<span class="label label-success">正常</span>';
	} else {
		return '<span class="label label-default">锁定</span>';
	}
}

function payoutFormatter(value, row, index){
	if (value == 1) {
		return '<span class="label label-default">自动代付</span>';
	} else {
		return '<span class="label label-success">人工代付</span>';
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
</script>
</body>
</html>