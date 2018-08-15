package com.mmall.service;

import com.github.pagehelper.PageInfo;
import com.mmall.common.ServerResponse;
import com.mmall.pojo.Category;
import com.mmall.vo.CategoryListVo;

import java.util.List;

/**
 * @author hexin
 * @createDate 2018年03月16日 15:52:00
 */
public interface ICategoryService {

    //添加分类
    ServerResponse addCategory(String categoryName, Integer parentId);

    //删除分类
    ServerResponse delete(Integer id);

    //修改分类的名称
    ServerResponse updateCategoryName(Integer categoryId,String categoryName);

    //获得该分类下的所有子分类(非递归)
    ServerResponse<List<Category>> getChildrenParallelCategory(Integer categoryId);

    //递归查询本节点的id及孩子节点的id
    ServerResponse<List<Integer>> selectCategoryAndChildrenById(Integer categoryId);

    //查询所有一级分类及对应的二级分类
    List<CategoryListVo> getCategoryAndChildrenCategory();

    ServerResponse<PageInfo> selectCategoryByKeys(String categoryName ,Integer parentId,Integer status, int pageNum, int pageSize);

    Category getCategoryById(Integer categoryId);



}
