package kr.or.wabis.framework.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.or.wabis.framework.util.SessionUtil;

public class AuthInterceptor extends HandlerInterceptorAdapter {
    
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        
        if (SessionUtil.isNotLogin()) {
            
            logger.debug("### [No Auth !!!!!!] Redirect to /login.do");
            
            request.setAttribute("redirectLogin", "Y");
            
            // 'Do login' message
            request.setAttribute("msg", "Do login"); 
            
            // auth fail
            response.setStatus(401); 
            
            return false;
        }
        
        HttpSession session = request.getSession();
        if (session == null) {
            session = request.getSession(true);
        }
        
        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
    
}
