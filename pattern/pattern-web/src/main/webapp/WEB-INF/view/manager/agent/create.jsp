<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
	<div class="row">
		<div class="col-sm-6">
		<div class="form-group">
			<label for="agentName">代理商名称：</label>
			<input id="agentName" type="text" class="form-control" name="agentName" maxlength="50">
		</div>
		<div class="radio">
			<div class="radio radio-inline radio-info">
				<input id="type_0" type="radio" name="type" value="0" checked>
				<label for="type_0" >个体工商户 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="type_1" type="radio" name="status" value="1">
				<label for="type_1" >公司/企业 </label>
			</div>
		</div>
		<div class="radio" class="col-sm-5">
			<div class="radio radio-inline radio-info">
				<input id="status_1" type="radio" name="status" value="1" checked>
				<label for="status_1">启用 </label>
			</div>
			<div class="radio radio-inline radio-danger">
				<input id="status_0" type="radio" name="status" value="0">
				<label for="status_0">锁定 </label>
			</div>
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
		<div class="form-group">
			<label for="qq">QQ：</label>
			<input id="qqId" type="text" class="form-control" name="qq" maxlength="15">
		</div>
		<div class="form-group">
			<label for="businessLicense">营业执照号：</label>
			<input id="businessLicense" type="text" class="form-control" name="businessLicense" maxlength="50">
		</div>	
	</div>
		
	<div class="col-sm-6">
		<div class="form-group" class="col-sm-6">
		    <div class="col-sm-4">
		    	<label for="file">身份证正面：</label>
		    </div>
			<div class="col-sm-6" style="margin-top:20px;bottom:20px">
				<input type="hidden" name="idCardFrontPath" id="idCardFrontPath">
			     <img id="idCardFrontPathImg" class="cover-radius"  src="${basePath}/resources/uploadifive/upload.png"
						                           width="100%" style="cursor: pointer;" />
					
			    <input  id="idCardFrontPathFile" name="file" type="file" onchange="upload_IdCardFont(this)"
						                           style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; opacity: 0; cursor: pointer;"/>
			</div>
		</div>	
		 <div class="form-group" class="col-sm-6">
				<div class="col-sm-4">
			  		 <label for="file">身份证反面：</label>
				</div>
			<div class="col-sm-6" style="margin-top:20px;bottom:20px">
			     <input type="hidden" name="idCardBackPath" id="idCardBackPath">
			     <img id="idCardBackPathImg"  class="cover-radius"  src="${basePath}/resources/uploadifive/upload.png"
						                           width="100%" style="cursor: pointer;" />
			    <input id="idCardBackPathFile"  name="file" type="file" onchange="upload_IdCardBack(this)"
						                           style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; opacity: 0; cursor: pointer;"/>
			</div>
		</div>	
		
		<div class="form-group" class="col-sm-6">
			 <div class="col-sm-4">
			  		 <label for="file">营业执照：</label>
				</div>
			<div class="col-sm-6" style="margin-top:20px;bottom:20px">
				<input type="hidden" name="companyPicPath" id="companyPicPath">
			     <img id="companyPicPathImg" class="cover-radius"  src="${basePath}/resources/uploadifive/upload.png"
						                           width="100%" style="cursor: pointer;" />
			    <input id="companyPicPathFile" name="file" type="file" onchange="upload_CompanyPic(this)"
						                           style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; opacity: 0; cursor: pointer;"/>
			    <small class="help-block cover-tips" style="color: #dd4b39;display: none;">请上传照片</small>
			</div>
		</div>			
	</div>
	</div>
					
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
		</div>
	</form>
</div>
<script type="text/javascript">


function upload_IdCardFont(obj) {
    ajax_upload(obj.id, function(result) { //function(data)是上传图片的成功后的回调方法
    	if(result.code == 1){
            $('#idCardFrontPath').val(result.data);
            $('#idCardFrontPathImg').attr('src',result.data);
    	}else{
    		layer.msg(result.msg);
    	}
        
    });
}

function upload_IdCardBack(obj) {
    ajax_upload(obj.id, function(result) { //function(data)是上传图片的成功后的回调方法
    	if(result.code == 1){
            $('#idCardBackPath').val(result.data);
            $('#idCardBackPathImg').attr('src',result.data);
    	}else if(result.code == '10110'){
        	layer.msg(result.msg);
            location:top.location.href = '${basePath}/login';
        }else{
    		layer.msg(result.msg);
    	}
        
    });
}

function upload_CompanyPic(obj) {
    ajax_upload(obj.id, function(result) { //function(data)是上传图片的成功后的回调方法
    	if(result.code == 1){
            $('#companyPicPath').val(result.data);
            $('#companyPicPathImg').attr('src',result.data);
    	}else{
    		layer.msg(result.msg);
    	}
        
    });
}

function ajax_upload(fileId, callback) { //具体的上传图片方法
    if (image_check(fileId)) { //自己添加的文件后缀名的验证
        $.ajaxFileUpload({
            fileElementId: fileId,    //需要上传的文件域的ID，即<input type="file">的ID。
            url:'${basePath}/manage/agent/upload', //后台方法的路径
            type: 'post',   //当要提交自定义参数时，这个参数要设置成post
            dataType: 'json',   //服务器返回的数据类型。可以为xml,script,json,html。如果不填写，jQuery会自动判断。
            success: function(data) {   //提交成功后自动执行的处理函数，参数data就是服务器返回的数据。
                if (callback) callback.call(this, data);
            },
            error: function(data, status, e) {  //提交失败自动执行的处理函数。
                console.error(e);
            }
        });
    }
}
function image_check(feid) { //自己添加的文件后缀名的验证
    var img = document.getElementById(feid);
    return /.(jpg|png|jpeg)$/.test(img.value)?true:(function() {
       // modals.info('图片格式仅支持jpg、png、gif、bmp格式，且区分大小写。');
        layer.msg('图片格式仅支持jpg、png、jpeg格式，且区分大小写');
        return false;
    })();
}

function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/manage/agent/create',
        data: $('#createForm').serialize(),
        beforeSend: function() {
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
				$agentTable.bootstrapTable('refresh');
			}
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
			$.confirm({
				theme: 'dark',
				animation: 'rotateX',
				closeAnimation: 'rotateX',
				title: false,
				content: textStatus,
				buttons: {
					confirm: {
						text: '确认',
						btnClass: 'waves-effect waves-button waves-light'
					}
				}
			});
        }
    });
}
</script>