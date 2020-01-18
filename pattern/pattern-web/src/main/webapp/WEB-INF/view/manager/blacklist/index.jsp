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
	<title>黑名单管理</title>
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
		<shiro:hasPermission name="pattern:blacklist:create">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="pattern:blacklist:update">
			 <a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i class="zmdi zmdi-plus"></i> 编辑</a>
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
	$table.bootstrapTable({
		url: '${basePath}/manage/blacklist/list',	//获取表格数据的url
		method:'post',
		dataType:'json',
		height: 523,	//行高，如果没有设置height属性，表格自动根据记录条数决定表格高度
		cache: false,	//是否使用缓存，默认为true
		striped: true,	//是否启用行间隔色
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
			{field:'blackListId',title:'ID',align:'center'},
			{field:'ip',title:'IP',align:'center'},
			{field:'createTime',title:'创建时间',align:'center',formatter: 'changeDateFormat'},
			{field:'updateTime',title:'更新时间',align:'center',formatter: 'changeDateFormat'},
            {field: 'status', title: '状态', align: 'center',formatter: 'statusFormatter'},
            {field: 'remark', title: '备注', align: 'center'}
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
function statusFormatter(value, row, index) {
	if (value == 1) {
		return '<span class="label label-success">正常</span>';
	} else {
		return '<span class="label label-danger">锁定</span>';
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