package com.mmall.Controller.portal;

import com.github.pagehelper.PageInfo;
import com.mmall.common.Const;
import com.mmall.common.ServerResponse;
import com.mmall.pojo.Category;
import com.mmall.pojo.Product;
import com.mmall.pojo.User;
import com.mmall.service.ICategoryService;
import com.mmall.service.IProductService;
import com.mmall.vo.CategoryListVo;
import com.mmall.vo.ProductDetailVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author lubiao
 * @createDate 2018年03月30日 下午 02:46:00
 */
@Controller
@RequestMapping("/product/")
public class ProductController {

    @Autowired
    private IProductService iProductService;

    @Autowired
    private ICategoryService iCategoryService;

    @RequestMapping("detail.do")
    @ResponseBody
    public ServerResponse<ProductDetailVo> detail(Integer productId) {
        return iProductService.getProductDetail(productId);
    }

    @RequestMapping("list.do")
    @ResponseBody
    public ServerResponse<PageInfo> list(@RequestParam(value = "keyword", required = false) String keyword,
                                         @RequestParam(value = "categoryId", required = false) Integer categoryId,
                                         @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                         @RequestParam(value = "orderBy", defaultValue = "") String orderBy) {
        return iProductService.getProductByKeywordCategory(keyword, categoryId, pageNum, pageSize, orderBy);
    }

    @RequestMapping("listByCategory")
    public String getListByCategory(HttpSession session,
                                    @RequestParam(value = "keyword", required = false) String keyword,
                                    @RequestParam(value = "categoryId", required = false) Integer categoryId,
                                    @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                                    @RequestParam(value = "pageSize", defaultValue = "20") int pageSize,
                                    @RequestParam(value = "orderBy", defaultValue = "") String orderBy, Model model) {

        //返回keyword
        model.addAttribute("keyword", keyword);

        //获取当前登陆的用户信息
        User CURRENT_USER = (User) session.getAttribute(Const.CURRENT_USER);
        model.addAttribute("CURRENT_USER", CURRENT_USER);

        ServerResponse<PageInfo> productList =  iProductService.getProductByKeywordCategory(keyword, categoryId, pageNum, pageSize, orderBy);
        model.addAttribute("page", productList.getData());

        //所有分类
        List<CategoryListVo> categoryListVoList = this.iCategoryService.getCategoryAndChildrenCategory();
        model.addAttribute("categoryListVoList", categoryListVoList);

        //当前分类
        Category category = iCategoryService.getCategoryById(categoryId);
        model.addAttribute("category", category);

        //当前分类下的子分类
        List<Category> categoryList = this.iCategoryService.getChildrenParallelCategory(categoryId).getData();
        //没有子分类
        if (categoryList.size() == 0) {
            //返回查询其父类
            Category parentCategory = this.iCategoryService.getCategoryById(category.getParentId());
            model.addAttribute("parentCategory", parentCategory);
            //查询同级别的子分类
            List<Category> sameLevelCategoryList = this.iCategoryService.getChildrenParallelCategory(category.getParentId()).getData();
            model.addAttribute("sameLevelCategoryList", sameLevelCategoryList);
        } else {
            model.addAttribute("categoryList", categoryList);

        }


        return "/product";
    }

    @RequestMapping("productDetail")
    public String goProductDetail(HttpSession session , Integer productId , Model model){

        //获取当前登陆的用户信息
        User CURRENT_USER = (User) session.getAttribute(Const.CURRENT_USER);
        model.addAttribute("CURRENT_USER", CURRENT_USER);

        //所有分类
        List<CategoryListVo> categoryListVoList = this.iCategoryService.getCategoryAndChildrenCategory();
        model.addAttribute("categoryListVoList", categoryListVoList);

        //获得商品的Vo
        ProductDetailVo productDetailVo = iProductService.getProductDetail(productId).getData();
        model.addAttribute("productDetailVo", productDetailVo);

        //获得一级父类
        Category parentCategory = iCategoryService.getCategoryById(productDetailVo.getParentCategoryId());
        model.addAttribute("parentCategory", parentCategory);

        //获得二级父类
        Category category = iCategoryService.getCategoryById(productDetailVo.getCategoryId());
        model.addAttribute("category", category);

        return "/productDetails";
    }

}
