package kr.or.wabis.framework.util;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import kr.or.wabis.admin.integration.service.CodeMtService;

public final class CommonUtil {
    
    public CommonUtil() {
    }
    
    /**
     * UUID 값을 생성하는 함수
     * 
     * @return String : uuid 값
     */
    public final static String createUUID() {
        String uuid = UUID.randomUUID().toString();
        uuid = uuid.replaceAll("-", "");
        return uuid;
    }
    
    /**
     * 기본 로케일을 리턴한다. 기본은 한글이다.
     * 
     * @return Locale
     */
    public final static Locale getDefaultLocale() {
        return Locale.KOREAN;
    }
    
    /**
     * HttpServletRequest 를 받아서 저장되어 있를 locale 값을 리턴한다. 없는 경우는 기본 로케일을 리턴한다.
     * 
     * @return Locale
     */
    public final static Locale getLocale(HttpServletRequest request) {
        Locale locale = null;
        HttpSession session = request.getSession();
        locale = (Locale) session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
        
        if (locale == null) {
            locale = getDefaultLocale();
        }
        return locale;
    }
    
    /**
     * 공통 코드 리스트를 반환해 준다.
     * 
     * @param codeg
     * @return
     */
    public static List<Map<String, Object>> getCodeList(String gubun) {
        
        List<Map<String, Object>> codeList = null;
                
        try {
            
            CodeMtService codeMtService = (CodeMtService) ObjectUtil.getBean("codeMtService");
            codeList = codeMtService.selectCodeGubunCodeList(gubun);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return codeList;
    }
    
    /**
     * 
     * @return
     */
    public static String getHostIp() {
        String hostAddr = "";
        try {
            Enumeration<NetworkInterface> nienum = NetworkInterface.getNetworkInterfaces();
            while (nienum.hasMoreElements()) {
                NetworkInterface ni = nienum.nextElement();
                Enumeration<InetAddress> kk = ni.getInetAddresses();
                while (kk.hasMoreElements()) {
                    InetAddress inetAddress = kk.nextElement();
                    if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress() && inetAddress.isSiteLocalAddress()) {
                        hostAddr = inetAddress.getHostAddress().toString();
                    }
                }
            }
        } catch (SocketException e) {
            e.printStackTrace();
        }
        
        return hostAddr;
    }
}
