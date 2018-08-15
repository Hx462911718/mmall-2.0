package com.mmall.Controller.backend;

import com.github.pagehelper.PageInfo;
import com.mmall.common.Const;
import com.mmall.common.ResponseCode;
import com.mmall.common.ServerResponse;
import com.mmall.pojo.Category;
import com.mmall.pojo.User;
import com.mmall.service.ICategoryService;
import com.mmall.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author hexin
 * @createDate 2018年04月23日 下午 05:32:00
 */
@Controller
@RequestMapping("/manage/childCategory")
public class ChildCategoryManageController {

    @Autowired
    private ICategoryService iCategoryService;

    @RequestMapping({"","/"})
    public String goChildCategoryPage(@RequestParam(value = "categoryName",required = false)String categoryName,
                                      @RequestParam(value = "preCategoryId",required = false)Integer preCategoryId,
                                      @RequestParam(value = "status",required = false)Integer status,
                                      @RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
                                      @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,Model model){
        System.out.println(preCategoryId);
        ServerResponse<PageInfo> page  = iCategoryService.selectCategoryByKeys(categoryName,preCategoryId,status,pageNum,pageSize);
        Category category = iCategoryService.getCategoryById(preCategoryId);
        model.addAttribute("category",category);
        model.addAttribute("page",page.getData());
        model.addAttribute("categoryName",categoryName);
        model.addAttribute("preCategoryId",preCategoryId);
        model.addAttribute("status",status);
        return "/admin/manageChildCategory";
    }

    /**
     * 添加分类
     * @param session
     * @param categoryName
     * @param parentId
     * @return
     */
    @RequestMapping("/addCategory")
    @ResponseBody
    public ServerResponse addCategory(HttpSession session, String categoryName, int parentId) {
        return iCategoryService.addCategory(categoryName,parentId);
    }

    /**
     * 查询分类
     * @param session
     * @param id
     * @return
     */
    @RequestMapping("/getCategory")
    @ResponseBody
    public ServerResponse getCategory(HttpSession session , Integer id) {
        Category category = iCategoryService.getCategoryById(id);
        ServerResponse serverResponse = ServerResponse.createBySuccess(category);
        return serverResponse;
    }


    /**
     * 添加分类
     * @param session
     * @param categoryName
     * @param id
     * @return
     */
    @RequestMapping("/setCategoryName")
    @ResponseBody
    public ServerResponse setCategoryName(HttpSession session, String categoryName, int id) {
        return iCategoryService.updateCategoryName(id,categoryName);
    }


    /**
     * 删除分类
     * @param session
     * @param id
     * @return
     */
    @RequestMapping("/deleteCategory")
    @ResponseBody
    public ServerResponse deleteCategory(HttpSession session, int id) {
        return iCategoryService.delete(id);
    }

}
