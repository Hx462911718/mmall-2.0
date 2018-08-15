ec.load("ajax");
ec.pkg("ec.index");
ec.index.clickHref = function (a) {
    window.open(a)
};
ec.index.sales = function (e) { };
ec.index.salesStatus = [];
ec.index.salesCallBack = function (h, k) {
    var f,
        d = [],
        b = new Date();
    b.setTime(ec.index.now.parseDate("yyyy-MM-dd HH:mm:ss"));
    var a = function (i, o) {
        var n = $(o),
            l = n.attr("data-skutype"),
            m = $(".channel-button", n);
        switch (parseInt(i, 10)) {
            case 0:
                m.html("\u9a6c\u4e0a\u5f00\u59cb").attr("title", "\u9a6c\u4e0a\u5f00\u59cb");
                if (l == 3 || l == 4) {
                    m.attr("class", "channel-button-begin")
                }
                break;
            case 1:
                if (l == 3) {
                    m.html("\u53bb\u770b\u770b").attr("title", "\u53bb\u770b\u770b")
                } else {
                    m.html("\u7acb\u5373\u62a2\u8d2d").attr("title", "\u7acb\u5373\u62a2\u8d2d")
                }
                m.attr("class", "channel-button");
                break;
            case 2:
                m.html("\u6d3b\u52a8\u7ed3\u675f").attr("title", "\u6d3b\u52a8\u7ed3\u675f");
                if (l == 2 || l == 3) {
                    m.attr("class", "channel-button-end")
                }
                break
        }
    };
    for (var c = 0; c < k.infoList.length; c += 1) {
        f = h[c];
        d = k.infoList[c];
        $(".channel-button", f).css("visibility", "");
        if (!d || !d.id) {
            continue
        }
        if (d.status == 1) {
            if (d.startTime && d.startTime >= b) {
                d.status = 0
            }
            if (d.endTime && d.endTime <= b) {
                d.status = 2
            }
        }
        a(d.status, f);
        if (d.startTime || d.endTime || d.limitAmount > 0) {
            $(".p-countdown", f).show()
        }
        if (d.limitAmount > 0) {
            $(".p-quantity", f).html("\u9650<b>" + d.limitAmount + "</b>\u53f0").show()
        }
        var e = parseFloat($(f).attr("data-price"), 10);
        if (d.price > 0) {
            if (parseInt(d.price) == d.price) {
                $(".p-sale-price span, .p-price span", f).html((d.price));
                if (parseInt(e) == e) {
                    $(".economize", f).html(e - d.price)
                } else {
                    $(".economize", f).html((e - d.price).toFixed(2))
                }
            } else {
                $(".p-sale-price span, .p-price span", f).html((d.price).toFixed(2));
                if (e - d.price == 0) {
                    $(".economize", f).html("0")
                } else {
                    $(".economize", f).html((e - d.price).toFixed(2))
                }
            }
        }
        $(".sale-quantity", f).html(d.saleAmount);
        if (d.status != 2 && (d.startTime || d.endTime)) {
            var g = ($(f).attr("data-block") == "slider") ? true : false,
                j = [];
            if (d.startTime) {
                j.push(new Date(d.startTime).format("yyyy-MM-dd HH:mm:ss"))
            }
            if (d.endTime) {
                j.push(new Date(d.endTime).format("yyyy-MM-dd HH:mm:ss"))
            }
            ec.index.salesStatus[c] = d.status;
            ec.ui.countdown($(".p-time", f), {
                html: "<b>" + (g ? "" : "\u5269\u4f59") + "</b><ins><i>{#hours}</i><s></s></ins><em>\u65f6</em><ins><i>{#minutes}</i><s></s></ins><em>\u5206</em><ins><i>{#seconds}</i><s></s></ins><em>\u79d2</em>",
                now: b,
                times: j,
                index: c,
                callback: function (i) {
                    ec.index.salesStatus[i.index]++;
                    a(ec.index.salesStatus[i.index], h[i.index])
                }
            })
        }
    }
};
ec.ready(function () {

    var skuids = $("#recommendSkuIds").val();
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "SKUID": skuids,
                "load": "1"
            }
    }
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011501", "link", value]);

    if (ec.account.isLogin()) {
        $("#cust_login_info").hide()
    }
    var a = ec.index.bigAd,
        g = ec.index.smallAd,
        f = ec.index.bigadShowTime,
        e,
        b,
        c = function () {
            var j = b.innerHeight();
            var i = e.innerHeight();
            var k = $("#search-bar-form").offset().top - i + j;
            var h = $("#search-bar-form").innerHeight();
            $(".autocomplete-w1").parent().hide();
            e.slideUp(1000, function () {
                if (g) {
                    b.show()
                }
                $(".autocomplete-w1").parent().css({
                    top: (k + h + "px")
                });
                $(".autocomplete-w1").parent().show();
                ec.index.SCROLL_GET = ec.index.getscrollLayout()
            });
            if (d) {
                clearTimeout(d)
            }
        },
        d;
    $("#top-banner-block").html(gid("top-banner").value);
    e = $("#top-banner-max");
    b = $("#top-banner-min");
    $("#top-banner-min-close").click(function () {
        $("#top-banner-block").hide();
        ec.index.SCROLL_GET = ec.index.getscrollLayout()
    });
    if (a) {
        e.show();
        ec.index.SCROLL_GET = ec.index.getscrollLayout();
        $("#top-banner-max-toggle").click(c);
        d = setTimeout(c, f)
    }
    if (g && !a) {
        b.show();
        ec.index.SCROLL_GET = ec.index.getscrollLayout()
    }
    if (!g && !a) {
        ec.index.SCROLL_GET = ec.index.getscrollLayout()
    }
    $("body .layout .channel-pro-item").hover(function () {
        $(this).addClass("pro-info-hover")
    }, function () {
        $(this).removeClass("pro-info-hover")
    });
    ec.index.sales("#main-sale-list .activity-list, #slider-sale-list .activity-list");
    ec.index.floatLayout()
});
ec.index.SCROLL_GET = {};
ec.index.getscrollLayout = function () {
    var b = $(".home-channel-container .layout"),
        d = $(".event-float-layout"),
        a = [],
        c = [];
    if (b.length == 0 || d.length == 0) {
        return false
    }
    b.each(function (e, f) {
        c.push($(this).offset().top);
        a.push($(this).outerHeight())
    });
    return {
        scrollListHeight: a,
        scrollList: c,
        top: d.offset().top
    }
};
ec.index.floatLayout = function () {
    var a = $(".event-float-layout");
    if (a.length == 0 || ec.index.SCROLL_GET === false) {
        return false
    }
    $("body").css({
        "min-width": "1200px",
        "overflow-x": "hidden"
    });
    var d = $(".event-float"),
        n = $(".hungBar-top"),
        h = $(".home-channel-container .layout"),
        p = $(".home-channel-container"),
        m = $(".home-channel-container .layout .channel-title"),
        l = "";
    a.find("ul").children().remove();
    function f(i) {
        return $("<span/>").text(i).html()
    }
    h.each(function (i, q) {
        var name = f(m.eq(i).text());
        l += '<li><a data-id="' + i + '" href="javascript:;" onclick = "pushMsg(\'' + name + '\');">' + name + "</a></li>"
    });
    a.find("ul").append(l);
    a.bind("click", function (r) {
        var q = $(r.target);
        if (q[0].nodeName.toLowerCase() === "a") {
            var i = parseInt(q.attr("data-id"));
            q.parent().addClass("hover").siblings().removeClass("hover");
            $("html,body").animate({
                scrollTop: ec.index.SCROLL_GET.scrollList[i] + "px"
            }, 400)
        }
    });
    var o = a.outerHeight(),
        e = d.offset(),
        c = e.left,
        b = $(window).height(),
        k = b / 2 - (o / 2),
        j = h.length,
        g = true;
    a.css({
        height: j * 47 + "px",
        top: k + "px"
    });
    if (document.body.clientWidth <= 1400) {
        a.hide();
        g = false
    }
    if ($.browser.msie && parseInt($.browser.version) <= 9) {
        a.hide()
    }
    if ($.browser.msie && parseInt($.browser.version) <= 7) {
        g = false
    } else {
        $(window).scroll(function () {
            if (!g) {
                return
            }
            var i = $(window).scrollTop();
            if (i >= b) {
                n.fadeIn(80)
            } else {
                n.fadeOut(80)
            }
            if (i >= ec.index.SCROLL_GET.scrollList[0] - k) {
                a.css({
                    top: k + "px"
                }).addClass("tool-Fixed");
                if ($.browser.msie && parseInt($.browser.version) >= 8 && parseInt($.browser.version) <= 9) {
                    a.show()
                }
                $.each(ec.index.SCROLL_GET.scrollList, function (q, r) {
                    if (i >= r - ec.index.SCROLL_GET.scrollListHeight[q] / 2) {
                        a.find("li").eq(q).addClass("hover").siblings().removeClass("hover")
                    }
                });
                if (i >= (ec.index.SCROLL_GET.scrollList[j - 1] + ec.index.SCROLL_GET.scrollListHeight[j - 1] / 2 - j * 47)) {
                    a.removeClass("tool-Fixed");
                    if ($.browser.msie && parseInt($.browser.version) >= 8 && parseInt($.browser.version) <= 9) {
                        a.hide()
                    }
                }
            } else {
                a.removeClass("tool-Fixed");
                if ($.browser.msie && parseInt($.browser.version) >= 8 && parseInt($.browser.version) <= 9) {
                    a.hide()
                }
            }
        }, 200)
    }
    $(window).resize(function () {
        if (document.body.clientWidth > 1400) {
            a.show();
            g = true;
            return
        }
        a.hide();
        g = false;
        $("body").css({
            "min-width": "1200px",
            "overflow-x": "auto"
        })
    }, 200);
    if ($(window).scrollTop() > 0) {
        $(window).trigger("scroll")
    }
};
$(document).ready(function () {
    var c = $(".goods-rolling"),
        a = [];
    c.each(function (f, g) {
        a.push($(this).attr("id"))
    });
    $.each(a, function (f, g) {
        var totalLen = $("#" + g).find('.swiper-slide').length;
        if (totalLen <= 5.5) {
            $("#" + g).find('.swiper-button-prev').addClass('disabled');
            $("#" + g).find('.swiper-button-next').addClass('disabled');
        } else {
            $("#" + g).find('.swiper-button-next').removeClass('disabled');

        }
        var mySwiper = new Swiper("#" + g, {
            slidesPerView: 5.5,
            slidesPerGroup: 5.5
        });
        //	左边箭头
        $("#" + g).find('.btn-prev').click(function () {
            //		插件向左切换效果
            mySwiper.swipePrev();
        })
        //	右边箭头
        $("#" + g).find('.btn-next').click(function () {
            mySwiper.swipeNext();
        })

    });

    new Slider({
        objid: "#notice",
        listname: ".p-notice-list",
        shownum: 1,
        type: 2,
        autoplay: true
    }).init();
    var b = $(".bottomImage");
    if (b.attr("src")) {
        b.show().bind("click", function () {
            var f = $("#adsArearLink").val();
            if (f != null && f.trim() != "") {
                var g = window.open(f, "_blank");
                g.opener = null
            }
        })
    }
    var e = $(".grid-list .grid-items,.grid-promo-list .grid-items");
    e.hover(function () {
        $(this).addClass("current")
    }, function () {
        $(this).removeClass("current")
    });
    var d = $(".hungBar-top");
    d.bind("click", function () {
        $("html,body").animate({
            scrollTop: "0px"
        }, 400)
    })
})


