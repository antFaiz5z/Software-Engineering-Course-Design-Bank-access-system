<%@ page import="com.jfinal.plugin.activerecord.DbPro" %>
<%@ page import="com.jfinal.plugin.activerecord.Page" %>
<%@ page import="com.jfinal.plugin.activerecord.Record" %>
<%@ page import="constant.Constant" %>
<%@ page import="service.UserService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/11
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "No-cache");

%>
<%
    String user_id = (String) session.getAttribute("user_id");
    Record user = UserService.getUserByID(user_id);

    long days = UserService.HowManyDaysFromLastSettle(user);
    double interest_add = UserService.settleInterestAddButNotAdd(user, days);
    long now = new Date().getTime();
    UserService.settleInterestAddToInterest(user, interest_add, now);
    //---------------------------------------------------------------------------------------
    int pageNumberOfHistory;
    int pageSizeOfHistory = 5;

    int historyCount = (int) UserService.getSizeOfHistorysById(user_id);
    int pageCountOfHistory = (int) Math.ceil(historyCount * 1.000 / pageSizeOfHistory);

    if (request.getParameter("history_page") != null) {

        pageNumberOfHistory = Integer.parseInt(request.getParameter("history_page"));
    } else {
        pageNumberOfHistory = 1;
    }

    Page<Record> historys = DbPro.use().paginate(pageNumberOfHistory, pageSizeOfHistory, "select * ",
            " from " + Constant.TABLE_HISTORY + " where " + Constant.USER_ID + " = ?", user_id);
    //---------------------------------------------------------------------------------------
    int pageNumberOfFixedDeposits;
    int pageSizeOfFixedDeposits = 5;

    int fixedDepositsCount = (int) UserService.getSizeOfFixedDepositsById(user_id);
    int pageCountOfFixedDeposit = (int) Math.ceil(fixedDepositsCount * 1.000 / pageSizeOfFixedDeposits);

    if (request.getParameter("fd_page") != null) {

        pageNumberOfFixedDeposits = Integer.parseInt(request.getParameter("fd_page"));
    } else {
        pageNumberOfFixedDeposits = 1;
    }

    Page<Record> deposits = DbPro.use().paginate(pageNumberOfFixedDeposits, pageSizeOfFixedDeposits, "select * ",
            " from " + Constant.TABLE_FIXED_DEPOSIT + " where " + Constant.USER_ID + " = ?", user_id);
%>
<% SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");%>

