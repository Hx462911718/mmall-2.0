/**
 * Created by W on 10/23 0023.
 */

/* ---------- Main Menu Open/Close, Min/Full ---------- */



//选择多项
$(function(){
    var lList = $("#lList");
    var rList = $("#rList");
    var items = $(".add-user-list li");
    for(var i = 0;i<items.length;i++){
        items[i].onclick = itemsclick;
    }
    function itemsclick(){
        var classname = this.className;
        if(classname === "selected"){
            this.className = "";
        }else{
            this.className="selected";
        }
    }
});


// 菜单滑动
$('.navbar-toggler').click(function(){

    if ($(this).hasClass('sidebar-toggler')) {
        $('body').toggleClass('sidebar-hidden');
        resizeBroadcast();
    }

    if ($(this).hasClass('aside-menu-toggler')) {
        $('body').toggleClass('aside-menu-hidden');
        resizeBroadcast();
    }

    if ($(this).hasClass('mobile-sidebar-toggler')) {
        $('body').toggleClass('sidebar-mobile-show');
        resizeBroadcast();
    }

});

$('.sidebar-close').click(function(){
    $('body').toggleClass('sidebar-opened').parent().toggleClass('sidebar-opened');
});



//check btn
;(function($){
    $.extend({
        inputStyle:function(){
            function check(el,cl){
                $(el).each(function(){
                    $(this).parent('i').removeClass(cl);

                    var checked = $(this).prop('checked');
                    if(checked){
                        $(this).parent('i').addClass(cl);
                    }
                })
            }
            $('input[type="radio"]').on('click',function(){
                check('input[type="radio"]','radio_bg_check');
            })
            $('input[type="checkbox"]').on('click',function(){
                check('input[type="checkbox"]','checkbox_bg_check');
            })
        }

    })

})(jQuery)

//调用
$(function(){
    $.inputStyle();
})


//addTag 添加标签
var lablId = -1;


$(function () {

    $("#addBlank").blur(function () {

        if (isNan(this.value) != false) {

            this.value = '用空格分隔多个标签';

            this.style.color = '#999';

        }

    });

});

$(document).ready(function () {

    $("#addBlank").keydown(function (event) {

        if (event.keyCode == 13) {

            var str = $("#addBlank").val();

            if (isNan(str) != true) {

                var li_id = $(".addBlank_list li:last-child").attr('id');

                if (li_id != undefined) {

                    li_id = li_id.split('_');

                    li_id = parseInt(li_id[1]) + 1;

                } else {

                    li_id = 0;

                }

                $(".addBlank_box").css("display", "block");

                var text = "<li id='li_" + li_id + "'><a href='javascript:;' onclick='deletes(" + li_id + ");' >" + str + "<i  class='fa fa-close'></i></a><input type='hidden' name='label[" + li_id + "].name' value='" + str + "'></li>";

                $(".addBlank_list").append(text);

            }

            $("#addBlank").val("");

        }

    })

});

function isNan(obj) {

    try {

        return obj == 0 ? true : !obj

    } catch (e) {

        return true;

    }

}


function deletes(id) {

    $("#li_" + id).remove();

    var li_id = $(".addBlank_list li:last-child").attr('id');

    if (li_id == undefined) {

        $(".addBlank_box").css("display", "none");

    }

}


function addlabl(id) {

    if (lablId == id) {

        return;

    }

    lablId = id;

    var str = $("#add_" + id).text();

    var li_id = $(".addBlank_list li:last-child").attr('id');

    if (li_id != undefined) {

        li_id = li_id.split('_');

        li_id = parseInt(li_id[1]) + 1;

    } else {

        li_id = 0;

    }

    $(".addBlank_box").css("display", "block");

    var text = "<li id='li_" + li_id + "'><a href='javascript:;' onclick='deletes(" + li_id + ");' >" + str + "<img src='images/label_03.png' class='label-pic'></a><input type='hidden' name='label[" + li_id + "].name' value='" + str + "'></li>";

    $(".addBlank_list").append(text);

}





//图片上传预览  IE是用了滤镜。
function previewImage(file)
{
    var MAXWIDTH  = 100;
    var MAXHEIGHT = 100;
    var div = document.getElementById('preview');
    if (file.files && file.files[0])
    {
        div.innerHTML ='<img id=imghead>';
        var img = document.getElementById('imghead');
        img.onload = function(){
            var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
            img.width  =  rect.width;
            img.height =  rect.height;
//                 img.style.marginLeft = rect.left+'px';
            img.style.marginTop = rect.top+'px';
        }
        var reader = new FileReader();
        reader.onload = function(evt){img.src = evt.target.result;}
        reader.readAsDataURL(file.files[0]);
    }
    else //兼容IE
    {
        var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
        file.select();
        var src = document.selection.createRange().text;
        div.innerHTML = '<img id=imghead>';
        var img = document.getElementById('imghead');
        img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
        var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
        status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
        div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>";
    }
}
function clacImgZoomParam( maxWidth, maxHeight, width, height ){
    var param = {top:0, left:0, width:width, height:height};
    if( width>maxWidth || height>maxHeight )
    {
        rateWidth = width / maxWidth;
        rateHeight = height / maxHeight;

        if( rateWidth > rateHeight )
        {
            param.width =  maxWidth;
            param.height = Math.round(height / rateWidth);
        }else
        {
            param.width = Math.round(width / rateHeight);
            param.height = maxHeight;
        }
    }
    param.left = Math.round((maxWidth - param.width) / 2);
    param.top = Math.round((maxHeight - param.height) / 2);
    return param;
}