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
	<title>修改或开通支付通道</title>
</head>
<body>
<div id="payTypeMain">
	<table id="payTypeTable"></table>
</div>
<script>
var $payTypeTable = $('#payTypeTable');
$(function() {
	// bootstrap table初始化
    $payTypeTable.bootstrapTable({
		url: '${basePath}/payChannelInfo/lookList/${payChannelAccountId}',	//获取表格数据的url
		//height: 500,	//行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
		cache: false,	//是否使用缓存，默认为true
		striped: true,	//是否启用行间隔色
		search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
		showRefresh: false,	//是否显示刷新按钮
		showColumns: false,	//是否显示所有的列
		minimumCountColumns: 2,	//最少允许的列数
		clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
		pagination: false,	//在表格底部显示分页组件，默认false
		paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
		idField: 'payTypeId',	//指定主键列
		maintainSelected: true,
		detailView: false, //是否开启子table
		//toolbar: '#toolbar',
		columns: [
            {field: 'payType.payname', title: '支付类型', align: 'center'},
            {field: 'payChannelAccount.simpleName', title: '所属渠道账户', align: 'center'},
            {field: 'channelInfoName', title: '支付通道名称', align: 'center', formatter: 'channelInfoNameFormatters'},
            {field: 'fee', title: '接入费率', align: 'center', formatter: 'feeFormatters'},
            {field: 'salefee', title: '销售费率', align: 'center', formatter: 'salefeeFormatters'},
            {field: 'isLock', title: '是否禁用', align: 'center', formatter: 'isLockFormatters'},
            {field: 'remark', title: '备注信息', align: 'center', formatter: 'remarkFormatters'},
            {field: 'createTime', title: '创建时间', align: 'center'},
            {field: 'action', title: '操作', align: 'center', width: 100, formatter: 'actionFormatters', events: 'actionEvents'}
		],
	});
});
// 操作按钮
function actionFormatters(value, row, index) {
    if(row.payChannelInfoId){
        return [
            '<shiro:hasPermission name="pattern:payChannelInfo:create"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="updateInfoRow('+row.payChannelInfoId+','+row.payTypeId+')" title="修改支付通道">更新</button></shiro:hasPermission>',
        ].join('');
	}else{
        var payChannelId = row.payChannelAccount.payChannelId;
        var payChannelAccountId = row.payChannelAccount.payChannelAccountId;
        var payTypeId = row.payType.payTypeId;
        return [
            '<shiro:hasPermission name="pattern:payChannelInfo:create"><button type="button" class="btn btn-success btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createInfoRow('+payChannelId+','+payChannelAccountId+','+payTypeId+')" title="开通支付通道">开通</button></shiro:hasPermission>',
        ].join('');
	}
}

function channelInfoNameFormatters(value, row) {
	if(value){
	    return '<input id="channelInfoName'+row.payType.payTypeId+'" type="text" class="form-control" style="height: 25px" value="'+value+'" maxlength="20">';
	}else{
	    //提供自定义支付通道命名
		value = row.payType.payname+'-'+row.payChannelAccount.simpleName;
        return'<input id="channelInfoName'+row.payType.payTypeId+'" type="text" class="form-control" style="height: 25px" value="'+value+'" maxlength="20">';
	}
}
function feeFormatters(value, row) {
    if(value){
        return '<input id="fee'+row.payType.payTypeId+'" type="text" class="form-control" value="'+value+'" style="height: 25px" maxlength="20" onpaste="return false" onkeyup="keyupRate(this)">';
    }else{
        return '<input id="fee'+row.payType.payTypeId+'" type="text" class="form-control" style="height: 25px" maxlength="20" onpaste="return false" onkeyup="keyupRate(this)">';
    }
}
function salefeeFormatters(value, row) {
    if(value){
        return '<input id="salefee'+row.payType.payTypeId+'" type="text" class="form-control" value="'+value+'" style="height: 25px" maxlength="30" onpaste="return false" onkeyup="keyupRate(this)">';
    }else{
        return '<input id="salefee'+row.payType.payTypeId+'" type="text" class="form-control" style="height: 25px" maxlength="30" onpaste="return false" onkeyup="keyupRate(this)">';
    }
}
function isLockFormatters(value, row) {
    if(value == true){
        return '<input type="checkbox" id="isLock'+row.payType.payTypeId+'" checked>';
    }else{
        return '<input type="checkbox" id="isLock'+row.payType.payTypeId+'">';
    }
}
function remarkFormatters(value, row) {
    if(value){
        return '<input id="remark'+row.payType.payTypeId+'" type="text" class="form-control" value="'+value+'" style="height: 25px" maxlength="50">';
    }else{
        return '<input id="remark'+row.payType.payTypeId+'" type="text" class="form-control" value="" style="height: 25px" maxlength="50">';
    }
}

//开通支付通道
function createInfoRow(payChannelId,payChannelAccountId,payTypeId) {
    var channelInfoName = $('#channelInfoName'+payTypeId).val().trim();
    var fee = $('#fee'+payTypeId).val().trim();
    var salefee = $('#salefee'+payTypeId).val().trim();
    var remark = $('#remark'+payTypeId).val().trim();
    var isLock = 0;
    if($('#isLock'+payTypeId).prop('checked')){
        isLock = 1;
    }

    var dateJson = {'payChannelId':payChannelId,'payChannelAccountId':payChannelAccountId,'payTypeId':payTypeId,'channelInfoName':channelInfoName,
		'fee':fee,'salefee':salefee,'remark':remark,'isLock':isLock};

    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelInfo/create',
        data: dateJson,
        beforeSend: function() {
            if (payChannelId == '') {
                layer.msg('支付渠道ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payChannelAccountId == '') {
                layer.msg('渠道账户ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payTypeId == '') {
                layer.msg('交易类型ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (channelInfoName == '') {
                layer.msg('支付通道名称不能为空',{icon:0,time:2000});
                return false;
            }
            if (fee == '') {
                layer.msg('接入费率不能为空',{icon:0,time:2000});
                return false;
            }
            if (salefee == '') {
                layer.msg('销售费率不能为空',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $payTypeTable.bootstrapTable('refresh');
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


//更新支付通道
function updateInfoRow(payChannelInfoId,payTypeId) {
    var channelInfoName = $('#channelInfoName'+payTypeId).val().trim();
    var fee = $('#fee'+payTypeId).val().trim();
    var salefee = $('#salefee'+payTypeId).val().trim();
    var remark = $('#remark'+payTypeId).val().trim();
    var isLock = 0;
    if($('#isLock'+payTypeId).prop('checked') == true){
        isLock = 1;
    }

    var dateJson = {'payChannelInfoId':payChannelInfoId,'channelInfoName':channelInfoName,'fee':fee,'salefee':salefee,'remark':remark,'isLock':isLock};

    $.ajax({
        type: 'post',
        url: '${basePath}/payChannelInfo/update',
        data: dateJson,
        beforeSend: function() {
            if (payChannelInfoId == '') {
                layer.msg('支付通道ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (channelInfoName == '') {
                layer.msg('支付通道名称不能为空',{icon:0,time:2000});
                return false;
            }
            if (fee == '') {
                layer.msg('接入费率不能为空',{icon:0,time:2000});
                return false;
            }
            if (salefee == '') {
                layer.msg('销售费率不能为空',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $payTypeTable.bootstrapTable('refresh');
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

</script>
</body>
</html>