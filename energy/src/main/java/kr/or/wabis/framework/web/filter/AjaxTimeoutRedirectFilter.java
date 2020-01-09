package kr.or.wabis.framework.web.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.util.ThrowableAnalyzer;
import org.springframework.security.web.util.ThrowableCauseExtractor;
import org.springframework.web.filter.GenericFilterBean;

public class AjaxTimeoutRedirectFilter extends GenericFilterBean {
    
    private static final Logger logger = LoggerFactory.getLogger(AjaxTimeoutRedirectFilter.class);
    
    private ThrowableAnalyzer throwableAnalyzer = new DefaultThrowableAnalyzer();
    private AuthenticationTrustResolver authenticationTrustResolver = new AuthenticationTrustResolverImpl();
    
    private int customSessionExpiredErrorCode = 901;
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        
        try {
            chain.doFilter(request, response);
        } catch (IOException ex) {
            throw ex;
        } catch (Exception ex) {
            
            logger.error("Session TimeOut  Or Access Is Denied");
            Throwable[] causeChain = throwableAnalyzer.determineCauseChain(ex);
            RuntimeException ase = (AuthenticationException) throwableAnalyzer.getFirstThrowableOfType(AuthenticationException.class, causeChain);
            
            if (ase == null) {
                ase = (AccessDeniedException) throwableAnalyzer.getFirstThrowableOfType(AccessDeniedException.class, causeChain);
            }
            
            if (ase != null) {
                if (ase instanceof AuthenticationException) {
                    throw ase;
                } else if (ase instanceof AccessDeniedException) {
                    
                    if (authenticationTrustResolver.isAnonymous(SecurityContextHolder.getContext().getAuthentication())) {
                       
                        String ajaxHeader = ((HttpServletRequest) request).getHeader("X-Requested-With");
                        
                        if ("XMLHttpRequest".equals(ajaxHeader)) {
                            HttpServletResponse resp = (HttpServletResponse) response;
                            resp.sendError(this.customSessionExpiredErrorCode);
                        } else {
                            throw ase;
                        }
                        
                    } else {
                        throw ase;
                    }
                }
            }
            
        }
    }
    
    public int getCustomSessionExpiredErrorCode() {
        return customSessionExpiredErrorCode;
    }
    
    public void setCustomSessionExpiredErrorCode(int customSessionExpiredErrorCode) {
        this.customSessionExpiredErrorCode = customSessionExpiredErrorCode;
    }
    
    private static final class DefaultThrowableAnalyzer extends ThrowableAnalyzer {
        
        protected void initExtractorMap() {
            
            super.initExtractorMap();
            
            registerExtractor(ServletException.class, new ThrowableCauseExtractor() {
                
                @Override
                public Throwable extractCause(Throwable throwable) {
                    ThrowableAnalyzer.verifyThrowableHierarchy(throwable, ServletException.class);
                    return ((ServletException) throwable).getRootCause();
                }
            });
        }
        
    }
    
}
