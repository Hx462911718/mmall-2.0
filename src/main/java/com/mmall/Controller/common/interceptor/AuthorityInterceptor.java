package com.mmall.Controller.common.interceptor;

import com.mmall.common.Const;
import com.mmall.common.ServerResponse;
import com.mmall.pojo.User;
import com.mmall.utils.CookieUtil;
import com.mmall.utils.JsonUtil;
import com.mmall.utils.RedisShardPoolUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;

/**
 * @author hexin
 * @createDate 2018年09月10日 14:22:00
 */
@Slf4j
public class AuthorityInterceptor implements HandlerInterceptor{
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //解析handler
        HandlerMethod handlerMethod = (HandlerMethod) o;
        String methoName = handlerMethod.getMethod().getName();
        String classNme = handlerMethod.getClass().getSimpleName();

        //获取请求参数
        Map paramMap = httpServletRequest.getParameterMap();
        StringBuffer param = new StringBuffer();
        Iterator iterator = paramMap.entrySet().iterator();
        while (iterator.hasNext()){
            Map.Entry entry = (Map.Entry) iterator.next();
            String mapKey = (String) entry.getKey();
            String mapValue = "";
            Object obj = entry.getValue();
            if(obj instanceof  String[]){
                String[] str = (String[]) obj;
                mapValue = Arrays.toString(str);

            }
            param.append(mapKey).append("=").append(mapValue);
        }
        String  loginToken = CookieUtil.readLoginToken(httpServletRequest);
        User user = null;
        if(StringUtils.isNotEmpty(loginToken)){
            String userStr = RedisShardPoolUtil.get(loginToken);
           user = JsonUtil.string2Obj(userStr,User.class);
        }
        if(user == null || (user.getRole()!= Const.Role.ROLE_ADMIN)){
            //false，不会调用controller方法
            //这里要添加reset,否则包异常 getWriter
            httpServletResponse.reset();
            //设置编码
            httpServletResponse.setCharacterEncoding("UTF-8");
            //设置返回数据类型
            httpServletResponse.setContentType("application/json;charset=UTf-8");
            PrintWriter out = httpServletResponse.getWriter();
            if (user == null){
                out.println(JsonUtil.obj2String(ServerResponse.createByErrorMessage("拦截器拦截,用户未登录")));
            }else{
                out.println(JsonUtil.obj2String(ServerResponse.createByErrorMessage("拦截器拦截,该用户权限不足，请管理员登录")));
            }
            out.flush();
            out.close();
            return  false;
        }
         return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
