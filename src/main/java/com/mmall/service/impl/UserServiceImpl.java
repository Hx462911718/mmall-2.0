package com.mmall.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mmall.common.Const;
import com.mmall.common.ServerResponse;
import com.mmall.common.TokenCache;
import com.mmall.dao.UserMapper;
import com.mmall.pojo.User;
import com.mmall.service.IUserService;
import com.mmall.utils.JedisPoolUtil;
import com.mmall.utils.MD5Util;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author hexin
 * @createDate 2018年03月16日 13:17:00
 */
@Service("iUserService")
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public ServerResponse<User> login(String username, String password) {
        int resultCount = userMapper.checkUsername(username);
        if(resultCount == 0){
            return ServerResponse.createByErrorMessage("用户名不存在");
        }

        String md5Password = MD5Util.MD5EncodeUtf8(password);

        User user = userMapper.selectLogin(username , md5Password);
        if(user == null){
            return ServerResponse.createByErrorMessage("密码不正确！");
        }

        user.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess("登录成功",user);
    }



    public ServerResponse<String> register(User user){
        user.setCreateTime(new Date());
        user.setUpdateTime(new Date());
        //校验用户名
        ServerResponse validResponse = this.checkValid(user.getUsername() , Const.USERNAME);
        if(!validResponse.isSuccess()){
            return validResponse;
        }
        //校验邮箱
        validResponse = this.checkValid(user.getEmail() , Const.EMAIL);
        if(!validResponse.isSuccess()){
            return validResponse;
        }
        //默认为普通用户
        user.setRole(Const.Role.ROLE_CUSTOMER);
        //md5加密
        user.setPassword(MD5Util.MD5EncodeUtf8(user.getPassword()));
        int resultCount = userMapper.insert(user);//插入数据
        if(resultCount == 0){
            return ServerResponse.createByErrorMessage("注册失败");
        }

        return ServerResponse.createBySuccessMessage("注册成功");
    }



    /**
     * 合法性校验方法封装
     * @param str 校验的参数
     * @param type 参数的类型
     * @return
     */
    public ServerResponse<String> checkValid(String str , String type){

        if(StringUtils.isNotBlank(type)){
            //开始校验
            if(Const.USERNAME.equals(type)){
                int resultCount = userMapper.checkUsername(str);
                if(resultCount > 0){
                    return ServerResponse.createByErrorMessage("用户名已存在");
                }
            }
            if(Const.EMAIL.equals(type)){
                int resultCount = userMapper.checkEmail(str);
                if(resultCount > 0){
                    return ServerResponse.createByErrorMessage("邮箱已存在");
                }
            }

        }else{
            return ServerResponse.createByErrorMessage("参数错误");
        }

        return ServerResponse.createBySuccessMessage("校验成功");
    }

    public ServerResponse selectQuestion(String username){
        ServerResponse validResponse = this.checkValid(username , Const.USERNAME);
        if(validResponse.isSuccess()){
            //用户不存在
            return ServerResponse.createByErrorMessage("用户不存在");
        }

        String question = userMapper.selectQuestionByUsername(username);
        if(StringUtils.isNotBlank(question)){
            return ServerResponse.createBySuccess(question);
        }

        return ServerResponse.createByErrorMessage("找回密码的问题是空的");
    }

    public ServerResponse<String> checkAnswer(String username , String question , String answer){
        int resultCount =  userMapper.checkAnswer(username , question , answer);
        if(resultCount>0){
            //说明问题及问题答案是这个用户的，并且是正确的
            String forgetToken = UUID.randomUUID().toString();
            //TokenCache.setKey(TokenCache.TOKEN_PREFIX+username , forgetToken);
            JedisPoolUtil.setWithExpireTime(Const.TOKEN_PREFIX+username,forgetToken,60*60*12);
            return ServerResponse.createBySuccess(forgetToken);
        }
        return ServerResponse.createByErrorMessage("问题的答案错误");
    }

    public ServerResponse<String> forgetResetPassword(String username , String passwordNew , String forgetToken){
        if(StringUtils.isBlank(forgetToken)){
            return ServerResponse.createByErrorMessage("参数错误，token需要传递");
        }
        ServerResponse validResponse = this.checkValid(username , Const.USERNAME);
        if(validResponse.isSuccess()){
            //用户不存在
            return ServerResponse.createByErrorMessage("用户不存在");
        }
       // String token = TokenCache.getKey(TokenCache.TOKEN_PREFIX+username);
        String token = JedisPoolUtil.get(Const.TOKEN_PREFIX+username);
        if(StringUtils.isBlank(token)){
            return ServerResponse.createByErrorMessage("token无效或者过期");
        }

        if(StringUtils.equals(forgetToken , token)){
            String md5Password  = MD5Util.MD5EncodeUtf8(passwordNew);
            int rowCount = userMapper.updatePasswordByUsername(username , md5Password);
            if(rowCount > 0){
                JedisPoolUtil.del(Const.TOKEN_PREFIX+username);
                return ServerResponse.createBySuccessMessage("修改密码成功");
            }
        }else{
            return ServerResponse.createByErrorMessage("token错误，请重新获取重置密码的token");
        }
        return ServerResponse.createByErrorMessage("修改密码失败");

    }

    public ServerResponse<String> resetPassword(User user , String passwordOld , String passwordNew){
        //防止横向越权问题的出现，要校验一下这个用户的旧密码，一定要这个用户的，因为我们会查询一个count(1)出来，
        //如果不指定id，结果那就是true了，count>大于0
        int resultCount = userMapper.checkPassword(MD5Util.MD5EncodeUtf8(passwordOld) , user.getId());
        if(resultCount == 0){
            return ServerResponse.createByErrorMessage("旧密码不正确");
        }
        user.setPassword(MD5Util.MD5EncodeUtf8(passwordNew));
        int updateCount = userMapper.updateByPrimaryKeySelective(user);
        if(updateCount > 0){
            return ServerResponse.createBySuccessMessage("密码更新成功");
        }
        return ServerResponse.createByErrorMessage("密码更新失败");
    }

    public ServerResponse<User> updateInformation(User user){
        //username是不能被更新的
        //同时email也要进行校验，校验新的email是不是已经存在，并且存在的email如果相同的话，你能是当前的用户的
        int resultCount = userMapper.checkEmailByUserId(user.getEmail(),user.getId());
        if(resultCount > 0){
            return ServerResponse.createByErrorMessage("邮箱已存在，请更换email重新更新");
        }
        User updateUser = new User();
        updateUser.setId(user.getId());
        updateUser.setEmail(user.getEmail());
        updateUser.setPhone(user.getPhone());
        updateUser.setQuestion(user.getQuestion());
        updateUser.setAnswer(user.getAnswer());

        int updateCount = userMapper.updateByPrimaryKeySelective(updateUser);
        if(updateCount > 0){
            return ServerResponse.createBySuccess("更新用户信息成功",updateUser);
        }
        return ServerResponse.createByErrorMessage("更新个人信息失败");
    }

    @Override
    public User selectUserById(Integer userId) {
        return userMapper.selectByPrimaryKey(userId);
    }


    public ServerResponse<User> getInformation(Integer userId){
        User user = userMapper.selectByPrimaryKey(userId);
        if(user == null){
            return ServerResponse.createByErrorMessage("找不到当前用户");
        }
        user.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess(user);
    }

    //backend

    /**
     * 判断是否是管理员
     * @param user
     * @return
     */
    public ServerResponse checkAdminRole(User user){
        if(user != null && user.getRole().intValue() == Const.Role.ROLE_ADMIN){
            return ServerResponse.createBySuccess();
        }
        return ServerResponse.createByError();
    }

    @Override
    public ServerResponse<PageInfo> getUserList(String username, Integer role, int pageNum, int pageSize) {
        if(StringUtils.isNotBlank(username)){
            username = new StringBuilder().append("%").append(username).append("%").toString();
        }else{
            username = new StringBuilder().append("%").append("").append("%").toString();
        }
        PageHelper.startPage(pageNum,pageSize);
        List<User> userList = userMapper.getUserList(StringUtils.isBlank(username)?null:username,role);
        PageInfo pageInfo = new PageInfo(userList);
        return ServerResponse.createBySuccess(pageInfo);

    }

    @Override
    public ServerResponse<User> setOrCancleAdminRole(User user) {
        Integer role = user.getRole();
        if(role == 0){
            user.setRole(1);
        }
        if(role == 1){
            user.setRole(0);
        }
        int updateCount = userMapper.updateByPrimaryKey(user);
        if(updateCount > 0){
            return ServerResponse.createBySuccessMessage("修改成功");
        }
        return ServerResponse.createByErrorMessage("修改失败");

    }

}

