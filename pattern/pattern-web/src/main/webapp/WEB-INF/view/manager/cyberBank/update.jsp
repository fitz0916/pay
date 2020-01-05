<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<jsp:include page="../../common/inc/head.jsp" flush="true"/>
<div id="updateDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<input id="file-Portrait1" type="file" name="files">
						</div>
						<div class="form-group" style="margin-left: 28px;">
							<span class="active">银行Logo：</span> 
							<img id="photo_img" src='${cyberBank.bankLogo}' style="width:126px;height:36px;"/>
							<input id="bankLogo" type="hidden" class="form-control" name="bankLogo" maxlength="100" value="${cyberBank.bankLogo}" readonly>
							<br/>
						</div>
						<div class="form-group">
							<label for="bankName">银行名称</label>
							<input id="bankName" type="text" class="form-control" name="bankName" maxlength="20" value="${cyberBank.bankName}">
						</div>
						<div class="form-group">
							<label for="bankNum">银行编码</label>
							<input id="bankNum" type="text" class="form-control" name="bankNum" maxlength="20" value="${cyberBank.bankNum}">
						</div>
						<div class="form-group">
							<label for="notes">描述</label>
							<input id="notes" type="text" class="form-control" name="notes" maxlength="255" value="${cyberBank.notes}">
						</div>
						<div class="radio">
							<div class="radio radio-inline radio-success">
								<input id="bankType_1" type="radio" name="bankType" value="1" style="margin-left: 11px;" <c:if test="${cyberBank.bankType==1}">checked</c:if>>
								<label for="bankType_1">借记卡</label>
							</div>
							<div class="radio radio-inline radio-info">
								<input id="bankType_2" type="radio" name="bankType" value="2" style="margin-left: 11px;" <c:if test="${cyberBank.bankType==2}">checked</c:if>>
								<label for="bankType_2">信用卡</label>
							</div>
						<div class="radio">
						</div>
							<div class="radio radio-inline radio-success">
								<input id="available_1" type="radio" name="available" value="1" style="margin-left: 11px;" <c:if test="${cyberBank.available==1}">checked</c:if>>
								<label for="available_1">启用</label>
							</div>
							<div class="radio radio-inline radio-info">
								<input id="available_0" type="radio" name="available" value="0" style="margin-left: 11px;" <c:if test="${cyberBank.available==0}">checked</c:if>>
								<label for="available_0">禁用</label>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group text-right dialog-buttons">
					<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
					<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
				</div>
			</div>
		</div>
	</form>
</div>
<jsp:include page="../../common/inc/dialog_footer.jsp" flush="true"/>
<script>
//文件上传
$(document).on('ready', function() {
	//初始化fileinput
    var oFileInput = new FileInput();
    oFileInput.Init("file-Portrait1", "${basePath}/upload/cyberBank/img");   
	//回调函数
	$("#file-Portrait1").on("fileuploaded",function(event, data, previewId, index) {
        var data = data.response.data;
        $('#bankLogo').val(data)
	    $('#photo_img').attr("src", data);
	});
});



//初始化fileinput
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



function createSubmit() {
    $.ajax({
        type: 'post',
        url: '${basePath}/cyberBank/update/${cyberBank.cyberBankId}',
        data: $('#updateForm').serialize(),
        beforeSend: function() {
            if ($('#bankName').val() == '') {
                $('#bankName').focus();
                return false;
            }
            if ($('#bankNum').val() == '') {
                $('#bankNum').focus();
                return false;
            }
            if ($('#bankLogo').val() == '') {
            	layer.alert("请上传银行Logo",{icon:7});
				return false;
			}
        },
        success: function(result) {
        	if (result.model.code == 1) {
                layer.msg(result.model.data,{icon:1,time:1000},function () {
                	updateDialog.close();
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