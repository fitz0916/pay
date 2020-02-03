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
	<title>支付订单管理</title>
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
	<table id="table"></table>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script type="text/javascript">

var $table = $('#table');


$(function() {
	initMyTable();
});

function initMyTable(){
	$table.bootstrapTable({
		url: '${basePath}/manage/paymentorder/list',	 //获取表格数据的url
		method:'post',
		dataType:'json',
		height: 523,	//行高，如果没有设置height属性，表格自动根据记录条数决定表格高度
		cache: false,	//是否使用缓存，默认为true
		striped: true,	 //是否启用行间隔色
		search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
		showRefresh: true,	//是否显示刷新按钮
		showColumns: true,	//是否显示所有的列
		minimumCountColumns: 2,	//最少允许的列数
		clickToSelect: true,	//设置true将在点击行时，自动选择rediobox和checkbox
		pagination: true,	//在表格底部显示分页组件，默认false
		paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
		idField: 'blackListId',	//指定主键列
		maintainSelected: true,
		detailView: false, //是否开启子table
		//detailFormatter:detailFormatter,
		//detailViewIcon:false,
		//detailViewByClick:true,
		queryParams:queryParams,
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
			{field:'orderNo',title:'订单号',align:'center'},
			{field:'customerNo',title:'商户号',align:'center'},
			{field:'customerName',title:'商户名称',align:'center'},
			{field:'customerOrderNo',title:'商户订单号',align:'center'},
			{field:'thirdChannelOrderNo',title:'渠道订单号',align:'center'},
            {field: 'payAmount', title: '交易金额(元)', align: 'center'},
            {field: 'transTime', title: '交易时间', align: 'center',formatter: 'changeDateFormat'},
            {field: 'payType', title: '支付类型', align: 'center',formatter: 'payTypeFormat'},
            {field: 'payStatus', title: '支付状态', align: 'center',formatter: 'payStatusFormat'},
            {field: 'customerFee', title: '销售费率', align: 'center'},
            {field: 'customerProundage', title: '手续费(元)', align: 'center'},
            {field: 'settlementType', title: '结算类型', align: 'center',formatter: 'settlementTypeFormat'},
            {field: 'settlementStatus', title: '结算状态', align: 'center',formatter: 'settlementStatusFormat'}
            
		]
		
	});
}

//新增_对话框
var createDialog;
function createAction() {
    createDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        containerFluid: true,
        title: '新增白名单',
        content: 'url:${basePath}/manage/blacklist/create',
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

//新增_对话框
//编辑
var updateDialog;
function updateAction() {
    var rows = $table.bootstrapTable('getSelections');
    if (rows.length > 1 || rows.length < 0) {
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
            title: '编辑白名单',
            columnClass: 'col-md-10 col-md-offset-1 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
            content: 'url:${basePath}/manage/blacklist/update/'+rows[0].blackListId,
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

//分页查询参数，是以键值对的形式设置的
function queryParams(params) {
    return {
        limit: params.limit, // 每页显示数量
        offset: parseInt(params.offset)
    }
}


//格式化状态
function payTypeFormat(value, row, index) {
	if (value == 41) {
		return '<span class="label label-success">微信-扫码</span>';
	} else {
		return '<span class="label label-danger">支付宝-扫码</span>';
	}
}

//格式化状态
function payStatusFormat(value, row, index) {
	if (value == 0) {
		return '<span class="label label-danger">支付中</span>';
	} else if (value == 1) {
		return '<span class="label label-success">支付成功</span>';
	}else {
		return '<span class="label label-danger">支付失败</span>';
	}
}

//格式化状态
function settlementTypeFormat(value, row, index) {
	if (value == 700) {
		return '<span class="label label-danger">T0</span>';
	} else if (value == 701) {
		return '<span class="label label-success">T1</span>';
	}else if( value == 702){
		return '<span class="label label-danger">D0</span>';
	}else if( value == 703){
		return '<span class="label label-success">D1</span>';
	}else {
		return '<span class="label label-danger">其他</span>';
	}
}

//格式化状态
function settlementStatusFormat(value, row, index) {
	if (value == 0) {
		return '<span class="label label-danger">未结算</span>';
	} else if (value == 1) {
		return '<span class="label label-success">已结算</span>';
	}else{
		return '<span class="label label-success">结算失败</span>';
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
	  var time = year+'-'+month+"-"+date + ' ' + h +":" + m +":" + s;
	  return time;
}
</script>
</body>
</html>