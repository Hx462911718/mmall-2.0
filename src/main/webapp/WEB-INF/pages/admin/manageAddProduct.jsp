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
    <title>添加商品</title>
    <link href="${basePath}/resources/css/style.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/style.css" rel="stylesheet">
    <link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/simple-line-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath}/resources/layui/css/layui.css">
    <script src="${basePath}/resources/js/libs/jquery-2.1.4.min.js"></script>
    <script src="${basePath}/resources/js/libs/bootstrap.min.js"></script>
    <script src="${basePath}/resources/js/require.js"></script>
    <script src="${basePath}/resources/js/main.js"></script>
    <!- -[if lt IE]>
    <script src="${basePath}/resources/js/libs/respond.min.js"></script>
    <script src="${basePath}/resources/js/libs/html5shiv.min.js"></script>

    <![endif]- ->
    <script>
        window.subImagesFlag = false;
    </script>
</head>
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
<header class="app-header navbar">
    <%--<button class="navbar-toggler mobile-sidebar-toggler hidden-lg-up" type="button"></button>
    <a class="navbar-brand" href="#"></a>--%>
    <ul class="nav navbar-nav hidden-md-down">
        <li class="nav-item">
            <span class=" navbar-toggler"
                  style="margin-left:30px;color: #FFF;line-height: 2;font-size: 16px;font-weight: bold;">后台管理</span>
        </li>
        <li class="nav-item">
            <a class="nav-link navbar-toggler sidebar-toggler" href="#">☰</a>
        </li>
    </ul>
    <ul class="nav navbar-nav ml-auto mr-sm-3">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button"
               aria-haspopup="true" aria-expanded="false">
                <%--<img src="images/header_user.jpg" class="img-avatar" alt="头像">--%>
                <span class="hidden-md-down">Admin</span>
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <a class="dropdown-item" href="#"><i class="fa fa-user"></i> 个人资料</a>
                <a class="dropdown-item" href="login.html"><i class="fa fa-reply-all"></i> 退出</a>
            </div>
        </li>

    </ul>
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
                    <a class="nav-link active" href="${basePath}/manage/product"><i class="icon-notebook"></i> 商品管理</a>
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
            <li class="breadcrumb-item active">添加商品</li>
        </ol>

        <div class="container-fluid">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card-content">
                            <div class="card-content-top">
                                <div class="card-content-top-left" style="height: 30px;">
                                    <span style="color:#3598DB;font-size: 15px;">&nbsp;&nbsp; <i class="fa fa-code"></i> <b>添加商品</b></span>
                                </div>
                                <div class="card-content-top-right">
                                    <!-- <button class="btn btn-primary">提交</button> -->
                                </div>
                            </div>
                            <hr style="margin-top: 0;"/>
                            <div class="card-content-main">
                                    <div class="form-group row">
                                        <label class="col-md-1 form-control-label"> 商品分类:</label>
                                        <div class="col-md-3">
                                            <select type="text" class="form-control" id="parCategory" name="">
                                                <option value="-1">请选择</option>
                                                <c:forEach var="mainCategory" items="${categoryListVoList}">
                                                    <option value="${mainCategory.id}">${mainCategory.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <select type="text" class="form-control" id="childCategory" name="">
                                                <option value='-1'>请选择</option>
                                            </select>
                                        </div>
                                        <script>
                                            $("#parCategory").change(function () {

                                                var parentId = $(this).val();

                                                $.ajax({
                                                    type: 'POST',
                                                    url: '${basePath}/manage/category/get_category.do',
                                                    data: {
                                                        "categoryId": parentId
                                                    },
                                                    dataType: 'json',

                                                    success: function (data) {
                                                        $("#childCategory").html("");
                                                        $("#childCategory").html("<option value='-1'>请选择</option>");
                                                        //alert(data.data[0].id);
                                                        for (var i = 0; i < data.data.length; i++) {
                                                            $("#childCategory").html($("#childCategory").html() + "<option value='" + data.data[i].id + "'>" + data.data[i].name + "</option>");
                                                        }
                                                    },
                                                    error: function (data) {
                                                        $("#msgBoxInfo").html("服务器错误");
                                                        $("#msgBox").modal('show');
                                                    }
                                                });
                                            });
                                        </script>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-1 form-control-label"> 商品名称:</label>
                                        <div class="col-md-11">
                                            <textarea rows="5" type="text" id="productName" name="productName"
                                                      class="check-input form-control" placeholder="商品名称"
                                                      value=""></textarea>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-md-1 form-control-label"> 商品描述:</label>
                                        <div class="col-md-11">
                                            <textarea rows="5" type="text" id="subtitle" name="subtitle"
                                                      class="check-input form-control" placeholder="商品描述"
                                                      value=""></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-1 form-control-label"> 价格:</label>
                                        <div class="col-md-2">
                                            <input type="number" id="price" name="price" class="check-input form-control"
                                                   placeholder="商品价格" value=""/>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-md-1 form-control-label"> 库存:</label>
                                        <div class="col-md-2">
                                            <input type="number" id="stock" name="stock" class="check-input form-control"
                                                   placeholder="商品库存" value=""/>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-md-1 form-control-label"> 商品图片:</label>
                                        <div class="col-md-11">
                                            <div class="layui-upload">
                                                <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多张图片</button>&nbsp;&nbsp;&nbsp;&nbsp;
                                                <button type="button" class="layui-btn" id="testListAction">开始上传</button>
                                                <div class="layui-upload-list">
                                                    <table class="layui-table">
                                                        <thead>
                                                        <tr><th>文件名</th>
                                                            <th>大小</th>
                                                            <th>状态</th>
                                                            <th>操作</th>
                                                        </tr></thead>
                                                        <tbody id="demoList"></tbody>
                                                    </table>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                <div class="form-group row">
                                    <label class="col-md-1 form-control-label"> 商品详情:</label>
                                    <div class="col-md-11">
                                        <textarea class="layui-textarea" id="LAY_demo"
                                                  style="display: none"></textarea>
                                    </div>

                                    <script src="${basePath}/resources/layui/layui.js" charset="utf-8"></script>
                                    <!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->

                                    <script>
                                        layui.use(['layedit','upload'], function () {
                                            //得到upload对象
                                            var layedit = layui.layedit
                                                ,upload = layui.upload
                                                , $ = layui.jquery;

                                            //多文件列表示例
                                            var demoListView = $('#demoList')
                                                ,uploadListIns = upload.render({
                                                elem: '#testList'
                                                ,url: '${basePath}/manage/product/richtext_img_upload.do'
                                                ,accept: 'file'
                                                ,multiple: true
                                                ,auto: false
                                                ,bindAction: '#testListAction'
                                                ,choose: function(obj){
                                                    var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                                                    //读取本地文件
                                                    obj.preview(function(index, file, result){
                                                                var tr = $(['<tr id="upload-'+ index +'">'
                                                                    ,'<td>'+ '<img src="'+ result +'" alt="'+ file.name +'" class="layui-upload-img" filename="">' +'</td>'
                                                                    ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
                                                                    ,'<td>等待上传</td>'
                                                                    ,'<td>'
                                                                    ,'<button class="layui-btn layui-btn-mini demo-reload layui-hide">重传</button>'
                                                                    ,'<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button>'
                                                                    ,'</td>'
                                                                    ,'</tr>'].join(''));

                                                        //单个重传
                                                        tr.find('.demo-reload').on('click', function(){
                                                            obj.upload(index, file);
                                                        });

                                                        //删除
                                                        tr.find('.demo-delete').on('click', function(){
                                                            delete files[index]; //删除对应的文件
                                                            tr.remove();
                                                            uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                                                        });

                                                        demoListView.append(tr);
                                                    });
                                                }
                                                ,done: function(res, index, upload){
                                                    if(res.code == 0){ //上传成功
                                                        subImagesFlag = true;
                                                        //console.log(res.data);
                                                        var tr = demoListView.find('tr#upload-'+ index)
                                                            ,tds = tr.children();
                                                        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                                                        //tds.eq(3).html(''); //清空操作
                                                        tds.eq(0).find('.layui-upload-img').attr('src',res.data.src);
                                                        tds.eq(0).find('.layui-upload-img').attr('filename',res.data.fileName);
                                                        //tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
                                                        return delete this.files[index]; //删除文件队列已经上传成功的文件
                                                    }
                                                    this.error(index, upload);
                                                }
                                                ,error: function(index, upload){
                                                    subImagesFlag = false;
                                                    var tr = demoListView.find('tr#upload-'+ index)
                                                        ,tds = tr.children();
                                                    tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                                                    tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
                                                }
                                            });

                                            layedit.set({
                                                uploadImage: {
                                                    url: '${basePath}/manage/product/richtext_img_upload.do' //接口url
                                                    , type: 'post'
                                                }
                                            });

                                            //构建一个默认的编辑器
                                            var index = layedit.build('LAY_demo');
                                        });
                                    </script>
                                </div>
                                <ul class="form-inline">
                                    <li class="form-group-btn">
                                        <button type="button" class="btn btn-warning" onclick="reset()">重置</button>
                                        <button type="button" class="btn btn-primary" onclick="addProduct()"
                                                id="addNoticeBtn">提交
                                        </button>
                                    </li>
                                </ul>
                                <script>

                                    function trim(str){//删除左右两端的空格
                                        return str.replace(/(^\s*)|(\s*$)/g, "");
                                    }

                                    function addProduct(){
                                        var categoryId = $("#childCategory").val();
                                        var name = $("#productName").val();
                                        var subtitle = $("#subtitle").val();
                                        var price = $("#price").val();
                                        var stock = $("#stock").val();
                                        var detail = $("iframe").contents().find("body").html();
                                        var imgs = $("#demoList").find('img');
                                        var subImages = '';
                                        for(var i =0 ; i< imgs.length ; i++){
                                            subImages+=$(imgs[i]).attr('filename') + ',';
                                        }
                                        //alert(subImagesFlag);
                                        if(categoryId == -1){
                                            $("#msgBoxInfo").html("请选择商品类别");
                                            $("#msgBox").modal('show');
                                            return;
                                        }
                                        if(!checkBlank(trim(name))){
                                            $("#msgBoxInfo").html("商品名称不允许为空");
                                            $("#msgBox").modal('show');
                                            return;
                                        }
                                        if(!checkBlank(trim(subtitle))){
                                            $("#msgBoxInfo").html("商品描述不允许为空");
                                            $("#msgBox").modal('show');
                                            return;
                                        }
                                        if(!checkBlank(trim(price))){
                                            $("#msgBoxInfo").html("商品价格不允许为空");
                                            $("#msgBox").modal('show');
                                            return;
                                        }
                                        if(!checkBlank(trim(stock))){
                                            $("#msgBoxInfo").html("商品库存不允许为空");
                                            $("#msgBox").modal('show');
                                            return;
                                        }
                                        if(!subImagesFlag){
                                            $("#msgBoxInfo").html("商品图片未添加或者没有上传成功");
                                            $("#msgBox").modal('show');
                                            return;
                                        }
                                        if(!checkBlank(detail)){
                                            $("#msgBoxInfo").html("商品详情未添加");
                                            $("#msgBox").modal('show');
                                            return;
                                        }
                                        /*alert("categoryId:"+categoryId);
                                        alert("name:"+name);
                                        alert("subtitle:"+subtitle);
                                        alert("price:"+price);
                                        alert("stock:"+stock);
                                        alert("subImages:"+subImages);
                                        alert("detail:"+detail);*/

                                        $.ajax({
                                            type : 'POST',
                                            url : '${basePath}/manage/product/doAddProduct',
                                            dataType : 'json' ,
                                            data : {
                                                'categoryId' : categoryId,
                                                'name' : name,
                                                'subtitle' : subtitle,
                                                'price' : price,
                                                'stock' : stock,
                                                'subImages' : subImages,
                                                'detail' : detail,

                                            },
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
                                                $("#msgBoxInfo").html("程序执行出错");
                                                $("#msgBox").modal('show');
                                                $("#addModal").modal('hide');
                                            }
                                        });

                                    }
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>


<!--    提示框 start -->
<%@include file="../../common/msgBox.jsp" %>
<!--    提示框 -->
<script src="${basePath}/resources/js/index.js"></script>
<%--<script src="${basePath}/resources/js/formgroup.js"></script>--%>
</body>
</html>
