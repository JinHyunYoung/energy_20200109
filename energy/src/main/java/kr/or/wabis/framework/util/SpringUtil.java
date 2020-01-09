package kr.or.wabis.framework.util;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class SpringUtil implements ApplicationContextAware {
    
    private Logger log = LoggerFactory.getLogger(SpringUtil.class);
    
    private static ApplicationContext context = null;
    
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringUtil.context = applicationContext;
    }
    
    public SpringUtil() {
    }
    
    public static ApplicationContext getContext() {
        return context;
    }
    
    public static Object getBean(String bean) {
        return (Object) context.getBean(bean);
    }
    
    public static Object getBean(Class<?> clazz) {
        return (Object) context.getBean(clazz);
    }
    
    public static <T> T getBean(String bean, Class<T> type) {
        return context.getBean(bean, type);
    }
    
    public static HttpServletRequest getServletRequest() {
        ServletRequestAttributes servletRequestAttributes = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes());
        return servletRequestAttributes.getRequest();
    }
}
