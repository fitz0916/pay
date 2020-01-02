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
	<title>日志管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<style>
	.padTop-7{
		padding-top:7px;
	}
</style>
<body>
<div id="main">
<div class="panel panel-default">
    <form class="form-horizontal">
        <div class="panel-body">
            <div class="row pd-bottom-2">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="col-md-4 control-label text-right">操&nbsp;作&nbsp;人：</label>
                        <div class="col-md-8">
                            <input class="form-control"  id="userName">
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="col-md-4 control-label">操作描述：</label>
                        <div class="col-md-8">
                            <input class="form-control"  id="description">
                        </div>
                    </div>
                </div>
            </div>
           <div class="row pd-bottom-2">
           	<div class="col-md-4">
                    <div class="form-group">
                        <label class="col-md-4 control-label">开始时间：</label>
                        <div class="col-md-8 padTop-7">
                            <input id="startDate"  class="Wdate" type="text" onclick="var endDate=$dp.$('endDate');WdatePicker({onpicked:function(){endDate.click();},dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}'})">
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="col-md-4 control-label text-right">结束时间：</label>
                        <div class="col-md-8 padTop-7">
                           <input id="endDate"  class="Wdate" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}'})">
                        </div>
                    </div>
                </div>
           </div>
                <div class="col-md-12 text-right ">
                    <div params="vm.searchParams" class="ng-isolate-scope">
						<button type="button" class="btn btn-success" onclick="query()"><span class="glyphicon glyphicon-search"></span>搜索</button>
						<button type="reset" id="reset" class="btn btn-danger">重置</button>
					</div>
                </div>
            </div>
        </form>
     </div>
	<table id="table"></table>
</div>

<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
    var $table = $('#table');
    $(function() {
        // bootstrap table初始化
        $table.bootstrapTable({
            url: '${basePath}/log/list',
            height: getHeight(),
            striped: true,
            // search: true,
            showRefresh: false,
            showColumns: false,
            minimumCountColumns: 2,
            clickToSelect: true,
            // detailView: true, //+号细节
            detailFormatter: 'detailFormatter',
            pagination: true,
            paginationLoop: false,
            sidePagination: 'server',
            silentSort: false,
            smartDisplay: false,
            escape: true,
            searchOnEnterKey: true,
            idField: 'logId',
            maintainSelected: true,
            toolbar: '#toolbar',
            queryParams: queryParams,
            columns: [
                // {field: 'ck', checkbox: true},
                {field: 'logId', title: '编号', sortable: true, align: 'center'},
                {field: 'description', title: '操作描述', align: 'center'},
                {field: 'userName', title: '操作人', align: 'center'},
                {field: 'startTime', title: '操作时间', align: 'center'},
                {field: 'spendTime', title: '耗时/ms', align: 'center'},
                {field: 'url', title: 'URL', align: 'center'},
                {field: 'method', title: '请求类型', align: 'center'},
                {field: 'parameter', title: '请求参数', align: 'center'},
                {field: 'ip', title: 'IP', align: 'center'},
                {field: 'result', title: '状态码', align: 'center'},
            ]
        });
    });

    /**
     * 查询
     */
    function query(){
        $("#table").bootstrapTable('refresh');
    }

    /**
     * 重置
     */
    function reset(){
        $("#startDate").val(""); // 请求时向服务端传递的参数
        $('#endDate').val(""); // 请求时向服务端传递的参数
        $('#description').val("");
        $('#userName').val('');
    }

    //分页查询参数，是以键值对的形式设置的
    function queryParams(params) {
        return {
            startDate: $("#startDate").val().trim(), // 请求时向服务端传递的参数
            endDate: $('#endDate').val().trim(), // 请求时向服务端传递的参数
            userName: $('#userName').val().trim(),
            description: $('#description').val().trim(),
            limit: params.limit, // 每页显示数量
            offset: parseInt(params.offset),
            // offset: parseInt(params.offset/params.limit) + 1,
        }
    }
</script>
</body>
</html>