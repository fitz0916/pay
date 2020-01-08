<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
	<style type="text/css">
	.cMaringB{
	    margin-bottom: 33px;
	}
	.cMaringB-combo{
	    margin-bottom: 26px;
	}
	</style>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
		<div class="row">
			<div class="col-sm-5">
						<div class="cMaringB">
							性质：
							<input id="type1" type="radio" name="type" value="1" style="margin-left: 11px;" checked>
							个体工商户
							<input id="type2" type="radio" name="type" value="2" style="margin-left: 11px;">
							公司/企业
						</div>
						<div class="form-group">
							<label for="agentName">代理商名称：</label>
							<input id="agentNameId" type="text" class="form-control" name="agentName" maxlength="50">
						</div>
						<div class="form-group">
							<label for="address">联系地址：</label>
							<input id="address" type="text" class="form-control" name="address" maxlength="60">
						</div>
						<div class="form-group">
							<label for="phone">手机号码：</label>
							<input id="phone" type="text" class="form-control" name="phone" maxlength="60">
						</div>
						<div class="form-group">
							<label for="email">邮箱：</label>
							<input id="email" type="text" class="form-control" name="email" maxlength="60">
						</div>
						<div class="form-group">
							<label for="wechat">微信：</label>
							<input id="wechat" type="text" class="form-control" name="wechat" maxlength="60">
						</div>
			</div>
			<div class="col-sm-5">
					    <div class="cMaringB">
							状态：
							<input type="radio" name="status" value="1" style="margin-left: 11px;" checked>
							启用
							<input type="radio" name="status" value="2" style="margin-left: 11px;">
							禁用
						</div>	
						<div class="form-group">
							<label for="businessLicense">营业执照号：</label>
							<input id="businessLicense" type="text" class="form-control" name="businessLicense" maxlength="50">
						</div>	
						<div class="form-group">
							<label for="qq">QQ：</label>
							<input id="qqId" type="text" class="form-control" name="qq" maxlength="15">
						</div>	
						<div class="form-group">
							公司营业执照照片：
							<input id="companyPicPathId" type="file" name="files">
							<input id="companyPicPath" type="hidden" class="form-control" name="companyPicPath" maxlength="50">
						</div>
						
						<div class="form-group">			
							身份证正面：
					        <input id="idCardFrontPathId" type="file" name="files">
							<input id="idCardFrontPath" type="hidden" class="form-control" name="idCardFrontPath" maxlength="50">
						</div>
						<div class="form-group">			
							身份证反面：
					        <input id="idCardBackPathId" type="file" name="files">
							<input id="idCardBackPath" type="hidden" class="form-control" name="idCardBackPath" maxlength="50">
						</div>
			</div>
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
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

    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/manage/agent/create',
            data: $('#createForm').serialize(),
            beforeSend: function() {
    			if($("#phone").val() != ''){
                    var mobileRegex = /^[1][0-9]{10}$/;
                    if(!mobileRegex.test($("#phone").val())){
                        layer.msg('手机号码格式不正确',{icon:0,time:2000});
        				$('#phone').focus();
                        return false;
    				}
    			}
    			if ($('#email').val() == '') {
    				$('#email').focus();
    				return false;
    			}
    			if($("#email").val() != ''){
                    var emailRegex = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
                    if(!emailRegex.test($("#email").val())){
                        layer.msg('邮箱格式不正确',{icon:0,time:2000});
                        return false;
    				}
    			}
    			
            },
            success: function(result) {
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
    				createDialog.close();
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
