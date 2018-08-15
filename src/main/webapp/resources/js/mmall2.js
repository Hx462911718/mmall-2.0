(function () {
    //获取二级菜单元素
    var $panels = $(".category-panels");
    //判断鼠标是否进入二级菜单
    var mouseInPanels = false;
    //用于存储鼠标移动过程中,开始位置和结束位置的数组
    var mouseTrach = [];
    var activeRow,  //选中的一级菜单
        activeMenu, //对应的右侧二级菜单
        timer;      //延时器

    $panels.live("mouseenter", function () {
        mouseInPanels = true;
    }).live("mouseleave", function () {
        mouseInPanels = false;
    });

    var moveHandler = function (e) {
        mouseTrach.push({
            x: e.pageX,
            y: e.pageY
        });
        if (mouseTrach.length > 2) {
            mouseTrach.shift();
        }
    };
    $('.category-item').each(function () {
        $(this).find('.category-panels').addClass('none');
    })
    $('.category-list').live('mouseenter', function () {
        $(document).bind("mousemove", moveHandler);
    }).live('mouseleave', function () {
        if (activeRow) {
            activeRow.removeClass("active");
            activeRow = null;
        }
        if (activeMenu) {
            activeMenu.addClass("none");
            activeMenu = null;
        }
        $(document).unbind("mousemove", moveHandler);
    });
    //鼠标进入每个li
    $('.category-item ').live('mouseenter', function (e) {
        if (!activeRow) {
            activeRow = $(this).addClass("active");
            activeMenu = $(this).find('.category-panels');
            activeMenu.removeClass("none");
        }
        if (timer) {
            clearTimeout(timer);
        }
        //当前鼠标位置坐标
        var curMouse = mouseTrach[mouseTrach.length - 1];
        //前面鼠标位置坐标
        var prevMouse = mouseTrach[mouseTrach.length - 2];
        var delay = needDelay($('.category-list'), curMouse, prevMouse);
        if (delay) {
            var $this = $(this);
            timer = setTimeout(function () {
                if (mouseInPanels) {
                    return
                }
                if (activeRow && activeRow.hasClass('active')) {
                    activeRow.removeClass("active");
                }
                if (activeMenu) {
                    activeMenu.addClass("none");
                }
                activeRow = $this;
                activeRow.addClass("active");
                activeMenu = $this.find('.category-panels');
                activeMenu.removeClass("none");
                timer = null;
            }, 500);
        } else {
            var prevActiveRow = activeRow;
            var prevActiveMenu = activeMenu;
            activeRow = $(this);
            activeMenu = $(this).find('.category-panels');
            prevActiveRow.removeClass("active");
            prevActiveMenu.addClass("none");
            activeRow.addClass("active");
            activeMenu.removeClass("none");
        }
    });

    //所有分类显示隐藏控制
    var isIndex = true,
        categoryBlock = gid('category-block');

    if (isIndex) return;

    $("#category-block").hover(function () {
        $(this).addClass("category-hover");
    }, function () {
        $(this).removeClass("category-hover");
    });


}());



//显示导航右侧商品数据
function showProList(id) {
    //查询标志
    var flag = $("#" + id + "_flag").val();
    var skuIds = $("#" + id + "_skuIds").val();

    var mediaPath = "https://res.vmallres.com/pimages/";
    //未查询过且有商品时才能执行
    if (skuIds != "" && flag == "no") {
        skuIds = skuIds.substring(0, skuIds.length - 1);
        var skuIdArr = skuIds.split(",");

        skuIdArr = removeDuplicatedItem(skuIdArr);

        //标记标志位
        $("#" + id + "_flag").val("yes");
        new ec.ajax().get({
            url: "/querySbomInfo.json?skuIdsStr=" + skuIds,
            async: true,//使用异步的Ajax请求
            timeout: 10000,
            successFunction: function (json) {
                if (json.success) {
                    var infoMap = json.sbomInfoMap;
                    var html = '';
                    for (var i = 0; i < skuIdArr.length; i++) {
                        var skuId = skuIdArr[i];
                        var sbomInfo = json.sbomInfoMap[skuId];
                        if (sbomInfo != null) {
                            //商品图片URL
                            var imgPath = mediaPath + sbomInfo.photoPath + "142_142_" + sbomInfo.photoName;
                            //商品URL
                            var urlPath = "/product/" + sbomInfo.disPrdId + ".html";
                            //商品名称
                            //var proName = sbomInfo.sbomName;
                            var proName = $('#name_' + skuId).val();
                            var price;
                            //取得价格显示方式
                            var priceMode = sbomInfo.priceMode;
                            if (priceMode == 2 || sbomInfo.price == 0) {
                                price = "暂无报价";
                            } else {
                                price = "&yen;" + sbomInfo.price;
                            }
                            //一级分类导航名称
                            var oneNavName = $("#" + id + "_name").val();
                            var onShowName = "分类导航_" + oneNavName + "_" + sbomInfo.sbomCode;
                            //var clickContent="_paq.push(['trackLink','"+onShowName+"', 'link', ' ']);ec.code.addAnalytics({hicloud:true});";
                            html += '<li class="grid-items" onmouseenter="fixCurrent(this)"  onmouseleave="leaveCurrent(this)" >';
                            html += '     <a class="thumb" target="_blank" href="' + urlPath + '" onclick = "pushNavIndexProImgMsg(\'' + skuId + '\',\'' + urlPath + '\')">';
                            html += '         <p class="grid-img">';
                            html += '         	<img alt="" src="' + imgPath + '">';
                            html += '          </p>';
                            html += '          <div class="grid-title">' + proName + '</div>';
                            html += '          <p class="grid-price">' + price + '</p>';
                            //html += '          <p class="grid-tips"><img src="" alt=""></p>';
                            html += '       </a>';
                            html += '  </li>';
                        }
                    }
                    $("#" + id + "_prolist").html(html);
                }

            }
        });
    }
};
function vector(a, b) {
    return {
        x: b.x - a.x,
        y: b.y - a.y
    }
}

