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
	<title>公告表管理</title>
	<jsp:include page="../../common/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
		<div class="row">
		    
    		<div class="col-md-12">
        		<div id="toolbar">
	        		<shiro:hasPermission name="pattern:news:save">
	    				<a class="waves-effect waves-button" href="javascript:;" onclick="editRow(null,null)"><i class="zmdi zmdi-plus"></i> 新增公告</a> 
    				</shiro:hasPermission>
				</div>
				<table id="table"></table>
			</div>
		</div>
</div>
<script type="text/javascript" charset="utf-8" src="${basePath}/resources/plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${basePath}/resources/plugins/ueditor/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="${basePath}/resources/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
var $table = $('#table');

//删除
var deleteDialog;

function reset(){
	$('#title').val('');
	$('#author').val('');
	$('#newsId').val('');
	ueditor.setContent('');
}

$(function() {
	//覆盖UEditor中获取路径的方法
	 window.UEDITOR_HOME_URL = "${basePath}/resources/plugins/ueditor/";
	 UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
	 UE.Editor.prototype.getActionUrl = function(action) {
	     if (action == 'uploadimage') {
	         return '${basePath}/upload/news/img';
	     } else {
	         return this._bkGetActionUrl.call(this, action);
	     }

	}
	
	// bootstrap table初始化
	$table.bootstrapTable({
		url: '${basePath}/news/list',
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
		idField: 'newsId',
		maintainSelected: true,
		toolbar: '#toolbar',
		columns: [
			{field:'newsId', visible:false},
			{field:'title',title:'标题',align:'center'},
			{field:'author',title:'作者',align:'center'},
			{field:'createtime',title:'创建时间',align:'center'},
			{field:'action',align:'center', title: '操作', align: 'center', formatter:function (value, row, index) {
			    return [
					'<shiro:hasPermission name="pattern:news:save"><button type="button" class="btn btn-primary btn-sm" style="padding:0 10px;" onclick="editRow('+row.newsId+','+index+')">编辑</button></shiro:hasPermission>',
					'<shiro:hasPermission name="pattern:news:delete"><button type="button" class="btn btn-danger btn-sm" style="padding:0 10px;margin-left:10px" onclick="deleteRow('+row.newsId+')">删除</button></shiro:hasPermission>'
			    ].join('');
			},  clickToSelect: false}
		]
	});
});


var ueditor;
function init(){
	ueditor=UE.getEditor('formContent',{
        initialFrameWidth : $('.jconfirm-box').width()-20,
        initialFrameHeight: 435
    });
	 
}

function destroy(){
	ueditor.destroy();
	$('#content').remove();
}


var createDialog;
function editRow(id,index) {
	if(id==null){
		id=0;
	}
    createDialog = $.dialog({
        animationSpeed: 300,
        title: '编辑公告',
        columnClass: 'col-md-12',
        containerFluid: true,
        content: 'url:${basePath}/news/save/' + id,
        onContentReady: function () {
            init();
            ueditor.addListener("ready", function () {
            	ueditor.setHeight(getHeight()-350);
            	if(index!=null){
	                var row = $table.bootstrapTable('getData')[index];
		        	$('#title').val(row.title);
		        	$('#author').val(row.author);
		        	$('#newsId').val(row.newsId);
		        	ueditor.setContent(row.content);
            	}
	        });
        },
        onClose:function(){
        	destroy();
        }
    }); 
};
	


function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/news/save',
        data: {
        	title:$('#title').val(),
        	author:$('#author').val(),
        	content:ueditor.getContent(),
        	newsId:$('#newsId').val()
        },
        beforeSend: function() {
			if ($('#title').val() == '') {
				$('#title').focus();
				return false;
			}
			if ($('#author').val() == '') {
				$('#author').focus();
				return false;
			}
			if (ueditor.getContent() == '') {
            	layer.alert("公告内容不能为空!",{icon:7});
				return false;
			}
        },
        success: function(result) {
			if (result.model.code == 1) {
                layer.msg(result.model.data,{icon:1,time:1000},function () {
                	createDialog.close();
                    $table.bootstrapTable('refresh');
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




//删除行
function deleteRow(id) {
    deleteDialog = $.confirm({
        type: 'red',
        animationSpeed: 300,
        title: false,
        content: '确认删除该公告吗？',
        buttons: {
            confirm: {
                text: '确认',
                btnClass: 'waves-effect waves-button',
                action: function () {
                    var ids = new Array();
                    if(id){
                        ids.push(id);
                    }
                    $.ajax({
                        type: 'get',
                        url: '${basePath}/news/delete/' + ids.join("-"),
                        success: function(result) {
                			if (result.model.code == 1) {
                                 layer.msg(result.model.data,{icon:1,time:1000},function () {
                                	 deleteDialog.close();
                                     $table.bootstrapTable('refresh');
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




</script>
</body>
</html>