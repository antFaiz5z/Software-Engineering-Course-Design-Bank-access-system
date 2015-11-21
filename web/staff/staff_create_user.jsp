<%@ page import="constant.Constant" %>
<%--
  Created by IntelliJ IDEA.
  User: 凡
  Date: 2015/10/15
  Time: 19:48
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
    <title>管理-开户</title>
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
                    n6: /^[0-9]{6}$/,
                    zh: /[\u4e00-\u9fa5]/,
                    id: /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/
                }
            });
        })
    </script>
    <script type="text/javascript" language="JavaScript">
        function back() {
            window.location.href = "${base_path}/staff/home";
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
            <li class="active"><a>管理 > 开户</a></li>

        </ul>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-10">
            <div class="panel panel-default">

                <div class="panel-heading">
                    <div align="left">
                        <button class="btn btn-default btn-sm" onclick="back()">&slarr;&nbsp;返回</button>
                        <div align="center">
                            <h4>开户</h4>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div align="center">
                        <form class="form-horizontal ValidForm" action="createNewUser" method="post">

                            <div class="form-group ">
                                <label class="col-sm-3 control-label">姓名：</label>

                                <div class="col-sm-5">
                                    <input type="text" class="form-control" placeholder="真实姓名" name="user_name"
                                           datatype="zh" errormsg="请输入真实姓名"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-3 control-label">身份证号：</label>

                                <div class="col-sm-5">
                                    <input type="text" class="form-control" placeholder="15位或18位,18位中的X大小写都可" name="user_idcard"
                                           datatype="id" errormsg="15位或18位数字"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-3 control-label">密码：</label>

                                <div class="col-sm-5">
                                    <input type="password" class="form-control" placeholder="六位数字" name="user_password"
                                           datatype="n6" errormsg="六位数字"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-3 control-label">确认密码：</label>

                                <div class="col-sm-5">
                                    <input type="password" class="form-control" placeholder="六位数字"
                                           name="user_password_re" datatype="n6" errormsg="六位数字"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-3 control-label">账户类型：</label>

                                <div class="col-sm-5">
                                    <select class="form-control" name="user_type" id="user_type">
                                        <option value="0">普通储户</option>
                                        <option value="1">金卡储户</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-3 control-label">初始存入金额：</label>

                                <div class="col-sm-5">
                                    <input type="text" class="form-control"
                                           placeholder="普通储户至少为<%= Constant.NORMAL_ACCOUNT_INITIAL_AMOUNT%>元，金卡储户至少为<%= Constant.GOLD_ACCOUNT_INITIAL_AMOUNT%>元"
                                           name="user_balance" datatype="n" errormsg="金额为数字"/>
                                </div>
                                <div class="col-sm-3 Validform_checktip"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-1">
                                    <button type="submit" class="btn btn-primary">确认开户</button>
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
