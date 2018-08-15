<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/common.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keyword" content="">
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">
    <title>用户登录--MMall电商平台</title>
    <link href="${basePath}/resources/css/style.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/style.css" rel="stylesheet">
    <link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/simple-line-icons.css" rel="stylesheet">
    <script src="${basePath}/resources/js/libs/jquery-2.1.4.min.js"></script>
    <script src="${basePath}/resources/js/libs/bootstrap.min.js"></script>
    <!- -[if lt IE]>
    <script src="${basePath}/resources/js/libs/respond.min.js"></script>
    <script src="${basePath}/resources/js/libs/html5shiv.min.js"></script>
    <![endif]- ->

<body class="login">
<div class="login-body">
    <div class="login-logo">
        <span><span class="login-logo-text" style="color: #FFF;">用户登录--MMall电商平台</span></span>
    </div>
    <div class="login-from" style="height: 250px;">
        <div class="login-padding">
            <div>
                <h2>用户名:</h2>
                <label>
                    <input type="text" id="username" class="txt-input" autocomplete="off" placeholder="请输入用户名">
                </label>
                <h2>密码:</h2>
                <label>
                    <input type="password" id="userPwd" class="txt-input" autocomplete="off" placeholder="请输入密码">
                </label>
            </div>
            <div class="operate-box">
                <label class="remember-me">
                    <a href="${basePath}/register" style="color: #0a0a0a;"><span id="free-register">免费注册</span></a></label>
                <style>
                    #free-register:hover{
                        color: #F00;
                    }
                </style>
                <%--<span class="forgot-pwd"><a href="javascript:void(0);">免费注册</a></span>--%>
                <span class="forgot-pwd"><a href="javascript:void(0);">忘记密码?</a></span>
            </div>
            <div class="login-button">
                <a href="#">
                    <input type="submit" onclick="doLogin()" class="sub-button" name="button" id="button" value="登 录">
                </a>
            </div>
            <script>
                function doLogin() {
                    var username = $("#username").val();
                    var password = $("#userPwd").val();

                    if($.trim(username) == ""){
                        $("#msgBoxInfo").html("用户名不能为空");
                        $("#msgBox").modal('show');
                        $("#username").val("")
                        return;
                    }
                    if($.trim(password) == ""){
                        $("#msgBoxInfo").html("密码不能为空");
                        $("#msgBox").modal('show');
                        $("#userPwd").val("");
                        return;
                    }

                    $.ajax({
                        type : 'POST',
                        url : '${basePath}/user/login.do',
                        data : {
                            'username' : username,
                            'password' : password
                        },
                        dataType : 'json',
                        success : function(data) {
                            if (data.status == '0') {
                                window.location.href='${basePath}/';
                                /*$("#msgBoxInfo").html(data.msg);
                                $("#msgBox").modal('show');
                                $("#msgBoxOKButton").on('click' , function(){
                                });*/
                            } else {
                                $("#msgBoxInfo").html(data.msg);
                                $("#msgBox").modal('show');
                                $("#username").val("");
                                $("#userPwd").val("");
                                $("#msgBoxOKButton").on('click' , function(){
                                    $("#msgBox").modal('hide');
                                    //parent.window.location.reload();
                                });
                            }
                        },
                        error : function(data) {
                            $("#msgBoxInfo").html("服务器错误");
                            $("#msgBox").modal('show');
                        }
                    });
                }
            </script>
        </div>
    </div><!--login_boder end-->
</div><!--login_m end-->


<!--    提示框 start -->
<%@include file="../../common/msgBox.jsp"%>
<!--    提示框 -->

<script>
    //remember
    $("#remember-me").click(function () {
        var n = document.getElementById("remember-me").checked;
        if (n) {
            $(".remember-box").show();
        } else {
            $(".remember-box").hide();
        }
    });

    //login_bg
    var winHeight = $(window).height();
    $(".login").css("height", winHeight);
    $(window).resize(function () {
        winHeight = $(window).height();
        $(".login").css("height", winHeight);
    });
</script>
<script src="${basePath}/resources/js/index.js"></script>
</body>
</html>
