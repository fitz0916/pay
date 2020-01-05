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
	<title>开通或修改商户代付通道</title>
</head>
<body>
<div id="agentPayoutTypeMain">
	<table id="agentPayoutTypeTable"></table>
</div>
<script>
var $agentPayoutTypeTable = $('#agentPayoutTypeTable');
$(function() {
	// bootstrap table初始化
    $agentPayoutTypeTable.bootstrapTable({
		url: '${basePath}/agentPayoutChannelInfo/agentPayoutChannelInfoList/${agentId}/${payoutTypeId}',	//获取表格数据的url
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
            {field: 'payoutChannel.payoutChannelId', title: '代付通道ID', align: 'center'},
            {field: 'payoutTypeId', title: '代付类型', align: 'center', formatter: 'payoutTypeIdFormatters'},
            {field: 'payoutChannel.channelName', title: '代付通道名称', align: 'center'},
            {field: 'priority', title: '优先级[从大到小]', align: 'center', formatter: 'priorityFormatters'},
            {field: 'payoutChannel.payoutTypeIds', title: '通道支持类型', align: 'center'},
            {field: 'payoutChannel.isLock', title: '代付通道状态', align: 'center', formatter: 'isLockInfoFormatters'},
            {field: 'payoutChannel.remark', title: '备注信息', align: 'center'},
            {field: 'action', title: '操作', width: 150, formatter: 'actionFormatters', events: 'actionEvents'}
		],
	});
});
// 操作按钮
function actionFormatters(value, row, index) {
    console.log(value);
    if(row.agentPayoutChannelInfoId){
        return [
            '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:update"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateRow('+row.agentPayoutChannelInfoId+','+row.payoutChannelId+')" title="修改商户代付通道">更新</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:delete"><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;padding:0 10px;" onclick="deleteRow('+row.agentPayoutChannelInfoId+')" title="删除商户代付通道">删除</button></shiro:hasPermission>'
        ].join('');
	}else{
        var agentId = row.agentId;
        var payoutTypeId = row.payoutTypeId;
        var payoutChannelId = row.payoutChannel.payoutChannelId;
        var payChannelAccountId = row.payoutChannel.payChannelAccountId;
        return [
            '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:create"><button type="button" class="btn btn-success btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createRow('+agentId+','+payoutTypeId+','+payoutChannelId+','+payChannelAccountId+')" title="开通商户代付通道">开通</button></shiro:hasPermission>',
        ].join('');
	}
}

function priorityFormatters(value, row) {
    if(value != null){
        return '<input id="priority'+row.payoutChannelId+'" type="text" class="form-control" onpaste="return false" onkeyup="value=value.replace(/[^\\d]/g,\'\')" value="'+value+'" style="height: 25px;" maxlength="10">';
    }else{
        return '<input id="priority'+row.payoutChannel.payoutChannelId+'" type="text" class="form-control" onkeyup="value=value.replace(/[^\\d]/g,\'\')" style="height: 25px;" maxlength="10">';
    }
}

function payoutTypeIdFormatters(value){
    if(value == 700){
        return 'T0结算';
    }else if(value == 701){
        return 'T1结算';
	}else if(value == 702){
        return 'D0结算';
    }else if(value == 703){
        return 'D1结算';
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



//开通商户代付通道
function createRow(agentId,payoutTypeId,payoutChannelId,payChannelAccountId) {
    var priority = $('#priority'+payoutChannelId).val().trim();
    var dateJson = {'agentId':agentId,'payoutTypeId':payoutTypeId,'payoutChannelId':payoutChannelId,'priority':priority,'payChannelAccountId':payChannelAccountId};

    $.ajax({
        type: 'post',
        url: '${basePath}/agentPayoutChannelInfo/create',
        data: dateJson,
        beforeSend: function() {
            if (agentId == '') {
                layer.msg('商户ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payoutTypeId == '') {
                layer.msg('代付类型ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payoutChannelId == '') {
                layer.msg('代付通道ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payChannelAccountId == '') {
                layer.msg('渠道账户ID获取失败',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $agentPayoutTypeTable.bootstrapTable('refresh');
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


//更新商户代付通道
function updateRow(agentPayoutChannelInfoId,payoutChannelId) {
    var priority = $('#priority'+payoutChannelId).val().trim();
    var dateJson = {'agentPayoutChannelInfoId':agentPayoutChannelInfoId,'priority':priority};

    $.ajax({
        type: 'post',
        url: '${basePath}/agentPayoutChannelInfo/update',
        data: dateJson,
        beforeSend: function() {
            if (agentPayoutChannelInfoId == '') {
                layer.msg('商户代付通道ID获取失败',{icon:0,time:2000});
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
                    $agentPayoutTypeTable.bootstrapTable('refresh');
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


//删除商户代付通道
var deleteDialog;
function deleteRow(agentPayoutChannelInfoId) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该商户代付通道吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/agentPayoutChannelInfo/delete/' + agentPayoutChannelInfoId,
                        success: function(result) {
                            if (result.code == 1) {
                                layer.msg(result.data,{icon:1,time:1000},function () {
                                    deleteDialog.close();
                                    $agentPayoutTypeTable.bootstrapTable('refresh');
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