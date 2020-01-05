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
	<title>开通或修改商户支付通道</title>
</head>
<body>
<div id="agentPayTypeMain">
	<table id="agentPayTypeTable"></table>
</div>
<script>
var $agentPayTypeTable = $('#agentPayTypeTable');
$(function() {
	// bootstrap table初始化
    $agentPayTypeTable.bootstrapTable({
		url: '${basePath}/agentPayChannelInfo/agentPayChannelInfoList/${agentId}/${payTypeId}',	//获取表格数据的url
		//height: 600,	//行高，如果没有设置height属性，表格自动根据记录条数决定表格高度
		cache: false,	//是否使用缓存，默认为true
		striped: true,	//是否启用行间隔色
		search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
		showRefresh: false,	//是否显示刷新按钮
		showColumns: false,	//是否显示所有的列
		minimumCountColumns: 2,	//最少允许的列数
		clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
		pagination: true,	//在表格底部显示分页组件，默认false
		paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
		idField: 'agentPayTypeId',	//指定主键列
		maintainSelected: true,
		detailView: false, //是否开启子table
		//toolbar: '#toolbar',
		columns: [
            {field: 'payChannelInfo.payChannelInfoId', title: '支付通道ID', align: 'center'},
            {field: 'payType.payname', title: '支付类型', align: 'center'},
            {field: 'payChannelInfo.channelInfoName', title: '支付通道名称', align: 'center'},
            {field: 'payChannelInfo.salefee', title: '销售费率', align: 'center'},
            {field: 'priority', title: '优先级[从大到小]', align: 'center', formatter: 'priorityFormatters'},
            {field: 'payChannelInfo.isLock', title: '支付通道状态', align: 'center', formatter: 'isLockInfoFormatters'},
            {field: 'payChannelInfo.remark', title: '备注信息', align: 'center'},
            {field: 'action', title: '操作', width: 150, formatter: 'actionFormatters', events: 'actionEvents'}
		],
	});
});
// 操作按钮
function actionFormatters(value, row, index) {
    if(row.agentPayChannelInfoId){
        return [
            '<shiro:hasPermission name="pattern:agentPayChannelInfo:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.agentPayChannelInfoId+','+row.payChannelInfoId+')" title="修改商户支付通道">更新</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:agentPayChannelInfo:delete"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="deleteRow('+row.agentPayChannelInfoId+')" title="删除商户支付通道">删除</button></shiro:hasPermission>'
        ].join('');
	}else{
        var agentId = row.agentId;
        var payTypeId = row.payType.payTypeId;
        var payChannelInfoId = row.payChannelInfo.payChannelInfoId;
        var payChannelAccountId = row.payChannelInfo.payChannelAccountId;
        return [
            '<shiro:hasPermission name="pattern:agentPayChannelInfo:create"><button type="button" class="btn btn-success btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createRow('+agentId+','+payTypeId+','+payChannelInfoId+','+payChannelAccountId+')" title="开通商户支付通道">开通</button></shiro:hasPermission>',
        ].join('');
	}
}

function priorityFormatters(value, row) {
    if(value != null){
        return '<input id="priority'+row.payChannelInfoId+'" type="text" class="form-control" onpaste="return false" onkeyup="value=value.replace(/[^\\d]/g,\'\')" value="'+value+'" style="height: 25px;" maxlength="10">';
    }else{
        return '<input id="priority'+row.payChannelInfo.payChannelInfoId+'" type="text" class="form-control" onkeyup="value=value.replace(/[^\\d]/g,\'\')" style="height: 25px;" maxlength="10">';
    }
}

function isLockInfoFormatters(value){
    if(value == 0){
        return '启用';
    }
    if(value == 1){
        return '<label style="color:red">禁用</label>';
    }
}


//开通商户支付通道
function createRow(agentId,payTypeId,payChannelInfoId,payChannelAccountId) {
    var priority = $('#priority'+payChannelInfoId).val().trim();
    var dateJson = {'agentId':agentId,'payChannelInfoId':payChannelInfoId,'payTypeId':payTypeId,'priority':priority,'payChannelAccountId':payChannelAccountId};

    $.ajax({
        type: 'post',
        url: '${basePath}/agentPayChannelInfo/create',
        data: dateJson,
        beforeSend: function() {
            if (agentId == '') {
                layer.msg('商户ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payTypeId == '') {
                layer.msg('支付类型ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payChannelInfoId == '') {
                layer.msg('所属支付通道ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payChannelAccountId == '') {
                layer.msg('所属渠道账户ID获取失败',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $agentPayTypeTable.bootstrapTable('refresh');
                });
            } else {
                if (result.data instanceof Array) {
                    $.each(result.data, function(index, value) {
                        layer.alert(value.errorMsg,{icon:2})
                    });
                } else {
                    layer.alert(result.data,{icon:2});
                }
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            layer.alert(textStatus,{icon:2});
        }
    });
}


//更新商户支付通道
function updateRow(agentPayChannelInfoId,payChannelInfoId) {
    var priority = $('#priority'+payChannelInfoId).val().trim();
    var dateJson = {'agentPayChannelInfoId':agentPayChannelInfoId,'priority':priority};

    $.ajax({
        type: 'post',
        url: '${basePath}/agentPayChannelInfo/update',
        data: dateJson,
        beforeSend: function() {
            if (agentPayChannelInfoId == '') {
                layer.msg('商户支付通道ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (priority == '') {
                layer.msg('优先级[从大到小]不能为空',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $agentPayTypeTable.bootstrapTable('refresh');
                });
            } else {
                if (result.data instanceof Array) {
                    $.each(result.data, function(index, value) {
                        layer.alert(value.errorMsg,{icon:2})
                    });
                } else {
                    layer.alert(result.data,{icon:2});
                }
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            layer.alert(textStatus,{icon:2});
        }
    });
}

//删除商户支付通道
var deleteDialog;
function deleteRow(agentPayChannelInfoId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该商户支付通道吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/agentPayChannelInfo/delete/' + agentPayChannelInfoId,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    deleteDialog.close();
                                    $agentPayTypeTable.bootstrapTable('refresh');
                                });
                            } else {
                                if (result.data instanceof Array) {
                                    $.each(result.data, function(index, value) {
                                        layer.alert(value.errorMsg,{icon:2})
                                    });
                                } else {
                                    layer.alert(result.data,{icon:2});
                                }
                            }
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            layer.alert(textStatus,{icon:2});
                        }
                    });
                }
            },
            cancel: {
                text: '取消',
                btnClass: 'waves-effect waves-button'
            }
        }
    });
}

</script>
</body>
</html>