<html>
<head>
    <title>储户-主页</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"/>
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.js"></script>
    <script type="text/javascript" language="JavaScript" src="../js/back_disabled.js"></script>
    <script language="JavaScript" type="text/javascript">
        function changePassword() {
            window.location.href = "user_change_info.jsp";
        }
        function previous_history() {
            <% if (pageNumberOfHistory==1){%>
            this.disabled();
            <% }%>

            <% if (pageNumberOfHistory>1){%>
            window.location.href = "${base_path}/user/home?history_page=<%=pageNumberOfHistory-1%>&fd_page=<%=pageNumberOfFixedDeposits%>";
            <% }else{%>
            window.location.href = "${base_path}/user/home?history_page=1&fd_page=<%=pageNumberOfFixedDeposits%>";
            <% }%>
        }

        function next_history() {

            <% if (pageNumberOfHistory==pageCountOfHistory){%>
            this.disabled();
            <% }%>
            <% if (pageNumberOfHistory<pageCountOfHistory){%>
            window.location.href = "${base_path}/user/home?history_page=<%=pageNumberOfHistory+1%>&fd_page=<%=pageNumberOfFixedDeposits%>";
            <% }else{%>
            window.location.href = "${base_path}/user/home?history_page=<%=pageCountOfHistory%>&fd_page=<%=pageNumberOfFixedDeposits%>";
            <% }%>
        }
        function previous_fd() {
            <% if (pageNumberOfFixedDeposits==1){%>
            this.disabled();
            <% }%>

            <% if (pageNumberOfFixedDeposits>1){%>
            window.location.href = "${base_path}/user/home?history_page=<%=pageNumberOfHistory%>&fd_page=<%=pageNumberOfFixedDeposits-1%>";
            <% }else{%>
            window.location.href = "${base_path}/user/home?history_page=<%=pageNumberOfHistory%>&fd_page=1";
            <% }%>
        }

        function next_fd() {

            <% if (pageNumberOfFixedDeposits==pageCountOfFixedDeposit){%>
            this.disabled();
            <% }%>
            <% if (pageNumberOfFixedDeposits<pageCountOfFixedDeposit){%>
            window.location.href = "${base_path}/user/home?history_page=<%=pageNumberOfHistory%>&fd_page=<%=pageNumberOfFixedDeposits+1%>";
            <% }else{%>
            window.location.href = "${base_path}/user/home?history_page=<%=pageNumberOfHistory%>&fd_page=<%=pageCountOfFixedDeposit%>";
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
            <li class="active"><a>储户 > 主页</a></li>
        </ul>
        <p class="nav navbar-nav navbar-text">当前时间：<%= simpleDateFormat.format(new java.util.Date().getTime()) %>
        </p>

        <p class="nav navbar-nav navbar-text">你好，储户<%=user.get("user_name")%>, <a href="${base_path}/user/logout">退出登录</a></p>

    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4>您的储户信息：</h4>
                </div>
                <div class="panel-body">
                    <p>账号：  <%= user_id%>
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

                    <p>
                        <button class="btn btn-default btn-sm" onclick="changePassword()">修改密码</button>
                    </p>
                </div>
            </div>
        </div>


        <div class="col-md-8 col-md-offset-0">
            <div class="row">
                <div class="col-md-13" >
                    <table class="table table-hover">
                        <caption><h3>存取款历史记录：</h3></caption>
                        <thead>
                        <tr>
                            <th>记录编号</th>
                            <th>类型</th>
                            <th>金额</th>
                            <th>时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (int i = 0; i < historys.getList().size(); i++) {%>
                        <tr>
                            <td><%= historys.getList().get(i).get(Constant.HISTORY_ID)%>
                            </td>
                            <% if (historys.getList().get(i).getInt(Constant.HISTORY_TYPE) == 0) {%>
                            <td>取款</td>
                            <% } else if (historys.getList().get(i).getInt(Constant.HISTORY_TYPE) == 1) {%>
                            <td>活期存款</td>
                            <% } else if (historys.getList().get(i).getInt(Constant.HISTORY_TYPE) == 2) {%>
                            <td>定期存款</td>
                            <% }%>
                            <td><%= historys.getList().get(i).get(Constant.HISTORY_AMOUNT)%>
                            </td>
                            <td><%= simpleDateFormat.format(Long.parseLong(historys.getList().get(i).get(Constant.HISTORY_DATE).toString()))%>
                            </td>
                            <% }%>
                        </tr>
                        </tbody>
                    </table>
                    <% if (pageCountOfHistory == 0) {%>
                    <p>无</p>
                    <% } else {%>
                    <ul class="pager">
                        <li class="previous"><a onclick="previous_history()">&larr; 上一页</a></li>
                        <li>当前第<%= pageNumberOfHistory%>/<%= pageCountOfHistory%>页，共<%= historyCount%>条记录</li>
                        <li class="next"><a onclick="next_history()">下一页 &rarr;</a></li>
                    </ul>
                    <% }%>
                </div>
            </div>

            <div class="row">
                <div class="col-md-13" >
                    <table class="table table-hover">
                        <caption><h3>定期存款单：</h3></caption>
                        <thead>
                        <tr>
                            <th>存款单编号</th>
                            <th>类型</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>金额</th>
                            <th>预计收入</th>
                            <th>是否过期</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (int i = 0; i < deposits.getList().size(); i++) {%>
                        <tr>
                            <td><%= deposits.getList().get(i).get(Constant.FD_ID)%>
                            </td>
                            <% if (deposits.getList().get(i).getInt(Constant.FD_TYPE) == 0) {%>
                            <td>半年期</td>
                            <% } else {%>
                            <td>一年期</td>
                            <% }%>
                            <td><%= simpleDateFormat.format(Long.parseLong(deposits.getList().get(i).getStr(Constant.FD_START_DATE)))%>
                            </td>
                            <td><%= simpleDateFormat.format(Long.parseLong(deposits.getList().get(i).getStr(Constant.FD_END_DATE)))%>
                            </td>
                            <td><%= deposits.getList().get(i).get(Constant.FD_AMOUNT)%>
                            </td>
                            <td><%= deposits.getList().get(i).get(Constant.FD_INCOME)%>
                            </td>
                            <% if (deposits.getList().get(i).getInt(Constant.FD_IS_VALID) == 0) {%>
                            <td>否</td>
                            <% } else {%>
                            <td>是</td>
                            <% }%>
                        </tr>
                        <% }%>
                        </tbody>
                    </table>
                    <% if (pageCountOfFixedDeposit == 0) {%>
                    <p>无</p>
                    <% } else {%>
                    <ul class="pager">
                        <li class="previous"><a onclick="previous_fd()">&larr; 上一页</a></li>
                        <li>当前第<%= pageNumberOfFixedDeposits%>/<%= pageCountOfFixedDeposit%>页，共<%= fixedDepositsCount%>条记录</li>
                        <li class="next"><a onclick="next_fd()">下一页 &rarr;</a></li>
                    </ul>
                    <% }%>
                </div>
            </div>


        </div>

    </div>
</div>

</body>
</html>