"use strict"; var Slider = function (a) { this.i = 0; this.objid = a.objid || null; this.preclassname = a.preclassname || ".btn-prev"; this.nextclassname = a.nextclassname || ".btn-next"; this.listname = a.listname || ".grid-list"; this.listitem = a.listitem || "li"; this.shownum = a.shownum || 5.5; this.type = a.type || 1; this.autoplay = a.autoplay || false }; Slider.prototype = { init: function () { var b = this; var a = b.set(); if (b.autoplay) { b.auto(a) } else { b.next(a); b.pre(a) } }, auto: function (e) { var d = this, c = null; $(d.listname).find(d.listitem).eq(0).clone().appendTo(d.listname); e.len += 1; var b = (e.itemHeight) * (e.len - 1), a = function () { d.i++; if (Math.abs(parseInt(e.$grid.css("margin-top"))) == b) { e.$grid.css("margin-top", 0); d.i = 1 } e.$grid.animate({ "margin-top": "-" + (d.i * e.itemHeight * d.shownum) + "px" }, 500) }; if (d.autoplay) { c = setInterval(a, 2000); e.$grid.hover(function () { clearInterval(c) }, function () { c = setInterval(a, 2000) }) } }, set: function () { var d = this, g = $(d.objid + " " + d.listitem), i = $(d.objid + " " + d.listname), h = $(d.objid + " " + d.preclassname), b = $(d.objid + " " + d.nextclassname), e = g.length, f = g.outerWidth(), a = g.outerHeight(), c = Math.ceil(e / d.shownum); switch (d.type) { default: case 1: i.css("width", (f + 1) * e + "px"); break; case 2: i.css("height", (a) * e + "px"); break }return { $item: g, $grid: i, $pre: h, $next: b, len: e, itemWidth: f, itemHeight: a, num: c } }, pre: function (b) { var a = this; b.$pre.bind("click", function () { if ($(this).hasClass("disabled")) { return } a.i--; if (a.i - 1 < 0) { b.$pre.addClass("disabled") } b.$next.removeClass("disabled"); switch (a.type) { default: case 1: b.$grid.animate({ "margin-left": a.i == 0 ? 0 : parseInt(b.$grid.css("margin-left")) + (b.itemWidth * a.shownum) + "px" }, 500); break; case 2: b.$grid.animate({ "margin-top": a.i == 0 ? 0 : parseInt(b.$grid.css("margin-top")) + (b.itemHeight * a.shownum) + "px" }, 500) } }) }, next: function (b) { var a = this; b.$next.bind("click", function () { if ($(this).hasClass("disabled")) { return } a.i++; b.$pre.removeClass("disabled"); switch (a.type) { default: case 1: if (a.shownum > 1) { if (a.i + 1 == b.num) { var d = parseInt(b.$grid.css("margin-left")); var c = (b.len - ((a.i) * parseInt(a.shownum)) - 1 / 2) * b.itemWidth; b.$grid.animate({ "margin-left": d - c + "px" }, 500) } else { b.$grid.animate({ "margin-left": "-" + (a.i * b.itemWidth * parseInt(a.shownum)) + "px" }, 500) } } else { b.$grid.animate({ "margin-left": "-" + (a.i * b.itemWidth * a.shownum) + "px" }, 500) } break; case 2: b.$grid.animate({ "margin-top": "-" + (a.i * b.itemHeight * a.shownum) + "px" }, 500); break }if (a.i + 1 == b.num) { b.$next.addClass("disabled") } }) } };

