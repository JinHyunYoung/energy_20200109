package kr.or.wabis.framework.web.support;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.or.wabis.framework.contants.CmsConstant;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.LocaleUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.user.vo.UserAuthVO;
import kr.or.wabis.user.vo.UserVO;

public class CustomArgumentResolver implements HandlerMethodArgumentResolver {
    
    public final static String KEY_REGUSERNO = "reg_userno";
    public final static String KEY_REGDATE = "reg_date";
    
    private static final Log logger = LogFactory.getLog(CustomArgumentResolver.class);
    
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        
        /*
         * if(Map.class.isAssignableFrom(parameter.getParameterType()) && parameter.hasParameterAnnotation(CommandMap.class)) { return true; }else
         */
        if (ExtHttpRequestParam.class.isAssignableFrom(parameter.getParameterType())) {
            return true;
        } else if (ListOp.class.isAssignableFrom(parameter.getParameterType())) {
            return true;
        } else {
            return false;
        }
    }
    
    public Object resolveArgument(MethodParameter methodparameter, ModelAndViewContainer mavContainer, NativeWebRequest nativewebrequest, WebDataBinderFactory binderFactory) throws Exception {
        
        Class<?> type = methodparameter.getParameterType();
        String paramName = methodparameter.getParameterName();
        HttpServletRequest hReq = (HttpServletRequest) nativewebrequest.getNativeRequest();
        
        if (type.equals(ExtHttpRequestParam.class)) {
            return bindExtParam(hReq);
        } else if (type.equals(ListOp.class)) {
            return bindListOp(hReq);
        } else if ((type.equals(Map.class)) && (paramName.equals("commandMap"))) {
            return bindCommMap(hReq);
        }
        
        return new Object();
    }
    
    /**
     * ListOp 자동 매핑 ListOp가 여러개일 경우 Controller에서 수동 처리
     * 
     * @param request
     * @return
     */
    public Object bindListOp(HttpServletRequest request) {
        ListOp listOp = new ListOp(request.getParameter("LISTOP"));
        request.setAttribute(ListOp.LIST_OP_NAME, listOp);
        return listOp;
    }
    
    /**
     * ExtHttpRequestParam Parameter 매핑
     * 
     * @param nativewebrequest
     * @return
     * @throws Exception
     */
    public Object bindExtParam(HttpServletRequest request) throws Exception {
        
        ExtHttpRequestParam eReq = new ExtHttpRequestParam();
        
        String cntType = request.getHeader("Content-Type");
        
        if (cntType != null && cntType.startsWith("application/json")) {
            
            logger.debug(" >> Start JSON Parse ");
            
            ServletInputStream fi = request.getInputStream();
            
            StringWriter writer = new StringWriter();
            
            IOUtils.copy(fi, writer, "UTF-8");
            String jsonStr = writer.toString();
            Map<String, Object> obj = (Map<String, Object>) JsonUtil.fromJsonStr(jsonStr);
            eReq.setParam(obj);
            
        } else {
            eReq = RequestParamParser.parse(request);
        }
        
        LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
        Locale locale = localeResolver.resolveLocale(request);
        eReq.setLocale(locale);
        
        // db에서는 SIMPLE 로케일만 사용
        eReq.put("LOCALE", LocaleUtil.getSimpleLocale(locale));
        
        HttpSession session = request.getSession();
        Object tObj = session.getAttribute("SESSION_USER");
        
        // 멀티권한 가져오기
        List<String> inStr = null;
        String math_id_list = "";
        
        List<UserAuthVO> userAuth = (List<UserAuthVO>) session.getAttribute(CmsConstant.SESSION_USER_AUTH);
        
        if (userAuth != null) {
            
            int listSize = 0;
            listSize = userAuth.size();
            inStr = new ArrayList<String>();
            
            for (int i = 0; i < listSize; i += 1) {
                
                UserAuthVO authInfo = userAuth.get(i);
                inStr.add(authInfo.getAuth() + "");
                
                if (math_id_list.equals("")) {
                    math_id_list = authInfo.getAuth() + "";
                } else {
                    math_id_list = math_id_list + "," + authInfo.getAuth() + "";
                }
                
            }
        }
        
        if (tObj instanceof UserVO) {
            
            UserVO userVO = (UserVO) tObj;
            
            eReq.setSessionUser(userVO);
            eReq.put(KEY_REGUSERNO, userVO.getUserNo());
            
            eReq.put("s_user_no", userVO.getUserNo());
            eReq.put("s_user_id", userVO.getUserId());
            eReq.put("s_user_name", userVO.getUserName());
            eReq.put("s_user_email", userVO.getUserEmail());
            eReq.put("s_user_mobile", userVO.getUserMobile());
            eReq.put("s_auth_id", StringUtil.nvl(session.getAttribute("s_auth_id")));
            eReq.put("s_userip", request.getRemoteAddr());
            
        } else {
            eReq.setSessionUser(null);
            
            if(request.getSession() != null && request.getSession().getAttribute("JSESSIONID") != null){
            	eReq.put(KEY_REGUSERNO, request.getSession().getAttribute("JSESSIONID").toString());
            }
        }
        eReq.put(KEY_REGDATE, DateUtil.getCurrentDateTime());
        
        return eReq;
    }
    
    public Object bindCommMap(HttpServletRequest request) throws Exception {
        
        Map<String, Object> commandMap = new HashMap<String, Object>();
        Enumeration<?> enumeration = request.getParameterNames();
        
        while (enumeration.hasMoreElements()) {
            String key = (String) enumeration.nextElement();
            String[] values = request.getParameterValues(key);
            if (values != null) {
                commandMap.put(key, (values.length > 1) ? values : values[0]);
            }
        }
        
        return commandMap;
    }
    
}
