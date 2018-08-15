package com.mmall.service;

import com.github.pagehelper.PageInfo;
import com.mmall.common.ServerResponse;
import com.mmall.pojo.User;

import java.util.List;

/**
 * @author hexin
 * @createDate 2018年03月16日 13:17:00
 */
public interface IUserService {

    /**
     * 用户登录
     * @param username  用户名
     * @param password  密码
     * @return  登录成功与否的status以及msg
     */
    ServerResponse<User> login(String username , String password);


    /**
     * 用户注册
     * @param user 注册用户对象
     * @return  注册成功与否的status以及msg
     */
    ServerResponse<String> register(User user);


    /**
     * 检查用户字段的合法性
     * @param str 需要检查的字段名
     * @param type 需要检查的字段类型（比如是用户名/还是邮箱）
     * @return
     */
    ServerResponse<String> checkValid(String str , String type);


    //修改密码时选择问题
    ServerResponse selectQuestion(String username);

    //检查问题的答案
    ServerResponse<String> checkAnswer(String username , String question , String answer);

    //忘记密码时重置密码
    ServerResponse<String> forgetResetPassword(String username , String passwordNew , String forgetToken);

    //用户在登录状态下修改密码
    ServerResponse<String> resetPassword(User user , String passwordOld , String passwordNew);

    //更新个人信息
    ServerResponse<User> updateInformation(User user);

    //根据id获取用户信息
    User selectUserById(Integer userId);

    //获取用户个人信息
    ServerResponse<User> getInformation(Integer userId);

    //判断是否是管理员
    ServerResponse checkAdminRole(User user);

    //获取userlist
    ServerResponse<PageInfo> getUserList(String username, Integer roleType, int pageNum, int pageSize);

    //是否设置为管理员
    ServerResponse<User> setOrCancleAdminRole(User user);
}
