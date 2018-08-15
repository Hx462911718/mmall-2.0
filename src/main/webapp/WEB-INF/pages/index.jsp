<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/common.jsp" %>
<html>
<head>
    <script src="${basePath}/resources/js/mmall.js"></script>
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">
    <title>首页——MMall电商平台</title>
    <link href="http://res8.vmallres.com/20180323/css/echannel/ec.core.base.min.css?20170722" rel="stylesheet"
          type="text/css">
    <link href="https://res8.vmallres.com/20180305/css/echannel/index.min.css?20170320" rel="stylesheet"
          type="text/css">
    <script src="https://res10.vmallres.com/20180305/js/??/common/jsapi.js,/common/base/jquery-1.4.4.min.js,/common/ec.core.js,/echannel/ec.business.min.js,/echannel/base.min.js,/echannel/slider.min.js,/echannel/swiper.min.js"
            namespace="ec"></script>
</head>

<body class="wide">

<img src="https://res.vmallres.com/20180305/images/echannel/icon-common.png" class="hide">
<div class="shortcut">
    <div class="layout">
        <div class="s-sub">
        </div>
        <div class="s-main ">
            <img src="https://res.vmallres.com/20180305/images/echannel/bg/bg71.png" class="hide">
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
                <c:if test="${not empty CURRENT_USER}">
                    <li>
                        <a href="${basePath}/logout" timeType="timestamp">退出登录</a>
                    </li>
                </c:if>
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
            <div class="logo" style="position: relative;">
                <a href="${basePath}/" title="mmall.com - mmall商城" style="position: absolute;left: -20px; top: -10px;">
                    <img src="${basePath}/resources/images/logo.png" alt="mmall.com - mmall商城"
                         style="transform:scale(0.64);"/>
                </a>
            </div>

            <div class="naver">
                <ul class="clearfix">
                    <ul id="naver-list">
                        <c:forEach var="mainCategory" items="${categoryListVoList}">
                            <li>
                                <a href="#" onclick="goCategory(${mainCategory.id})">
                                    <span>${mainCategory.name}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    <form id="hiddenForm" action="${basePath}/product/listByCategory" method="post" target="_blank">
                        <input type="hidden" name="categoryId" id="hiddenId"/>
                    </form>
                    <script>
                        function goCategory(categoryId) {
                            $("#hiddenId").val(categoryId);
                            $("#hiddenForm").submit();
                        }

                        $(function () {
                            $('#naver-list li').hover(function () {
                                $(this).addClass('hover');
                            }, function () {
                                $(this).removeClass('hover');
                            });
                        });
                    </script>
                </ul>
            </div>
        </div>

        <div class="right">
            <!-- 2017-02-15-搜索条-焦点为search-form增加className:hover -start -->
            <div class="search-bar relative" id="searchBar-area">
                <div class="search-bar-form" id="search-bar-form">
                    <form id="searchForm" method="post" action="${basePath}/product/listByCategory" >
                        <input type="hidden" id="pageNum" name="pageNum" value="1">
                        <input type="text" class="text" name="keyword" maxlength="200" id="search-kw"
                               autocomplete="off" placeholder="根据关键字搜索商品"/>
                        <input type="hidden" name="categoryId" value="0"/>
                        <input type="submit" class="button" value="搜索"/>
                    </form>
                </div>

            </div>
            <!-- 2017-02-15-搜索条-end -->
        </div>
    </div>
</div>

