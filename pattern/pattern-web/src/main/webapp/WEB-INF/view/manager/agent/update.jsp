<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>

<div id="updateDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<div class="row">
			<div class="col-sm-5">
						<div class="cMaringB">
							性质：
							<input type="radio" name="type" value="1" style="margin-left: 11px;" <c:if test="${agent.type==1}">checked</c:if>>
							个体工商户
							<input type="radio" name="type" value="2" style="margin-left: 11px;" <c:if test="${agent.type==2}">checked</c:if>>
							公司/企业
						</div>
						<div class="form-group">
						
						</div>
						<div class="form-group">
							<label for="agentName">代理商名称：</label>
							<input type="text" class="form-control" value="${agent.agentName}" name="agentName" maxlength="50">
						</div>
						<div class="form-group">
							<label for="address">联系地址：</label>
							<input type="text" class="form-control" value="${agent.address}" name="address" maxlength="60">
						</div>
						<div class="form-group">
							<label for="phone">手机号码：</label>
							<input type="text" class="form-control" value="${agent.phone}" name="phone" maxlength="60">
						</div>
						<div class="form-group">
							<label for="email">邮箱：</label>
							<input type="text" class="form-control" value="${agent.email}" name="email" maxlength="60">
						</div>
						<div class="form-group">
							<label for="wechat">微信：</label>
							<input type="text" class="form-control" value="${agent.wechat}" name="wechat" maxlength="60">
						</div>
			</div>
			<div class="col-sm-5">
					    <div class="cMaringB">
							状态：
							<input type="radio" name="status" value="1" style="margin-left: 11px;" <c:if test="${agent.status==1}">checked</c:if>>
							启用
							<input type="radio" name="status" value="2" style="margin-left: 11px;" <c:if test="${agent.status==0}">checked</c:if>>
							禁用
						</div>	
						<div class="form-group">
						
						</div>
						<div class="form-group">
							<label for="businessLicense">营业执照号：</label>
							<input type="text" class="form-control" value="${agent.businessLicense}" name="businessLicense" maxlength="50">
						</div>	
						<div class="form-group">
							<label for="qq">QQ：</label>
							<input type="text" class="form-control" value="${agent.qq}" name="qq" maxlength="15">
						</div>	
						<div class="form-group">
							公司营业执照照片：
							<input type="file" name="files">
							<input type="hidden" class="form-control" value="${agent.companyPicPath}" name="companyPicPath" maxlength="50">
						</div>
						
						<div class="form-group">			
							身份证正面：
					        <input type="file" name="files">
							<input type="hidden" class="form-control" value="${agent.idCardFrontPath}" name="idCardFrontPath" maxlength="50">
						</div>
						<div class="form-group">			
							身份证反面：
					        <input type="file" name="files">
							<input type="hidden" class="form-control" value="${agent.idCardBackPath}" name="idCardBackPath" maxlength="50">
						</div>
			</div>
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
		</div>
	</form>
</div>

<script>


function init(){

    $('select').select2();
	
	//文件上传
	var companyPicPathInput = new FileInput();
	companyPicPathInput.Init("file-companyPicPath", "${basePath}/upload/agent/img");   
	//回调函数
	$("#file-companyPicPath").on("fileuploaded",function(event, data, previewId, index) {
	    var data = data.response.data;
	    $('#companyPicPath').val(data)
	    $('#companyPicPath_img').attr("src", data);
	});
	
	var idcardPicPathAInput = new FileInput();
	idcardPicPathAInput.Init("file-idcardPicPathA", "${basePath}/upload/agent/img");   
	//回调函数
	$("#file-idcardPicPathA").on("fileuploaded",function(event, data, previewId, index) {
	    var data = data.response.data;
	    $('#idcardPicPathA').val(data)
	    $('#idcardPicPathA_img').attr("src", data);
	});
	
	var idcardPicPathBInput = new FileInput();
	idcardPicPathBInput.Init("file-idcardPicPathB", "${basePath}/upload/agent/img");   
	//回调函数
	$("#file-idcardPicPathB").on("fileuploaded",function(event, data, previewId, index) {
	    var data = data.response.data;
	    $('#idcardPicPathB').val(data)
	    $('#idcardPicPathB_img').attr("src", data);
	});
	
	var photoInput = new FileInput();
	photoInput.Init("file-photo", "${basePath}/upload/agent/img");   
	//回调函数
	$("#file-photo").on("fileuploaded",function(event, data, previewId, index) {
	    var data = data.response.data;
	    $('#photo').val(data)
	    $('#photo_img').attr("src", data);
	});
}


function updateSubmit() {
    $.ajax({
        type: 'post',
		url: '${basePath}/manage/agent/update/${agent.agentId}',
        data: $('#updateForm').serialize(),
        beforeSend: function() {
			
        },
        success: function(result){
        	if (result.code != 1) {
				if (result.data instanceof Array) {
					$.each(result.data, function(index, value) {
						$.confirm({
							theme: 'dark',
							animation: 'rotateX',
							closeAnimation: 'rotateX',
							title: false,
							content: value.errorMsg,
							buttons: {
								confirm: {
									text: '确认',
									btnClass: 'waves-effect waves-button waves-light'
								}
							}
						});
					});
				} else if(result.code == '10110'){
                	layer.msg(result.msg);
                    location:top.location.href = '${basePath}/login';
                }  else {
						$.confirm({
							theme: 'dark',
							animation: 'rotateX',
							closeAnimation: 'rotateX',
							title: false,
							content: result.msg,
							buttons: {
								confirm: {
									text: '确认',
									btnClass: 'waves-effect waves-button waves-light'
								}
							}
						});
				}
			} else {
				updateDialog.close();
				$table.bootstrapTable('refresh');
			}
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
        	layer.alert(textStatus,{icon:2});
        }
    });
}


//以下js是通用的部分，后面可以把它放到单独js中在其他地方引用
var FileInput = function() {
var oFile = new Object();
//初始化fileinput控件（第一次初始化）
oFile.Init = function(ctrlName, uploadUrl) {
    var control = $('#' + ctrlName);
    //初始化上传控件的样式
    control.fileinput({
        language : 'zh', //设置语言
        uploadUrl : uploadUrl, //上传的地址
        allowedFileExtensions : ['jpg','jpeg','gif','png','bmp'],//接收的文件后缀
        showUpload : true, //是否显示上传按钮
        showCaption : true,//是否显示标题
        browseClass : "btn btn-primary", //按钮样式
        dropZoneEnabled: false,//是否显示拖拽区域
        //minImageWidth: 50, //图片的最小宽度
        //minImageHeight: 50,//图片的最小高度
        //maxImageWidth: 1000,//图片的最大宽度
        //maxImageHeight: 1000,//图片的最大高度
        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
        //minFileCount: 0,
        maxFileCount : 1, //表示允许同时上传的最大文件个数
        enctype : 'multipart/form-data',
        validateInitialCount : true,
        previewFileIcon : "<i class='glyphicon glyphicon-king'></i>",
        msgFilesTooMany : "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
    });
}
return oFile;
}
</script>