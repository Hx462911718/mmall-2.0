<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/common.jsp" %>
<html>

<head>

    <title>购物车</title>
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
                <span style="margin-left: 180px;font-family:Helvetica Neue;">我的购物车</span>
            </div>
            <!-- 2017-06-19-logo-文字-end -->
        </div>

    </div>
</div>
<div class="layout " >
    <div class="hr-20"></div>
    <!--20170721-购物车-start -->
    <div class="sc-list">
        <!--20170721-购物车-标题-start -->
        <c:if test="${!empty cartVo.cartProductVoList}">
        <div class="sc-pro-title clearfix" id="shopping-cart-product-list" style="border: 1px solid #EEE;">
            <label style="cursor: pointer">
                <%--<i class="icon-choose-normal icon-choose icon-choose-all" id="checkAll-top"></i>全选</label>--%>
                <c:if test="${cartVo.allChecked}">
                    <input type="checkbox" checked="checked"/>全选
                </c:if>
                <c:if test="${!cartVo.allChecked}">
                    <input type="checkbox"/>全选
                </c:if>

            </label>
            <ul class="clearfix">
                <li style="margin-left: -17px;">商品</li>
                <li>单价</li>
                <li>数量</li>
                <li>小计</li>
                <li>操作</li>
            </ul>
        </div>
        </c:if>

        <!--20170721-购物车-空数据-start-->
        <c:if test="${empty cartVo.cartProductVoList}">
            <div id="cart-empty-msg" class="sc-empty" style="display: block;">
                <span class="icon-minicart"></span>
                <p>您的购物车里什么也没有哦~</p>
                <a href="${basePath}/">去逛逛</a>
            </div>
        </c:if>
        <!--20170721-购物车-空数据-end-->

        <form id="cart-form" autocomplete="off" method="get">
        <c:forEach var="cartItem" items="${cartVo.cartProductVoList}" varStatus="varStatus">
                <div id="cart-list">
                    <!--product-list start-->
                    <div class="sc-pro">
                        <!--单品start-->
                        <div class="sc-pro-list clearfix" style="border: 1px solid #EEE;width: 1160px;">
                            <%--<i class="icon-choose-normal icon-choose" id=""></i>--%>
                            <c:if test="${cartItem.productChecked eq 1}">
                                <input type="checkbox" name="test" class="cartCheckBox" value="${cartItem.id}" productId="${cartItem.productId}" id="${cartItem.id}" checked="checked" style="cursor: pointer;float: left;" onclick="selected(${cartItem.id} , ${cartItem.productId})"/>
                            </c:if>
                            <c:if test="${cartItem.productChecked eq 0}">
                                <input type="checkbox" name="test" class="cartCheckBox" value="${cartItem.id}" productId="${cartItem.productId}" id="${cartItem.id}" style="cursor: pointer;float: left;" onclick="selected(${cartItem.id} , ${cartItem.productId})"/>
                            </c:if>
                            <div class="sc-pro-area " id="sc-pro-area-10086221210400">
                                <div class="sc-pro-main clearfix">
                                    <!--至灰时添加class="disabled"-->
                                    <a href="#" class="p-img">
                                        <img alt="${cartItem.productName}${cartItem.productSubtitle}" src="${cartVo.imageHost}${cartItem.productMainImage}">
                                    </a>
                                    <ul>
                                        <li>
                                            <a href="#" class="p-name" title="${cartItem.productName}${cartItem.productSubtitle}" >
                                                    ${cartItem.productName}${cartItem.productSubtitle}
                                            </a>
                                        </li>
                                        <li>
                                            <div class="p-price">
                                                <span>¥&nbsp;${cartItem.productPrice}</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="p-stock">
                                                <div class="p-stock-area">
                                                    <input type="text" class="p-stock-text ${cartItem.id}" value="${cartItem.quantity}">
                                                    <p class="p-stock-btn" id="p-stock-btn-area">
                                                        <a id="pro-quantity-plus" href="javascript:;" onclick="plus(${cartItem.id} , ${cartItem.productId} , ${varStatus.index})">+</a>
                                                        <a id="pro-quantity-minus" href="javascript:;" onclick="minus(${cartItem.id} , ${cartItem.productId} , ${varStatus.index})">−</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </li>
                                        <script>
                                            function plus(obj , productId , index){
                                                var num = $("."+obj).val();
                                                $("."+obj).val(parseInt(num) + 1);
                                                var count = $("."+obj).val();


                                                $.ajax({
                                                    type : 'POST',
                                                    url : '${basePath}/cart/update',
                                                    dataType : 'json' ,
                                                    data : {
                                                        'productId' : productId,
                                                        'count' : count
                                                    },
                                                    success : function(data) {
                                                        if(data.status == 10){
                                                            window.location.href="${basePath}/login";
                                                        }
                                                        else if (data.status == 0) {
                                                            //修改单个商品的总价格
                                                            var productTotalPrice = data.data.cartProductVoList[index].productTotalPrice;

                                                            $(".p-price-total-" + obj).html("");
                                                            $(".p-price-total-" + obj).html("¥&nbsp;" + productTotalPrice + ".00");

                                                            //修改总价格
                                                            //alert(data.data.cartTotalPrice);
                                                            $("#sc-cartInfo-totalOriginalPrice").html("");
                                                            $("#sc-cartInfo-totalOriginalPrice").html("¥&nbsp;" + data.data.cartTotalPrice + ".0");

                                                        } else {

                                                        }
                                                    },
                                                    error : function(data) {
                                                        $("#msgBoxInfo").html("程序执行出错");
                                                        $("#msgBox").modal('show');
                                                        $("#addModal").modal('hide');
                                                    }

                                                });


                                            }
                                            function minus(obj , productId , index){
                                                var num = $("."+obj).val();
                                                if(parseInt(num) > 1){
                                                    $("."+obj).val(parseInt(num) - 1);
                                                }
                                                var count = $("."+obj).val();
                                                $.ajax({
                                                    type : 'POST',
                                                    url : '${basePath}/cart/update',
                                                    dataType : 'json' ,
                                                    data : {
                                                        'productId' : productId,
                                                        'count' : count
                                                    },
                                                    success : function(data) {
                                                        if(data.status == 10){
                                                            window.location.href="${basePath}/login";
                                                        }
                                                        else if (data.status == 0) {
                                                            //修改单个商品的总价格
                                                            var productTotalPrice = data.data.cartProductVoList[index].productTotalPrice;

                                                            $(".p-price-total-" + obj).html("");
                                                            $(".p-price-total-" + obj).html("¥&nbsp;" + productTotalPrice + ".00");

                                                            //修改总价格
                                                            //alert(data.data.cartTotalPrice);
                                                            $("#sc-cartInfo-totalOriginalPrice").html("");
                                                            $("#sc-cartInfo-totalOriginalPrice").html("¥&nbsp;" + data.data.cartTotalPrice + ".0");

                                                        } else {

                                                        }
                                                    },
                                                    error : function(data) {
                                                        $("#msgBoxInfo").html("程序执行出错");
                                                        $("#msgBox").modal('show');
                                                        $("#addModal").modal('hide');
                                                    }

                                                });
                                            }

                                            function selected(id , productId){
                                               var flag = $("#"+id).is(":checked");
                                               if(flag){
                                                   //window.location.href="${basePath}/cart/select?productId="+productId;
                                                   $.ajax({
                                                       type : 'POST',
                                                       url : '${basePath}/cart/select',
                                                       dataType : 'json' ,
                                                       data : {
                                                           'productId' : productId
                                                       },
                                                       success : function(data) {
                                                           if(data.status == 10){
                                                               window.location.href="${basePath}/login";
                                                           }
                                                           else if (data.status == 0) {
                                                            //修改总价格
                                                               //alert(data.data.cartTotalPrice);
                                                               $("#sc-cartInfo-totalOriginalPrice").html("");
                                                               $("#sc-cartInfo-totalOriginalPrice").html("¥&nbsp;" + data.data.cartTotalPrice + ".0");

                                                           } else {

                                                           }
                                                       },
                                                       error : function(data) {
                                                           $("#msgBoxInfo").html("程序执行出错");
                                                           $("#msgBox").modal('show');
                                                           $("#addModal").modal('hide');
                                                       }

                                                   });
                                               }else{
                                                   //window.location.href="${basePath}/cart/un_select?productId="+productId;
                                                   $.ajax({
                                                       type : 'POST',
                                                       url : '${basePath}/cart/un_select',
                                                       dataType : 'json' ,
                                                       data : {
                                                           'productId' : productId
                                                       },
                                                       success : function(data) {
                                                           if(data.status == 10){
                                                               window.location.href="${basePath}/login";
                                                           }
                                                           else if (data.status == 0) {
                                                               //修改总价格
                                                               //alert(data.data.cartTotalPrice);
                                                               $("#sc-cartInfo-totalOriginalPrice").html("");
                                                               $("#sc-cartInfo-totalOriginalPrice").html("¥&nbsp;" + data.data.cartTotalPrice + ".0");

                                                           } else {

                                                           }
                                                       },
                                                       error : function(data) {
                                                           $("#msgBoxInfo").html("程序执行出错");
                                                           $("#msgBox").modal('show');
                                                           $("#addModal").modal('hide');
                                                       }

                                                   });
                                               }

                                            }
                                        </script>
                                        <li class="p-price-total-${cartItem.id}" id="">¥&nbsp;${cartItem.productTotalPrice}</li>
                                        <li>
                                            <a href="javascript:;" class="p-del" onclick="deleteCartById(${cartItem.productId})">删除</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </c:forEach>
        </form>
        <script>
        function deleteCartById(productId){
            $("#msgBoxConfirmInfo").html("确定要删除吗?");
            $("#msgBoxConfirm").modal('show');
            $("#msgBoxConfirmButton").on('click' , function(){//点击确认按钮时执行下面的方法
                $.ajax({
                    type : 'POST',
                    url : '${basePath}/cart/delete_product',
                    data : {
                        'productIds' : productId.toString()
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
    </div>
    <!-- 20170721-购物车-end -->
    <c:if test="${!empty cartVo.cartProductVoList}">
        <div id="center_balance" class="">
        <div id="cart-total-area" class="sc-total-tool layout clearfix " style="border: 1px solid #EEE;width: 1200px;margin-bottom: 50px;">
            <div class="sc-total-control">
                <label style="cursor: pointer">
                    <%--<i class="icon-choose-normal icon-choose icon-choose-all" id="checkAll-buttom"></i>--%>
                        <c:if test="${cartVo.allChecked}">
                            <input type="checkbox" checked="checked"/>全选
                        </c:if>
                        <c:if test="${!cartVo.allChecked}">
                            <input type="checkbox"/>全选
                        </c:if>

                </label>
                <a href="javascript:;" class="p-del" onclick="deleteCart()">删除选中</a>
            </div>
            <div class="sc-total-btn">
                <a href="javascript:;" id="payNow" lubiao="dsfaasdf" onclick="payNow()">立即结算</a>
            </div>
            <div class="sc-total-price">
                <p>
                    <label>总计：</label>
                    <span id="sc-cartInfo-totalOriginalPrice">¥&nbsp;${cartVo.cartTotalPrice}</span>
                </p>
            </div>
            <script>
                function payNow(){
                   /* var cartIds =[];
                    $('input[name="test"]:checked').each(function(){
                        cartIds.push($(this).attr('productId'));
                    });
                    alert(cartIds);*/
                   window.location.href="${basePath}/cart/confirmCart";

                }

                function deleteCart(){
                    var cartIds =[];
                    $('input[name="test"]:checked').each(function(){
                        cartIds.push($(this).attr('productId'));
                    });
                    $("#msgBoxConfirmInfo").html("确定要删除吗?");
                    $("#msgBoxConfirm").modal('show');
                    $("#msgBoxConfirmButton").on('click' , function(){//点击确认按钮时执行下面的方法
                        $.ajax({
                            type : 'POST',
                            url : '${basePath}/cart/delete_product',
                            data : {
                                'productIds' : cartIds.toString()
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
        </div>
    </div>
    </c:if>
</div>
<!--    提示框 start -->
<%@include file="../../common/msgBox.jsp" %>
<!--    提示框 -->
</body>

</html>