<!-- 导航 -->
<div class="naver-main">
    <div class="layout">
        <div class="category category-index" id="category-block">
            <!-- 20170223-分类-start -->
            <div class="b">
                <ol class="category-list">
                    <!-- 鼠标悬停增加ClassName： hover -->
                    <c:forEach var="categoryItem" items="${categoryListVoList}">
                    <li id="zxnav_0" class="category-item " onmouseenter="showProList('zxnav_0')">
                        <div class="category-info">
                            <div>
                                <a href="#"
                                   onclick="goCategory(${categoryItem.id})"><span>${categoryItem.name}</span></a>
                            </div>
                            <c:forEach var="childCategoryItem" items="${categoryItem.categoryList}" begin="0" end="1"
                                       step="1">
                                <a href="#"
                                   onclick="goCategory(${childCategoryItem.id})"><span>${childCategoryItem.name}</span></a>
                            </c:forEach>
                            <i class=""></i>
                        </div>
                        <div class="category-panels relative">
                            <div class="p-title">
                                <a class="clearfix" href="#" onclick="goCategory(${categoryItem.id})">
                                    <span class="fl">浏览${categoryItem.name}频道</span>
                                </a>
                            </div>
                            <ul class="subcate-list clearfix">
                                <c:forEach var="childCategoryItem" items="${categoryItem.categoryList}">
                                    <li class="subcate-item">
                                        <a href="#" onclick="goCategory(${childCategoryItem.id})"
                                           style="border-radius:1px;border:1px solid #cccccc;padding: 2px;margin-right: 15px;">
                                            <span>${childCategoryItem.name}</span>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                            </c:forEach>
                </ol>
            </div>

        </div>
    </div>
</div>
<script src="${basePath}/resources/js/mmall2.js"></script>

<div class="hot-board">
    <div class="ec-slider" id="index_slider">
        <ul>
            <li ID='firstImg'
                style="background:url('https://res.vmallres.com/pimages//sale/2018-04/20180425113736396c.jpg') 50% 0px no-repeat ;display: block;">
                <div style="width:100%;">
                    <img src="http://image.lbcto.com/20180425113736396c.jpg"
                         style="display:none;"/>
                    <a style="width:100%;height:450px;display:block;" href="#"></a>
                </div>
            </li>
        </ul>
    </div>
    <script src="${basePath}/resources/js/mmall4.js"></script>
    <!--ads end-->
</div>


<div class="event-float-layout">
    <div class="event-float">
        <div>
            <ul class="hover-list">
            </ul>
        </div>
    </div>
</div>

