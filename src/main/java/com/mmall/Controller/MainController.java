package com.mmall.Controller;

import com.github.pagehelper.PageInfo;
import com.mmall.common.Const;
import com.mmall.common.ServerResponse;
import com.mmall.pojo.User;
import com.mmall.service.ICategoryService;
import com.mmall.service.IProductService;
import com.mmall.vo.CategoryListVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * main-controller
 *
 * @author hexin
 * @createDate 2018年03月19日 14:11:00
 */

@Controller
@RequestMapping({"/", ""})
public class MainController {

    @Autowired
    private ICategoryService iCategoryService;

    @Autowired
    private IProductService iProductService;

    @RequestMapping({"","/"})
    public String toIndexpage(HttpSession session, Model model) {
        //获取当前登陆的用户信息
        User CURRENT_USER = (User) session.getAttribute(Const.CURRENT_USER);
        model.addAttribute("CURRENT_USER", CURRENT_USER);
        //获取分类信息，获取一级分类以及一级分类下的子类(这里最多有两级分类)
        List<CategoryListVo> categoryListVoList = this.iCategoryService.getCategoryAndChildrenCategory();
        model.addAttribute("categoryListVoList", categoryListVoList);

        //手机
        ServerResponse<PageInfo> phone = iProductService.getProductByKeywordCategory(null,100001,1,10,null);
        model.addAttribute("phone" , phone.getData());

        //笔记本电脑
        ServerResponse<PageInfo> computer = iProductService.getProductByKeywordCategory(null,100012,1,10,null);
        model.addAttribute("computer" , computer.getData());

        //智能穿戴
        ServerResponse<PageInfo> ware = iProductService.getProductByKeywordCategory(null,100003,1,10,null);
        model.addAttribute("ware" , ware.getData());

        //智能家居
        ServerResponse<PageInfo> home = iProductService.getProductByKeywordCategory(null,100004,1,10,null);
        model.addAttribute("home" , home.getData());

        return "/index";
    }

    @RequestMapping({"/login", "login"})
    public String toLoginpage() {
        return "/user/login";
    }

    @RequestMapping({"/logout", "logout"})
    public String toLogout(HttpSession session) {
        session.removeAttribute(Const.CURRENT_USER);
        return "/user/login";
    }

    @RequestMapping("/register")
    public String toRegisterPage() {
        return "/user/register";
    }


}