(function (_ec) {
    //顶部banner
    _ec.bigAd = false;
    _ec.smallAd = true;
    _ec.bigadShowTime = 8000;
    _ec.now = new Date().format('yyyy-MM-dd HH:mm:ss');

    _ec.configNowTime = function () {
        if (_serverTime) {
            _ec.now = new Date(_serverTime).format('yyyy-MM-dd HH:mm:ss');
        }
    }

    //ec.load({
    //	url : "/serverTime.jsp?"+(new Date()).getTime(),
    //	type : "js",
    //	loadType:"lazy",
    //	onload : _ec.configNowTime
    //});

})(ec.index);


/*
     *
     * 首页左浮动位置
     *
     * */
(function ($) {
    function floatShow() {
        function getScrollTop() {
            var scrollTop = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
            return scrollTop;
        }
        if (getScrollTop() > 1080) {
            if ($(".leftfloat")) {
                $(".leftfloat").addClass('leftfloat-show');
            }
        } else {
            if ($(".leftfloat")) {
                $(".leftfloat").removeClass('leftfloat-show');
            }
        }
    };
    floatShow();



    window.onscroll = function () {
        floatShow();
    };
    function floatPosition() {
        if ($(".leftfloat")) {
            var floatLeft = ($(window).width() - 1200) / 2 - $('.leftfloat').width() - 10,
                floatTop = $(window).height() / 2 - $('.leftfloat').height() / 2;
            $(".leftfloat").css('left', floatLeft);
            $(".leftfloat").css('top', floatTop);
            setTimeout(floatPosition, 100);
        }
    };
    floatPosition();
    window.onresize = function () {
        floatPosition();
    };
    /*
         *
         * 首页底部浮动位置
         *
         * */
    var $top = $('.home-channel-container .layout').eq(0).offset().top,
        $height = $('.bottom-banner').height();
    $(window).scroll(function () {
        var bottomV = $height * (-1);
        $(".bottom-banner").css("bottom", bottomV + "px");
        var scrollTop = $(window).scrollTop();
        if (scrollTop >= ($top - $height)) {
            $(".footer-container").css("padding-bottom", $height + "px");
            $(".bottom-banner").addClass('bm-0');
        } else {
            $(".bottom-banner").removeClass('bm-0');
            $(".footer-container").css("padding-bottom", "0");
        }
    })

})(jQuery);

