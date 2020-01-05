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
	<title>订单交易统计管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
	<style type="text/css">
		.marTb{
			margin-top: 4px;    
			margin-right: -17px;
    		margin-left: 17px;
		}
		.pan_labTitle{
			float:left;
			margin-top:5px
			
		}
		.pan_inp{
			margin-left: 0 !important;
			margin-right: 0 !important;
			width: 52%;
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
			overflow:hidden; 
		}
		.padClear{
			padding:0 !important;
		}
		.mar0{
			margin:0 !important;
		}
	</style>
</head>
<body>
<div id="main">
	<div class="panel panel-default">
	    <form class="form-horizontal">
	        <div class="panel-body">
	            <div class="row pd-bottom-2">
	                <div class="col-md-5 col-lg-4">
	                    <div class="form-group" style="margin-left: 5px;margin-top: 3px;">
							 开始时间: <input id="startDate" name="startDate" class="Wdate" type="text" onfocus="startTimeFocus();"> 	
							&nbsp;&nbsp;&nbsp;&nbsp;结束时间: <input id="endDate" name="endDate" class="Wdate" type="text" onfocus="endTimeFocus();">
	                    </div>
	                </div>
	           
	                <div class="col-md-2 padClear clearFix">
	                	<div class="pan_labTitle">交易类型：</div>
	                    <div class="form-group pan_inp fl">
	                    	<select id ="payType" class="selectpicker" style="width:100%">
								<option value="0">全部类型</option>
							</select>
	                    </div>
	                    <div style="clear:both;"></div>
	                </div>
	                <div class="col-md-2 padClear clearFix">
					　　 <div class="pan_labTitle">收款通道：</div>
	                    <div class="form-group pan_inp fl">
							<select id ="queryPayChannel" class="selectpicker"  style="width:100%">
								<option value="0">全部通道</option>
							</select> 
	                    </div>
	                    <div style="clear:both;"></div>
	                </div>
	                <div class="col-md-2 padClear clearFix">
					　　<div class="pan_labTitle">商户名称：</div>
	                   <div class="form-group pan_inp fl">
							<select id ="merId" class="selectpicker" style="width:100%" >
								<option value="0">全部商户</option>
							</select>
	                    </div>
	                    <div style="clear:both;"></div>
	                </div>
	            </div>
	            
 	            <div class="row pd-bottom-2">
	                <div class="col-md-5 col-lg-4 padClear clearFix"> 
		                <div class="pan_labTitle fl" style="margin-left: 31px;">
						　状态：
		                </div>
	                    <div class="form-group fl pan_inp mar0" >
	                    	<select id ="payStatus" class="selectpicker" style="width:60%" >
								<option value="0">全部状态</option>
								<option value="1">支付中</option> 
								<option value="2">支付成功</option>
								<option value="3">支付失败</option> 
								<option value="4">订单初始化失败</option> 
								<option value="5">订单异常</option>
							</select>
	                    </div>
	                </div>
	                <div class="col-md-2 padClear clearFix">
		                 <div class="pan_labTitle fl">结算类型：
		                </div>
	                     <div class="form-group fl pan_inp mar0" >
	                    	<select id ="balanceType" class="selectpicker" style="width:100%" >
								<option value="0">全部结算类型</option>
								<option value="700">T0</option>
								<option value="701">T1</option>
								<option value="702">D0</option>
								<option value="703">D1</option>
							</select>
	                    </div>
	                </div>
	                <div class="col-md-2 padClear clearFix">
		                <div class="pan_labTitle">
		                	系统订单号：
		                </div>
	                    <div class="form-group fl pan_inp mar0">
							<input type="text" id ="orderId"  class="form-control" style="width:100%" />
	                    </div>
	                </div>
	                <div class="col-md-2 padClear clearFix">
		                <div class="pan_labTitle">
		                	商户订单号：
		                </div>
	                    <div class="form-group fl pan_inp mar0">
							<input type="text" id ="merOrderId" class="form-control"  style="width:100%" />
	                    </div>
	                </div>
	            </div>
	       
	            
	            <div class="col-md-12 text-right " style="margin-top: 10px;">
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



