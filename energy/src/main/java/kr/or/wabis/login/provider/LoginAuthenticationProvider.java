package kr.or.wabis.login.provider;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import kr.or.wabis.dao.user.UserDao;
import kr.or.wabis.framework.contants.CmsConstant;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.login.vo.Role;
import kr.or.wabis.user.vo.UserVO;

@Component
public class LoginAuthenticationProvider implements AuthenticationProvider {
    
    private final Logger logger = LoggerFactory.getLogger(LoginAuthenticationProvider.class);
    
    @Autowired
    private UserDao userDao;
    
    @Override
    public final Authentication authenticate(final Authentication authentication) throws AuthenticationException {
        
        String userId = authentication.getName();
        String userPassword = CryptoUtil.SHA_encrypt((String) authentication.getCredentials());
        
        logger.debug("######" + userId);
        logger.debug("######" + userPassword);
        
        UserVO userVo = null;
        
        Collection<? extends GrantedAuthority> authorities;
        
        try {

            userVo = userDao.selectUserLogin(userId);      
            
            if (userVo == null) {
                throw new UsernameNotFoundException("접속자 정보를 찾을 수 없습니다.");
            }

            logger.debug("### " + userVo.toString());
            logger.debug("### " + userId + "|" + userVo.getUserId());
            logger.debug("### " + userPassword + "|" + userVo.getUserPw());
            
            if(userVo.getErrCnt() > 4) {
            	String lastErrDt = userVo.getLastErrDt();

            	SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMddHHmm");
            	Date lastErrDate = transFormat.parse(lastErrDt);
            	
            	Date today = new Date();
            	
            	long diff = today.getTime() - lastErrDate.getTime();
        		long min = diff / 60000;
        		
        		if(min > 30) {
            		userDao.initErrorLoginCount(userId);
            	}
        		else {
        			throw new BadCredentialsException("연속으로 5회 이상 비밀번호가 틀렸습니다. 30분 후에 다시 시도하십시오.");
	        	}
            }
            
            if (!userPassword.equals(userVo.getUserPw())) {
            	// set ErrCnt to DATABASE
            	userDao.updateErrorLoginCount(userId);
                throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
            }
            
            if(userVo.getErrCnt() != 0) {
            	// set ErrCnt to 0
            	userDao.initErrorLoginCount(userId);
            }
                
            Role role = new Role();
            
            // 관리자 일 경우
            if( StringUtil.isNotEmpty(userVo.getUserGb()) || CmsConstant.ROLE_ADMIN.equals(userVo.getUserGb()) ){
                role.setName("ROLE_ADMIN");                
            } 
            
            // 일반 사용자 일 경우
            else {
                role.setName("ROLE_USER");         
            }
            
            List<Role> roles = new ArrayList<Role>();
            roles.add(role);
            
            userVo.setAuthorities(roles);
            
            authorities = userVo.getAuthorities();
            
        } catch (UsernameNotFoundException e) {
            logger.info(e.toString());
            throw new UsernameNotFoundException(e.getMessage());
        } catch (BadCredentialsException e) {
            logger.info(e.toString());
            throw new BadCredentialsException(e.getMessage());
        } catch (Exception e) {
            logger.info(e.toString());
            throw new RuntimeException(e.getMessage());
        }
        
        return new UsernamePasswordAuthenticationToken(userVo, userPassword, authorities);
    }
    
    
    @Override
    public final boolean supports(final Class<?> authentication) {
        return true;
    }
}
