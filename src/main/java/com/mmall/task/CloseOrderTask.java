package com.mmall.task;

import com.mmall.service.IOrderService;
import com.mmall.utils.PropertiesUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author hexin
 * @createDate 2018年08月14日 11:11:00
 */
@Component
@Slf4j
public class CloseOrderTask {
    @Autowired
    private IOrderService orderService;
    //每分钟执行一次
    @Scheduled(cron = "0 0/1 * * * ?")
    public  void  closeOrder(){
//        log.info("定时任务开启");
//        int days = Integer.parseInt(PropertiesUtil.getProperty("close.order.task.time.day","3"));
//        orderService.insertProductByOrder(days);
//        log.info("关闭");
    }


}