//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
	return {
		limit: params.limit, // 每页显示数量
		offset: parseInt(params.offset),
		payChannelId: $('#queryPayChannel').val()==0 ? null : $('#queryPayChannel').val(),
		balanceType: $('#balanceType').val()==0 ? null : $('#balanceType').val(),
		merId: $('#merId').val()==0 ? null : $('#merId').val(),
		payType: $('#payType').val()==0 ? null : $('#payType').val(),
		payStatus: $('#payStatus').val()==0 ? null : $('#payStatus').val(),
		merOrderId: $('#merOrderId').val(),
		orderId: $('#orderId').val(),
		startDate: $('#startDate').val(),
		endDate: $('#endDate').val()
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
	var payChannelId= ($('#queryPayChannel').val()==0) ? "" : $('#queryPayChannel').val();
	var balanceType= ($('#balanceType').val()==0) ? "" : $('#balanceType').val();
	var merId= ($('#merId').val()==0) ? "" : $('#merId').val();
	var payType= ($('#payType').val()==0) ? "" : $('#payType').val();
	var payStatus= $('#payStatus').val()==0 ? "" : $('#payStatus').val();
	var merOrderId= $('#merOrderId').val();
	var orderId= $('#orderId').val();
	var startDate= $('#startDate').val();
	var endDate= $('#endDate').val();
	 
	 
	window.open("${basePath}/orderStatistic/export?"
			+"payChannelId="+payChannelId
			+"&balanceType="+ balanceType
			+"&merId="+ merId
			+"&payType="+ payType
			+"&payStatus="+ payStatus
			+"&merOrderId="+ merOrderId
			+"&orderId="+ orderId
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
	$("#balanceType").val("0").trigger("change"); 
	$("#balanceType").change();
	$("#merId").val("0").trigger("change"); 
	$("#merId").change();
	$("#payType").val("0").trigger("change"); 
	$("#payType").change();
	$("#payStatus").val("0").trigger("change"); 
	$("#payStatus").change();
	
	$('#merOrderId').val('');
	$('#orderId').val('');
	$('#startDate').val('');
	$('#endDate').val('');
}


/**
 * 检查订单
 */
function checkOrder(id){
	$.ajax({
	    type:"GET",
	    url:'${basePath}/orderStatistic/check/'+id,
	    success:function(result){
	    	if (result.success) {
                layer.msg(result.model,{icon:1,time:1000},function () {
                    $table.bootstrapTable('refresh');
                });
			} else {
				if(result.errorCode!=-1){
	                layer.msg(result.errorCode,{icon:0,time:2000});
				}else{
	                layer.alert(result.errorMsg,{icon:2});
				}
			}
	    }
	});
}




//更改到成功状态
var orderStatusDialog;
function updateStatus(id) {
	orderStatusDialog = $.dialog({
      animationSpeed: 300,
      columnClass: 'col-md-6 col-md-offset-1 col-sm-3 col-sm-offset-3 col-xs-6 col-xs-offset-1',
      title: '更改订单状态',
      content: 'url:${basePath}/orderStatistic/update/'+id,
      onContentReady: function () {
          initMaterialInput();
      }
  });
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
		url: '${basePath}/orderStatistic/list',
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
		idField: 'orderId',
		maintainSelected: true,
		toolbar: '#toolbar',
		showFooter:true,
        queryParams: queryParams,
		columns: [
			{field:'orderGenerateDate',title:'交易时间',align:'center', footerFormatter: function (value) {
		        return "交易统计：共"+$table.bootstrapTable('getOptions').totalRows+"条";
		    }},
			{field:'orderId',title:'系统订单号',align:'center', footerFormatter: function (value) {
		        var count = 0;
		        for (var i in value) {
		            count = value[i].allPayAmountD;
		        }
		        return "付款总额(元):"+count;
		    }},
			{field:'merOrderId',title:'商户订单号',align:'center', footerFormatter: function (value) {
				var count = 0;
		        for (var i in value) {
		            count = value[i].allAgentProundageD;
		        }
		        return "手续费(元):"+count;
		    }},
			{field:'payTypeName',title:'交易类型',align:'center', footerFormatter: function (value) {
				var count = 0;
		        for (var i in value) {
		            count = value[i].allThirdAmountD;
		        }
		        return "三方到账总额(元)："+count;
		    }},
			{field:'merId',title:'商户号',align:'center'},
			{field:'merName',title:'商户名称',align:'center'},
			{field:'payAmountD',title:'付款(元)',align:'center'},
			{field:'agentFee',title:'费率',align:'center'},
			{field:'agentProundageD',title:'手续费(元)',align:'center'},
			{field:'thirdAmountD',title:'三方到帐金额(元)',align:'center'},
			{field:'payStatus',title:'状态',align:'center', formatter: function (value, row, index) {
				if(value==0){
					return "支付中";
				}else if(value==1){
					return "支付中";
				}else if(value==2){
					return "支付成功";
				}else if(value==3){
					return "支付失败";
				}else if(value==4){					
					return "订单初始化失败";
				}else if(value==6){					
					return "订单退款";
				}else{					
					return "订单异常";
				}
			}},
			{field:'channelName',title:'支付通道',align:'center'},
            {field: 'action', title: '操作', align: 'center', width: 210, formatter: function(value, row, index){//0135
                if(row.payStatus=='0'||row.payStatus=='1'||row.payStatus=='3'||row.payStatus=='5'){
	       		 return [
	      				'<shiro:hasPermission name="pattern:orderStatistic:check"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="checkOrder(\''+row.orderId+'\')">检查订单</button></shiro:hasPermission>',
						'<shiro:hasPermission name="pattern:orderStatistic:update"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateStatus(\''+row.orderId+'\')">修改状态</button></shiro:hasPermission>'
	    			].join('');
                }else{
                    return '暂无可用操作';
                }
           }, events: 'actionEvent'}
		]
	});
});






</script>
</body>
</html>