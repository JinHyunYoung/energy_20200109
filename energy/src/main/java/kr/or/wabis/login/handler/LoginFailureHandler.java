package kr.or.wabis.login.handler;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import kr.or.wabis.login.provider.LoginAuthenticationProvider;
import kr.or.wabis.login.vo.Role;
import kr.or.wabis.user.service.UserService;

public class LoginFailureHandler implements AuthenticationFailureHandler {
    
    private Logger logger = LoggerFactory.getLogger(LoginAuthenticationProvider.class);
    
    @Autowired
    private UserService userService;
    
    private String j_username;
    
    @Override
    public void onAuthenticationFailure(
    		final HttpServletRequest request, 
    		final HttpServletResponse response, 
    		final AuthenticationException exception) throws IOException, ServletException {
    	
    	String username = request.getParameter("j_username");

    	// 로그인 이력 적재
        Map<String, Object> param = new HashMap();
        param.put("user_id", username);        
        param.put("system", "admin");
		param.put("login_yn", "N");
        param.put("ip", request.getRemoteAddr());        
		
		try {
			userService.insertLoginHistory(param);	
		} catch(Exception e) {
			e.printStackTrace();
			logger.error("로그인 이력을 적재하는데 실패하였습니다.");
		}	
        
//        String homepage = "";
//        String url = request.getRequestURL().toString();
//        if (url.indexOf("admin") > -1)
//            homepage = "B";
//        else
//            homepage = "F";
//        
//        logger.debug(exception.getMessage());
//                
//        request.setAttribute("errorMessage", exception.getMessage());
//        
//        if (homepage.equals("B"))
//            request.getRequestDispatcher("/admin.do").forward(request, response);
//        else
//            request.getRequestDispatcher("/web/user/login.do").forward(request, response);
        

        request.setAttribute("errorMessage", exception.getMessage());
        request.getRequestDispatcher("/admin.do").forward(request, response);
    }
    
}
