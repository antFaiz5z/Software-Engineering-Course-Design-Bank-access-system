<%@ page import="com.jfinal.plugin.activerecord.Record" %>
<%@ page import="service.UserService" %>
<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/15
  Time: 22:23
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
    <title>管理-取款</title>
    <link rel="stylesheet" type="text/css" href="../css/custom.css"/>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"/>
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.js"></script>
    <script type="text/javascript" language="JavaScript" src="../js/back_disabled.js"></script>
    <script type="text/javascript" src="../js/Validform_v5.3.2.js"></script>
    <script type="text/javascript" language="JavaScript">
        $(function () {
            $(".ValidForm").Validform({
                tiptype: 2,
                datatype: {
                    n: /^[0-9]{1,20}$/,
                    n6: /^[0-9]{6}$/
                }
            });
        })
    </script>
    <script type="text/javascript" language="JavaScript">
        function back() {
            window.location.href = "${base_path}/staff/manage";
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
            <li class="active"><a href="${base_path}/staff/staff_withdrawal.jsp">取款</a></li>
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
                    <div align="left">
                        <button class="btn btn-default btn-sm" onclick="back()">&slarr;&nbsp;返回</button>
                        <div align="center">
                            <h4>活期存款</h4>
                        </div>
                    </div>

                </div>
                <div class="panel-body">
                    <div align="center">
                        <form class="form-horizontal ValidForm" action="withdrawal" method="post">

                            <div class="form-group ">
                                <label class="col-sm-3 control-label">取款金额：</label>

                                <div class="col-sm-8">
                                    <input type="text" class="form-control" placeholder="应大于余额"
                                           name="withdrawal_amount" datatype="n" errormsg="金额为数字"/>
                                </div>
                                <div class="col-sm-5 col-sm-offset-2 Validform_checktip"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-1">
                                    <button type="submit" class="btn btn-primary">确认</button>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="reset" class="btn btn-default">重置</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<%--<form action="withdrawal" method="post">

    <p>取款金额：<input type="text" name="withdrawal_amount"/></p>
    <p><input type="submit" value="确认"/></p>
</form>--%>
</body>
</html>
