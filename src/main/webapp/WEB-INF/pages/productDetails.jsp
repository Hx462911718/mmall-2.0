<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/common.jsp" %>
<html>
<head>
    <title>商品详情</title>
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">
    <link href="http://res8.vmallres.com/20180323/css/echannel/ec.core.base.min.css?20170722" rel="stylesheet"
          type="text/css">
    <link href="http://res8.vmallres.com/20180323/css/echannel/index.min.css?20170320" rel="stylesheet" type="text/css">
    <link href="http://res8.vmallres.com/20180323/css/echannel/main.min.css?20170106" rel="stylesheet" type="text/css">
    <link href="http://res8.vmallres.com/20180504/css/echannel/main.min.css?20170609" rel="stylesheet" type="text/css">
    <link href="http://res8.vmallres.com/20180504/css/product/main.min.css?20170710" rel="stylesheet" type="text/css">
    <script src="http://res9.vmallres.com/20180323/js/common/base/jquery-1.4.4.min.js"></script>

</head>
<body class="wide">
<link href="${basePath}/resources/css/mmall.css" rel="stylesheet" type="text/css">
<div class="top-banner" id="top-banner-block"></div>
<img src="http://res.vmallres.com/20180323/images/echannel/icon-common.png" class="hide">

<div class="shortcut">
    <div class="layout">
        <div class="s-sub">
        </div>
        <div class="s-main ">
            <img src="http://res.vmallres.com/20180305/images/echannel/bg/bg71.png" class="hide">
            <ul>
                <li id="unlogin_status">
                    <div id="top_unlogin" class="header-toolbar">
                        <!-- 2017-02-15-头部-工具栏-焦点为header-toolbar-item增加ClassName:hover -->
                        <div class="header-toolbar-item">
                            <div class="i-login">
                                <div class="h">
                                    <div class="">
                                        <c:if test="${empty CURRENT_USER}">
                                            <script>document.write('<a id="top-index-loginUrl" href="${basePath}/login" rel="nofollow">请登录</a>');</script>
                                            <a href="${basePath}/register" rel="nofollow">&nbsp;&nbsp;注册</a>
                                        </c:if>
                                        <c:if test="${not empty CURRENT_USER}">
                                            <a href="#" rel="nofollow">&nbsp;&nbsp;欢迎你，${CURRENT_USER.username}</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <a href="${basePath}/order/orderList" timeType="timestamp">我的订单</a>
                </li>
                <li>
                    <a href="${basePath}/cart/" class="icon-minicart" rel="nofollow" timeType="timestamp" target="blank">
                        <span>购物车</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="header">
    <div class="layout">
        <div class="left">
            <!-- 2017-02-15-logo-start -->
            <div class="logo" style="position: relative;">
                <a href="${basePath}/" title="mmall.com - mmall商城" style="position: absolute;left: -47px; top: -15px;">
                    <img src="${basePath}/resources/images/logo.png" alt="mmall.com - mmall商城"
                         style="transform:scale(0.6);"/>
                </a>
            </div>
            <!-- 2017-02-15-logo-end -->

            <!-- 2017-06-19-导航-start -->
            <div class="naver">
                <ul id="naver" class="clearfix">
                    <c:forEach var="mainCategory" items="${categoryListVoList}">
                        <li>
                            <a href="#" onclick="goCategory(${mainCategory.id})">
                                <span>${mainCategory.name}</span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <!-- 2017-06-19-导航-end -->
        </div>
    </div>
    <!-- 2017-02-15-头部-end -->

    <div class="hr-20"></div>
    <div class="g">
        <!--面包屑 -->
        <div class="breadcrumb-area fcn">
            <a href="${basePath}/" title="首页">首页</a>&nbsp;&gt;&nbsp;<a href="#" onclick="goCategory(${parentCategory.id})" title="${parentCategory.name}">${parentCategory.name}</a>&nbsp;&gt;&nbsp;<a
                href="#" onclick="goCategory(${category.id})" title="${category.name}">${category.name}</a>&nbsp;&gt;&nbsp;
            <span id="bread-pro-name">${productDetailVo.name}${productDetailVo.subtitle}</span>
        </div>
    </div>
    <div class="hr-10"></div>

    <div class="product clearfix">
        <div class="left">
            <!-- 20170518-商品图片-start -->
            <div class="product-gallery">
                <div >
                    <div class="product-gallery-img" id="pic-container" style="border:1px solid #EEE;">
                        <div>
                            <a id="product-img" href="javascript:;" class="cloud-zoom">
                                <img src="${productDetailVo.imageHost}${productDetailVo.mainImage}" alt="${productDetailVo.name}${productDetailVo.subtitle}" title="${productDetailVo.name}${productDetailVo.subtitle}">
                            </a>
                        </div>
                    </div>
                </div>
                <div class="product-gallery-nav">
                    <a href="javascript:;" class="product-gallery-back"></a>
                    <!--不可点击添加class="disabled"-->
                    <div class="product-gallery-thumbs">
                        <ul id="pro-gallerys" style="left: 0px;">
                            <li class=""><a href="javascript:;"><img
                                    src="http://image.lubiao.com/428_428_1506589486461mp.jpg"
                                    alt="荣耀10&nbsp;AI摄影手机&nbsp;6GB+64GB&nbsp;幻影紫&nbsp;全网通 双卡双待 高配版"></a></li>
                            <li class=""><a href="javascript:;"><img
                                    src="https://res.vmallres.com/pimages//product/6901443232420/group//78_78_1523952297552.jpg"
                                    alt="荣耀10&nbsp;AI摄影手机&nbsp;6GB+64GB&nbsp;幻影紫&nbsp;全网通 双卡双待 高配版"></a></li>
                            <li class=""><a href="javascript:;"><img
                                    src="https://res.vmallres.com/pimages//product/6901443232420/group//78_78_1523952298110.jpg"
                                    alt="荣耀10&nbsp;AI摄影手机&nbsp;6GB+64GB&nbsp;幻影紫&nbsp;全网通 双卡双待 高配版"></a></li>
                            <li class=""><a href="javascript:;"><img
                                    src="https://res.vmallres.com/pimages//product/6901443232420/group//78_78_1523952298957.jpg"
                                    alt="荣耀10&nbsp;AI摄影手机&nbsp;6GB+64GB&nbsp;幻影紫&nbsp;全网通 双卡双待 高配版"></a></li>
                            <li class=""><a href="javascript:;"><img
                                    src="https://res.vmallres.com/pimages//product/6901443232420/group//78_78_1523952299349.jpg"
                                    alt="荣耀10&nbsp;AI摄影手机&nbsp;6GB+64GB&nbsp;幻影紫&nbsp;全网通 双卡双待 高配版"></a></li>
                            <li class=""><a href="javascript:;"><img
                                    src="https://res.vmallres.com/pimages//product/6901443232420/group//78_78_1523952299790.jpg"
                                    alt="荣耀10&nbsp;AI摄影手机&nbsp;6GB+64GB&nbsp;幻影紫&nbsp;全网通 双卡双待 高配版"></a></li>
                            <li class=""><a href="javascript:;"><img
                                    src="https://res.vmallres.com/pimages//product/6901443232420/group//78_78_1523952300410.jpg"
                                    alt="荣耀10&nbsp;AI摄影手机&nbsp;6GB+64GB&nbsp;幻影紫&nbsp;全网通 双卡双待 高配版"></a></li>
                        </ul>
                    </div>
                    <a href="javascript:;" class="product-gallery-forward"></a>
                </div>
                <form id="hiddenForm" action="${basePath}/product/listByCategory" method="post" target="_blank">
                    <input type="hidden" name="categoryId" id="hiddenId"/>
                </form>
                <script>
                    function goCategory(categoryId) {
                        $("#hiddenId").val(categoryId);
                        $("#hiddenForm").submit();
                    }

                    $(".product-gallery-back").click(function(){
                        // $("#pro-gallerys").css('left',$("#pro-gallerys").position().left + 70 + 'px');
                        if($("#pro-gallerys").position().left < 0){
                            $("#pro-gallerys").animate({ left: "+=74px" }, 150);
                        }
                    });
                    $(".product-gallery-forward").click(function(){
                        //$("#pro-gallerys").css('left',$("#pro-gallerys").position().left - 70 + 'px');
                        if($("#pro-gallerys").position().left > (5 - $("#pro-gallerys li").length)*74){
                            $("#pro-gallerys").animate({ left: "-=74px" }, 150);
                        }

                    });
                </script>
            </div>
            <!-- 20170518-商品图片-end -->
        </div>
        <div class="right relative">
            <!-- 20170518-商品简介-start -->
            <div class="product-property clearfix">
                <div id="product-property-recommand">
                    <!-- 20170518-商品简介-商品信息-start -->
                    <div class="product-meta">
                        <h1 id="pro-name">${productDetailVo.name}</h1>
                        <input type="hidden" id="productId" value="${productDetailVo.id}"/>
                        <%--<input type="hidden" id="userId" value="${CURRENT_USER.id}"/>--%>
                        <div class="product-slogan" id="skuPromWord">
                            <span class="product-slogan-link">${productDetailVo.subtitle}</span>
                        </div>
                    </div>
                    <div class="product-info">
                        <div class="product-info-list clearfix">
                            <label>价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格</label>
                            <div class="product-price clearfix">
                                <div class="product-price-info">
                                    <span id="pro-price" class="f24"><em>¥</em>${productDetailVo.price}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="hr-10"></div>
                    <div class="">
                        <div class="product-info-list clearfix">
                            <label>库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存</label>
                            <div class="product-price clearfix">
                                <div class="product-price-info">
                                    <span id="pro-price" class="f18" style="color: #000;">${productDetailVo.stock} 件</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-operation-main" >
                        <div id="product-operation" class="product-operation relative" style="display: block;">
                            <div class="clearfix">
                                <!-- 20170518-商品简介-购买数量-start -->
                                <div class="product-stock" id="pro-quantity-area" style="margin-left: 0;margin-top: -20px;">
                                    <input id="pro-quantity" type="number" readonly="readonly" align="center" class="product-stock-text" value="1" style="width: 70px;">
                                    <p class="product-stock-btn">
                                        <a id="pro-quantity-plus" href="javascript:;">+</a>
                                        <a id="pro-quantity-minus" href="javascript:;">−</a>
                                    </p>
                                </div>
                                <script>
                                    $("#pro-quantity-plus").click(function(){
                                        var num = $("#pro-quantity").val();
                                        $("#pro-quantity").val(parseInt(num) + 1);
                                    });
                                    $("#pro-quantity-minus").click(function(){
                                        var num = $("#pro-quantity").val();
                                        if(parseInt(num) > 1){
                                            $("#pro-quantity").val(parseInt(num) - 1);
                                        }
                                    });
                                </script>
                                <!-- 20170518-商品简介-购买数量-end -->
                                <div class="hr-20"></div>
                                <div class="product-buttonmain" style="margin-left: 0;clear: both;">
                                    <div id="pro-operation" class="product-button clearfix" style="visibility: visible;">
                                        <a href="#" onclick="addToCart()" class="product-button01">
                                            <span>加入购物车</span>
                                        </a>
                                    </div>
                                </div>
                                <script>
                                    function addToCart(){
                                        var productId = $("#productId").val();
                                        var quantity =$("#pro-quantity").val();

                                        $.ajax({
                                            type : 'POST',
                                            url : '${basePath}/cart/add',
                                            dataType : 'json' ,
                                            data : {
                                                'productId' : productId,
                                                'count' : quantity
                                            },
                                            success : function(data) {
                                                if(data.status == 10){
                                                    window.location.href="${basePath}/login";
                                                }
                                                else if (data.status == 0) {
                                                    $("#msgBoxConfirm").modal('hide');
                                                    $("#msgBoxInfo").html(data.msg);
                                                    $("#msgBox").modal('show');
                                                    $("#msgBoxOKButton").on('click' , function(){
                                                        window.location.href="${basePath}/";
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
            <!-- 20170518-商品简介-属性-end -->
        </div>
    </div>
    <div class="hr-40"></div>
    <div class="line"></div>
    <div class="product-tab" id="product-tab" style="position: static; top: 0px; background: rgb(255, 255, 255); width: 100%; z-index: 100;">
        <div class="layout relative" id="layoutRelative">
            <p>
                <a href="javascript:;" id="pro-tab-feature" class="selected">商品详情<em></em></a>
            </p>
        </div>
    </div>

    <div id="pro-tab-feature-content" class="product-detail relative tit1">
        <div id="pro-detail-contents">
            <div id="pro-detail-content-10086431508342" class="pro-detail-see" style="">
                <div id="kindPicture-10086431508342">
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/19/20180419180308301142.jpg" alt="荣耀10详情.jpg"></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/19/201804191805136250563.jpg" alt="1.jpg"></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/28/201804281746107872803.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915314487523.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/20180418091531782983.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915311057507.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915324488013.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915331222268.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915329157685.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915337777211.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915354814419.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915425010208.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915354397213.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915373726670.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915375872476.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915391216711.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915397744051.jpg" style=""></p>
                    <p><img src="https://res.vmallres.com/pimages/detailImg/2018/04/18/201804180915408163870.jpg" style=""></p>
                </div>
            </div>
        </div>
    </div>
</div>

<!--    提示框 start -->
<%@include file="../common/msgBox.jsp" %>
<!--    提示框 -->
</body>
</html>
