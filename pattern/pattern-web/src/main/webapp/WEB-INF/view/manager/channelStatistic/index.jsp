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
	<title>通道交易统计管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
	<div class="panel panel-default">
	    <form class="form-horizontal">
	        <div class="panel-body">
	            <div class="row pd-bottom-2">
	                <div class="col-md-2">
	                    <div class="form-group" style="margin-left: 5px;margin-top: 2px;">
					                    选择日期: <input id="createDay" name="createDay" class="Wdate" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"> 	
	                    </div>
	                </div>
	                <div class="col-md-10">
	                    <div class="form-group">
							收款通道：<select id ="queryPayChannel" class="selectpicker" style="width: 150px">
								<option value="0">全部通道</option>
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
        createDay: $('#createDay').val()
    }
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
	 var payChannelId = $('#queryPayChannel').val()==0 ? '' : $('#queryPayChannel').val();
	 window.open("${basePath}/channelStatistic/export?createDay="+$('#createDay').val()+"&payChannelId="+ payChannelId);
}

/**
 * 重置
 */
function reset(){
	$("#queryPayChannel").val("0").trigger("change"); 
	$("#queryPayChannel").change();
	$('#createDay').val('');
}


$(function() {

	$('#createDay').val('${nowDate}');
	
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
	
	
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/channelStatistic/list',
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
		idField: 'channelStatisticId',
		maintainSelected: true,
		showFooter:true,
		toolbar: '#toolbar',
        queryParams: queryParams,
		columns: [
			{field:'channelStatisticId', visible:false},
			{field:'updateTime',title:'最后更新时间',align:'center', footerFormatter: function (value) {
		        return "交易统计：共"+$table.bootstrapTable('getOptions').totalRows+"条";
		    }},
			{field:'channelName',title:'收款通道',align:'center', footerFormatter: function (value) {
		        var count = 0;
		        for (var i in value) {
		            count = value[i].allAmountD;
		        }
		        return '成交总金额(元)'+count;
		    }},
			{field:'payTypeName',title:'支付类型',align:'center'},
			{field:'payNumber',title:'成功笔数',align:'center'},
			{field:'amountD',title:'成交金额(元)',align:'center'},
			{field:'dayMoney',title:'日限额(元)',align:'center', formatter: function (value, row, index) {return value==null?"不限额":value;}}
		]
	});
});









</script>
</body>
</html>