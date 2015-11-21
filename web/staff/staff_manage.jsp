<%@ page import="com.jfinal.plugin.activerecord.Record" %>
<%@ page import="constant.Constant" %>
<%@ page import="service.UserService" %>
<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/15
  Time: 18:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "No-cache");

    String staff_user_id = (String) session.getAttribute("staff_user_id");
    if (staff_user_id == null) {
        response.sendRedirect("home");
    }
    Record user = UserService.getUserByID(staff_user_id);
%>
<html>
<head>
    <title>管理-操作</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"/>
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.js"></script>
    <script type="text/javascript" language="JavaScript" src="../js/back_disabled.js"></script>

</head>
<body style="padding-top: 65px;">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand">银行存取系统</a>
    </div>
    <div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="${base_path}/staff/staff_manage.jsp">储户信息</a></li>
            <li><a href="${base_path}/staff/staff_withdrawal.jsp">取款</a></li>
            <li><a href="${base_path}/staff/staff_current_deposit.jsp">活期存款</a></li>
            <li><a href="${base_path}/staff/staff_fixed_deposit.jsp">定期存款</a></li>
            <li><a href="${base_path}/staff/staff_cancel_user.jsp">销户</a></li>
            <li><a href="${base_path}/staff/userLogout">退出此储户登录</a></li>
            <p class="nav navbar-nav navbar-text">当前储户: <a href="${base_path}/staff/staff_manage.jsp"><%=user.get("user_name")%>
            </a></p>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>储户信息：</h4>
                </div>
                <div class="panel-body">
                    <p>账号：  <%= staff_user_id%>
                    </p>

                    <p>姓名：<%= user.get(Constant.USER_NAME)%>
                    </p>

                    <p>身份证号：  <%= user.get(Constant.USER_IDCARD)%>
                    </p>

                    <p>余额：  <%= user.get(Constant.USER_BALANCE)%>
                    </p>

                    <p>未结算利息：  <%= user.get(Constant.USER_INTEREST)%>
                    </p>

                    <p>账户类型：  <% if (user.get(Constant.USER_TYPE).toString().equals("0")) {%>
                        普通储户
                        <%} else {%>
                        金卡储户
                        <%}%>
                    </p>

                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
