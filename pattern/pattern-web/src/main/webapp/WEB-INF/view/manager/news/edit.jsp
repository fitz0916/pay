<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="createDialog" class="crudDialog">
	<form id="createForm" method="post">
		<div class="row">
			<div class="col-md-12" id="createOrupdate">
				<div class="form-group" style="margin-top: 7px;">
					<div class="row">
						<div class="col-md-1">
		                    <h5>&nbsp;&nbsp;&nbsp;&nbsp;标题:</h5>
		                </div>
						<div class="col-md-6">
							<input type="hidden" id="newsId" value=""/>
							<input id="title" type="text" class="form-control" name="title" maxlength="255">
						</div>
						<div class="col-md-1">
		                    <h5>&nbsp;&nbsp;&nbsp;&nbsp;作者:</h5>
		                </div>
						<div class="col-md-2">
							<input id="author" type="text" class="form-control" name="author" maxlength="60">
							<input id="newsId" type="hidden" name="newsId" maxlength="90">
						</div>
						<div class="col-md-2">
							<a onclick="createSubmit()" class="btn btn-success" style="margin-left:-12px;" >保存</a>
							<a onclick="reset()" class="btn btn-danger" style="margin-left:10px;">清空</a>
						</div>
					</div>
					
					<div class="row" style="margin-top: 13px;">
						<div class="col-md-12">
							<script id="formContent" type="text/plain" style="width:1024px;height:500px;"></script>
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

