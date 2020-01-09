package kr.or.wabis.framework.web.interceptor;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.or.wabis.framework.contants.CmsConstant;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.web.support.RequestParamParser;
import kr.or.wabis.user.vo.UserVO;

public class SessionInterceptor extends HandlerInterceptorAdapter {
    
    protected Log logger = LogFactory.getLog(SessionInterceptor.class);
    
    public static final String DEFAULT_PARAM_NAME = "locale";
    
    private String localeParamName;
    
    public SessionInterceptor() {
        this.localeParamName = "locale";
    }
    
    /**
     * 
     * @param localeParamName
     */
    public void setLocaleParamName(String localeParamName) {
        this.localeParamName = localeParamName;
    }
    
    /**
     * 
     * @return
     */
    public String getLocaleParamName() {
        return this.localeParamName;
    }
    
    /**
     * 사전 처리
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        
        String targetURI = request.getRequestURI();
        StringBuffer sb = new StringBuffer();
        String userId = "";
        String userIp = "";
        String authCode = "";
        
        // 권한 정보 획득
        List<String> authorities = this.getAuthorities();
        
        // 세션 정보 획득
        HttpSession session = request.getSession();
        
        // 사용자 정보 획득
        UserVO userVo = (UserVO) session.getAttribute(CmsConstant.SESSION_USER);
        // logger.debug("userVo : " + userVo);
        
        if (userVo != null) {
            
            userId = userVo.getUserId();
            userIp = request.getRemoteAddr();
            
            if (authorities != null) {
                authCode = (String) authorities.get(0);
            } else {
                logger.error("authorities is null");
                authCode = "ROLE_USER";
            }
        }
        
        HandlerMethod hm = (HandlerMethod) handler;
        Method method = hm.getMethod();
        
        // request 정보
        sb.append("\n<==================================== [ Pre Handle ] =============================================>");
        sb.append("\n# Request URL : " + request.getRequestURL());
        sb.append("\n# Client IP : " + request.getRemoteAddr());
        sb.append("\n# User Agent : " + request.getHeader("User-Agent"));        
        sb.append("\n# User Id :" + userId);
        sb.append("\n# Auth Code :" + authCode);
        sb.append("\n# Locale :" + LocaleContextHolder.getLocale());
        
        String xmlreq = request.getHeader("x-requested-with");
        
        boolean isAjaxRequest = false;
        if (xmlreq != null && xmlreq.startsWith("XMLHttpRequest")) {
            isAjaxRequest = true;
            sb.append("\n# Request Method : " + xmlreq);
        } else {
            sb.append("\n# Request Method : " + request.getMethod());
        }
        sb.append("\n# Referer : " + request.getHeader("referer"));
        
        ExtHttpRequestParam extParam = RequestParamParser.parse(request);

        sb.append("\n# Parameters : " + extParam.toString());
        
        sb.append("\n<==================================================================================================>");        
        logger.debug(sb.toString());
        
        if (method.getDeclaringClass().isAnnotationPresent(Controller.class)) {
            logger.debug("### [Enter] Controller  : " + method.getDeclaringClass() + "." + method.getName() + "()");
        } else {
            logger.debug("### [Enter] Handler(Controller)  : " + handler.getClass().getName());
        }
        
        request.setAttribute("controlAction", request.getRequestURI());
                
        boolean sessionInvalid = false;
        try {
            
            if (!"".equals(request.getSession().getId())) {
                
                String url = request.getRequestURL().toString();
                
                // 일반 사용자 일 경우만 세션 관리함 (관리자는 패스)
                if (CmsConstant.ROLE_USER.equals(session.getAttribute("s_user_gb")) && url.indexOf("back") > -1) {
                    sessionInvalid = true;
                }
            }
            
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        
        if (sessionInvalid) {
            ModelAndView modelAndView = new ModelAndView("/auth.do");
            throw new ModelAndViewDefiningException(modelAndView);
        } else {
            return true;
        }
        
    }
    
    /**
     * 웹 로그정보를 생성한다.
     * 
     * @param HttpServletRequest request, HttpServletResponse response, Object handler
     * @return
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modeAndView) throws Exception {
        
        if (logger.isDebugEnabled() && modeAndView != null) {
            
            StringBuffer sb = new StringBuffer();
            
            try {
                                
                View view = modeAndView.getView();
                
                // request 정보
                sb.append("\n<==================================== [ Post Handle ] =============================================>");
                sb.append("\n# URL : " + request.getRequestURL());
                
                if (view == null) {
                    sb.append("\n## View Name  : " + modeAndView.getViewName());
                } else {
                    sb.append("\n## View Name  : " + modeAndView.getViewName() + " , " + modeAndView.getView());
                }
                
                sb.append("\n<==================================================================================================>");
                
                logger.debug(sb.toString());
                
            } catch (Exception e) {
                logger.debug(" not Found View Name!!!");
            }
        }
    }
    
    /**
     * Auth 정보를 가지고 온다
     * 
     * @return
     */
    public List<String> getAuthorities() {
        
        List<String> listAuth = new ArrayList<String>();
        
        // 스프링시큐리티 인정 정보를 리턴한다
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        if (authentication == null) {
            return null;
        }
        
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        
        for (GrantedAuthority authority : authorities) {
            listAuth.add(authority.getAuthority());
        }
        
        return listAuth;
    }
}