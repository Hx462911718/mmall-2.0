package com.mmall.dao;

import com.mmall.pojo.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);

    //根据父id查询子分类
    List<Category> selectCategoryChildrenByParentId(Integer parentId);

    //根据条件查询子分类
    List<Category> selectCategoryChildrenByKeys(@Param(value="categoryName")String categoryName , @Param(value="parentId")Integer parentId, @Param(value="status")Integer status);
}