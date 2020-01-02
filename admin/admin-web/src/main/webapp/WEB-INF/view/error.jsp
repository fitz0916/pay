<%@ page contentType="text/html; charset=utf-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>系统错误</title>
</head>
<body>
<% Exception e = null != exception ? (Exception) exception : (Exception)request.getAttribute("ex"); %>
<h2>错误: <%= e.getClass().getSimpleName()%></h2>
<hr />
<h5>错误描述：</h5>
<%= e.getMessage()%>
<h5>错误信息：</h5>
<pre>
<% e.printStackTrace(new java.io.PrintWriter(out)); %>
</pre>
</body>
<script>
    if (self != top) {
        top.location.href = location.href;
    }
</script>
</html>