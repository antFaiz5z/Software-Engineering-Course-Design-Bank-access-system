<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/13
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<html>
<head>
    <title>管理-错误</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"/>
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.js"></script>
</head>
<body class="center" style="padding-top: 65px;">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand">银行存取系统</a>
    </div>
    <div>
        <ul class="nav navbar-nav">
            <li class="active"><a>管理 > 错误</a></li>
        </ul>
    </div>
</nav>
<div style="margin-left: 100px">
    <h3>错误！</h3><a href="${base_path}/staff/home">返回</a>
</div>
</body>
</html>
