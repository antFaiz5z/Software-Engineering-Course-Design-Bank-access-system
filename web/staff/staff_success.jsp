<%@ page import="com.jfinal.plugin.activerecord.Record" %>
<%@ page import="constant.Constant" %>
<%@ page import="service.UserService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/27
  Time: 17:55
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

    String activity = request.getParameter("activity");
    String history_id = request.getParameter("history_id");
    Record history = UserService.getHistoryById(history_id);
%>
<% SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd,HH:mm:ss");%>

<html>
<head>
    <title>管理-操作成功</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"/>
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.js"></script>
    <script type="text/javascript" language="JavaScript" src="../js/back_disabled.js"></script>
    <script type="text/javascript" language="JavaScript">
        function back(){
            window.location.href="${base_path}/staff/manage";
        }
    </script>
</head>
<body style="padding-top: 65px;">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand">银行存取系统</a>
    </div>
    <div>
        <ul class="nav navbar-nav">
            <li><a href="${base_path}/staff/staff_manage.jsp">储户信息</a></li>
            <li><a href="${base_path}/staff/staff_withdrawal.jsp">取款</a></li>
            <li><a href="${base_path}/staff/staff_current_deposit.jsp">活期存款</a></li>
            <li><a href="${base_path}/staff/staff_fixed_deposit.jsp">定期存款</a></li>
            <li><a href="${base_path}/staff/staff_cancel_user.jsp">销户</a></li>
            <li><a href="${base_path}/staff/userLogout">退出此储户登录</a></li>
            <p class="nav navbar-nav navbar-text">当前储户: <a href="${base_path}/staff/staff_manage.jsp"><%=user.get("user_name")%></a></p>

        </ul>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-6">
            <div class="alert alert-success">操作成功！很好地完成了提交。</div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div align="left">
                        <button class="btn btn-default btn-sm" onclick="back()">&slarr;&nbsp;返回</button>
                        <div align="center">
                            <% if (activity.equals("withdrawal")){%>
                            <h4>取款账单</h4>
                            <% }%>
                            <% if (activity.equals("currentDeposit")){%>
                            <h4>活期存款账单</h4>
                            <% }%>
                            <% if (activity.equals("fixedDeposit")){%>
                            <h4>定期存款账单</h4>
                            <% }%>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <% if (activity.equals("withdrawal")){%>
                    <p>账单号：<%= history.get(Constant.HISTORY_ID)%></p>
                    <p>储户账号：<%= user.get(Constant.USER_ID)%></p>
                    <p>账户余额：<%= user.get(Constant.USER_BALANCE)%></p>
                    <p>取款金额：<%= history.get(Constant.HISTORY_AMOUNT)%></p>
                    <p>取款时间：<%= simpleDateFormat.format(Long.parseLong(history.get(Constant.HISTORY_DATE).toString()))%></p>
                    <% }%>
                    <% if (activity.equals("currentDeposit")){%>
                    <p>账单号：<%= history.get(Constant.HISTORY_ID)%></p>
                    <p>储户账号：<%= user.get(Constant.USER_ID)%></p>
                    <p>余额：<%= user.get(Constant.USER_BALANCE)%></p>
                    <p>活期存款金额：<%= history.get(Constant.HISTORY_AMOUNT)%></p>
                    <p>活期存款时间：<%= simpleDateFormat.format(Long.parseLong(history.get(Constant.HISTORY_DATE).toString()))%></p>
                    <% }%>
                    <%
                        if (activity.equals("fixedDeposit")){
                            Record fd = UserService.getFixedDepositById(request.getParameter("fd_id"));
                    %>
                    <p>账单号：<%= history.get(Constant.HISTORY_ID)%></p>
                    <p>储户账号：<%= user.get(Constant.USER_ID)%></p>
                    <p>余额：<%= user.get(Constant.USER_BALANCE)%></p>
                    <p>定期存款金额：<%= history.get(Constant.HISTORY_AMOUNT)%></p>
                    <p>类型：<% if (fd.getInt(Constant.FD_TYPE)==0){%>半年期<% }else{%>一年期<% }%></p>
                    <p>开始时间：<%= simpleDateFormat.format(Long.parseLong(fd.get(Constant.FD_START_DATE).toString()))%></p>
                    <p>结束时间：<%= simpleDateFormat.format(Long.parseLong(fd.get(Constant.FD_END_DATE).toString()))%></p>
                    <p>预计收益：<%= fd.get(Constant.FD_INCOME)%></p>
                    <% }%>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
