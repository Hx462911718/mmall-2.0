ec.ready(function () {
    var imgLi = document.createElement("li");
    imgLi.setAttribute("class", "ec-slider-item");
    imgLi.setAttribute("style", "background: url('http://image.lbcto.com/2018042720354279.jpg') 50% 0px no-repeat; ; width: 100%; height: 450px; display: none; position: absolute;");
    imgLi.innerHTML = "<div style=\"width:100%;\" class=\"ec-slider-item-img\"><a style=\"width:100%;height:450px;display:block;\" href=\"#\"></a></div>";
    $("#index_slider").children("ul").append(imgLi);
    var imgLi = document.createElement("li");
    imgLi.setAttribute("class", "ec-slider-item");
    imgLi.setAttribute("style", "background: url('http://image.lbcto.com/20180505234458446.jpg') 50% 0px no-repeat; ; width: 100%; height: 450px; display: none; position: absolute;");
    imgLi.innerHTML = "<div style=\"width:100%;\" class=\"ec-slider-item-img\"><a style=\"width:100%;height:450px;display:block;\" href=\"#\"></a></div>";
    $("#index_slider").children("ul").append(imgLi);
    var imgLi = document.createElement("li");
    imgLi.setAttribute("class", "ec-slider-item");
    imgLi.setAttribute("style", "background: url('http://image.lbcto.com/20180507092731204.jpg') 50% 0px no-repeat; ; width: 100%; height: 450px; display: none; position: absolute;");
    imgLi.innerHTML = "<div style=\"width:100%;\" class=\"ec-slider-item-img\"><a style=\"width:100%;height:450px;display:block;\" href=\"#\"></a></div>";
    $("#index_slider").children("ul").append(imgLi);
    var imgLi = document.createElement("li");
    imgLi.setAttribute("class", "ec-slider-item");
    imgLi.setAttribute("style", "background: url('http://image.lbcto.com/20180505231105938.jpg') 50% 0px no-repeat; ; width: 100%; height: 450px; display: none; position: absolute;");
    imgLi.innerHTML = "<div style=\"width:100%;\" class=\"ec-slider-item-img\"><a style=\"width:100%;height:450px;display:block;\" href=\"#\"></a></div>";
    $("#index_slider").children("ul").append(imgLi);
    var imgLi = document.createElement("li");
    imgLi.setAttribute("class", "ec-slider-item");
    imgLi.setAttribute("style", "background: url('http://image.lbcto.com/20180506223136981.jpg') 50% 0px no-repeat; ; width: 100%; height: 450px; display: none; position: absolute;");
    imgLi.innerHTML = "<div style=\"width:100%;\" class=\"ec-slider-item-img\"><a style=\"width:100%;height:450px;display:block;\" href=\"#\"></a></div>";
    $("#index_slider").children("ul").append(imgLi);
    var imgLi = document.createElement("li");
    imgLi.setAttribute("class", "ec-slider-item");
    imgLi.setAttribute("style", "background: url('http://image.lbcto.com/20180506223356928.jpg') 50% 0px no-repeat; ; width: 100%; height: 450px; display: none; position: absolute;");
    imgLi.innerHTML = "<div style=\"width:100%;\" class=\"ec-slider-item-img\"><a style=\"width:100%;height:450px;display:block;\" href=\"#\"></a></div>";
    $("#index_slider").children("ul").append(imgLi);
    var imgLi = document.createElement("li");
    imgLi.setAttribute("class", "ec-slider-item");
    imgLi.setAttribute("style", "background: url('http://image.lbcto.com/20180504231142288.png') 50% 0px no-repeat; ; width: 100%; height: 450px; display: none; position: absolute;");
    imgLi.innerHTML = "<div style=\"width:100%;\" class=\"ec-slider-item-img\"><a style=\"width:100%;height:450px;display:block;\" href=\"#\"></a></div>";
    $("#index_slider").children("ul").append(imgLi);

    ec.load("ec.slider", {
        loadType: "lazy",
        callback: function () {
            $("#index_slider").slider({
                width: '100%', //必须
                height: 450, //必须
                style: 2,                    //1显示分页，2只显示左右箭头,3两者都显示
                pause: 5000,           //间隔时间
                auto: true,
                minWidth: 1200,
                showNumber: false,
                circleBtn: true
            });
        }
    });
});