function vectorPro(v1, v2) {
    return v1.x * v2.y - v1.y * v2.x;
}

/**
 *功能:判断两个值是否同正负
 *入参:两个number类型的值
 *出参:布尔值,同正负返回true,反之false
 */
function sameSign(a, b) {
    return (a ^ b) >= 0;
}

/**
 *功能:判断p是否在三角形abc内
 *入参:p, a, b, c;p是需要判断的点，a,b,c是三角形的三个点，如果p在三角形内部，那么pa,pb,pc两个向量之间的差乘应该符号相同。（同正负）
 *出参:布尔值。如果p在a,b,c构成的三角形内,返回true,反之false
 */

function isPoint(p, a, b, c) {
    var pa = vector(p, a);
    var pb = vector(p, b);
    var pc = vector(p, c);

    var t1 = vectorPro(pa, pb);
    var t2 = vectorPro(pb, pc);
    var t3 = vectorPro(pc, pa);

    return sameSign(t1, t2) && sameSign(t2, t3);
}

/**
 *功能:判断是正常切换一级菜单，还是需要延时
 *入参:鼠标滑入的DOM元素
 *出参:布尔值。需要延时返回true,正常切换一级菜单返回false
 */
function needDelay(ele, curMouse, prevMouse) {
    if (!curMouse || !prevMouse) {
        return
    }
    var offset = ele.offset();
    var topleft = {
        x: offset.left + 240,
        y: offset.top
    };
    var leftbottom = {
        x: offset.left + 240,
        y: offset.top + ele.height()
    };
    return isPoint(curMouse, prevMouse, topleft, leftbottom);
}


//定位当前推荐商品
function fixCurrent(obj) {
    $(obj).addClass('current');
}

//离开当前推荐商品
function leaveCurrent(obj) {
    $(obj).removeClass('current');
}
//去重
function removeDuplicatedItem(ar) {
    var ret = [];
    for (var i = 0, j = ar.length; i < j; i++) {
        if (ret.indexOf(ar[i]) === -1) {
            ret.push(ar[i]);
        }
    }
    return ret;
}

//商品分类纵向导航数据上报
function pushNavIndexProMsg(name, url) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "name": name,
                "URL": url,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300010501", "link", value]);
}
//商品分类纵向导航数据上报(图片)
function pushNavIndexProImgMsg(skuId, url) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "SKUID": skuId,
                "URL": url,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300010601", "link", value]);
}

$("#category-block .category-info").find("a").click(function () {
    var name = $(this).find("span").html().trim();
    var url = $(this).attr("href");
    pushNavIndexProMsg(name, url);
});

$("#category-block .category-panels.relative").find("a").each(function () {
    $(this).bind('click', 'a', function () {
        var name = "";
        var src = "";
        var url = this.href;
        if ($(this).hasClass("clearfix")) {
            name = $(this).find(".fl").html().trim();
            pushNavIndexProMsg(name, url);
        }
        if ($(this).parent().attr("class") == "subcate-item") {
            name = $(this).find("span").html().trim();
            pushNavIndexProMsg(name, url);
        }
    })
});