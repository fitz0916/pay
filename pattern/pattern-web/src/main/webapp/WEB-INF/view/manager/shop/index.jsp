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
	<style type="text/css">
		.agent-main-class{
			width: 80%;
			margin-top: 5%;
		}
		.frozen-diglog-left{
			margin-left: 30%;
		}
	</style>
</head>
<body>
<div id="main">
	<div id="toolbar">
		<shiro:hasPermission name="pattern:agent:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i class="zmdi zmdi-plus"></i> 编辑</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="deleteAction()"><i class="zmdi zmdi-plus"></i> 删除</a>
		</shiro:hasPermission>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script type="text/javascript">

var $table = $('#table');


$(function() {
	initMyTable();
});


function initMyTable(){
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/manage/shop/list/'+'${shopId}',
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
			{field:'shopId',title:'ID',align:'center'},
			{field:'shopName',title:'门店名称',align:'center'},
			{field:'shopNo',title:'门店编号',align:'center'},
			{field:'createDate',title:'创建时间',align:'center',formatter: 'changeDateFormat'},
            {field: 'status', title: '状态', align: 'center',formatter: 'statusFormatter'},
            {field:'phone',title:'手机号码',align:'center'},
            {field:'address',title:'地址',align:'center'},
            {field: 'action', title: '操作', align: 'center', width: 240, formatter: 'actionFormatter'}
		]
	});
}

//格式化操作按钮
function actionFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:shop:create"><a class="add" href="javascript:;" onclick="createShopRow('+row.agentId+')" data-toggle="tooltip" title="新增门店"><i class="zmdi zmdi-plus"></i>新增门店</a></shiro:hasPermission>　',
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
</script>