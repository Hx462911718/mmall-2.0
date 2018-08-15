<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/common.jsp" %>
<html>
<head>
    <title>订单详情</title>
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">
    <link href="https://res8.vmallres.com/20180504/css/echannel/ec.core.base.min.css?20170722" rel="stylesheet" type="text/css">

    <link href="https://res8.vmallres.com/20180504/css/order/main.min.css?20180212" rel="stylesheet" type="text/css">
    <script src="https://res9.vmallres.com/20180504/js/common/jsapi.js?20141025" namespace="ec"></script>
    <script src="https://res9.vmallres.com/20180504/js/common/base/jquery-1.4.4.min.js"></script>
    <script src="https://res9.vmallres.com/20180504/js/common/ec.core.js?20141025"></script>
    <script src="https://res9.vmallres.com/20180504/js/echannel/ec.business.min.js?20171028"></script>
    <script src="https://res9.vmallres.com/20180504/js/echannel/base.min.js?20171028"></script>
    <script id="jsapi_loader0" loadtype="insert" type="text/javascript" src="https://res9.vmallres.com/20180504/js/common/ec.box/box-min.js"></script>
    <script>(function () { var time = 0, el = document.getElementById('jsapi_loader0'); if (!el || (el.readyState && 'complete' != el.readyState)) { if (time < 10) { setTimeout(arguments.callee, 30); time++; } else { logger.error('load the script of id jsapi_loader0 fail!'); } return; } ol._setLoadStatus("ec.box/box-min.js", "complete"); })();</script>
    <script src="https://res9.vmallres.com/20180504/js/echannel/slider.min.js?20170426"></script>
    <script src="https://res9.vmallres.com/20180504/js/echannel/swiper.min.js?20170426"></script>
    <!--[if lt IE 9]><script src="https://res9.vmallres.com/20180504/js/common/html5shiv.js"></script> <![endif]-->
</head>
<body class="wide">
<link href="${basePath}/resources/css/cart-css.css">
<div class="top-banner" id="top-banner-block"></div>
<img src="https://res.vmallres.com/20180504/images/echannel/icon-common.png" class="hide">
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
                    <a href="${basePath}/cart/" timeType="timestamp">购物车</a>
                </li>
            </ul>
        </div>

    </div>
</div>


<div class="header order-header">
    <div class="layout">
        <div class="left">
            <!-- 2017-06-19-logo-文字-start -->
            <div class="logo logo-word" style="position: relative;">
                <a href="${basePath}/" title="mmall商城" style="position: absolute;left: -47px; top: -15px;">
                    <img src="${basePath}/resources/images/logo.png" style="transform:scale(0.6);" alt="mmall商城">
                </a>
                <span style="margin-left: 180px;font-family:Helvetica Neue;">订单详情</span>
            </div>
            <!-- 2017-06-19-logo-文字-end -->
        </div>

    </div>
</div>


<div class="layout " >
    <div class="hr-20"></div>

    <div class="sc-pro-title clearfix" id="shopping-cart-product-list" style="border: 1px solid #EEE;background: #EEE;margin-top: 20px;">
        <label style="cursor: pointer"></label>
        <ul class="clearfix">
            <li style="margin-left: -17px;width:200px;">订单信息</li>
        </ul>
    </div>
    <div id="cart-list" style="margin-top:-10px;">
            <div class="sc-pro">
                <div class="sc-pro-list clearfix" style="border: 1px solid #EEE;width: 1158px;background: #FAFAFA;" >
                    <div class="sc-pro-area " id="sc-pro-area-10086221210400">
                        <div class="sc-pro-main clearfix">
                            <p>订单号：${orderDetail.orderNo}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;创建时间：${orderDetail.createTime}</p></br>
                            <p>收件人：${orderDetail.shippingVo.receiverName}</p></br>
                            <p>手机号码：${orderDetail.shippingVo.receiverPhone}</p></br>
                            <p>收货地址：${orderDetail.shippingVo.receiverProvince}  ${orderDetail.shippingVo.receiverCity}  ${orderDetail.shippingVo.receiverAddress}</p></br>
                            <p>订单状态：${orderDetail.statusDesc}
                                <c:if test="${orderDetail.status eq 10}">
                                    <a href="${basePath}/order/payCode?orderNo=${orderDetail.orderNo}"><button>立即支付</button></a>
                                </c:if>
                            </p></br>
                            <p>支付方式：${orderDetail.paymentTypeDesc}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <div class="sc-pro-title clearfix" id="shopping-cart-product-list" style="border: 1px solid #EEE;background: #EEE;margin-top: 20px;">
        <label style="cursor: pointer"></label>
        <ul class="clearfix">
            <li style="margin-left: -17px;width:200px;">商品清单</li>
        </ul>
    </div>

    <c:forEach var="orderDetails" items="${orderDetail.orderItemVoList}">
        <div id="cart-list" style="margin-top:-10px;">
            <!--product-list start-->
            <div class="sc-pro">
                <!--单品start-->
                <div class="sc-pro-list clearfix" style="border: 1px solid #EEE;width: 1158px;background: #FAFAFA;" >
                    <div class="sc-pro-area " id="sc-pro-area-10086221210400">
                        <div class="sc-pro-main clearfix">
                            <!--至灰时添加class="disabled"-->
                            <a href="#" class="p-img">
                                <img alt="${orderDetails.productName}" src="${orderDetail.imageHost}${orderDetails.productImage}">
                            </a>
                            <ul>
                                <li>
                                    <a href="#" class="p-name" title="${orderDetails.productName}" >
                                            ${orderDetails.productName}
                                    </a>
                                </li>
                                <li>
                                    <div class="p-price" style="width: 200px;">
                                        <span>价格：<font color="red">¥&nbsp;${orderDetails.currentUnitPrice}</font></span>
                                    </div>
                                </li>
                                <li>
                                    <div class="p-price" style="width: 200px;margin-left: 40px;">
                                        <span>数量：x${orderDetails.quantity}</span>
                                    </div>
                                </li>
                                <li>
                                    <div class="p-price" style="width: 200px;margin-left: 99px;">
                                        <span>总价：<font color="red">￥${orderDetails.totalPrice}</font></span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <div class="sc-pro-title clearfix" id="shopping-cart-product-list" style="border: 1px solid #EEE;background: #EEE;margin-top: 0px;margin-bottom: 70px;">
        <label style="cursor: pointer"></label>
        <ul class="clearfix">
            <li style="text-align:right;font-size:20px;margin-left: -17px;width:1100px;">订单总价：<font color="red">￥${orderDetail.payment}</font></li>
        </ul>
    </div>
</div>





</body>
</html>
