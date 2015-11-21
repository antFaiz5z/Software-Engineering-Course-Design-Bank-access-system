<%@ page import="com.jfinal.plugin.activerecord.DbPro" %>
<%@ page import="com.jfinal.plugin.activerecord.Page" %>
<%@ page import="com.jfinal.plugin.activerecord.Record" %>
<%@ page import="constant.Constant" %>
<%@ page import="service.StaffService" %>
<%@ page import="service.UserService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/11
  Time: 21:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma","No-cache");

    String staff_user_id = (String) session.getAttribute("staff_user_id");

    if (staff_user_id!=null){
        response.sendRedirect("manage");
    }
%>
<%
    String staff_id = (String) session.getAttribute("staff_id");
    Record staff = StaffService.getStaffByID(staff_id);

    int pageNumber;
    int pageSize = 10;

    int userCount = (int) UserService.getSizeOfUsers();
    int pageCount = (int) Math.ceil(userCount * 1.000 / pageSize);

    if (request.getParameter("page") != null) {

        pageNumber = Integer.parseInt(request.getParameter("page"));
    } else {
        pageNumber = 1;
    }

    Page<Record> users = DbPro.use().paginate(pageNumber, pageSize, "select * ", " from " + Constant.TABLE_USER);
%>
<% SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");%>

<html>
<head>
    <title>管理-主页</title>
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
    <script language="JavaScript" type="text/javascript">
        function previous() {
            <% if (pageNumber==1){%>
            this.disabled();
            <% }%>
            <% if (pageNumber>1){%>
            window.location.href = "${base_path}/staff/home?page=<%=pageNumber-1%>";
            <% }else{%>
            window.location.href = "${base_path}/staff/home?page=1";
            <% }%>
        }
        function next() {
            <% if (pageNumber==pageCount){%>
            this.disabled();
            <% }%>
            <% if (pageNumber<pageCount){%>
            window.location.href = "${base_path}/staff/home?page=<%=pageNumber+1%>";
            <% }else{%>
            window.location.href = "${base_path}/staff/home?page=<%=pageCount%>";
            <% }%>
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
            <li class="active"><a>管理 > 主页</a></li>
            <li><a href="${base_path}/staff/create" class="btn-warning">开户</a></li>
        </ul>
        <p class="nav navbar-nav navbar-text">当前时间：<%= simpleDateFormat.format(new java.util.Date().getTime()) %>
        </p>

        <p class="nav navbar-nav navbar-text">你好，工作人员<%=staff_id%>：<%=staff.get("staff_name")%>, <a href="${base_path}/staff/logout">退出登录</a></p>

    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-4">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>储户登录</h4>
                </div>
                <div class="panel-body">
                    <div align="center">
                        <form class="form-horizontal ValidForm" action="userLogin" method="post">

                            <div class="form-group">
                                <label class="col-sm-3 control-label">账号：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" placeholder="账号" name="staff_user_id" datatype="n" errormsg="账号为数字"/>
                                </div>
                                <div class="col-sm-5 col-sm-offset-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-8">
                                    <input type="password" class="form-control" placeholder="六位数字" name="staff_user_password" datatype="n6" errormsg="六位数字"/>
                                </div>
                                <div class="col-sm-5 col-sm-offset-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <button type="submit" class="btn btn-primary">登录</button>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="reset" class="btn btn-default" >重置</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <table class="table table-hover">
                <caption><h3>所有储户信息：</h3></caption>
                <thead>
                <tr>
                    <th>账号</th>
                    <th>姓名</th>
                    <th>身份证号</th>
                    <th>账户类型</th>
                    <th>余额</th>
                    <th>未结算利息</th>
                    <th>上次结算利息时间</th>
                </tr>
                </thead>
                <%
                    double interest_add;
                    long now;
                    Long days;
                    for (int i = 0; i < users.getList().size(); i++) {
                        now = new Date().getTime();
                        days = UserService.HowManyDaysFromLastSettle(users.getList().get(i));
                        interest_add = UserService.settleInterestAddButNotAdd(users.getList().get(i), days);
                        UserService.settleInterestAddToInterest(users.getList().get(i), interest_add, now);
                %>
                <tbody>
                <tr>
                    <td><%= users.getList().get(i).get(Constant.USER_ID)%>
                    </td>
                    <td><%= users.getList().get(i).get(Constant.USER_NAME)%>
                    </td>
                    <td><%= users.getList().get(i).get(Constant.USER_IDCARD)%>
                    </td>
                    <td><% if (users.getList().get(i).get(Constant.USER_TYPE).toString().equals("0")) {%>
                        普通储户
                        <% } else {%>
                        金卡储户
                        <% }%>
                    </td>
                    <td><%= users.getList().get(i).get(Constant.USER_BALANCE)%>
                    </td>
                    <td><%= users.getList().get(i).get(Constant.USER_INTEREST)%>
                    </td>
                    <td><%= simpleDateFormat.format(Long.parseLong(users.getList().get(i).get(Constant.USER_LAST_SETTLE_INTEREST_DATE).toString()))%>
                    </td>
                </tr>
                </tbody>
                <% }%>
            </table>
            <ul class="pager">
                <li class="previous"><a onclick="previous()">&larr; 上一页</a></li>
                <li>当前第<%= pageNumber%>/<%= pageCount%>页，共<%= userCount%>条记录</li>
                <li class="next"><a onclick="next()">下一页 &rarr;</a></li>
            </ul>
        </div>
    </div>
</div>
<%--<table>
    <tr>
        <th>账号</th>
        <th>姓名</th>
        <th>身份证号</th>
        <th>账户类型</th>
        <th>余额</th>
        <th>未结算利息</th>
        <th>上次结算利息时间</th>
    </tr>
    <%

        for (int i = 0; i < users.getList().size(); i++) {
            now = new Date().getTime();
            days = UserService.HowManyDaysFromLastSettle(users.getList().get(i));
            interest_add = UserService.settleInterestAddButNotAdd(users.getList().get(i), days);
            UserService.settleInterestAddToInterest(users.getList().get(i), interest_add, now);
    %>
    <tr>
        <td><%= users.getList().get(i).get(Constant.USER_ID)%>
        </td>
        <td><%= users.getList().get(i).get(Constant.USER_NAME)%>
        </td>
        <td><%= users.getList().get(i).get(Constant.USER_IDCARD)%>
        </td>
        <td><% if (users.getList().get(i).get(Constant.USER_TYPE).toString().equals("0")) {%>
            普通储户
            <% } else {%>
            金卡储户
            <% }%>
        </td>
        <td><%= users.getList().get(i).get(Constant.USER_BALANCE)%>
        </td>
        <td><%= users.getList().get(i).get(Constant.USER_INTEREST)%>
        </td>
        <td><%= simpleDateFormat.format(Long.parseLong(users.getList().get(i).get(Constant.USER_LAST_SETTLE_INTEREST_DATE).toString()))%>
        </td>
    </tr>
    <% }%>

</table>

<button onclick="previous()">上一页</button>
<button onclick="next()">下一页</button>

<p>当前第<%= pageNumber%>/<%= pageCount%>页，共<%= userCount%>条记录</p>


<p>用户登录：</p>

<form action="userLogin" method="post">
    <p>账号：<input type="text" name="staff_user_id"/></p>

    <p>密码：<input type="password" name="staff_user_password"/></p>

    <p><input type="submit" value="登录"/></p>
</form>--%>

</body>
</html>
