package com.mmall.Controller.backend;

import com.mmall.common.ServerResponse;
import com.mmall.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * @author:hexin
 * @ctrateTime:2018年05月19日 21:55:00
 */
@Controller
@RequestMapping("/manage/order")
public class OrderManageController {

    @Autowired
    private IOrderService iOrderService;

    @RequestMapping({"","/"})
    public String goOrderPage(Model model,
                              @RequestParam(value = "orderNo",required = false) Long orderNo,
                              @RequestParam(value = "status",required = false) Integer status,
                              @RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                              @RequestParam(value = "pageSize",defaultValue = "10") int pageSize){


        model.addAttribute("orderNo", orderNo);
        model.addAttribute("status", status);

        Object page = iOrderService.manageList(orderNo,status,pageNum,pageSize).getData();
        model.addAttribute("page", page);
        return "/admin/manageOrder";
    }

   /* @RequestMapping("/list")
    @ResponseBody
    public Object goOrderPagesdfsdf(Model model,
                              @RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                              @RequestParam(value = "pageSize",defaultValue = "10") int pageSize){

        Object page = iOrderService.manageList(pageNum,pageSize).getData();
        model.addAttribute("page", page);
        return page;
    }*/

    @RequestMapping("/manageSendGoods")
    @ResponseBody
    public Object manageSendGoods(Long orderNo){
        ServerResponse serverResponse = iOrderService.manageSendGoods(orderNo);
        return serverResponse;
    }
}
