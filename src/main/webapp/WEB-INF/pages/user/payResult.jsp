<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/common.jsp" %>
<html>
<head>
    <title>支付结果</title>
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">



    <style>
        #main{
            width: 100%;
            height: 200px;
        }
        #tip{
            width: 200px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            margin: 20px auto 0;
        }
        #op{
            width: 400px;
            height: 100px;
            margin: 10px auto 0;
        }
        #keepShopping{
            border: 1px solid #EEE;
            width: 100px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            float: left;
            margin-left: 50px;
            margin-top: 35px;
        }
        #orderList{
            border: 1px solid #EEE;
            width: 100px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            float: right;
            margin-right: 50px;
            margin-top: 35px;
        }
        #keepShopping:hover , #orderList:hover{
            color:#FD482C;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div id="main">
    <div id="tip">
        您的订单支付成功！
    </div>
    <div id="op">
        <div id="keepShopping" onclick="window.location.href='${basePath}/'">
            继续购物
        </div>
        <div id="orderList" onclick="window.location.href='${basePath}/order/orderList'">
            查看订单
        </div>
    </div>
</div>
</body>
</html>
