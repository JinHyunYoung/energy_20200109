package kr.or.wabis.framework.web.tld;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import kr.or.wabis.framework.util.LocaleUtil;

public class ExtendedTagSupport extends SimpleTagSupport {
    
    protected String lngaCd;
    
    public ExtendedTagSupport() {
        super();
        init();
    }
    
    private void init() {
        this.lngaCd = LocaleUtil.getLanguage();
    }
    
    protected HttpServletRequest getRequest() {
        return (HttpServletRequest) super.getJspContext().getAttribute(PageContext.REQUEST);
    }
    
    protected HttpSession getSession() {
        return (HttpSession) super.getJspContext().getAttribute(PageContext.SESSION);
    }
    
    protected ApplicationContext getContext() {
        return WebApplicationContextUtils.getWebApplicationContext(getSession().getServletContext());
    }
    
    protected Object getServiceBean(String beanName) throws Exception {
        return getContext().getBean(beanName);
    }
    
    protected String getMessage(String messageId) {
        if (StringUtils.isEmpty(messageId)) {
            return "";
        }
        
        String message = "";
        try {
            message = getContext().getMessage(messageId, null, LocaleUtil.getLocale());
        } catch (Exception e) {
            message = "";
        }
        return message;
    }
    
}
