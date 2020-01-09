package kr.or.wabis.login.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.wabis.contents.service.LogoService;
import kr.or.wabis.framework.util.ExtHttpRequestParam;

@Controller("loginController")
public class LoginController {
    
    private Logger logger = LoggerFactory.getLogger(LoginController.class);
    
    @Resource(name = "logoService")
    private LogoService logoService;

    
    /**
     * 로그인 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login.do")
    public String login(final HttpServletRequest request, final HttpServletResponse response, ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        String url = request.getRequestURL().toString();        
        logger.debug("url : " + url);
        
        response.sendRedirect("/web/user/main.do");
        
        return "/adminLogin";
    }
    
    /**
     * 로그인 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin.do")
    public String loginAdmin(final HttpServletRequest request, final HttpServletResponse response, ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        String url = request.getRequestURL().toString();        
        HttpSession session = request.getSession();
        
        logger.debug("url : " + url);        
                
        Map<String, Object> logo = (Map<String, Object>) session.getAttribute("Logo");        
        if (logo == null) {
            logo = logoService.selectLogo(param);
            session.setAttribute("Logo", logo);
        }
        
        String errorMessage = (String) request.getAttribute("errorMessage");        
        logger.debug("errorMessage : {} ", errorMessage);        
        request.setAttribute("errorMessage", errorMessage);
        
        return "/adminLogin";
    }
    
    /**
     * 로그인 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin")
    public String admin(final HttpServletRequest request, final HttpServletResponse response, ExtHttpRequestParam _req, ModelMap model) throws Exception {  
    	 
        Map<String, Object> param = _req.getParameterMap();
        
        String url = request.getRequestURL().toString();        
        HttpSession session = request.getSession();
        
        logger.debug("url : " + url);        
                
        Map<String, Object> logo = (Map<String, Object>) session.getAttribute("Logo");        
        if (logo == null) {
            logo = logoService.selectLogo(param);
            session.setAttribute("Logo", logo);
        }
        
        String errorMessage = (String) request.getAttribute("errorMessage");        
        logger.debug("errorMessage : {} ", errorMessage);        
        request.setAttribute("errorMessage", errorMessage);
        return "/adminLogin";
    }    
    
}
