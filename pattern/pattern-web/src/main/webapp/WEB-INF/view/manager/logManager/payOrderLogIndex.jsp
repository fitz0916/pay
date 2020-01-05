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
	<title>PayOrderLog管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
	<style type="text/css">
		.marTb{
			margin-top: 4px;    
			margin-right: -17px;
    		margin-left: 17px;
		}
		.W120 .th-inner {
		    width:120px !important;
		}
	</style>
</head>
<body>
<div id="main">

	<div class="panel panel-default">
	    <form class="form-horizontal">
	        <div class="panel-body">
	            <div class="row pd-bottom-2">
	                <div class="col-md-1 marTb">
	        		　　订单ID：
	                </div>
	                <div class="col-md-2">
	                    <div class="form-group">
							<input type="text" id ="orderId"  class="form-control" style="width: 320px"/>
	                    </div>
	                </div>
	                <div class="col-md-1 marTb">
					　　三方订单ID：
	                </div>
	                <div class="col-md-2">
	                    <div class="form-group">
							<input type="text" id ="thirdOrderId" class="form-control"  style="width: 320px"/>
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
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');


//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
	return {
		limit: params.limit, // 每页显示数量
		offset: parseInt(params.offset),
		thirdOrderId: $('#thirdOrderId').val(),
		orderId: $('#orderId').val()
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
	$('#thirdOrderId').val('');
	$('#orderId').val('');
}

$(function() {
	
	
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/payOrderLog/list',
		height: getHeight(),
		striped: true,
		search: false,
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
		idField: 'orderId',
		maintainSelected: true,
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			{field:'orderId',title:'订单ID',align:'center',class:'W120'},
			{field:'thirdOrderId',title:'第三方订单ID',align:'center',class:'W120'},
			{field:'merRequestSource',title:'商户请求原数据',align:'center',class:'W120'},
			{field:'callbackResponseSource',title:'第三方回调原始数据',align:'center',class:'W120'}
		]
	});
});







</script>
</body>
</html>