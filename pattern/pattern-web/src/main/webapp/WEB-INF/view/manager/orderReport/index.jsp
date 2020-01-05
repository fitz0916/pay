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
	<title>订单交易报表管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div class="panel panel-default">
	    <form class="form-horizontal">
	        <div class="panel-body">
	            <div class="row pd-bottom-2">
	                <div class="col-md-4">
	                    <div class="form-group" style="margin-left: 5px;margin-top: 2px;">
					                    开始时间: <input id="startDate" name="startDate" class="Wdate" type="text" onfocus="startTimeFocus();"> 	
							&nbsp;&nbsp;&nbsp;&nbsp;结束时间: <input id="endDate" name="endDate" class="Wdate" type="text" onfocus="endTimeFocus();">
	                    </div>
	                </div>
	                <div class="col-md-2">
	                    <div class="form-group">
	                    	交易类型：<select id ="payType" class="selectpicker" style="width:150px">
										<option value="0">全部类型</option>
									</select>
	                    </div>
	                </div>
	                <div class="col-md-2">
	                    <div class="form-group">
							收款通道：<select id ="queryPayChannel" class="selectpicker"  style="width:150px">
								<option value="0">全部通道</option>
							</select> 
	                    </div>
	                </div>
	                <div class="col-md-2">
	                    <div class="form-group">
							商户名称：<select id ="merId" class="selectpicker" style="width:150px" >
								<option value="0">全部商户</option>
							</select>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-12 text-right ">
					<a onclick="query()" class="btn btn-success" style="margin-right:10px;"><span class="glyphicon glyphicon-search"></span>搜索</a>
					<a onclick="exportXls()" class="btn btn-primary" style="margin-right:10px;" >导出</a>
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
		payChannelId: $('#queryPayChannel').val()==0 ? null : $('#queryPayChannel').val(),
		merId: $('#merId').val()==0 ? null : $('#merId').val(),
		payType: $('#payType').val()==0 ? null : $('#payType').val(),
		startDate: $('#startDate').val(),
		endDate: $('#endDate').val()
	}
}


function startTimeFocus() {
    return WdatePicker({
        skin : 'whyGreen',
        minDate:'#F{$dp.$D(\'endDate\',{d:-30});}',
        maxDate : '#F{$dp.$D(\'endDate\')||\'%y-%M-%d\'}',
        readonly:true,
        dateFmt:'yyyy-MM-dd'
    });
}
 
function endTimeFocus() {
    return WdatePicker({
        skin : 'whyGreen',
        minDate:'#F{$dp.$D(\'startDate\')}',
        maxDate : '#F{$dp.$D(\'startDate\',{d:30})||\'%y-%M-%d\'}',
        readonly:true,
        dateFmt:'yyyy-MM-dd'
    });
}

/**
* 查询
*/
function query(){
  $table.bootstrapTable('refresh');
}
/**
* 导出
*/
function exportXls(){
	
	var payChannelId= ($('#queryPayChannel').val()==0) ? "" : $('#queryPayChannel').val();
	var merId= ($('#merId').val()==0) ? "" : $('#merId').val();
	var payType= ($('#payType').val()==0) ? "" : $('#payType').val();
	var startDate= $('#startDate').val();
	var endDate= $('#endDate').val();
	 
	window.open("${basePath}/orderReport/export?"
			+"payChannelId="+payChannelId
			+"&merId="+ merId
			+"&payType="+ payType
			+"&startDate="+ startDate
			+"&endDate="+ endDate
			);
}

/**
* 重置
*/
function reset(){
	$("#queryPayChannel").val("0").trigger("change"); 
	$("#queryPayChannel").change();
	$("#merId").val("0").trigger("change"); 
	$("#merId").change();
	$("#payType").val("0").trigger("change"); 
	$("#payType").change();
	
	$('#startDate').val('');
	$('#endDate').val('');
}



$(function() {

	$('#startDate').val('${nowDate}');
	$('#endDate').val('${nowDate}');
	
	//支付渠道下拉框
	$.ajax({
	    type:"GET",
	    url:'${basePath}/payChannel/all',
	    success:function(result){
	        for(var i=0;i<result.length;i++){
	            var option = $("<option value="+ result[i].payChannelId +">" + result[i].channelName +"</option>");
	            $("#queryPayChannel").append(option);
	        }
	    }
	});
	
	//支付类型下拉框
	$.ajax({
	    type:"GET",
	    url:'${basePath}/orderStatistic/allPayType',
	    success:function(result){
	        for(var i=0;i<result.length;i++){
	            var option = $("<option value="+ result[i].payTypeId +">" + result[i].payname +"</option>");
	            $("#payType").append(option);
	        }
	    }
	});
	
	//商户下拉框
	$.ajax({
	    type:"GET",
	    url:'${basePath}/agent/all?role=1',
	    success:function(result){
	        for(var i=0;i<result.length;i++){
	            var option = $("<option value="+ result[i].agentId +">" + result[i].companyName +"</option>");
	            $("#merId").append(option);
	        }
	    }
	});
	
	
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/orderReport/list',
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
		idField: 'orderReportId',
		maintainSelected: true,
		toolbar: '#toolbar',
		showFooter:true,
        queryParams: queryParams,
		columns: [
			{field:'payFinishDateStr',title:'日期',align:'center', footerFormatter: function (value) {
		        return "交易统计：共"+$table.bootstrapTable('getOptions').totalRows+"条";
		    }},
			{field:'merName',title:'商户名称',align:'center', footerFormatter: function (value) {
		        var count = 0;
		        for (var i in value) {
		            count = value[i].countInfo.orderCount;
		        }
		        return "成交总笔数"+count;
		    }},
			{field:'orderCount',title:'成功笔数',align:'center', footerFormatter: function (value) {
		        var count = 0;
		        for (var i in value) {
		            count = value[i].countInfo.thirdAmountR;
		        }
		        return "成交总额(元)"+count;
		    }},
			{field:'thirdAmountR',title:'成交金额（元）',align:'center', footerFormatter: function (value) {
		        var count = 0;
		        for (var i in value) {
		            count = value[i].countInfo.agentProundageR;
		        }
		        return "手续费总额(元):"+count;
		    }},
			{field:'agentFee',title:'费率',align:'center'},
			{field:'agentProundageR',title:'手续费（元）',align:'center'},
			{field:'payTypeName',title:'交易类型',align:'center'},
			{field:'channelName',title:'收款通道',align:'center'}
		]
	});
});








</script>
</body>
</html>