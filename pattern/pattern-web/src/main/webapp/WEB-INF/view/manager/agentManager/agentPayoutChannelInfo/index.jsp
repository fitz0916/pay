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
	<title>商户代付通道列表</title>
	<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<style>
	.update_dialog{
		width: 100%;
		margin-top: 5%;
	}
</style>
<div id="main">
	<%--<div id="toolbar">
		<shiro:hasPermission name="pattern:agentPayChannelInfo:update">
			<a class="waves-effect waves-button" href="javascript:;" onclick="switchoverAction()"><i class="zmdi zmdi-plus"></i> 批量切换支付通道</a>
		</shiro:hasPermission>
	</div>--%>

	<table id="table"></table>
</div>
<jsp:include page="../../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');
$(function() {
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/agentPayoutChannelInfo/list',	//获取表格数据的url
		height: getHeight(),	//行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
		cache: false,	//是否使用缓存，默认为true
		striped: true,	//是否启用行间隔色
		search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
		showRefresh: true,	//是否显示刷新按钮
		showColumns: true,	//是否显示所有的列
		minimumCountColumns: 2,	//最少允许的列数
		clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
		pagination: true,	//在表格底部显示分页组件，默认false
		paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
		idField: 'agentIds',	//指定主键列
		maintainSelected: true,
		detailView: true, //是否开启子table
		//toolbar: '#toolbar',
		columns: [
			/*{field: 'ck', checkbox: true},*/
            {field: 'agentId', title: '商户ID', align: 'center'},
            {field: 'role', title: '商户类型', align: 'center', formatter: 'roleFormatter'},
            {field: 'companyName', title: '公司/商户名称', align: 'center'},
            {field: 'name', title: '联系人', align: 'center'},
            {field: 'phone', title: '联系电话', align: 'center'},
            {field: 'action', title: '操作', align: 'center', width: 205, formatter: 'actionFormatter', events: 'actionEvents'}
		],
		//子table触发事件
        onExpandRow:function(index,row,$element){
			var childTable = $element.html('<table id="child_table'+row.agentId+'"></table>').find('table');
            $(childTable).bootstrapTable({
                url: '${basePath}/agentPayoutChannelInfo/agentPayoutTypeList/'+row.agentId,	//获取表格数据的url
                striped: true,	//是否启用行间隔色
                search: false,	//是否启用搜索框，此搜索是客户端搜索，意义不大
                cache: false,	//是否使用缓存，默认为true
                searchOnEnterKey: false,	//设置为true时，按回车触发搜索方法，否则自动触发搜索方法
                minimumCountColumns: 2,	//最少允许的列数
                clickToSelect: false,	//设置true将在点击行时，自动选择rediobox和checkbox
                detailFormatter: 'detailFormatter',
                pagination: false,	//在表格底部显示分页组件，默认false
                paginationLoop: false,	//设置为 true 启用分页条无限循环的功能
                sidePagination: 'server',
                silentSort: false,
                smartDisplay: false,
                escape: true,
                idField: 'agentPayoutTypeId',	//指定主键列
                maintainSelected: true,
                columns: [
                    {field: 'payoutType.payoutTypeId', title: '代付类型ID', align: 'center'},
                    {field: 'payoutType.payoutTypeName', title: '代付类型', align: 'center'},
                    {field: 'singleMoney', title: '单笔结算额度上限(元)', align: 'center', formatter: 'singleMoneyFormatters'},
                    {field: 'isLock', title: '使用状态', align: 'center', formatter: 'isLockFormatters'},
                    {field: 'remark', title: '备注信息', align: 'center', formatter: 'remarkFormatters'},
                    {field: 'action', title: '操作', width: 260, formatter: 'actionPayTypeFormatter', events: 'actionEvents'}
                ]
            });
		}
	});
});
// 操作按钮
function actionFormatter(value, row, index) {
    return [
        '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:agentPayoutType"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="lookChildTableRow('+index+')" title="查看或开通代付类型">代付类型</button></shiro:hasPermission>',
        '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:read"><button type="button" class="btn btn-info btn-sm" style="margin-right:10px;padding:0 10px;" onclick="lookAgentPayoutChannelInfoRow('+row.agentId+')" title="查看代付类型">查看代付通道</button></shiro:hasPermission>'
    ].join('');
}

// 参数列表操作按钮
function actionPayTypeFormatter(value, row, index) {
    if(row.agentPayoutTypeId){
        return [
            '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:create"><button type="button" class="btn btn-primary btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createOrUpdateRow('+row.agentId+','+row.payoutTypeId+')">配置代付通道</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:agentPayoutType"><button type="button" class="btn btn-warning btn-sm" style="margin-right:10px;padding:0 10px;" onclick="payoutTypeFeeRow('+row.agentId+','+row.payoutTypeId+')">设置手续费</button></shiro:hasPermission>',
            '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:update"><button type="button" class="btn btn-info btn-sm" style="padding:0 10px;" onclick="updatePayoutTypeRow('+row.agentPayoutTypeId+','+row.payoutTypeId+','+row.agentId+')">更新</button></shiro:hasPermission>'
        ].join('');
	}else{
        return [
            '<shiro:hasPermission name="pattern:agentPayoutChannelInfo:agentPayoutType"><button type="button" class="btn btn-success btn-sm" style="margin-right:10px;padding:0 10px;" onclick="createPayoutTypeRow('+row.agentId+','+row.payoutType.payoutTypeId+')">开通代付类型</button></shiro:hasPermission>',
        ].join('');
	}
}

