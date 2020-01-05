<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="channelParamDialog" class="crudDialog">
		<form id="createParamForm" method="post">
			<div class="row">
				<div class="col-sm-2">
					<div class="form-group">
						<div class="fg-line">
							<div class="form-group">
								<label for="paramName">参数名</label>
								<input id="paramName" type="text" class="form-control" name="paramName" maxlength="50">
								<input id="smsChannelId" type="hidden" name="smsChannelId" value="${smsChannelId}">
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<div class="fg-line">
							<div class="form-group">
								<label for="paramValue">参数值</label>
								<input id="paramValue" type="text" class="form-control" name="paramValue" maxlength="150">
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-4">	
					<div class="form-group">
						<div class="fg-line">
							<div class="form-group">
								<label for="remarks">参数说明</label>
								<input id="remarks" type="text" class="form-control" name="remarks" maxlength="200">
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-2">	
					<div class="form-group">
						<div class="fg-line">
							<div class="form-group">
								<button type="button" class="btn btn-success btn-sm" onclick="createSubmit();">新增参数</button>
							</div>
						</div>
					</div>
				</div>
			</div>	
		</form>
	<table id="paramTable"></table>
</div>
<jsp:include page="../../../common/inc/dialog_footer.jsp" flush="true"/>
<script>
var $paramTable = $('#paramTable');

//删除
var deleteParamDialog;

$(function() {
	// bootstrap paramTable初始化
	$paramTable.bootstrapTable({
		url: '${basePath}/smsChannelParam/list/${smsChannelId}',
		height: getHeight()-300,
		striped: true,
		search: false,
		showRefresh: false,
		showColumns: false,
		minimumCountColumns: 2,
		clickToSelect: true,
		detailFormatter: 'detailFormatter',
		pagination: true,
		paginationLoop: false,
		sidePagination: 'server',
		silentSort: false,
		smartDisplay: false,
		escape: true,
		searchOnEnterKey: true,
		idField: 'smsChannelParamId',
		maintainSelected: true,
		columns: [
			{field:'smsChannelParamId', visible:false},
			{field:'paramName',title:'参数',align:'center'},
			{field:'paramValue',title:'值',align:'center'},
			{field:'remarks',title:'参数说明',align:'center'},
			{field:'action',align:'center', title: '操作', align: 'center', formatter: function(value, row, index) {
			    return [
					'<shiro:hasPermission name="pattern:smsChannel:delete"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;" onclick="deleteParamRow('+row.smsChannelParamId+',null)">删除</button></shiro:hasPermission>'
			    ].join('');
			}, events: 'actionEvents', clickToSelect: false}
		]
	});
});


//删除行
function deleteParamRow(id,rows) {
    deleteParamDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该短信通道参数吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    var ids = new Array();
                    if(id){
                        ids.push(id);
                    }
                    if(rows){
                    	for (var i in rows) {
							ids.push(rows[i].smsChannelParamId);
						}
                    }
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/smsChannelParam/delete/' + ids.join("-"),
                        success: function(result) {
                			if (result.model.code == 1) {
                                 layer.msg(result.model.data,{icon:1,time:1000},function () {
                                	 deleteParamDialog.close();
                                     $paramTable.bootstrapTable('refresh');
                                 });
                 			} else {
                                 if (result.model.data instanceof Array) {
                                     $.each(result.model.data, function(index, value) {
                                         layer.alert(value.errorMsg,{icon:2})
                                     });
                                 } else {
                                     layer.alert(result.model.data,{icon:2});
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


function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/smsChannelParam/create',
        data: $('#createParamForm').serialize(),
        beforeSend: function() {
			if ($('#paramName').val() == '') {
				$('#paramName').focus();
				return false;
			}
			if ($('#paramValue').val() == '') {
				$('#paramValue').focus();
				return false;
			}
			if ($('#remarks').val() == '') {
				$('#remarks').focus();
				return false;
			}
        },
        success: function(result) {
			if (result.model.code == 1) {
                layer.msg(result.model.data,{icon:1,time:1000},function () {
                	$('#paramName').val('');
        			$('#paramValue').val('');
        			$('#remarks').val('');
                	
                	
                    $paramTable.bootstrapTable('refresh');
                });
			} else {
                if (result.model.data instanceof Array) {
                    $.each(result.model.data, function(index, value) {
                        layer.alert(value.errorMsg,{icon:2})
                    });
                } else {
                    layer.alert(result.model.data,{icon:2});
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