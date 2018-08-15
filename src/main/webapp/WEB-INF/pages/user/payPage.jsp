<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/common.jsp" %>
<html>
<head>
    <title>订单支付</title>
    <link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.ico">
    <script src="https://res9.vmallres.com/20180504/js/common/base/jquery-1.4.4.min.js"></script>
</head>
<body>
<c:if test="${order.status eq 0}">
    <div style="width: 100%;height: 80px;line-height: 80px;text-align: center;">
        订单提交成功，请尽快支付，订单号：${order.data.orderNo}
        <input type="hidden" id="orderNo" value="${order.data.orderNo}">
    </div>

    <div style="width: 100%;height: 60px;line-height: 60px;text-align: center;font-size: 16px;">
        请示用支付宝App扫描如下二维码支付
    </div>

    <div style=" border:1px solid #EEE;width: 280px;height: 280px;line-height: 280px;text-align: center;margin: 0 auto;">
        <img src="${order.data.qrUrl}"/>
    </div>
</c:if>

<c:if test="${order.status ne 0}">
    <div style="width: 100%;height: 80px;line-height: 80px;text-align: center;">
        服务器异常，订单提交失败。
    </div>
</c:if>
<script>
    var orderNo = $("#orderNo").val();
    window.setInterval(function(){
        $.ajax({
            type : 'POST',
            url : '${basePath}/order/query_order_pay_status',
            dataType : 'json' ,
            data : {
                'orderNo' : orderNo
            },
            success : function(data) {
                if(data.data){
                    window.location.href="${basePath}/order/payResult";
                }
            },
            error : function(data) {
                $("#msgBoxInfo").html("程序执行出错");
                $("#msgBox").modal('show');
                $("#addModal").modal('hide');
            }

        });

    },1000);
</script>



</body>
</html>
