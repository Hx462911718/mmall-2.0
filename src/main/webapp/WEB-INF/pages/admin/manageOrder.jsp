<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/common.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keyword" content="">
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">
    <title>订单管理</title>
    <link href="${basePath}/resources/css/style.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/style.css" rel="stylesheet">
    <link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/simple-line-icons.css" rel="stylesheet">
    <script src="${basePath}/resources/js/libs/jquery-2.1.4.min.js"></script>
    <script src="${basePath}/resources/js/libs/bootstrap.min.js"></script>
    <script src="${basePath}/resources/js/require.js"></script>
    <script src="${basePath}/resources/js/main.js"></script>
    <!- -[if lt IE]>
    <script src="${basePath}/resources/js/libs/respond.min.js"></script>
    <script src="${basePath}/resources/js/libs/html5shiv.min.js"></script>
    <![endif]- ->
    <script>
        $(document).ready(function() {
            //显示查询条件
            var typeCondition = $('#roleInput').val();
            $('#status').val(typeCondition);

            $("#status").change(function(){
                $("#searchForm").submit();
            });

        });
        function resett(){
            $("#orderNo").val("");
            $("#status").val("");
        }
    </script>
</head>
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
    <header class="app-header navbar">
        <%--<button class="navbar-toggler mobile-sidebar-toggler hidden-lg-up" type="button"></button>
        <a class="navbar-brand" href="#"></a>--%>
        <ul class="nav navbar-nav hidden-md-down">
            <li class="nav-item">
                <span class=" navbar-toggler" style="margin-left:30px;color: #FFF;line-height: 2;font-size: 16px;font-weight: bold;">后台管理</span>
            </li>
            <li class="nav-item">
                <a class="nav-link navbar-toggler sidebar-toggler" href="#">☰</a>
            </li>
        </ul>
        <%--<ul class="nav navbar-nav ml-auto mr-sm-3">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button"
                   aria-haspopup="true" aria-expanded="false">
                    &lt;%&ndash;<img src="images/header_user.jpg" class="img-avatar" alt="头像">&ndash;%&gt;
                    <span class="hidden-md-down">Admin</span>
                </a>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item" href="#"><i class="fa fa-user"></i> 个人资料</a>
                    <a class="dropdown-item" href="login.html"><i class="fa fa-reply-all"></i> 退出</a>
                </div>
            </li>

        </ul>--%>
    </header>

    <div class="app-body">
        <div class="sidebar">
            <nav class="sidebar-nav">
                <ul class="nav">
                    <li class="nav-item text-center">
                        <a class="nav-link" href="#"><i class="fa fa-leanpub"></i> 你好，管理员</a>
                    </li>
                    <li class="nav-title"></li>
                    <li class="nav-item">
                        <a class="nav-link" href="${basePath}/manage/user"><i class="fa fa-user"></i> 用户管理</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${basePath}/manage/category"><i class="icon-pie-chart"></i> 分类管理</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${basePath}/manage/product"><i class="icon-notebook"></i> 商品管理</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#"><i class="icon-wrench"></i> 订单管理</a>
                    </li>
                </ul>
            </nav>
        </div>

        <main class="main">
            <!-- Breadcrumb -->
            <ol class="breadcrumb">
                <li class="breadcrumb-item active">Home</li>
                <li class="breadcrumb-item active" >Admin</li>
                <li class="breadcrumb-item ">订单管理</li>
            </ol>

            <div class="container-fluid" >
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-content" style="padding-bottom:7px;">
                                <div id="forSearch">
                                    <form action="${basePath}/manage/order" method="post" id="searchForm">
                                        <input type="hidden" id="pageNum" name="pageNum" value="1">
                                        <ul class="form-inline">
                                            <li class="form-group">
                                                <label>订单号:</label>
                                                <input type="number" id="orderNo" name="orderNo" class="form-control" value="${orderNo}" placeholder="根据订单号称搜索">
                                            </li>
                                            <li class="form-group">
                                                <label>订单状态:</label>
                                                <input type="hidden" value="${status}" id="roleInput">
                                                <select type="text" id="status" name="status" class="form-control ">
                                                    <option value="">所有订单</option>
                                                    <option value="0">已取消的订单</option>
                                                    <option value="10">未付款的订单</option>
                                                    <option value="20">已付款的订单</option>
                                                    <option value="40">已发货的订单</option>
                                                    <option value="50">交易成功的订单</option>
                                                    <option value="60">交易关闭的订单</option>
                                                </select>
                                            </li>
                                            <li class="form-group-btn" >
                                                <button  type="button" class="btn btn-warning" onclick="resett()">重置</button>
                                                <input type="submit" class="btn btn-primary" value="搜索"/>
                                            </li>
                                        </ul>
                                    </form>
                                    <style>
                                        input::-webkit-outer-spin-button,
                                        input::-webkit-inner-spin-button {
                                            -webkit-appearance: none;
                                        }
                                        input[type="number"]{
                                            -moz-appearance: textfield;
                                        }
                                    </style>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <i class="fa fa-code"></i> 订单管理
                                    <%--<button type="button" class="btn btn-success float-right" data-toggle="modal"
                                            data-target="#myModal">添加用户
                                    </button>--%>
                                </div>
                                <div class="card-block">
                                    <c:if test="${!empty page.list}">
                                    <table class="table user-table table-striped">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>订单号</th>
                                            <th>收件人</th>
                                            <th>创建时间</th>
                                            <th>订单状态</th>
                                            <th>订单总价</th>
                                            <th style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="orderList" items="${page.list}" varStatus="varStatus">
                                            <tr>
                                                <td>${varStatus.index+1 + (page.pageNum - 1) * page.pageSize}</td>
                                                <td>${orderList.orderNo}</td>
                                                <td>${orderList.receiverName}</td>
                                                <td>${orderList.createTime}</td>
                                                <td>
                                                    <c:if test="${orderList.status eq 0}">已取消</c:if>
                                                    <c:if test="${orderList.status eq 10}">未付款</c:if>
                                                    <c:if test="${orderList.status eq 20}">已付款</c:if>
                                                    <c:if test="${orderList.status eq 40}">已发货</c:if>
                                                    <c:if test="${orderList.status eq 50}">交易成功</c:if>
                                                    <c:if test="${orderList.status eq 60}">交易关闭</c:if>
                                                </td>
                                                <td>${orderList.payment}</td>
                                                <td>
                                                    <c:if test="${orderList.status eq 20}">
                                                        <button class="badge badge-pwd" onclick="sendGoodsNow(${orderList.orderNo})">立即发货</button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    </c:if>
                                    <script type="text/javascript">
                                        $('.d').html(function(i,oldHTML){
                                            return oldHTML.replace(/${username}/g,'<font color="red">${username}</font>');
                                        })
                                    </script>
                                    <script>
                                        function sendGoodsNow(orderNo){
                                            $("#msgBoxConfirmInfo").html("确认立即发货？");
                                            $("#msgBoxConfirm").modal('show');
                                            $("#msgBoxConfirmButton").on('click' , function(){//点击确认按钮时执行下面的方法

                                                $.ajax({
                                                    type : 'POST',
                                                    url : '${basePath}/manage/order/manageSendGoods',
                                                    data : {
                                                        'orderNo' : orderNo
                                                    },
                                                    dataType : 'json',
                                                    success : function(data) {
                                                        if (data.status == 0) {
                                                            $("#msgBoxConfirm").modal('hide');
                                                            $("#msgBoxInfo").html(data.msg);
                                                            $("#msgBox").modal('show');
                                                            $("#msgBoxOKButton").on('click' , function(){
                                                                parent.window.location.reload();
                                                            });
                                                        } else {
                                                            $("#msgBoxConfirm").modal('hide');
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
                                            });
                                        }
                                    </script>
                                    <c:if test="${empty page.list}">
                                        <div style="width:100%;height:50px;text-align: center;line-height: 50px;">
                                            <span>没有数据 ( ^ _ ^ )</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${!empty page.list}">
                                        <div class="up-clearfix">
                                            <div class="up-pull-right">
                                                <%@include file="../../common/page.jsp"%>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>


        </main>


    </div>


    <!--    提示框 start -->
    <%@include file="../../common/msgBox.jsp"%>
    <!--    提示框 -->
    <script src="${basePath}/resources/js/index.js"></script>
    <script src="${basePath}/resources/js/formgroup.js"></script>
</body>
</html>
