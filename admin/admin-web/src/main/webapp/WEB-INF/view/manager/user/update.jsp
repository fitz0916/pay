<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<head>
<style type="text/css">
.cinput{
	margin-left: -40px !important;
}
</style>
</head>
<div id="updateDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<div class="row">
		   <!-- 
			<div class="col-sm-4">
				<div class="form-group">
					<div class="fg-line">
						<ul id="ztree1" class="ztree"></ul>
					</div>
				</div>
			</div>
			 -->
			<div class="col-sm-8">
				<!-- 
				<div class="form-group">
					<input id="file-Portrait1" type="file" name="files">
				</div>
				 -->
				<div class="form-group">
					<div class="fg-line">
						<div class="form-group">
							<label for="userName">帐号</label>
							<input id="userName" type="text" class="form-control" name="userName" maxlength="20" value="${user.userName}" readonly>
						</div>
						<div class="form-group">
							<label for="realName">姓名</label>
							<input id="realName" type="text" class="form-control" name="realName" maxlength="20" value="${user.realName}">
						</div>
						<div class="form-group">
							<label for="avatar">头像</label>
							<input id="avatar" type="text" class="form-control" name="avatar" maxlength="150" value="${user.avatar}" readonly>
						</div>
						<div class="form-group">
							<label for="phone">电话</label>
							<input id="phone" type="text" class="form-control" name="phone" maxlength="20" value="${user.phone}">
						</div>
						<div class="form-group">
							<label for="email">邮箱</label>
							<input id="email" type="text" class="form-control" name="email" maxlength="50" value="${user.email}">
						</div>
						<div id="radio">
							<div class="radio radio-inline radio-info">
								<input id="sex_1" class="cinput" type="radio" name="sex" value="1" <c:if test="${user.sex==1}">checked</c:if>>
								<label for="sex_1" style="width: 20px">男 </label>
							</div>
							<div class="radio radio-inline radio-danger">
								<input id="sex_0"  class="cinput" type="radio" name="sex" value="0" <c:if test="${user.sex==0}">checked</c:if>>
								<label for="sex_0" style="width: 30px">女 </label>
							</div>
							<div class="radio radio-inline radio-success">
								<input id="locked_0"  class="cinput" type="radio" name="locked" value="0" <c:if test="${user.locked==0}">checked</c:if>>
								<label for="locked_0">正常 </label>
							</div>
							<div class="radio radio-inline">
								<input id="locked_1"  class="cinput" type="radio" name="locked" value="1" <c:if test="${user.locked==1}">checked</c:if>>
								<label for="locked_1">锁定 </label>
							</div>
							<!--  
							<div class="radio radio-inline radio-success">
								<input id="user_tye_0"  class="cinput" type="radio" name="userType" value="0" <c:if test="${user.userType==0}">checked</c:if>>
								<label for="user_tye_0">管理员 </label>
							</div>
							<div class="radio radio-inline radio-info" style="width: 15%">
								<input id="user_tye_1"  class="cinput" type="radio" name="userType" value="1" <c:if test="${user.userType==1}">checked</c:if>>
								<label for="user_tye_1">普通用户</label>
							</div>
							-->
						</div>

					</div>
				</div>
			</div>
		</div>
		<div class="form-group text-right dialog-buttons">
			<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
			<a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
		</div>
	</form>
</div>
<jsp:include page="../../common/inc/footer.jsp" flush="true"/>
<script>
	var changeDatas1 = [];
	var agentId = '${user.agentId}';
	var level = '${user.level}';
	if($.trim(agentId) == ''){
		agentId = "-1";
	}
	var setting1 = {
	    check: {
	        enable: true,
	        chkStyle: "radio",
	        radioType: "level"
	    },
	    async: {
	        enable: true,
	        url: '${basePath}/manage/user/updateAgents/'+agentId+'/'+level
	    },
	    data: {
	        simpleData: {
	            enable: true
	        }
	    },
	    callback: {
	        onCheck: function() {
	            var zTree = $.fn.zTree.getZTreeObj("ztree1")
	            var changeNodes = zTree.getChangeCheckedNodes();
	            changeDatas1 = [];
	            for (var i = 0; i < changeNodes.length; i ++) {
	                var changeData = {};
	                changeData.id = changeNodes[i].id;
	                $('#agentId').val(changeData.id);
	                $('#level').val(changeNodes[i].level);
	            }
	        }
	    }
	};
	
	  function initTree() {
	        var type = $("#level").attr("checked")? "level":"all";
	        setting1.check.radioType = type;
	        $.fn.zTree.init($('#ztree1'), setting1);
	    }
	 
    function isPoneAvailable(str) {
        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
        if (!myreg.test(str)) {
            return false;
        } else {
            return true;
        }
    }

    function checkEmail(str){
        var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
        if(re.test(str)){
            return true;
        }else{
            return false;
        }
    }

    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/manage/user/update/${user.userId}',
            data: $('#updateForm').serialize(),
            beforeSend: function() {
            	if($('#agentId').val() == ''){
            		layer.msg('请选择左边代理商信息');
            		return false;
            	}
                if ($('#username').val() == '') {
                    $('#username').focus();
                    return false;
                }
                if (!isPoneAvailable($('#phone').val())){
                    layer.msg('手机号格式不正确');
                    return false;
                }
                if (!checkEmail($('#email').val())){
                    layer.msg('邮箱格式不正确');
                    return false;
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
                    }else if(result.code == '10110'){
                    	layer.msg(result.msg);
                        location:top.location.href = '${basePath}/login';
                    }else {
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

    //文件上传
    $(document).on('ready', function() {
        //初始化fileinput
        var oFileInput = new FileInput();
        oFileInput.Init("file-Portrait1", "${basePath}/manage/user/upload");
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
                allowedFileExtensions : [ 'jpg', 'gif', 'png' ],//接收的文件后缀
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

            //导入文件上传完成之后的事件
            $("#file-Portrait1").on("fileuploaded",
                function(event, data, previewId, index) {
                    var data = data.response.data;
                    $('#avatar').val(data)

                });
        }
        return oFile;
    }

</script>
