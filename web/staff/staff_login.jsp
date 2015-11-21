<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/11
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma","No-cache");

    String staff_id = (String) session.getAttribute("staff_id");

    if (staff_id!=null){
        response.sendRedirect("home");
    }
%>
<html>
<head>
    <title>管理-登录</title>
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
</head>
<body class="center">
<div style="margin-bottom: 100px;">
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand">银行存取系统</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li class="active"><a>管理 > 登录</a></li>

            </ul>
        </div>
    </nav>
</div>

<div class="container-fluid" align="center">
    <div class="row">
        <div class="col-md-7   col-sm-9  col-sm-offset-2">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div align="left"><h4>工作人员登录</h4></div>
                </div>
                <div class="panel-body">
                    <div align="center">
                        <form class="form-horizontal ValidForm" action="${base_path}/staff/login" method="post">

                            <div class="form-group">
                                <label class="col-sm-3 control-label">账号：</label>

                                <div class="col-sm-5">
                                    <input type="text" class="form-control" placeholder="账号" name="staff_id" datatype="n" errormsg="账号为数字"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-3 control-label">密码：</label>

                                <div class="col-sm-5">
                                    <input type="password" class="form-control" placeholder="六位数字" name="staff_password" datatype="n" errormsg="密码为数字"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-1">
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
    </div>
</div>
<%--<form action="/staff/login" method="post">
  <p>账号：<input type="text" name="staff_id"/></p>
  <p>密码：<input type="password" name="staff_password"/></p>
  <p><input type="submit" value="登录"/></p>
</form>--%>

</body>
</html>
