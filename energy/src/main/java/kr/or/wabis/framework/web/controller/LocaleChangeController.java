package kr.or.wabis.framework.web.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.wabis.framework.util.LocaleUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.SessionUtil;

/**
 * <PRE>
 * LocaleChangeController
 * </PRE>
 *
 * @author Jangsoo Kim
 * @version 1.0
 * @since 04/08/2016
 */
@Controller("localeChangeController ")
public class LocaleChangeController {
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    @RequestMapping("/locale/changeLanguage.do")
    @ResponseBody
    public String changeLanguage(ModelMap model) {
        
        String language = LocaleUtil.getLanguage();
        log.debug("### changed language : {}", language);
        
        SessionUtil.setAttribute("lngaCd", language);
        SessionUtil.setAttribute("language", language);
        
        return "";
    }
    
    @RequestMapping(value = "/locale/searchMessageByLanguage.do")
    @ResponseBody
    public Map<String, String> searchMessageByLanguage(ModelMap model) throws Exception {
        
        String language = LocaleUtil.getLanguage();
        
        SessionUtil.setAttribute("lngaCd", language);
        SessionUtil.setAttribute("language", language);
        
        return MessageUtil.searchMessageByLanguage();
    }
    
}
