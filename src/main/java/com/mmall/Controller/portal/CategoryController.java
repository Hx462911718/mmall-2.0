package com.mmall.Controller.portal;

import com.mmall.common.ServerResponse;
import com.mmall.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author lubiao
 * @createDate 2018年04月05日 下午 12:09:00
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private ICategoryService iCategoryService;

    @ResponseBody
    @RequestMapping("/allCategory")
    public ServerResponse getCategoryAndChildrenCategory(){
        return ServerResponse.createBySuccess(iCategoryService.getCategoryAndChildrenCategory());
    }



}
