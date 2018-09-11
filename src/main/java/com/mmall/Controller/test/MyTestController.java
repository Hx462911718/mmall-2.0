package com.mmall.Controller.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author hexin
 * @createDate 2018年09月11日 9:18:00
 */
@Controller
@RequestMapping("/test")
public class MyTestController {

    @RequestMapping("/toupload")
    public String toupload(){
        return "/test1";
    }
}
