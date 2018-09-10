package com.mmall.Controller.backend;

import com.github.pagehelper.PageInfo;
import com.mmall.common.Const;
import com.mmall.common.ServerResponse;
import com.mmall.pojo.User;
import com.mmall.service.IUserService;
import com.mmall.utils.CookieUtil;
import com.mmall.utils.JsonUtil;
import com.mmall.utils.RedisShardPoolUtil;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;


/**
 * @author hexin
 * @createDate 2018年03月16日 15:25:00
 */
@Controller
@RequestMapping("/manage/user")
public class UserManageController {

    @Autowired
    private IUserService iUserService;

    @RequestMapping(value="login.do",method = RequestMethod.GET)
    @ResponseBody
    public ServerResponse<User> login(String username, String password, HttpServletResponse httpServletResponse, HttpSession session){
        ServerResponse<User> response = iUserService.login(username,password);
        if(response.isSuccess()){
            User user = response.getData();
            if(user.getRole() == Const.Role.ROLE_ADMIN){
                //说明登录的是管理员
                  CookieUtil.writeLoginCookie(httpServletResponse,session.getId());
                  RedisShardPoolUtil.setWithExpireTime(session.getId(), JsonUtil.obj2String(response.getData()),Const.RedisCacheExtime.REDIS_SESSION_EXTIME);

//                 session.setAttribute(Const.CURRENT_USER,user);
                return response;
            }else{
                return ServerResponse.createByErrorMessage("不是管理员,无法登录");
            }
        }
        return response;
    }

    @RequestMapping({"","/"})
    public String goUserPage(
            @RequestParam(value = "username",required = false) String username,
            @RequestParam(value = "role",required = false) Integer role,
            @RequestParam(value = "pageNum",defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,
            Model model){
        ServerResponse<PageInfo> page = iUserService.getUserList(username , role, pageNum , pageSize);
        model.addAttribute("page",page.getData());
        model.addAttribute("username",username);
        model.addAttribute("role",role);
        return "/admin/manageUser";
    }


    @RequestMapping("/setOrCancleAdminRole")
    @ResponseBody
    public ServerResponse setOrCancleAdminRole(Integer userId){
        User user = iUserService.selectUserById(userId);
        return iUserService.setOrCancleAdminRole(user);
    }

}