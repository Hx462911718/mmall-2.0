<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/common.jsp" %>
<html>
<head>
    <title>确认订单</title>
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">
    <link href="https://res8.vmallres.com/20180504/css/echannel/ec.core.base.min.css?20170722" rel="stylesheet"
          type="text/css">
    <link href="https://res8.vmallres.com/20180504/css/order/main.min.css?20180212" rel="stylesheet" type="text/css">
    <script src="https://res9.vmallres.com/20180504/js/common/jsapi.js?20141025" namespace="ec"></script>
    <script src="https://res9.vmallres.com/20180504/js/common/base/jquery-1.4.4.min.js"></script>
    <script src="https://res9.vmallres.com/20180504/js/common/ec.core.js?20141025"></script>
    <script src="https://res9.vmallres.com/20180504/js/echannel/ec.business.min.js?20171028"></script>
    <script src="https://res9.vmallres.com/20180504/js/echannel/base.min.js?20171028"></script>
    <script id="jsapi_loader0" loadtype="insert" type="text/javascript"
            src="https://res9.vmallres.com/20180504/js/common/ec.box/box-min.js"></script>
    <script src="${basePath}/resources/js/city.js"></script>
    <script src="https://res9.vmallres.com/20180504/js/echannel/slider.min.js?20170426"></script>
    <script src="https://res9.vmallres.com/20180504/js/echannel/swiper.min.js?20170426"></script>
    <!--[if lt IE 9]>
    <script src="https://res9.vmallres.com/20180504/js/common/html5shiv.js"></script> <![endif]-->
</head>

<body class="wide order">
<link href="${basePath}/resources/css/confirmCart.css">
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
                    <a href="#" timeType="timestamp">我的订单</a>
                </li>
            </ul>
        </div>

    </div>
</div>
<!-- 2017-06-19-捷径栏-end -->


<div class="header order-header">
    <div class="layout">
        <div class="left">
            <!-- 2017-06-19-logo-文字-start -->
            <div class="logo logo-word" style="position: relative;">
                <a href="${basePath}/" title="mmall商城" style="position: absolute;left: -47px; top: -15px;">
                    <img src="${basePath}/resources/images/logo.png" style="transform:scale(0.6);" alt="mmall商城">
                </a>
                <span style="margin-left: 180px;font-family:Helvetica Neue;">确认订单</span>
            </div>
            <!-- 2017-06-19-logo-文字-end -->
        </div>


    </div>
</div>
<script type="text/javascript">$("#progress-confirm").show();</script>
<script type="text/javascript">window._to = {start: new Date()};</script>
<script type="text/javascript">document.body.className = "wide order";</script>

