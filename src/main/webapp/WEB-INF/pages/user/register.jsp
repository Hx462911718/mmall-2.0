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
    <title>用户注册--MMall电商平台</title>
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
<div class="login-body" style="top:15%">
    <div class="login-logo">
        <span><span class="login-logo-text" style="color: #FFF;">用户注册--MMall电商平台</span></span>
    </div>
    <div class="login-from" style="height: 550px;">
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
                <h2>确认密码:</h2>
                <label>
                    <input type="password" id="userPwd2" class="txt-input" autocomplete="off" placeholder="请再次输入用户名">
                </label>
                <h2>电话:</h2>
                <label>
                    <input type="text" id="userPhone" class="txt-input" autocomplete="off" placeholder="请输入电话号码">
                </label>
                <h2>邮箱:</h2>
                <label>
                    <input type="text" id="userEmail" class="txt-input" autocomplete="off" placeholder="请输入邮箱">
                </label>
                <h2>问题:</h2>
                <label>
                    <input type="text" id="userquestion" class="txt-input" autocomplete="off" placeholder="请输入密码">
                </label>
                <h2>答案:</h2>
                <label>
                    <input type="text" id="useranswer" class="txt-input" autocomplete="off" placeholder="请输入密码">
                </label>
            </div>
            <div class="login-button">
                <input style="margin-right: 40px;" type="button" onclick="javascript:window.location.href='${basePath}/login';" class="btn btn-primary" name="backButton" id="backButton" value="返 回 登 录">
                <input style="margin-left: 40px;" type="submit" onclick="doLogin()" class="btn btn-pinterest" name="button" id="button" value="立 即 注 册">
            </div>
            <script>

                function doLogin() {
                    var username = $("#username").val();
                    var password = $("#userPwd").val();
                    var password2 = $("#userPwd2").val();
                    var userPhone = $("#userPhone").val();
                    var userEmail = $("#userEmail").val();
                    var userquestion = $("#userquestion").val();
                    var useranswer = $("#useranswer").val();

                    if($.trim(username) == ""){
                        $("#msgBoxInfo").html("用户名不能为空！");
                        $("#msgBox").modal('show');
                        $("#username").val("")
                        return;
                    }
                    if($.trim(password) == ""){
                        $("#msgBoxInfo").html("密码不能为空！");
                        $("#msgBox").modal('show');
                        $("#userPwd").val("");
                        return;
                    }
                    if($.trim(password2) == ""){
                        $("#msgBoxInfo").html("确认密码不能为空！");
                        $("#msgBox").modal('show');
                        $("#userPwd2").val("");
                        return;
                    }
                    if($.trim(password2) != $.trim(password)){
                        $("#msgBoxInfo").html("两次密码不一致");
                        $("#msgBox").modal('show');
                        $("#userPwd").val("");
                        $("#userPwd2").val("");
                        return;
                    }
                    if($.trim(userPhone) == ""){
                        $("#msgBoxInfo").html("电话不能为空！");
                        $("#msgBox").modal('show');
                        $("#userPhone").val("");
                        return;
                    }
                    if(!(/^1[34578]\d{9}$/.test($.trim(userPhone)))){
                        $("#msgBoxInfo").html("电话号码格式不正确！");
                        $("#msgBox").modal('show');
                        $("#userPhone").val("");
                        return;
                    }
                    if($.trim(userEmail) == ""){
                        $("#msgBoxInfo").html("邮箱不能为空！");
                        $("#msgBox").modal('show');
                        $("#userEmail").val("");
                        return;
                    }
                    var regex = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g;
                    if(!(regex.test($.trim(userEmail)))){
                        $("#msgBoxInfo").html("邮箱格式不正确！");
                        $("#msgBox").modal('show');
                        $("#userEmail").val("");
                        return;
                    }
                    if($.trim(userquestion) == ""){
                        $("#msgBoxInfo").html("问题不能为空！");
                        $("#msgBox").modal('show');
                        $("#userquestion").val("");
                        return;
                    }
                    if($.trim(useranswer) == ""){
                        $("#msgBoxInfo").html("问题答案不能为空！");
                        $("#msgBox").modal('show');
                        $("#useranswer").val("");
                        return;
                    }

                    $.ajax({
                        type : 'POST',
                        url : '${basePath}/user/register.do',
                        data : {
                            'username' : username,
                            'password' : password,
                            'phone' : userPhone ,
                            'email' :  userEmail,
                            'question' : userquestion,
                            'answer' : useranswer
                        },
                        dataType : 'json',
                        success : function(data) {
                            if (data.status == '0') {
                                $("#msgBoxInfo").html(data.msg);
                                $("#msgBox").modal('show');
                                $("#msgBoxOKButton").on('click' , function(){
                                    //parent.window.location.reload();
                                    window.location.href='${basePath}/login';
                                });
                            } else {
                                $("#msgBoxInfo").html(data.msg);
                                $("#msgBox").modal('show');
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
