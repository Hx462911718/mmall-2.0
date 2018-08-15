<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/common.jsp" %>
<html>
<head>
    <title>${category.name}——mmall商城</title>
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">
    <link href="http://res8.vmallres.com/20180323/css/echannel/ec.core.base.min.css?20170722" rel="stylesheet"
          type="text/css">
    <link href="http://res8.vmallres.com/20180323/css/echannel/index.min.css?20170320" rel="stylesheet"
          type="text/css">
    <link href="http://res8.vmallres.com/20180323/css/echannel/main.min.css?20170106" rel="stylesheet" type="text/css">
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
<!-- 2017-06-19-捷径栏-end -->


<div class="header">
    <div class="layout">
        <div class="left">
            <!-- 2017-02-15-logo-start -->
            <div class="logo" style="position: relative;">
                <a href="${basePath}/" title="mmall.com - mmall商城" style="position: absolute;left: -47px; top: -15px;">
                    <img src="${basePath}/resources/images/logo.png" alt="mmall.com - mmall商城" style="transform:scale(0.6);"/>
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

            <div class="right">
                <!-- 2017-02-15-搜索条-焦点为search-form增加className:hover -start -->
                <div class="search-bar relative" id="searchBar-area">
                    <div class="search-bar-form" id="search-bar-form">
                        <form id="searchForm" method="post" action="${basePath}/product/listByCategory" >
                            <input type="hidden" id="pageNum" name="pageNum" value="1">
                            <input type="text" class="text" name="keyword" maxlength="200" id="search-kw"
                                   autocomplete="off" placeholder="根据关键字搜索商品" value="${keyword}"/>
                            <input type="hidden" name="categoryId" value="${category.id}"/>
                            <input type="submit" class="button" value="搜索"/>
                        </form>
                    </div>

                </div>
                <!-- 2017-02-15-搜索条-end -->
            </div>
        </div>
    </div>
    <!-- 2017-02-15-头部-end -->

    <div class="hr-10"></div>
    <div class="g">
        <!--面包屑 -->
        <div class="breadcrumb-area fcn">
            <a href="#" title="首页">首页</a>&nbsp;>&nbsp;
            <c:if test="${not empty parentCategory}">
                <span>${parentCategory.name}</span>&nbsp;>&nbsp;
            </c:if>
            <span>${category.name}</span>
        </div>
    </div>
    <div class="hr-10"></div>
    <div class="layout">
        <!-- 20140726-商品类别-start -->
        <div class="pro-cate-area">
            <!-- 20140726-商品类别-属性-start -->
            <div class="pro-cate-attr clearfix">
                <div class="p-title">分类：</div>
                <div class="p-default">
                    <ul>
                        <c:if test="${empty parentCategory}">
                            <li id="first-category" class="selected">
                                <a href="#">全部</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty parentCategory}">
                            <li id="first-category">
                                <a href="#" onclick="goCategory(${parentCategory.id})">全部</a>
                            </li>
                        </c:if>
                    </ul>
                </div>

                <div class="p-values">
                    <div class="p-expand">
                        <ul class="clearfix">
                            <c:if test="${empty sameLevelCategoryList}">
                                <c:forEach var="categoryList" items="${categoryList}">
                                    <li>
                                        <a href="#" onclick="goCategory(${categoryList.id})">${categoryList.name}</a>
                                    </li>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not empty sameLevelCategoryList}">
                                <c:forEach var="categoryList" items="${sameLevelCategoryList}">
                                    <c:if test="${categoryList.name eq category.name}">
                                        <li class="selected">
                                            <a href="#" onclick="goCategory(${categoryList.id})">${categoryList.name}</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${categoryList.name ne category.name}">
                                        <li>
                                            <a href="#" onclick="goCategory(${categoryList.id})">${categoryList.name}</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </ul>
                        <form id="hiddenForm" action="${basePath}/product/listByCategory" method="post">
                            <input type="hidden" name="categoryId" id="hiddenId2" />
                        </form>
                        <script>
                            function goCategory(categoryId){
                                $("#hiddenId2").val(categoryId);
                                $("#hiddenForm").submit();
                            }
                        </script>
                    </div>
                </div>

            </div>
            <div class="pro-cate-sort clearfix">
                <div class="p-title">排序：</div>
                <div class="p-default">
                    <ul>
                        <li id="sort-0" class="selected">
                            <a href="javascript:;" >默认</a>
                        </li>
                    </ul>
                </div>
                <div class="p-values">
                    <div class="p-expand">
                        <ul class="clearfix">
                            <li id="sort-1" <%--class="sort-asc selected"--%>>
                                <a href="javascript:;" class="sort-price">价格
                                    <s></s>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>

        <div class="hr-20"></div>
    </div>


    <div class="layout">
        <div class="channel-list">
            <div class="pro-list clearfix">
                <ul>
                    <c:if test="${page.total == 0}">
                        <li style="margin-left: -60px; color:#e01d20;">很抱歉，没有找到您需要的商品。<li>
                    </c:if>
                    <c:forEach var="productList" items="${page.list}">
                        <li>
                            <div class="pro-panels">
                                <p class="p-img">
                                    <a href="#" onclick="productDetail(${productList.id})"
                                       title="${productList.name}${productList.subtitle}">
                                        <img alt="${productList.name}${productList.subtitle}" src="${productList.imageHost}${productList.mainImage}"/>
                                    </a>
                                </p>
                                <p class="p-name">
                                    <a href="#" onclick="productDetail(${productList.id})"
                                       title="${productList.name}${productList.subtitle}">${productList.name}
                                        <span class="red"></span>
                                    </a>
                                </p>
                                <p class="p-price">
                                    <b>&yen;${productList.price}</b>
                                </p>
                                <div class="p-button clearfix">
                                    <table colspan="0" border="0" rowspan="0">
                                        <tbody>
                                        <tr>
                                            <td>
                                                <a  href="#" onclick="productDetail(${productList.id})"
                                                   class="p-button-cart">
                                                    <span>加入购物车</span>
                                                </a>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </li>
                    </c:forEach>

                    <form id="hiddenForm2" action="${basePath}/product/productDetail" method="post" target="_blank">
                        <input type="hidden" name="productId" id="hiddenId3" />
                    </form>
                    <script>
                        function productDetail(productId){
                            $("#hiddenId3").val(productId);
                            $("#hiddenForm2").submit();
                        }
                    </script>

                    <%--<li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086157327552.html" title="华为畅享8e 3GB+32GB 全网通版（黑色）"
                                   onclick="pushListProClickMsg('2601010029601')">
                                    <img alt="华为畅享8e 3GB+32GB 全网通版（黑色）"
                                         src="http://res.vmallres.com/pimages//product/6901443225798/428_428_1521789024901mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086157327552.html" title="华为畅享8e 3GB+32GB 全网通版（黑色）"
                                   onclick="pushListProClickMsg('2601010029601')">华为畅享8e 3GB+32GB 全网通版（黑色）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;1099</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a href="http://www.vmall.com/product/10086453929323.html" target="_blank"
                                               class="p-button-an">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            &lt;%&ndash;<s class="p-tag">
                                <img alt="华为畅享8e 3GB+32GB 全网通版（黑色）"
                                     src="http://res.vmallres.com/pimages//tag/79/1497575938261.png"/>
                            </s>&ndash;%&gt;
                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086453929323.html"
                                   title="【100元订金抵150元】华为畅享8e 3GB+32GB 全网通版（黑色）"
                                   onclick="pushListProClickMsg('2601010036401')">
                                    <img alt="华为畅享8e 3GB+32GB 全网通版（黑色）"
                                         src="http://res.vmallres.com/pimages//product/6901443225798/428_428_1521789024901mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086453929323.html"
                                   title="【100元订金抵150元】华为畅享8e 3GB+32GB 全网通版（黑色）"
                                   onclick="pushListProClickMsg('2601010036401')">华为畅享8e 3GB+32GB 全网通版（黑色）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <em>暂无报价</em>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/10086453929323.html"
                                               class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086195106339.html"
                                   title="华为畅享8 Plus 4GB+128GB 全网通版（金色）" onclick="pushListProClickMsg('2601010028706')">
                                    <img alt="华为畅享8 Plus 4GB+128GB 全网通版（金色）"
                                         src="http://res.vmallres.com/pimages//product/6901443224418/428_428_1521296102232mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086195106339.html"
                                   title="华为畅享8 Plus 4GB+128GB 全网通版（金色）" onclick="pushListProClickMsg('2601010028706')">华为畅享8
                                    Plus 4GB+128GB 全网通版（金色）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;1899</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/10086195106339.html"
                                               class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            &lt;%&ndash;<s class="p-tag">
                                <img alt="华为畅享8 Plus 4GB+128GB 全网通版（金色）"
                                     src="http://res.vmallres.com/pimages//tag/79/1497575938261.png"/>
                            </s>&ndash;%&gt;
                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086733534868.html" title="华为畅享8 4GB+64GB 全网通高配版（蓝色）"
                                   onclick="pushListProClickMsg('2601010028807')">
                                    <img alt="华为畅享8 4GB+64GB 全网通高配版（蓝色）"
                                         src="http://res.vmallres.com/pimages//product/6901443218738/428_428_1521287325807mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086733534868.html" title="华为畅享8 4GB+64GB 全网通高配版（蓝色）"
                                   onclick="pushListProClickMsg('2601010028807')">华为畅享8 4GB+64GB 全网通高配版（蓝色）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;1499</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/10086733534868.html"
                                               class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                           &lt;%&ndash; <s class="p-tag">
                                <img alt="华为畅享8 4GB+64GB 全网通高配版（蓝色）"
                                     src="http://res.vmallres.com/pimages//tag/79/1497575938261.png"/>
                            </s>&ndash;%&gt;
                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086471194207.html"
                                   title="HUAWEI P20 Pro 6GB+64GB 全网通版（亮黑色）"
                                   onclick="pushListProClickMsg('2601010026801')">
                                    <img alt="HUAWEI P20 Pro 6GB+64GB 全网通版（亮黑色）"
                                         src="http://res.vmallres.com/pimages//product/6901443227907/428_428_1522651615353mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086471194207.html"
                                   title="HUAWEI P20 Pro 6GB+64GB 全网通版（亮黑色）"
                                   onclick="pushListProClickMsg('2601010026801')">HUAWEI P20 Pro 6GB+64GB 全网通版（亮黑色）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <em>暂无报价</em>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a href="http://sale.vmall.com/p20buy.html" target="_blank"
                                               class="p-button-an">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                          &lt;%&ndash;  <s class="p-tag">
                                <img alt="HUAWEI P20 Pro 6GB+64GB 全网通版（亮黑色）"
                                     src="http://res.vmallres.com/pimages//tag/79/1497575938261.png"/>
                            </s>&ndash;%&gt;
                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086915330134.html"
                                   title="HUAWEI P20 6GB+64GB 全网通版（亮黑色）" onclick="pushListProClickMsg('2601010026701')">
                                    <img alt="HUAWEI P20 6GB+64GB 全网通版（亮黑色）"
                                         src="http://res.vmallres.com/pimages//product/6901443223459/428_428_1522652355294mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086915330134.html"
                                   title="HUAWEI P20 6GB+64GB 全网通版（亮黑色）" onclick="pushListProClickMsg('2601010026701')">HUAWEI
                                    P20 6GB+64GB 全网通版（亮黑色）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <em>暂无报价</em>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a href="http://sale.vmall.com/p20buy.html" target="_blank"
                                               class="p-button-an">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                          &lt;%&ndash;  <s class="p-tag">
                                <img alt="HUAWEI P20 6GB+64GB 全网通版（亮黑色）"
                                     src="http://res.vmallres.com/pimages//tag/79/1497575938261.png"/>
                            </s>&ndash;%&gt;
                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086570096517.html"
                                   title="【新品首发】HUAWEI nova 3e 4GB+128GB 全网通版（克莱因蓝）"
                                   onclick="pushListProClickMsg('2601010025206')">
                                    <img alt="HUAWEI nova 3e 4GB+128GB 全网通版（克莱因蓝）"
                                         src="http://res.vmallres.com/pimages//product/2601010025206/428_428_1523351983155mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086570096517.html"
                                   title="【新品首发】HUAWEI nova 3e 4GB+128GB 全网通版（克莱因蓝）"
                                   onclick="pushListProClickMsg('2601010025206')">HUAWEI nova 3e 4GB+128GB 全网通版（克莱因蓝）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;2199</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/10086570096517.html"
                                               class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                           &lt;%&ndash; <s class="p-tag">
                                <img alt="【新品首发】HUAWEI nova 3e 4GB+128GB 全网通版（克莱因蓝）"
                                     src="http://res.vmallres.com/pimages//tag/79/1497575938261.png"
                                />
                            </s>&ndash;%&gt;
                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086612047184.html"
                                   title="荣耀9青春版 移动4G+高配版 4GB+32GB（幻夜黑）" onclick="pushListProClickMsg('2601010028301')">
                                    <img alt="荣耀9青春版 移动4G+高配版 4GB+32GB（幻夜黑）"
                                         src="http://res.vmallres.com/pimages//product/6901443211821/428_428_1520586237115mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086612047184.html"
                                   title="荣耀9青春版 移动4G+高配版 4GB+32GB（幻夜黑）" onclick="pushListProClickMsg('2601010028301')">荣耀9青春版
                                    移动4G+高配版 4GB+32GB（幻夜黑）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;1399</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a href="javascript:;" onclick="ec.product.arrival(10086276179107)"
                                               class="p-button-an">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/461751298.html" title="HUAWEI 麦芒5 全网通高配版（香槟金）"
                                   onclick="pushListProClickMsg('1001010036301')">
                                    <img alt="HUAWEI 麦芒5 全网通高配版（香槟金）"
                                         src="http://res.vmallres.com/pimages//product/6901443137015/428_428_1467859642209mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/461751298.html" title="HUAWEI 麦芒5 全网通高配版（香槟金）"
                                   onclick="pushListProClickMsg('1001010036301')">HUAWEI 麦芒5 全网通高配版（香槟金）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;2399</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a href="javascript:;" onclick="ec.product.arrival(444314191)"
                                               class="p-button-an">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086883263315.html"
                                   title="荣耀畅玩7C 全网通标配版 3GB+32GB（幻夜黑）" onclick="pushListProClickMsg('2601010025502')">
                                    <img alt="荣耀畅玩7C 全网通标配版 3GB+32GB（幻夜黑）"
                                         src="http://res.vmallres.com/pimages//product/6901443218912/428_428_1520998608898mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086883263315.html"
                                   title="荣耀畅玩7C 全网通标配版 3GB+32GB（幻夜黑）" onclick="pushListProClickMsg('2601010025502')">荣耀畅玩7C
                                    全网通标配版 3GB+32GB（幻夜黑）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;899</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/10086883263315.html"
                                               class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086580593850.html"
                                   title="荣耀V10 移动4G+高配版 6GB+64GB（幻夜黑）" onclick="pushListProClickMsg('2601010028204')">
                                    <img alt="荣耀V10 移动4G+高配版 6GB+64GB（幻夜黑）"
                                         src="http://res.vmallres.com/pimages//product/6901443210121/428_428_1520567827978mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086580593850.html"
                                   title="荣耀V10 移动4G+高配版 6GB+64GB（幻夜黑）" onclick="pushListProClickMsg('2601010028204')">荣耀V10
                                    移动4G+高配版 6GB+64GB（幻夜黑）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;2799</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a href="javascript:;" onclick="ec.product.arrival(10086294294998)"
                                               class="p-button-an">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/570379791.html" title="荣耀V10 全网通高配版 6GB+64GB（极光蓝）"
                                   onclick="pushListProClickMsg('2601010014006')">
                                    <img alt="荣耀V10 全网通高配版 6GB+64GB（极光蓝）"
                                         src="http://res.vmallres.com/pimages//product/6901443210244/428_428_1511747365975mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/570379791.html" title="荣耀V10 全网通高配版 6GB+64GB（极光蓝）"
                                   onclick="pushListProClickMsg('2601010014006')">荣耀V10 全网通高配版 6GB+64GB（极光蓝）
                                    <span class="red">限时直降200元</span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;2799</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/570379791.html" class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                           &lt;%&ndash; <s class="p-tag">
                                <img alt="荣耀V10 全网通高配版 6GB+64GB（极光蓝）"
                                     src="http://res.vmallres.com/pimages//tag/77/1497575918300.png"/>
                            </s>&ndash;%&gt;
                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/10086260510042.html"
                                   title="【购机送商城代金券+话费】荣耀V10 全网通标配版 4GB+64GB（极光蓝）"
                                   onclick="pushListProClickMsg('2601010024401')">
                                    <img alt="【购机送商城代金券+话费】荣耀V10 全网通标配版 4GB+64GB（极光蓝）"
                                         src="http://res.vmallres.com/pimages//product/6901443210213/428_428_1513158355343mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/10086260510042.html"
                                   title="【购机送商城代金券+话费】荣耀V10 全网通标配版 4GB+64GB（极光蓝）"
                                   onclick="pushListProClickMsg('2601010024401')">【购机送商城代金券+话费】荣耀V10 全网通标配版
                                    4GB+64GB（极光蓝）
                                    <span class="red">人工智能芯片 全面屏旗舰</span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;2499</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/10086260510042.html"
                                               class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/738677717.html" title="荣耀V9 全网通高配版 6GB+64GB（极光蓝）"
                                   onclick="pushListProClickMsg('1001010040206')">
                                    <img alt="荣耀V9 全网通高配版 6GB+64GB（极光蓝）"
                                         src="http://res.vmallres.com/pimages//product/6901443169443/428_428_1506589486461mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/738677717.html" title="荣耀V9 全网通高配版 6GB+64GB（极光蓝）"
                                   onclick="pushListProClickMsg('1001010040206')">荣耀V9 全网通高配版 6GB+64GB（极光蓝）
                                    <span class="red">双镜头/麒麟960芯片/2K屏</span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;2699</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a href="javascript:;" onclick="ec.product.arrival(107557000)"
                                               class="p-button-an">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/501317311.html" title="荣耀9青春版 全网通标配版（魅海蓝）"
                                   onclick="pushListProClickMsg('2601010016403')">
                                    <img alt="荣耀9青春版 全网通标配版（魅海蓝）"
                                         src="http://res.vmallres.com/pimages//product/6901443211937/428_428_1513560677378mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/501317311.html" title="荣耀9青春版 全网通标配版（魅海蓝）"
                                   onclick="pushListProClickMsg('2601010016403')">荣耀9青春版 全网通标配版（魅海蓝）
                                    <span class="red">正反四摄/5.65英寸全面屏*</span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;1099</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/501317311.html" class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/832675437.html" title="华为畅享7S 4GB+64GB 全网通高配版（蓝色）"
                                   onclick="pushListProClickMsg('2601010013017')">
                                    <img alt="华为畅享7S 4GB+64GB 全网通高配版（蓝色）"
                                         src="http://res.vmallres.com/pimages//product/6901443217298/428_428_1517624781373mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/832675437.html" title="华为畅享7S 4GB+64GB 全网通高配版（蓝色）"
                                   onclick="pushListProClickMsg('2601010013017')">华为畅享7S 4GB+64GB 全网通高配版（蓝色）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;1699</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/832675437.html" class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/144380118.html" title="荣耀V9 play 全网通高配版（极光蓝）"
                                   onclick="pushListProClickMsg('2601010003108')">
                                    <img alt="荣耀V9 play 全网通高配版（极光蓝）"
                                         src="http://res.vmallres.com/pimages//product/6901443196173/428_428_1505116116937mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/144380118.html" title="荣耀V9 play 全网通高配版（极光蓝）"
                                   onclick="pushListProClickMsg('2601010003108')">荣耀V9 play 全网通高配版（极光蓝）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;1199</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/144380118.html" class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/478362844.html" title="荣耀畅玩7X 全网通标配版（极光蓝）"
                                   onclick="pushListProClickMsg('2601010005802')">
                                    <img alt="荣耀畅玩7X 全网通标配版（极光蓝）"
                                         src="http://res.vmallres.com/pimages//product/6901443204793/428_428_1514860379284mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/478362844.html" title="荣耀畅玩7X 全网通标配版（极光蓝）"
                                   onclick="pushListProClickMsg('2601010005802')">荣耀畅玩7X 全网通标配版（极光蓝）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;1249</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/478362844.html" class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div class="pro-panels">
                            <p class="p-img">
                                <a target="_blank" href="/product/135859985.html"
                                   title="HUAWEI nova 2s 6GB+64G 全网通版（樱粉金）"
                                   onclick="pushListProClickMsg('2601010015408')">
                                    <img alt="HUAWEI nova 2s 6GB+64G 全网通版（樱粉金）"
                                         src="http://res.vmallres.com/pimages//product/6901443211111/428_428_1518483439580mp.jpg"
                                    />
                                </a>
                            </p>
                            <p class="p-name">
                                <a target="_blank" href="/product/135859985.html"
                                   title="HUAWEI nova 2s 6GB+64G 全网通版（樱粉金）"
                                   onclick="pushListProClickMsg('2601010015408')">HUAWEI nova 2s 6GB+64G 全网通版（樱粉金）
                                    <span class="red"></span>
                                </a>
                            </p>
                            <p class="p-price">
                                <b>&yen;2799</b>
                            </p>
                            <div class="p-button clearfix">
                                <table colspan="0" border="0" rowspan="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <a target="_blank" href="/product/135859985.html" class="p-button-cart">
                                                <span>加入购物车</span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </li>--%>
                </ul>
            </div>
            <!-- 20140727-商品列表-end -->
            <!-- 分页-start -->
            <c:if test="${page.total > 20}">
                <div class="up-clearfix">
                    <div class="up-pull-right">
                        <%@include file="../common/page2.jsp"%>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    <!--    提示框 start -->
    <%@include file="../common/msgBox.jsp"%>
    <!--    提示框 -->
    <script src="${basePath}/resources/js/index.js"></script>
</body>
</html>
