package kr.or.wabis.login.handler;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import kr.or.wabis.framework.util.CommonUtil;

import kr.or.wabis.admin.stats.service.StatsMtService;
import kr.or.wabis.dao.user.UserDao;
import kr.or.wabis.framework.contants.CmsConstant;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.login.vo.Role;
import kr.or.wabis.user.service.UserService;
import kr.or.wabis.user.vo.UserAuthVO;
import kr.or.wabis.user.vo.UserVO;

@Service
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Autowired
    private UserDao userDao;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private StatsMtService statsMtService;
  
    public final void onAuthenticationSuccess(
        final HttpServletRequest request, 
        final HttpServletResponse response, 
        final Authentication authentication) throws ServletException, IOException {
       
        String homepage = "F";
        String url = request.getRequestURL().toString();
        
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

        // 권한  정보 획득    
        if(authorities != null ){
            
            List<Role> roles = (List<Role>) authentication.getAuthorities();
            Role role = roles.get(0);
            if("ROLE_ADMIN".equals(role.getName())){
                homepage = "B";
            } 
        }
        
        String userId = authentication.getName();
        
        HttpSession session = request.getSession();
        
        logger.debug("## : " + session.getId());
        
        UserVO userVo = null;
        try {            
            userVo = userService.selectUserId(userId);            
        } catch (Exception e) {
            logger.error("사용자 정보를 찾을 수 없습니다.");
        }
                
        List<UserAuthVO> userAuthMath = null;
        
        logger.debug(userVo.toString());
        
        session.setAttribute(CmsConstant.SESSION_USER, userVo);
        session.setAttribute(CmsConstant.SESSION_USER_AUTH, userAuthMath);
        session.setAttribute("s_homepage", homepage);
        session.setAttribute("s_user_no", userVo.getUserNo());
        session.setAttribute("s_user_id", userVo.getUserId());
        session.setAttribute("s_user_name", userVo.getUserName());        
        session.setAttribute("s_auth", StringUtil.nvl(userVo.getAuth()));
        session.setAttribute("s_authNm", StringUtil.nvl(userVo.getAuthNm()));        
        session.setAttribute("s_auth_id", StringUtil.split(StringUtil.nvl(userVo.getAuth()), ",")[0]);
        session.setAttribute("s_todayconn_cnt", userVo.getTodayconnCnt());
        session.setAttribute("s_pwdChgYn", StringUtil.nvl(userVo.getPwdChgYn()));
        session.setAttribute("s_user_age", userVo.getAge());
        session.setAttribute("s_user_gb", userVo.getUserGb());
        
        
        System.out.println("로그인성공");
        
        try {
            session.setAttribute("s_user_email", CryptoUtil.AES_Decode(userVo.getUserEmail()));
            session.setAttribute("s_user_mobile", CryptoUtil.AES_Decode(userVo.getUserMobile()));
        } catch (Exception e) {
        }
        
        Map<String, Object> param = new HashMap();
        param.put("s_user_no", userVo.getUserNo());
        param.put("homepage", homepage);
        param.put("ip", request.getRemoteAddr());
        
        try {
            statsMtService.insertHomepageconn(param);
        } catch (Exception e) {
            logger.error("사용자 접속정보를 등록하는데 실패하였습니다.");
        }
        
        // 로그인 이력 적재
        param.put("user_id", userVo.getUserId());
        param.put("system", "admin");
		param.put("login_yn", "Y");
		
		try {
			userService.insertLoginHistory(param);	
		} catch(Exception e) {
			logger.error("로그인 이력을 적재하는데 실패하였습니다.");
		}		
        
        if (homepage.equals("F")) {
            
            if ("Y".equals(StringUtil.nvl(userVo.getPwdChgYn()))) {
                response.sendRedirect("/web/user/pwdChangePage.do");
            } 
            
            else {
                response.sendRedirect("/web/user/main.do");
            }
            
        } else {
            response.sendRedirect("/admin/user/main.do");
        }
    }
}