//会员频道点击上报
function pushMemberMsg(name, url) {
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
    _paq.push(["trackLink", "300010801", "link", value]);
}

//中通广告数据上报
function pushBannerMsg(adid, url) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "ADID": adid,
                "URL": url,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011601", "link", value]);

}

$(".home-banner-slideshow").find("li").find("a").click(function () {
    var adid = $(this).find("img").attr("src");
    var url = $(this).attr("href");
    pushBannerMsg(adid, url);
});
//商品楼层更多点击上报
function pushFoolMsg(index, category, url) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "index": index,
                "category": category,
                "URL": url,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011703", "link", value]);
}
//商品楼层商品楼层子分类点击上报
function pushFoolChildrenMsg(index, category, subCategory, url) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "index": index,
                "category": category,
                "subCategory": subCategory,
                "URL": url,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011701", "link", value]);
}

//底部通栏广告数据上报
$(".ad.fl").find("a").click(function () {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "name": $(this).find("img").attr("src"),
                "URL": $(this).attr("href"),
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011801", "link", value]);
});

//楼层广告数据上报
function pushFoolAdvertMsg(index, category, adid, url) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "index": index,
                "category": category,
                "ADID": adid,
                "URL": url,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011702", "link", value]);
}

//右浮动导航数据上报
$(".hover-list").find("li").find("a").click(function () {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "buttonName": $(this).html(),
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300010001", "link", value]);
});