function roleFormatter(value) {
    if(value == 1){
        return "商户";
    }else{
        return '代理商';
    }
}
function singleMoneyFormatters(value, row) {
    if(value){
        return '<input id="singleMoney'+row.agentId+'_'+row.payoutType.payoutTypeId+'" type="text" class="form-control" value="'+value+'" style="height: 25px" maxlength="20" onpaste="return false" onkeyup="keyupDaymoney(this)">';
    }else{
        return '<input id="singleMoney'+row.agentId+'_'+row.payoutType.payoutTypeId+'" type="text" class="form-control" style="height: 25px" maxlength="20" onpaste="return false" onkeyup="keyupDaymoney(this)">';
    }
}
function isLockFormatters(value, row) {
    if(value){
        return '<input type="radio" name="isLock'+row.agentId+'_'+row.payoutType.payoutTypeId+'" value="0"> 启用&nbsp;<input type="radio" name="isLock'+row.agentId+'_'+row.payoutType.payoutTypeId+'" value="1" checked> <label style="color:red">禁用<label>';
	}else{
        return '<input type="radio" name="isLock'+row.agentId+'_'+row.payoutType.payoutTypeId+'" value="0" checked> 启用&nbsp;<input type="radio" name="isLock'+row.agentId+'_'+row.payoutType.payoutTypeId+'" value="1"> <label style="color:red">禁用<label>';
	}
}
function remarkFormatters(value, row) {
    if(value){
        return '<input id="remark'+row.agentId+'_'+row.payoutType.payoutTypeId+'" type="text" class="form-control" value="'+value+'" style="height: 25px" maxlength="50">';
    }else{
        return '<input id="remark'+row.agentId+'_'+row.payoutType.payoutTypeId+'" type="text" class="form-control" value="" style="height: 25px" maxlength="50">';
    }
}


//查看商户代付类型
function lookChildTableRow(index) {
    //加载子table
    $('tr[data-index="'+index+'"]').find('.detail-icon').click();
}


//查看商户所有的代付通道
function lookAgentPayoutChannelInfoRow(agentId) {
    createDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'update_dialog',
        title: '查看商户代付通道',
        content: 'url:${basePath}/agentPayoutChannelInfo/agentPayoutChannelInfoAll/'+agentId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//开通或修改商户代付通道
var updateDialog;
function createOrUpdateRow(agentId,payoutTypeId){
    updateDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'update_dialog',
        title: '开通或修改商户代付通道',
        content: 'url:${basePath}/agentPayoutChannelInfo/agentPayoutChannelInfoView/'+agentId+'/'+payoutTypeId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}


//查看与设置商户代付类型费率
var payoutTypeFeeDialog;
function payoutTypeFeeRow(agentId,payoutTypeId) {
    payoutTypeFeeDialog = $.dialog({
        animationSpeed: 300,
        columnClass: 'update_dialog',
        title: '查看与设置商户代付类型费率',
        content: 'url:${basePath}/agentPayoutChannelInfo/payoutTypeFee/'+agentId+'/'+payoutTypeId,
        onContentReady: function () {
            initMaterialInput();
        }
    });
}

//开通商户代付类型
function createPayoutTypeRow(agentId,payoutTypeId){
	var singleMoney = $("#singleMoney"+agentId+'_'+payoutTypeId).val().trim();
    var isLock = $('input[name="isLock'+agentId+'_'+payoutTypeId+'"]:checked').val();
    var remark = $("#remark"+agentId+'_'+payoutTypeId).val().trim();

    var dataJson = {'agentId':agentId,'payoutTypeId':payoutTypeId,'singleMoney':singleMoney,'isLock':isLock,'remark':remark};

    $.ajax({
        type: 'post',
        url: '${basePath}/agentPayoutChannelInfo/createAgentPayoutType',
        data: dataJson,
        beforeSend: function() {
            if (agentId == '') {
                layer.msg('商户ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (payoutTypeId == '') {
                layer.msg('代付类型ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (singleMoney == '') {
                layer.msg('请填写单笔结算额度上限',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $('#child_table'+agentId).bootstrapTable('refresh');
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


//修改商户代付类型
function updatePayoutTypeRow(agentPayoutTypeId,payoutTypeId,agentId){
    var singleMoney = $("#singleMoney"+agentId+'_'+payoutTypeId).val().trim();
    var isLock = $('input[name="isLock'+agentId+'_'+payoutTypeId+'"]:checked').val();
    var remark = $("#remark"+agentId+'_'+payoutTypeId).val().trim();

    var dataJson = {'agentPayoutTypeId':agentPayoutTypeId,'singleMoney':singleMoney,'isLock':isLock,'remark':remark};

    $.ajax({
        type: 'post',
        url: '${basePath}/agentPayoutChannelInfo/updateAgentPayoutType',
        data: dataJson,
        beforeSend: function() {
            if (agentPayoutTypeId == '') {
                layer.msg('商户支付类型ID获取失败',{icon:0,time:2000});
                return false;
            }
            if (singleMoney == '') {
                layer.msg('请填写支付类型费率',{icon:0,time:2000});
                return false;
            }
        },
        success: function(result) {
            if (result.code == 1) {
                layer.msg(result.data,{icon:1,time:1000},function () {
                    $('#child_table'+agentId).bootstrapTable('refresh');
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