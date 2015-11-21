<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/13
  Time: 18:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "No-cache");

%>
<html>
<head>
    <title>储户-修改密码</title>
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
            window.location.href = "${base_path}/user/home";
        }
    </script>
</head>
<body class="center" style="padding-top: 65px;">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand">银行存取系统</a>
    </div>
    <div>
        <ul class="nav navbar-nav">
            <li class="active"><a>储户 > 修改密码</a></li>

        </ul>
    </div>
</nav>

<div class="container" align="center">
    <div class="row">
        <div class="col-sm-8 ">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div align="left">
                        <button class="btn btn-default btn-sm" onclick="back()">&slarr;&nbsp;返回</button>
                        <div align="center">
                            <h4>修改密码</h4>
                        </div>
                    </div>

                </div>
                <div class="panel-body">
                    <div align="center">
                        <form class="form-horizontal ValidForm" action="saveChangedPassword" method="post">

                            <div class="form-group">
                                <label class="col-sm-3 control-label">新密码：</label>

                                <div class="col-sm-5">
                                    <input type="password" class="form-control" placeholder="六位数字" name="password"
                                           datatype="n6" errormsg="六位数字"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-3 control-label">重复：</label>

                                <div class="col-sm-5">
                                    <input type="password" class="form-control" placeholder="再输入一遍" name="password_re"
                                           datatype="n6" recheck="password" errormsg="六位数字"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-1">
                                    <button type="submit" class="btn btn-primary">确定</button>
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


</body>
</html>
