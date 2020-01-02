<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="passwordDialog" class="crudDialog">
	<form id="updateForm" method="post">
		<div class="row">
			<div>
				<h4 style="margin-left: 15px">用户名：<span style="color: #1E9FFF">${user.userName}</span></h4>
			</div>
			<div class="form-group" style="margin-left: 15px">
				<label > 设置新密码：</label>
				<input id="newPassword" type="password" class="form-control" name="newPassword" maxlength="20">
			</div>
			<div class="form-group" style="margin-left: 15px">
				<label > 再次输入新密码：</label>
				<input id="repeatPassword" type="password" class="form-control" name="repeatPassword" maxlength="20">
			</div>
			<div class="form-group text-right dialog-buttons" style="margin-right: 10px">
				<a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
				<a class="waves-effect waves-button" href="javascript:;" onclick="passwordDialog.close();">取消</a>
			</div>
		</div>
	</form>
</div>
<script>
    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/manage/user/password/${user.userId}',
            data: $('#updateForm').serialize(),
            beforeSend: function() {
                if ($('#newPassword').val() == '') {
                    $('#newPassword').focus();
                    return false;
                }
                if ($('#repeatPassword').val() == '') {
                    $('#repeatPassword').focus();
                    return false;
                }
                if ($('#newPassword').val() != $('#repeatPassword').val()){
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
                    } else {
                        $.confirm({
                            theme: 'dark',
                            animation: 'rotateX',
                            closeAnimation: 'rotateX',
                            title: false,
                            content: result.data.errorMsg,
                            buttons: {
                                confirm: {
                                    text: '确认',
                                    btnClass: 'waves-effect waves-button waves-light'
                                }
                            }
                        });
                    }
                } else {
                    passwordDialog.close();
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
    $("#newPassword").focus(function(){
        $(this).prev("label").addClass("active");
	})
    $("#newPassword").blur(function(){
        if ($('#newPassword').val()==''){
            $(this).prev("label").removeClass("active");
		}
    })
    $("#repeatPassword").focus(function(){
        $(this).prev("label").addClass("active");
    })
    $("#repeatPassword").blur(function(){
        if ($('#repeatPassword').val()==''){
            $(this).prev("label").removeClass("active");
        }
    })
</script>