<div class="layout order">
    <!--订单-表单 -->
    <div>
        <!--20170717-全局提示-start -->
        <!--20170717-全局提示-end -->

        <div class="hr-20" id="order-address-hr"></div>

        <!-- 20170717-订单表单-地址-start -->
        <div class="order-detail-area order-address" id="order-address-mod" style="padding-bottom: 30px;">
            <div class="h">
                收货地址
                <a id="upAddAddressButton" href="javascript:;" onclick="openBox()"
                   class="address-add-btn" style="display: block;">新增收货地址</a>
            </div>
            <div class="order-address-list" id="order-address-list">
                <ul class="clearfix">

                    <c:forEach var="shipping" items="${shipping.list}">
                        <li id="myAddress-${shipping.id}"  class="hide " style="display: list-item;" onclick="chooseAddress(${shipping.id})">
                            <%--<input type="hidden" id="shippingID-${shipping.id}" value="${shipping.id}"/>--%>
                            <div class="address-main">
                                <p class="clearfix">
                                    <b id="consignee-name-57404645">${shipping.receiverName}</b>
                                    <span id="consignee-tel-57404645">${shipping.receiverPhone}</span>
                                </p>
                                <div class="address-detail" id="address-detail-57404645">
                                        ${shipping.receiverProvince}&nbsp;${shipping.receiverCity}&nbsp;${shipping.receiverAddress}&nbsp;&nbsp;
                                </div>
                            </div>

                            <div class="address-sub">
                                <a class="address-edit" href="javascript:;"
                                   onclick="ec.order.myAddress.edit(57404645)">编辑</a>
                                <a class="address-del" href="javascript:;" onclick="delAddress(${shipping.id})">删除</a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <input type="hidden" id="currentAddress" value="0"/>
            </div>
            <script>
                function chooseAddress(id){
                    $("#myAddress-"+id).siblings("li").removeClass("current");  // 删除其他兄弟元素的样式
                    $("#myAddress-"+id).addClass("current");
                    $("#currentAddress").val(id);
                }
            </script>
        </div>
        <!--20170717-订单表单-地址-end -->

        <div class="hr-10"></div>


        <div class="hr-10"></div>
        <div class="order-detail-area">
            <div class="order-detail clearfix" id="order-pro-list">
                <div class="order-list" style="width:1080px;min-height: 140px;">
                    <c:forEach var="orderItem" items="${cartVo.cartProductVoList}">
                        <c:if test="${orderItem.productChecked eq 1}">
                            <div class="order-list-detail">
                                <div class="order-main clearfix ">
                                    <input type="hidden" name="productId" value="${orderItem.productId}"/>
                                    <a style="cursor:default" class="p-img">
                                        <img alt="${orderItem.productName}${orderItem.productSubtitle}"
                                             src="${cartVo.imageHost}${orderItem.productMainImage}">
                                    </a>
                                    <ul class="">
                                        <li>
                                            <a style="cursor:default;margin-left:-300px;" class="p-name"
                                               title="${orderItem.productName}${orderItem.productSubtitle}">${orderItem.productName}${orderItem.productSubtitle}</a>
                                        </li>
                                        <li>x ${orderItem.quantity}</li>
                                        <li class="p-price">
                                            ¥&nbsp;${orderItem.productTotalPrice}
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                </div>
            </div>

        </div>
        <div class="hr-10"></div>
        <div class="order-detail-area clearfix">
            <div class="order-submit">
                <!-- 20170718-订单提交-start -->
                <div class="order-submit-info" style="min-height: 40px;">
                    <div class="order-submit-price">应付总额：
                        <b>¥
                            <span id="payableTotal">${cartVo.cartTotalPrice}</span>
                        </b>
                    </div>
                </div>
                <div class="clearfix">
                    <a href="javascript:;" class="order-submit-btn" onclick="confirmCart()">
                        <span>提交订单</span>
                    </a>
                </div>
            </div>
            <!-- 20170718-订单提交-end -->
            <script>
                function confirmCart() {
                    var productIds = [];
                    $('input[name="productId"]').each(function () {
                        productIds.push($(this).val());
                    });
                    //alert(productIds);
                    var chooseAddressId = $("#currentAddress").val();
                    if(chooseAddressId == 0){
                        $("#msgBoxInfo").html("请选择收货地址");
                        $("#msgBox").modal('show');
                        return ;
                    }
                    //window.location.href="${basePath}/order/create?shippingId=" + chooseAddressId;
                    //alert(productIds);
                    $.ajax({
                        type : 'POST',
                        url : '${basePath}/order/create',
                        data : {
                            'shippingId' : chooseAddressId
                        },
                        dataType : 'json',
                        success : function(data) {
                            if (data.status == 0) {
                                //alert(data.data.orderNo);
                                window.location.href="${basePath}/order/payCode?orderNo=" + data.data.orderNo;
                            } else {
                                $("#msgBoxConfirm").modal('hide');
                                $("#msgBoxInfo").html("下单失败");
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

                function delAddress(id){
                    $("#msgBoxConfirmInfo").html("确定要删除吗?");
                    $("#msgBoxConfirm").modal('show');
                    $("#msgBoxConfirmButton").on('click' , function(){//点击确认按钮时执行下面的方法
                        $.ajax({
                            type : 'POST',
                            url : '${basePath}/shipping/del',
                            data : {
                                'shippingId' : id
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

    <div class="hr-45"></div>
</div>

<!-- start 添加model -->
<div class="ol_box_mask" style="visibility: hidden; width: 1348px; height: 1800px; z-index: 500;"></div>
<div id="myAddress-add-new-box" class="ol_box_4"
     style="visibility: hidden; position: fixed; top: 50%; left: 50%; margin-left:-400px;margin-top:-210px;z-index: 500; width: 800px; height: 420px;">
    <div class="box-ct">
        <div class="box-header">
            <div class="box-tl"></div>
            <div class="box-tc">
                <div class="box-tc1"></div>
                <div class="box-tc2">
                    <a href="javascript:;" title="关闭" class="box-close" onclick="closeBox()"></a>
                    <span class="box-title">添加地址</span>
                </div>
                <script>
                    function closeBox() {
                        $("#myAddress-add-new-box").css('visibility', 'hidden');
                        $(".ol_box_mask").css('visibility', 'hidden');
                    }

                    function openBox() {
                        $("#myAddress-add-new-box").css('visibility', 'visible');
                        $(".ol_box_mask").css('visibility', 'visible');
                    }
                </script>
            </div>
            <div class="box-tr"></div>
        </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed;">
            <tbody>
            <tr>
                <td class="box-cl"></td>
                <td class="box-cc">
                    <div class="box-content" style="height: auto;">
                        <div id="order-address-add-area">
                            <div class="form-edit-panels">
                                <div class="form-edit-area">
                                    <div class="form-edit-table form-edit-table-address">
                                        <table cellspacing="0" cellpadding="0" border="0">
                                            <tbody>
                                            <tr>
                                                <th><label>收货人：</label></th>
                                                <td>
                                                    <input type="text" class="text vam span-574" id="receiverName" name="receiverName"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="vat" rowspan="2">
                                                    <label>收货地址：</label>
                                                </th>
                                                <td class="relative">
                                                    <!--以下内容隐藏时添加class="hide"，显示去掉class="hide"-->
                                                    <div class="form-address">
                                                        <%--<div id="current-address" class="form-address-detail">
                                                        选择省-市-区-街道
                                                        </div>--%>
                                                        <select id="province" name="receiverProvince" style="width:48%;">
                                                            <option value="0">选择省</option>
                                                        </select>
                                                        <select id="city" name="receiverCity" style="width:48%;">
                                                            <option value="0">选择市</option>
                                                        </select>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr class="tr-rel">
                                                <td>
                                                    <textarea id="receiverAddress" name="receiverAddress" class="textarea span-574"
                                                              style="z-index: 1;"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>
                                                    <label>手机号码：</label>
                                                </th>
                                                <td>
                                                    <div class="vam inline-block">
                                                        <input type="text" class="text  span-229 ime-disabled"
                                                               name="receiverPhone" id="receiverPhone"
                                                               value="" id="input_label_17" style="z-index: 1;">
                                                    </div>
                                                    <label class="vam" styl="margin-left:2px;">&nbsp;固定电话：&nbsp;</label>
                                                    <div class="vam inline-block">
                                                        <input type="text" name="receiverMobile" id="receiverMobile"
                                                               class="text  span-229 ime-disabled" style="z-index: 1;">
                                                    </div>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="box-button">
                                <a class="box-ok" href="javascript:;" onclick="submit_address()">
                                    <span>保存并使用</span></a>
                                <a class="box-cancel" onclick="closeBox()">
                                    <span>取消</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="box-button" style="display: none;"><a class="box-ok" href="javascript:;"><span>确定</span></a>
                        <a class="box-cancel" href="javascript:;"><span>取消</span></a></div>
                </td>
                <td class="box-cr"></td>
            </tr>
            </tbody>
        </table>

    </div>
</div>
<!-- end 添加model-->
<script>
    var province = _cities.getProvinces();
    for (var i = 0; i < province.length; i++) {
        var $province = $('#province');
        $province.html($province.html() + "<option value='"+province[i]+"'>"+province[i]+"</option>");
    }

    $('#province').change(function(){
        var cities = _cities.getCities($(this).val());
        $('#city').html("<option value=\"0\">选择市</option>");
        for (var i = 0; i < cities.length; i++) {
            var $city = $('#city');
            $city.html($city.html() + "<option value='"+cities[i]+"'>"+cities[i]+"</option>");
        }
    });

    function submit_address(){
        var receiverName = $("#receiverName").val();
        var province = $("#province").val();
        var city = $("#city").val();
        var address = $("#receiverAddress").val();
        var phone = $("#receiverPhone").val();
        var mobile = $("#receiverMobile").val();

        $.ajax({
            type : 'POST',
            url : '${basePath}/shipping/add',
            data : {
                'receiverName' : receiverName,
                'receiverProvince' : province,
                'receiverCity' : city,
                'receiverAddress' : address,
                'receiverPhone' : phone,
                'receiverMobile' : mobile
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

    }


</script>


<!--    提示框 start -->
<%@include file="../../common/msgBox.jsp"%>
<!--    提示框 -->
</body>

</html>