<div class="home-channel-container relative">

    <div class="layout" id="lc_443595">
        <div class="home-channel-floor">
            <div class="h">
                <h2 class="channel-title fl">手机</h2>
                <div class="channel-more fr">
                    <a href="#" onclick="goCategory(100001)">更多></a>
                </div>
            </div>
            <div class="b">
                <div class="goods-list">
                    <ul class="grid-list clearfix">
                        <li class="grid-items grid-items-md ">
                            <a class="thumb" href="javascript:;">
                                <img src="http://image.lubiao.com/1521556239580.jpg" alt=""/>
                            </a>
                        </li>
                        <c:forEach var="phone" items="${phone.list}" begin="0" end="6" step="1">
                            <li class="grid-items" title="${phone.name}${phone.subtitle}">
                                <a class="thumb" href="#" onclick="productDetail(${phone.id})">
                                    <p class="grid-img">
                                        <img src="${phone.imageHost}${phone.mainImage}" alt="${phone.name}"/>
                                    </p>
                                    <div class="grid-title">${phone.name}</div>
                                    <p class="grid-desc">${phone.subtitle}&nbsp;</p>
                                    <p class="grid-price">&yen;${phone.price}</p>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>


    <div class="layout" id="lc_443603">
        <div class="home-channel-floor">
            <div class="h">
                <h2 class="channel-title fl">笔记本电脑</h2>
                <div class="channel-more fr">
                    <a href="#" onclick="goCategory(100002)">更多></a>
                </div>
            </div>
            <div class="b">
                <div class="goods-list">
                    <ul class="grid-list clearfix">
                        <li class="grid-items grid-items-md ">
                            <a class="thumb" href="javascript:;">
                                <img src="http://image.lubiao.com/1524838871726.jpg" alt=""/>
                            </a>
                        </li>
                        <c:forEach var="computer" items="${computer.list}" begin="2" end="4" step="1">
                            <li class="grid-items" title="${computer.name}${computer.subtitle}" >
                                <a class="thumb" href="#" onclick="productDetail(${computer.id})">
                                    <p class="grid-img">
                                        <img src="${computer.imageHost}${computer.mainImage}" alt="${computer.name}"/>
                                    </p>
                                    <div class="grid-title">${computer.name}</div>
                                    <p class="grid-desc">${computer.subtitle}&nbsp;</p>
                                    <p class="grid-price">&yen;${computer.price}</p>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="layout" id="lc_443591">
        <div class="home-channel-floor">
            <div class="h">
                <h2 class="channel-title fl">智能穿戴</h2>
                <div class="channel-more fr">
                    <a href="#" onclick="goCategory(100003)">更多></a>
                </div>
            </div>
            <div class="b">
                <div class="goods-list">
                    <ul class="grid-list clearfix">
                        <li class="grid-items grid-items-md ">
                            <a class="thumb" href="javascript:;">
                                <img src="http://image.lubiao.com/1510043740940.jpg"
                                     alt=""/>
                            </a>
                        </li>
                        <c:forEach var="ware" items="${ware.list}" begin="0" end="6" step="1">
                            <li class="grid-items" title="${ware.name}${ware.subtitle}">
                                <a class="thumb" href="#" onclick="productDetail(${ware.id})">
                                    <p class="grid-img">
                                        <img src="${ware.imageHost}${ware.mainImage}" alt="${ware.name}"/>
                                    </p>
                                    <div class="grid-title">${ware.name}</div>
                                    <p class="grid-desc">${ware.subtitle}&nbsp;</p>
                                    <p class="grid-price">&yen;${ware.price}</p>
                                </a>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>
        </div>
    </div>


    <div class="layout" id="lc_443597">
        <div class="home-channel-floor">
            <div class="h">
                <h2 class="channel-title fl">智能家居</h2>
                <div class="channel-more fr">
                    <a href="#" onclick="goCategory(100004)">更多></a>
                </div>
            </div>
            <div class="b">
                <div class="goods-list">
                    <ul class="grid-list clearfix">
                        <li class="grid-items grid-items-lg">
                            <a class="thumb" href="javascript:;"
                               onclick="pushFoolAdvertMsg('5','智能家居','https://res0.vmallres.com/pimages//frontLocation/content/957167/1521713311424.jpg','1521713311424.jpg','https://www.vmall.com/product/202235028.html')">
                                <img src="http://image.lubiao.com/1523520344098.png"
                                     alt=""/>
                            </a>
                        </li>
                        <c:forEach var="home" items="${home.list}" begin="0" end="6" step="1">
                            <li class="grid-items" title="${home.name}${home.subtitle}" >
                                <a class="thumb" href="#" onclick="productDetail(${home.id})">
                                    <p class="grid-img">
                                        <img src="${home.imageHost}${home.mainImage}" alt="${home.name}"/>
                                    </p>
                                    <div class="grid-title">${home.name}</div>
                                    <p class="grid-desc">${home.subtitle}&nbsp;</p>
                                    <p class="grid-price">&yen;${home.price}</p>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <form id="hiddenForm2" action="${basePath}/product/productDetail" method="post" target="_blank">
        <input type="hidden" name="productId" id="hiddenId3" />
    </form>
    <script>
        function productDetail(productId){
            $("#hiddenId3").val(productId);
            $("#hiddenForm2").submit();
        }
    </script>


    <div class="hr-20"></div>
</div>

<div class="channel-floor">
    <div class="layout">
        <div class="ad fl">
        </div>
    </div>
    <div class="hr-60"></div>
</div>


<script src="${basePath}/resources/js/mmall3.js"></script>


<!--    提示框 start -->
<%@include file="../common/msgBox.jsp" %>
<!--    提示框 -->
</body>

</html>
