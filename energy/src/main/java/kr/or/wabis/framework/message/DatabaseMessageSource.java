package kr.or.wabis.framework.message;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.context.support.AbstractMessageSource;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.ResourceLoader;

import kr.or.wabis.framework.dao.CommonDao;
import kr.or.wabis.framework.util.LocaleUtil;

public class DatabaseMessageSource extends AbstractMessageSource implements ResourceLoaderAware {
    
    private Logger log = LoggerFactory.getLogger(getClass());
    
    private ResourceLoader resourceLoader;
    
    @Resource(name = "commonDao")
    private CommonDao commonDao;
    
    private final Map<String, Map<String, String>> properties = new HashMap<String, Map<String, String>>();
    
    public void setResourceLoader(ResourceLoader resourceLoader) {
        this.resourceLoader = (resourceLoader != null ? resourceLoader : new DefaultResourceLoader());
    }
    
    public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
    
    public DatabaseMessageSource() {
        reload();
    }
    
    @Override
    protected MessageFormat resolveCode(String code, Locale locale) {
        String msg = getText(code, locale);
        MessageFormat result = createMessageFormat(msg, locale);
        return result;
    }
    
    @Override
    protected String resolveCodeWithoutArguments(String code, Locale locale) {
        return getText(code, locale);
    }
    
    private String getText(String code, Locale locale) {
        
        Map<String, String> langMap = properties.get(code);
        String textForCurrentLanguage = null;
        
        if (langMap != null) {
            textForCurrentLanguage = langMap.get(locale.getLanguage());
            if (textForCurrentLanguage == null) {
                textForCurrentLanguage = langMap.get(Locale.getDefault().getLanguage());
            }
        }
        
        if (textForCurrentLanguage == null) {
            log.error("{} --> no exists from database. Fallback to properties message", code);
            try {
                textForCurrentLanguage = getParentMessageSource().getMessage(code, null, locale);
            } catch (Exception e) {
                log.error("Cannot find message with code:{} ", code);
            }
        }
        
        return textForCurrentLanguage != null ? textForCurrentLanguage : code;
    }
    
    public void reload() {
        properties.clear();
        properties.putAll(loadAllMessages());
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    protected Map<String, Map<String, String>> loadAllMessages() {
        log.debug("loadAllMessages start.");
        
        Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
        List<MessageVo> list = null;
        
        try {
            list = commonDao.selectList("");
        } catch (Exception e) {
            log.error("fail to load message from database.");
            e.printStackTrace();
        }
        for (MessageVo vo : list) {
            String key = vo.getKey();
            String language = vo.getLanguage();
            String msg = vo.getMessgae();
            
            Map<String, String> langMap = map.get(key);
            if (langMap == null) {
                langMap = new HashMap();
            }
            langMap.put(language, msg);
            
            map.put(key, langMap);
        }
        
        log.debug("total message count:{}", list.size());
        log.debug("loadAllMessages end.");
        
        return map;
    }
    
    public Map<String, Map<String, String>> searchAllMessages() {
        return properties;
    }
    
    public Map<String, String> searchMessageByLanguage() {
        return properties.get(LocaleUtil.getLanguage());
    }
    
}
