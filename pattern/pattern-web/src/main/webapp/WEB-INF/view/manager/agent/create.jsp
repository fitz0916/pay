<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../../../common/inc/head.jsp" flush="true"/>
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
			<div class="col-sm-3">
				<div class="form-group">
					<div class="fg-line">
						<c:if test="${role==1}">
						<div class="row" style="margin-bottom: 6px;">
							<div class="col-sm-4" style="margin-top:-6px;">
								<h4>所属代理:</h4>
							</div>
							<div class="col-sm-8" style="margin-left: -44px;">
								<div class="form-group">
									<select id="formParentId" name="parentId" class="form-control" >
										<option value="0">请选择</option>
										<c:forEach var="temp" items="${agentlist}">
											<option value="${temp.agentId}">
													${temp.companyName}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						</c:if>
						<div class="cMaringB">
							性质：
							<input id="quale1" type="radio" name="quale" value="1" style="margin-left: 11px;" checked>
							个体工商户
							<input id="quale2" type="radio" name="quale" value="2" style="margin-left: 11px;">
							公司/企业
						</div>
						<div class="form-group">
							<label for="companyName">名称</label>
							<input type="hidden" id="role" name="role" value="${role}">
							<input id="companyName" type="text" class="form-control" name="companyName" maxlength="50">
						</div>
						<div class="form-group">
							<label for="businessLicense">证件号码</label>
							<input id="businessLicense" type="text" class="form-control" name="businessLicense" maxlength="50">
						</div>			
						<div class="form-group">
							<label for="address">联系地址</label>
							<input id="address" type="text" class="form-control" name="address" maxlength="60">
						</div>
						<div class="form-group" style="margin-bottom:<c:if test="${role==1}">74</c:if><c:if test="${role==0}">128</c:if>px;">
							<label for="trade">行业</label>
							<input id="trade" type="text" class="form-control" name="trade" maxlength="30">
						</div>
						<div class="form-group">
							企业三证合一
					        <input id="file-companyPicPath" type="file" name="files">
							<input id="companyPicPath" type="hidden" class="form-control" name="companyPicPath" maxlength="50">
						</div>	
					</div>
				</div>
			</div>
			
			<div class="col-sm-3">
				<div class="form-group">
					<div class="fg-line">
						<div class="cMaringB">
							银行账户类型：
							<input id="custType1" type="radio" name="custType" value="1" style="margin-left: 11px;" checked>
							对公账户
							<input id="custType2" type="radio" name="custType" value="2" style="margin-left: 11px;">
							个人账户
						</div>
						<div class="form-group">
							<label for="openBank">开户银行名称</label>
							<input id="openBank" type="text" class="form-control" name="openBank" maxlength="40">
						</div>
						<div class="form-group">
							<label for="bankNum">开户银行行号</label>
							<input id="bankNum" type="text" class="form-control" name="bankNum" maxlength="30">
						</div>
						<div class="form-group">
							<label for="bankCardNo">银行账户号码</label>
							<input id="bankCardNo" type="text" class="form-control" name="bankCardNo" maxlength="30">
						</div>
						<div class="form-group">
							<label for="bankName">银行账户名称</label>
							<input id="bankName" type="text" class="form-control" name="bankName" maxlength="25">
						</div>
						<div class="form-group">
							<label for="companyPhone">代付手机号码</label>
							<input id="companyPhone" type="text" class="form-control" name="companyPhone" maxlength="11" onpaste="return false" onkeyup="value=value.replace(/[^\d]/g,'')">
						</div>
						<div class="form-group">
							<label for="secretKey">接口密钥</label>
							<input id="secretKey" type="text" class="form-control" name="secretKey" maxlength="50">
						</div>
						<div class="form-group">
							银行开户许可证
					        <input id="file-photo" type="file" name="files">
							<input id="photo" type="hidden" class="form-control" name="photo" maxlength="50">
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-3">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<label for="useruserName">用户名</label>
							<input id="useruserName" type="text" class="form-control" name="user.userName" maxlength="20" value="">
						</div>
						<div class="form-group">
							<label for="userpassword">登录密码</label>
							<input id="userpassword" type="text" class="form-control" onfocus="this.type='password'" name="user.password" maxlength="32" value="">
						</div>
						<div class="form-group">
							<label for="cipher">支付密码</label>
							<input id="cipher" type="text" class="form-control" onfocus="this.type='password'" name="cipher" maxlength="50">
						</div>
						<div class="form-group">
							<label for="name">联系人姓名</label>
							<input id="name" type="text" class="form-control" name="name" maxlength="20">
						</div>
						<div class="form-group">
							<label for="phone">联系人手机</label>
							<input id="phone" type="text" class="form-control" name="phone" maxlength="11" onpaste="return false" onkeyup="value=value.replace(/[^\d]/g,'')">
						</div>
						<div class="form-group">
							<label for="email">联系人邮箱</label>
							<input id="email" type="text" class="form-control" name="email" maxlength="30">
						</div>
						<div class="form-group" style="margin-bottom:20px;">
							<label for="qq">联系人QQ</label>
							<input id="qq" type="text" class="form-control" name="qq" maxlength="15" onpaste="return false" onkeyup="value=value.replace(/[^\d]/g,'')">
						</div>
						<div class="form-group">
							身份证正面
					        <input id="file-idcardPicPathA" type="file" name="files">
							<input id="idcardPicPathA" type="hidden" class="form-control" name="idcardPicPathA" maxlength="50">
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<label for="pushTimes">推送消息最大次数</label>
							<input id="pushTimes" type="text" class="form-control" name="pushTimes" maxlength="2" value="5" onpaste="return false" onkeyup="value=value.replace(/[^\d]/g,'')">
						</div>
						<div class="cMaringB">
							启用代付白名单:
							<input id="payoutIpEnabled0" type="radio" name="payoutIpEnabled" value="0" style="margin-left: 11px;" checked>
							不启用
							<input id="payoutIpEnabled1" type="radio" name="payoutIpEnabled" value="1" style="margin-left: 11px;">
							启用
						</div>
						<div class="cMaringB">
							启用支付白名单:
							<input id="payIpEnabled0" type="radio" name="payIpEnabled" value="0" style="margin-left: 11px;" checked>
							不启用
							<input id="payIpEnabled1" type="radio" name="payIpEnabled" value="1" style="margin-left: 11px;">
							启用
						</div>
						<div class="cMaringB">
							节假日出款：
							<input id="isHolidayCash1" type="radio" name="isHolidayCash" value="1" style="margin-left: 11px;" checked>
							允许
							<input id="isHolidayCash0" type="radio" name="isHolidayCash" value="0" style="margin-left: 11px;">
							不允许
						</div>
						<div class="cMaringB">
							支付状态：
							<input type="radio" name="payStatus" value="0" style="margin-left: 11px;" checked>
							启用
							<input type="radio" name="payStatus" value="1" style="margin-left: 11px;">
							禁用
						</div>
						<div class="cMaringB">
							代付状态：
							<input type="radio" name="payoutStatus" value="0" style="margin-left: 11px;" checked>
							启用
							<input type="radio" name="payoutStatus" value="1" style="margin-left: 11px;">
							禁用
						</div>
						<div class="cMaringB" style="margin-bottom:34px">
							代付方式：
							<input type="radio" name="payoutWay" value="0" style="margin-left: 11px;" checked>
							自动代付
							<input type="radio" name="payoutWay" value="1" style="margin-left: 11px;">
							人工代付
						</div>
						<div class="form-group">			
							身份证反面
					        <input id="file-idcardPicPathB" type="file" name="files">
							<input id="idcardPicPathB" type="hidden" class="form-control" name="idcardPicPathB" maxlength="50">
						</div>
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
            url: '${basePath}/agent/create',
            data: $('#createForm').serialize(),
            beforeSend: function() {
				if('${role}'=='1'){
					if($('#formParentId').val()==0){
	    				$('#formParentId').focus();
	    				return false;
					}
				}
    			if ($("input:radio[name='quale']").val() == '') {
    				$("input:radio[name='quale']").focus();
    				return false;
    			}
    			if ($('#companyName').val() == '') {
    				$('#companyName').focus();
    				return false;
    			}
    			if ($('#businessLicense').val() == '') {
    				$('#businessLicense').focus();
    				return false;
    			}
    			if ($('#address').val() == '') {
    				$('#address').focus();
    				return false;
    			}
    			if ($('#trade').val() == '') {
    				$('#trade').focus();
    				return false;
    			}
    			if ($('#openBank').val() == '') {
    				$('#openBank').focus();
    				return false;
    			}
    			if ($('#bankNum').val() == '') {
    				$('#bankNum').focus();
    				return false;
    			}
    			if ($('#bankCardNo').val() == '') {
    				$('#bankCardNo').focus();
    				return false;
    			}
    			if ($('#bankName').val() == '') {
    				$('#bankName').focus();
    				return false;
    			}
    			if ($('#companyPhone').val() == '') {
    				$('#companyPhone').focus();
    				return false;
    			}
    			if($("#companyPhone").val() != ''){
                    var mobileRegex = /^[1][0-9]{10}$/;
                    if(!mobileRegex.test($("#companyPhone").val())){
                        layer.msg('手机号码格式不正确',{icon:0,time:2000});
        				$('#companyPhone').focus();
                        return false;
    				}
    			}
    			if ($('#secretKey').val() == '') {
    				$('#secretKey').focus();
    				return false;
    			}
				if ($('#useruserName').val() == '') {
    				$('#useruserName').focus();
    				return false;
    			}
    			if ($('#userpassword').val() == '') {
    				$('#userpassword').focus();
    				return false;
    			}   
    			
    			
    			 			
    			if ($('#cipher').val() == '') {
    				$('#cipher').focus();
    				return false;
    			}
    			if ($('#name').val() == '') {
    				$('#name').focus();
    				return false;
    			}
    			if ($('#phone').val() == '') {
    				$('#phone').focus();
    				return false;
    			}
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
    			if ($('#qq').val() == '') {
    				$('#qq').focus();
    				return false;
    			}
    			if ($('#pushTimes').val() == '') {
    				$('#pushTimes').focus();
    				return false;
    			}
    			if ($('#companyPicPath').val() == '') {
                	layer.alert("请上传企业三证合一照片",{icon:7});
    				return false;
    			}
    			if ($('#photo').val() == '') {
                	layer.alert("请上传银行开户许可证照片",{icon:7});
    				return false;
    			}
    			if ($('#idcardPicPathA').val() == '') {
                	layer.alert("请上传身份证正面照片",{icon:7});
    				return false;
    			}
    			if ($('#idcardPicPathB').val() == '') {
                	layer.alert("请上传身份证反面照片",{icon:7});
    				return false;
    			}
            },
            success: function(result) {
    			if (result.model.code == 1) {
                    layer.msg("新增成功",{icon:1,time:1000},function () {
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
