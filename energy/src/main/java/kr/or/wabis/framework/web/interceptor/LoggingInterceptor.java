package kr.or.wabis.framework.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggingInterceptor extends HandlerInterceptorAdapter {
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.debug("");
        log.debug("----------------------------------------------------------------------------------------");
        log.debug("### [Enter] {}", request.getRequestURI());
        
        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            log.debug("### [View] {}", modelAndView.getViewName());
        }
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        
        String jsp = (String) request.getAttribute("jsp");
        
        if (jsp == null) {
            log.debug("### [Complete] {}", request.getRequestURI());
        } else {
            log.debug("### [Complete] {}, Return JSP : {}", request.getRequestURI(), jsp);
        }
    }
    
}
