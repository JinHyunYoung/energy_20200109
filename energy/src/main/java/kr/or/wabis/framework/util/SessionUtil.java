package kr.or.wabis.framework.util;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;

import kr.or.wabis.framework.web.vo.DefaultVo;
import kr.or.wabis.framework.web.vo.SessionUserVo;

/**
 * Spring에서 제공하는 RequestContextHolder 를 이용하여 request 객체를 service까지 전달하지 않고 사용할 수 있게 해줌
 *
 */
public final class SessionUtil {
    
    private static Logger log = LoggerFactory.getLogger(SessionUtil.class);
    
    private final static String USER_VO = "userVo";
    
    private final static String SEARCH_CONDITION = "SEARCH_CONDITION";
    
    public static HttpSession getSession() {
        return getSession(true);
    }
    
    public static HttpSession getSession(boolean forceCreate) {
        return SpringUtil.getServletRequest().getSession(forceCreate);
    }
    
    public static Object getAttribute(String name) {
        Object value = null;
        HttpSession session = getSession();
        if (session != null) {
            value = session.getAttribute(name);
        }
        
        return value;
    }
    
    public static String getString(String name) {
        return getString(name, "");
    }
    
    public static String getString(String name, String defaultValue) {
        String str = (String) getAttribute(name);
        return str == null ? defaultValue : str;
    }
    
    public static void setAttribute(String name, Object value) {
        getSession().setAttribute(name, value);
    }
    
    public static void removeAttribute(String name) {
        getSession().removeAttribute(name);
    }
    
    public static SessionUserVo getUserVo() {
        HttpSession session = getSession();
        
        SessionUserVo vo = null;
        
        if (session != null) {
            vo = (SessionUserVo) session.getAttribute(USER_VO);
        }
        
        return vo;
    }
    
    public static void setUserVo(SessionUserVo vo) {
        HttpSession session = getSession();
        session.setAttribute(USER_VO, vo);
    }
    
    public static boolean isLogin() {
        return getUserVo() != null;
    }
    
    public static boolean isNotLogin() {
        return !isLogin();
    }
    
    public static void invalidate() {
        HttpSession session = getSession();
        
        if (session != null) {
            session.removeAttribute(USER_VO);
        }
    }
    
    public static void copySessionToVo(Object vo) {
        SessionUserVo userVo = getUserVo();
        
        if (userVo == null) {
            return;
        }
        
        DefaultVo defaultVo = (DefaultVo) vo;
        
        defaultVo.setFrstRegstId(userVo.getUserId());
        defaultVo.setLastChprId(userVo.getUserId());
        defaultVo.setFrstRegstNm(userVo.getUserNm());
        defaultVo.setLastChprNm(userVo.getUserNm());
        defaultVo.setLngaCd(LocaleUtil.getLanguage());
    }
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static <T> T getSearchCondition(T vo) throws Exception {
        
        DefaultVo defVo = (DefaultVo) vo;
        
//        boolean isPopup = Tiles.isPopup();
//        if (isPopup) {
//            defVo.setNewQryYn("Y");
//        }
        
        // newly Retrieve Yn != 검색조건이 있는 화면에서 신규조회여부 =!
        log.debug("### newQryYn : {}", defVo.getNewQryYn()); 
        if (!"Y".equals(defVo.getNewQryYn())) {
            
            Object sessionObj = SessionUtil.getAttribute(SEARCH_CONDITION);
            log.debug("### Session's search vo : {}", sessionObj);
            
            Class cls = vo.getClass();
            if (sessionObj != null && sessionObj.getClass().isAssignableFrom(cls)) { 
                
                log.debug("### Search vo '{}' replace with Session's", cls);
                DefaultVo savedVo = (DefaultVo) sessionObj;
                savedVo.setLngaCd(defVo.getLngaCd()); 
                
                return (T) sessionObj;
            }
        }
        
//        if (!isPopup) {
//            SessionUtil.setAttribute(SEARCH_CONDITION, vo);
//            log.debug("### Search vo '{}' set in session", vo.getClass());
//        }
        
        return vo;
    }
    
    /**
     * session id.
     * 
     * @return String
     * @throws Exception
     */
    public static String getSessionId() {
        return RequestContextHolder.getRequestAttributes().getSessionId();
    }
}
