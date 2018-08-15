package com.mmall.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.mmall.common.Const;
import com.mmall.common.ServerResponse;
import com.mmall.dao.CategoryMapper;
import com.mmall.pojo.Category;
import com.mmall.service.ICategoryService;
import com.mmall.vo.CategoryListVo;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * @author hexin
 * @createDate 2018年03月16日 15:53:00
 */
@Service("iCategoryService")
public class CategoryServiceImpl implements ICategoryService {

    private Logger logger = LoggerFactory.getLogger(CategoryServiceImpl.class);

    @Autowired
    private CategoryMapper categoryMapper;

    /**
     * 添加分类
     * @param categoryName 名称
     * @param parentId 父id
     * @return
     */
    public ServerResponse addCategory(String categoryName,Integer parentId){
        if(parentId == null || StringUtils.isBlank(categoryName)){
            return ServerResponse.createByErrorMessage("添加品类参数错误");
        }

        Category category = new Category();
        category.setName(categoryName);
        category.setParentId(parentId);
        category.setStatus(true);//这个分类是可用的
        category.setCreateTime(new Date());
        category.setUpdateTime(new Date());

        int rowCount = categoryMapper.insert(category);
        if(rowCount > 0){
            return ServerResponse.createBySuccessMessage("添加品类成功");
        }
        return ServerResponse.createByErrorMessage("添加品类失败");
    }

    @Override
    public ServerResponse delete(Integer id) {
        if(id == null){
            return ServerResponse.createByErrorMessage("删除品类参数错误");
        }
        int rowCount = categoryMapper.deleteByPrimaryKey(id);
        if(rowCount > 0){
            return ServerResponse.createBySuccessMessage("删除品类成功");
        }
        return ServerResponse.createByErrorMessage("删除品类失败");
    }

    /**
     * 根据id修改分类的名称
     * @param categoryId id
     * @param categoryName 名称
     * @return
     */
    public ServerResponse updateCategoryName(Integer categoryId,String categoryName){
        if(categoryId == null || StringUtils.isBlank(categoryName)){
            return ServerResponse.createByErrorMessage("更新品类参数错误");
        }
        Category category = new Category();
        category.setId(categoryId);
        category.setName(categoryName);

        int rowCount = categoryMapper.updateByPrimaryKeySelective(category);
        if(rowCount > 0){
            return ServerResponse.createBySuccessMessage("更新品类名字成功");
        }
        return ServerResponse.createByErrorMessage("更新品类名字失败");
    }

    /**
     *
     * @param categoryId id
     * @return
     */
    public ServerResponse<List<Category>> getChildrenParallelCategory(Integer categoryId){
        List<Category> categoryList = categoryMapper.selectCategoryChildrenByParentId(categoryId);
        if(CollectionUtils.isEmpty(categoryList)){
            logger.info("未找到当前分类的子分类");
        }
        return ServerResponse.createBySuccess(categoryList);
    }


    /**
     * 递归查询本节点的id及孩子节点的id
     * @param categoryId
     * @return
     */
    public ServerResponse<List<Integer>> selectCategoryAndChildrenById(Integer categoryId){
        Set<Category> categorySet = Sets.newHashSet();
        findChildCategory(categorySet,categoryId);


        List<Integer> categoryIdList = Lists.newArrayList();
        if(categoryId != null){
            for(Category categoryItem : categorySet){
                categoryIdList.add(categoryItem.getId());
            }
        }
        return ServerResponse.createBySuccess(categoryIdList);
    }

    /**
     * 查询所有一级分类及对应的二级分类
     * @return
     */
    @Override
    public List<CategoryListVo> getCategoryAndChildrenCategory() {
        List<CategoryListVo> categoryListVoList = Lists.newArrayList();
        List<Category> categoryList = this.categoryMapper.selectCategoryChildrenByParentId(Const.PARENTID);//所有的一级分类
        for(Category category : categoryList){
            CategoryListVo categoryListVo = assembleCategoryListVo(category);
            categoryListVoList.add(categoryListVo);
        }
        return categoryListVoList;
    }

    @Override
    public ServerResponse<PageInfo> selectCategoryByKeys(String categoryName, Integer parentId, Integer status, int pageNum, int pageSize) {
        if(StringUtils.isNotBlank(categoryName)){
            categoryName = new StringBuilder().append("%").append(categoryName).append("%").toString();
        }else{
            categoryName = new StringBuilder().append("%").append("").append("%").toString();
        }
        PageHelper.startPage(pageNum,pageSize);
        List<Category> categoryList = categoryMapper.selectCategoryChildrenByKeys(categoryName, parentId , status);
        PageInfo pageInfo = new PageInfo(categoryList);
        return ServerResponse.createBySuccess(pageInfo);
    }

    @Override
    public Category getCategoryById(Integer categoryId) {
        return categoryMapper.selectByPrimaryKey(categoryId);
    }

    /**
     * 组装CategoryListVo
     * @param category
     * @return
     */
    private CategoryListVo assembleCategoryListVo(Category category){
        CategoryListVo categoryListVo = new CategoryListVo();
        categoryListVo.setId(category.getId());
        categoryListVo.setParentId(category.getParentId());
        categoryListVo.setName(category.getName());
        categoryListVo.setStatus(category.getStatus());
        categoryListVo.setCreateTime(category.getCreateTime());
        categoryListVo.setUpdateTime(category.getUpdateTime());
        categoryListVo.setCategoryList(this.categoryMapper.selectCategoryChildrenByParentId(category.getId()));
        return categoryListVo;
    }




    //递归算法,算出子节点
    private Set<Category> findChildCategory(Set<Category> categorySet ,Integer categoryId){
        Category category = categoryMapper.selectByPrimaryKey(categoryId);
        if(category != null){
            categorySet.add(category);
        }
        //查找子节点,递归算法一定要有一个退出的条件
        List<Category> categoryList = categoryMapper.selectCategoryChildrenByParentId(categoryId);
        for(Category categoryItem : categoryList){
            findChildCategory(categorySet,categoryItem.getId());
        }
        return categorySet;
    }
}
