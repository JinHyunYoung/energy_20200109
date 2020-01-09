package kr.or.wabis.framework.web.support;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * Spring의 Application Context 를 가져오기위한 클래스
 */
public class ApplicationContextProvider implements ApplicationContextAware {
    
    private static ApplicationContext applicationContext = null;
    
    public ApplicationContextProvider() {
    }
    
    @Override
    public void setApplicationContext(ApplicationContext ctx) throws BeansException {
        ApplicationContextProvider.applicationContext = ctx;
    }
    
    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }
    
}
