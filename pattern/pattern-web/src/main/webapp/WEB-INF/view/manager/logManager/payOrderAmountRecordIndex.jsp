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
	<title>商户金额变动记录管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
	<style type="text/css">
		.marTb{
			margin-top: 4px;    
			margin-right: -17px;
    		margin-left: 17px;
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
					　　商户ID：
	                </div>
	                <div class="col-md-1">
	                    <div class="form-group">
							<input type="text" id ="agentId" class="form-control"  style="width: 160px"/>
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
		agentId: $('#agentId').val(),
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
	$('#agentId').val('');
	$('#orderId').val('');
}

$(function() {

	
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/payOrderAmountRecord/list',
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
		idField: 'payOrderAmountRecordId',
		maintainSelected: true,
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			{field:'payOrderAmountRecordId',title:'日志ID',align:'center'},
			{field:'payOrderAmountLogId',title:'订单日志表ID',align:'center'},
			{field:'orderId',title:'订单ID',align:'center'},
			{field:'agentId',title:'商户ID',align:'center'},
			{field:'amount',title:'新增金额',align:'center',formatter:function (value, row, index) {return toYuan(value);}},
			{field:'merBaseAmount',title:'商户新增前余额',align:'center',formatter:function (value, row, index) {return toYuan(value);}},
			{field:'status',title:'状态',align:'center',formatter:function (value, row, index) {
				if(value==0){
					return "失败";
				}else if(value==1){
					return "成功";
				}else{
					return "数据异常";
				}
			}},
			{field:'createTime',title:'更新时间',align:'center'}
		]
	});
});



function toYuan(arg1){
	var arg2=100;
	var t1=0,t2=0,r1,r2;
	try{t1=arg1.toString().split(".")[1].length;}catch(e){};
	try{t2=arg2.toString().split(".")[1].length;}catch(e){};
	with(Math){
		r1=Number(arg1.toString().replace(".",""));
		r2=Number(arg2.toString().replace(".",""));
		return accMul((r1/r2),pow(10,t2-t1));
	} 
}


function accMul(arg1,arg2) 
{ 
var m=0,s1=arg1.toString(),s2=arg2.toString(); 
try{m+=s1.split(".")[1].length}catch(e){} 
try{m+=s2.split(".")[1].length}catch(e){} 
return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m) 
}




</script>
</body>
</html>