//首页弹窗数据上报
$("#web_popup_ads").find("a").click(function () {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "ADID": $(this).find("img").attr("src"),
                "URL": $(this).attr("href"),
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300010002", "link", value]);
});

//楼层商品点击上报
function pushFoolGoodsMsg(obj, location, index, category, skuId, type) {
    var row;
    var column;
    if (type == "13") {
        var num = (location) / 4;
        row = parseInt(num) + 1;
        if (row == 1) {
            column = location + 1;
        }
        else {
            column = parseInt((location) % 4) + 1;
        }
    }
    else if (type == "12") {
        row = parseInt((location - 1) / 4) + 1;
        column = parseInt((location - 1) % 4) + 1;
    }


    var url = obj.href;
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "index": index,
                "category": category,
                "SKUID": skuId,
                "URL": url,
                "row": "" + row,
                "column ": "" + column,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011704", "link", value]);
}

/*	$(".bottom-banner").find("a").click(function(){
            var url = $(this).attr("href");
            var src = $(this).find("img").attr("src");
            var value = {
                "UID":ec.util.cookie.get("uid"),
                "TID":getPtid(),
                "TIME":getTime(),
                "CONTENT":
                {
                "ADID":src,
                    "URL":url,
                    "type":"1",
                        "click":"1"
                        }
            };
            ec.code.addAnalytics({hicloud:true});
            _paq.push(["trackLink","300010102", "link", value]);
        });
    */
$(".top-banner-min").find("a").live("click", function () {
    var name = $(this).attr("title");
    var type;
    var src;
    var url;
    if ($(this).attr("class") == "undefined" || $(this).attr("class") == "" || $(this).attr("class") == null) {
        type = "1";
        src = $(this).find("img").attr("src");
        url = $(this).attr("href");
    }
    else {
        type = "2";
        src = "";
        url = "";
    }

    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "ADID": src,
                "URL": url,
                "type": type,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300010102", "link", value]);
});

$(".top-banner-max").find("a").live("click", function () {
    var name = $(this).attr("title");
    var type;
    var src;
    var url;
    if ($(this).attr("class") == "undefined" || $(this).attr("class") == "" || $(this).attr("class") == null) {
        type = "1";
        src = $(this).find("img").attr("src");
        url = $(this).attr("href");
    }
    else {
        type = "2";
        src = "";
        url = "";
    }

    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "ADID": src,
                "URL": url,
                "type": type,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300010101", "link", value]);
});

function pushMsg(name) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "buttonName": name,
                "click": "1"
            }

    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300010001", "link", value]);
};

function pushMsgMenu(location, key, name, url) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "name": name,
                "URL": url,
                "location": location,
                "click": "1"
            }

    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", key, "link", value]);
};

function pushMsgNotice(location) {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "location": location,
                "click": "1"
            }

    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011001", "link", value]);
};

$('.home-promo-list.clearfix li a').click(function () {
    var value = {
        "UID": ec.util.cookie.get("uid"),
        "TID": getPtid(),
        "TIME": getTime(),
        "CONTENT":
            {
                "ADID": $(this).parent().find('img').attr("src"),
                "URL": $(this).attr('href'),
                "locaion": $(this).parent().index() + 1,
                "click": "1"
            }
    };
    ec.code.addAnalytics({ hicloud: true });
    _paq.push(["trackLink", "300011201", "link", value]);
});