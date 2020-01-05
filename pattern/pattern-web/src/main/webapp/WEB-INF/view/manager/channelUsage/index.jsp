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
	<title>支付通道统计</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<body>

<div id="main">
	<div id="pageChart" style="width:100%;height:450px"></div>
	<div id="toolbar">
        <input id="queryDate" class="Wdate" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})">
		<a style="margin-left:20px" onclick="query()" class="btn btn-success pull-right">查询</a>
	</div>
	<table id="table"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');
var pageChart ;
//x轴
var timeData = ['0点','1点', '2点', '3点', '4点', '5点', '6点',"7点","8点","9点","10点","11点","12点","13点","14点","15点","16点","17点","18点","19点","20点","21点","22点","23点"];
$(function() {
	pageChart = echarts.init(document.getElementById("pageChart"));
	
	loadChart(getNowFormatDate());
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/channelUsage/list',
		height: getHeight()-200,
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
        queryParams: queryParams,
		maintainSelected: true,
		toolbar: '#toolbar',
		columns: [
			{field:'payChannelId',title:'支付渠道ID',align:'center'},
			{field:'payChannelAccountId',title:'渠道账户ID',align:'center'},
			{field:'channelName',title:'支付渠道名称',align:'center'},
			{field:'payChannelAccountName',title:'渠道账户名称',align:'center'},
			{field:'feature',title:'支付类型',align:'center'},
			{field:'invokeDay',title:'调用日期',align:'center',formatter:function(value, row, index){
				return value.substr(0,10);
			}},
			{field:'invokeHour',title:'小时',align:'center'},
			{field:'updateTime',title:'更新时间',align:'center'},
			{field:'callSuccess',title:'调用成功次数',align:'center'},
			{field:'callFailures',title:'调用失败次数',align:'center'}
		]
	});
});

//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset),
        queryDate: $('#queryDate').val()
    }
}


function query(){
	loadChart($('#queryDate').val());
    $table.bootstrapTable('refresh');
}

function loadChart(dt){
	pageChart.showLoading();  
	
	if(dt==''){
		dt = getNowFormatDate();
	}
	
	$.ajax({
		type : "get",
	    async : true,
	    url : "${basePath}/channelUsage/chartData",   
	    data : {
	    	queryDate:dt
	    },
	    dataType : "json",
	    success : function(result) {
	    	
	    	if (result) {
	    		pageChart.setOption({
	    		    title: {
	    		        text: '支付渠道日统计图('+dt+')',
	    		        x: 'center'
	    		    },
	    		    tooltip: {
	    		        trigger: 'axis',
	    		        formatter:function(params){  //数据单位格式化
	    		        	if(params){
	    		               var head=params[0].name+'<br/>';//x轴名称 
	    			           var succVal='';  
	    			           var failVal='';   
	    			           var succValue=0;
	    			           var failValue=0;
	    			           var lineCont = ''; 
	    			           for (var i = 0, l = params.length; i < l; i++) { 
	    			               if (params[i].axisIndex==0) {
		    			               lineCont = '<span style="display:inline-block;margin-right:5px;border-radius:10px;width:10px;height:10px;background-color:'+params[i].color+';"></span>'
		    		    	               +params[i].seriesName+'调用成功: '+params[i].value+'(次)<br/>';
	    			                   succVal+=lineCont;
	    		    	               succValue += params[i].value; 
	    			               } else {
		    			               lineCont = '<span style="display:inline-block;margin-right:5px;border-radius:10px;width:10px;height:10px;background-color:'+params[i].color+';"></span>'
		    		    	               +params[i].seriesName+'调用失败: '+params[i].value+'(次)<br/>';
	    			                   failVal+=lineCont;
	    		    	               failValue += params[i].value; 
	    			               }
	    			               
	    			           }  
	    			               
	    			           return head+succVal+'<br/>'+failVal;    
	    		        	}
	    			     }  
	    		    },
	    		    toolbox: {
	    		        feature: {
	    		            saveAsImage: {}
	    		        }
	    		    },
	    		    axisPointer: {
	    		        link: {xAxisIndex: 'all'}
	    		    },
	    		    grid: [{
	    		        left: 50,
	    		        right: 50,
	    		        height: 155
	    		    }, {
	    		        left: 50,
	    		        right: 50,
	    		        top: 243,
	    		        height: 155
	    		    }],
	    		    xAxis : [
	    		        {
	    		            type : 'category',
	    		            axisLine: {onZero: true},
	    		            data: timeData
	    		        },
	    		        {
	    		            gridIndex: 1,
	    		            type : 'category',
	    		            axisLine: {onZero: true},
	    		            data: timeData,
	    		            position: 'top'
	    		        }
	    		    ],
	    		    yAxis : [
	    		        {
	    		            name : '成功次数',
	    		            type : 'value'
	    		        },
	    		        {
	    		            gridIndex: 1,
	    		            name : '失败次数',
	    		            type : 'value',
	    		            inverse: true
	    		        }
	    		    ],
	    		    legend: {
						data: result.legend,
	    		        x: 'left'
					},
					series:result.allData
	    		    
	    		},true);
				pageChart.hideLoading();    
			} 
    	},
		error : function(errorMsg) {
	     	pageChart.hideLoading();
		}
	});
}

function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = year + seperator1 + month + seperator1 + strDate;
    return currentdate;
}

</script>
</body>
</html>