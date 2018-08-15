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
    <title>商品管理</title>
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
            var typeCondition = $('#statusInput').val();
            $('#status').val(typeCondition);

            $("#status").change(function(){
                $("#searchForm").submit();
            });

        });
        function resett(){
            $("#productName").val("");
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
                    <a class="nav-link " href="${basePath}/manage/user"><i class="fa fa-user"></i> 用户管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${basePath}/manage/category"><i class="icon-pie-chart"></i> 分类管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="icon-notebook"></i> 商品管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${basePath}/manage/order"><i class="icon-wrench"></i> 订单管理</a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main content -->
    <main class="main">

        <!-- Breadcrumb -->
        <ol class="breadcrumb">
            <li class="breadcrumb-item">Home</li>
            <li class="breadcrumb-item">Admin</li>
            <li class="breadcrumb-item active">商品管理</li>
        </ol>

        <div class="container-fluid" >
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card-content" style="padding-bottom:7px;">
                            <div id="forSearch">
                                <form action="" method="post" id="searchForm">
                                        <input type="hidden" id="pageNum" name="pageNum" value="1">
                                    <ul class="form-inline">
                                        <li class="form-group">
                                            <label>商品名称:</label>
                                            <input type="text" id="productName" name="productName" class="form-control" value="${productName}" placeholder="根据商品名称搜索">
                                        </li>
                                        <li class="form-group">
                                            <label>商品状态:</label>
                                            <input type="hidden" value="${status }" id="statusInput">
                                            <select type="text" id="status" name="status" class="form-control ">
                                                <option value="">所有状态</option>
                                                <option value="1">在售</option>
                                                <option value="2">已下架</option>
                                            </select>
                                        </li>
                                        <li class="form-group-btn" >
                                            <button  type="button" class="btn btn-warning" onclick="resett()">重置</button>
                                            <input type="submit" class="btn btn-primary" value="搜索"/>
                                        </li>
                                    </ul>
                                </form>
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
                            <div style="height: 10px;weight:100%;"></div>
                            <div class="card-header">
                                <i class="fa fa-code"></i> 商品管理
                                <a href="${basePath}/manage/product/addProduct"><button type="button" class="btn btn-primary float-right" >添加商品</button></a>
                                <div style="height: 10px;weight:100%;"></div>
                            </div>
                            <div class="card-block">
                                <c:if test="${!empty page.list}">
                                <table class="table user-table table-striped">
                                    <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>名称</th>
                                        <th width="150px">类别</th>
                                        <th>价格</th>
                                        <th>状态</th>
                                        <th style="text-align: center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="productList" items="${page.list}" varStatus="varStatus">
                                        <tr>
                                            <td>${varStatus.index+1 + (page.pageNum - 1) * page.pageSize}</td>
                                            <td class="d">${productList.name}</td>
                                            <td>${productList.category.name}</td>
                                            <td><font color="#ff6609">&yen;${productList.price}</font></td>
                                            <td>
                                                <c:if test="${productList.status eq 1}">在售</c:if>
                                                <c:if test="${productList.status eq 2}">已下架</c:if>
                                            </td>
                                            <td>
                                                <%--<button class="badge badge-edit"></button>--%>
                                                    <c:if test="${productList.status eq 2}">
                                                        <button class="badge badge-edit" onclick="onSaleorNot(${productList.id} , 1)">上架</button>
                                                    </c:if>
                                                    <c:if test="${productList.status eq 1}">
                                                        <button class="badge badge-pwd" onclick="onSaleorNot(${productList.id} , 2)">下架</button>
                                                    </c:if>
                                                <button class="badge badge-star">查看详情</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                </c:if>
                                <script type="text/javascript">
                                    $('.d').html(function(i,oldHTML){
                                        return oldHTML.replace(/${productName}/g,'<font color="red">${productName}</font>');
                                    })
                                </script>
                                <script>
                                    function onSaleorNot(id , status){
                                        $("#msgBoxConfirmInfo").html("确定要修改信息吗？");
                                        $("#msgBoxConfirm").modal('show');
                                        $("#msgBoxConfirmButton").on('click' , function(){//点击确认按钮时执行下面的方法

                                            $.ajax({
                                                type : 'POST',
                                                url : '${basePath}/manage/product/set_sale_status.do',
                                                data : {
                                                    'productId' : id,
                                                    "status" : status
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

<!-- /.modal-content -->
<%--<div class="modal animate-fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="myModalLabel">添加用户</h6>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="card-block">
                    <form action="" method="post" enctype="multipart/form-data" class="form-horizontal ">
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label">账号</label>
                            <div class="col-md-10">
                                <input type="text" id="user_name" class="check-input form-control"
                                       aria-label="用户名（包含字母／数字／下划线）" placeholder="6-20个字符">
                                <div class="hint">*请填写6-20个字符的账号</div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label">姓名</label>
                            <div class="col-md-10">
                                <input type="text" id="name" class="check-input form-control" aria-label="用户名（包含字母／数字／下划线）"
                                       placeholder="姓名">
                                <div class="hint">*请填写4-20个字符的姓名</div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label" for="select">性别</label>
                            <div class="col-md-10">
                                <select id="select" name="select" class="form-control">
                                    <option value="0">请选择</option>
                                    <option value="1">男</option>
                                    <option value="2">女</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label" for="class-input">部门</label>
                            <div class="col-md-10">
                                <button id="class-input" class="btn btn-primary">部门</button>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label" for="select1">技术方向</label>
                            <div class="col-md-10">
                                <select id="select1" name="select" class="form-control">
                                    <option value="0">请选择</option>
                                    <option value="1">java</option>
                                    <option value="2">C++</option>
                                    <option value="3">测试</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label" for="select2">岗位评定</label>
                            <div class="col-md-10">
                                <select id="select2" name="select" class="form-control">
                                    <option value="0">请选择</option>
                                    <option value="1">未评定</option>
                                    <option value="2">1级</option>
                                    <option value="3">2级</option>
                                    <option value="4">3级</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label">电话</label>
                            <div class="col-md-10">
                                <input type="text" id="phone" class="check-input form-control" placeholder="电话">
                                <div class="hint">请填写手机号</div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label">邮箱</label>
                            <div class="col-md-10">
                                <input type="text" id="user_email" class="check-input form-control" placeholder="邮箱">
                                <div class="hint">请填写邮箱</div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label">管理员</label>
                            <div class="col-md-10 from-radio">
                                <label class="radio-inline" for="inline-radio1">
                                    <input type="radio" id="inline-radio1" name="inline-radios" value="option1">管理员
                                </label>
                                <label class="radio-inline" for="inline-radio2">
                                    <input type="radio" id="inline-radio2" name="inline-radios" value="option2">老师
                                </label>
                                <label class="radio-inline" for="inline-radio3">
                                    <input type="radio" id="inline-radio3" name="inline-radios" value="option3">学生
                                </label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-2 form-control-label" for="manage-input">试题分类权限</label>
                            <div class="col-md-10">
                                <button id="manage-input" class="btn btn-primary">试题类型</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">确认</button>
            </div>
        </div>
    </div>
</div>--%>
<!--    提示框 start -->
<%@include file="../../common/msgBox.jsp"%>
<!--    提示框 -->
<script src="${basePath}/resources/js/index.js"></script>
<script src="${basePath}/resources/js/formgroup.js"></script>


</body>
</html>
