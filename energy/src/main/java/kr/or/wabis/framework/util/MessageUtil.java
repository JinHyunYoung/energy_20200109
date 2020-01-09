package kr.or.wabis.framework.util;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceResolvable;
import org.springframework.context.support.MessageSourceAccessor;

import kr.or.wabis.framework.message.DatabaseMessageSource;
import kr.or.wabis.framework.message.PropertyResourceBundleMessageSource;

public class MessageUtil {
    
    private final static Logger logger = LoggerFactory.getLogger(MessageUtil.class);
    
    private static MessageSourceAccessor messageSourceAccessor;
    
    public void setMessageSourceAccessor(MessageSourceAccessor messageSourceAccessor) {
        MessageUtil.messageSourceAccessor = messageSourceAccessor;
    }
    
    public static void reload() {
        Object source = SpringUtil.getBean("messageSource");
        
        if (source instanceof PropertyResourceBundleMessageSource) {
            PropertyResourceBundleMessageSource messageSource = (PropertyResourceBundleMessageSource) source;
            messageSource.clearCache();
            
        } else if (source instanceof DatabaseMessageSource) {
            DatabaseMessageSource messageSource = (DatabaseMessageSource) source;
            messageSource.reload();
        }
    }
    
    /**
     * searchMessageByLanguage != 특정언어에 해당하는 메시지만 리턴 =!
     * 
     * @return
     */
    public static Map<String, String> searchMessageByLanguage() {
        Object source = SpringUtil.getBean("messageSource");
        
        if (source instanceof PropertyResourceBundleMessageSource) {
            PropertyResourceBundleMessageSource messageSource = (PropertyResourceBundleMessageSource) source;
            Map<String, String> map = new HashMap(messageSource.searchMessageByLanguage());
            return map;
        } else if (source instanceof DatabaseMessageSource) {
            DatabaseMessageSource messageSource = (DatabaseMessageSource) source;
            return messageSource.searchMessageByLanguage();
        } else {
            return null;
        }
    }
    
    /**
     * getMessage by messageId
     * 
     * @param key
     * @return
     */
    public static String getMessage(String key) {
        return messageSourceAccessor.getMessage(key, "", LocaleUtil.getLocale());
    }
    
    /**
     * getMessage by messageId
     * 
     * @param key
     * @return
     */
    public static String getMessage(String key, Locale locale) {
        return messageSourceAccessor.getMessage(key, "", locale);
    }
    
    /**
     * getMessage by messageId
     * 
     * @param key
     * @return
     */
    public static String getMessage(String key, Object[] param) {
        return messageSourceAccessor.getMessage(key, param, LocaleUtil.getLocale());
    }
    
    /**
     * getMessage by messageId
     * 
     * @param key
     * @return
     */
    public static String getMessage(String key, Object[] param, Locale locale) {
        return messageSourceAccessor.getMessage(key, param, locale);
    }
    
    /**
     * <pre>
     * Replace Message.
     * != 오류검증 Message에서 {} 행태로 된 String을 화면에서 보여줄 메시지로 치환 =!
     * 
     * ex) replaceMessage("field '{0}' not exist.", "Name"); --> field 'Name' not exist.
     * </pre>
     * 
     * @param String
     *            , String
     * @return String
     */
    public static String replaceMessage(String template, String... spnMsgs) {
        String ret = template;
        int replaceCharCount = StringUtil.countMatches(template, "}");
        for (int i = 0; i < replaceCharCount; i++) {
            if (spnMsgs != null && spnMsgs.length > 0) {
                if (i < spnMsgs.length) {
                    String srcBlace = "{" + i + "}";
                    ret = StringUtils.replace(ret, srcBlace, spnMsgs[i]);
                }
            }
        }
        return ret;
    }
    
    public static String getMessage(MessageSourceResolvable resolvable, Locale locale) {
        try {
            return messageSourceAccessor.getMessage(resolvable, locale);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return "";
        }
        
    }
    
    /**
     * 해당 id의 메시지를 locale 처리하여 돌려 준다.
     * 
     * @param id
     * @param obj
     * @param _req
     * @return
     */
    public static String getMessage(String id, Object obj, Locale locale) {
        return messageSourceAccessor.getMessage(id, new Object[] { obj }, locale);
    }
    
    /**
     * Updated 메시지를 locale 처리하여 돌려 준다.
     * 
     * @param cnt
     * @param _req
     * @return
     */
    public static String getUpdatedMsg(int cnt, ExtHttpRequestParam _req) {
        return getMessage("msg.updated", ObjectUtil.toArray(cnt), _req.getLocale());
    }
    
    /**
     * insert 메시지를 locale 처리하여 돌려 준다.
     * 
     * @param cnt
     * @param _req
     * @return
     */
    public static String getInsertMsg(int cnt, ExtHttpRequestParam _req) {
        return getMessage("msg.inserted", ObjectUtil.toArray(cnt), _req.getLocale());
    }
    
    /**
     * deleted 메시지를 locale 처리하여 돌려 준다.
     * 
     * @param cnt
     * @param _req
     * @return
     */
    public static String getDeteleMsg(int cnt, ExtHttpRequestParam _req) {
        return getMessage("msg.deleted", ObjectUtil.toArray(cnt), _req.getLocale());
    }
    
    public static String getDeteleNotCountMsg(int cnt, ExtHttpRequestParam _req) {
        return getMessage("msg.deleted.not.count", _req.getLocale());
    }
    
    /**
     * 저장되었습니다 메시지를 locale 처리하여 돌려 준다.
     * 
     * @param cnt
     * @param _req
     * @return
     */
    public static String getSavedMsg(int cnt, ExtHttpRequestParam _req) {
        return getMessage("msg.saved", ObjectUtil.toArray(cnt), _req.getLocale());
    }
    
    /**
     * 해당 id의 메시지를 locale 처리하여 돌려 준다.
     * 
     * @param id
     * @param _req
     * @return
     */
    public static String getMessage(String id, ExtHttpRequestParam _req) {
        return getMessage(id, null, _req.getLocale());
    }
    
    /**
     * 해당 id의 메시지를 locale 처리하여 돌려 준다.
     * 
     * @param id
     * @param obj
     * @param _req
     * @return
     */
    public static String getMessage(String id, Object obj, ExtHttpRequestParam _req) {
        return getMessage(id, obj, _req.getLocale());
    }
    
    /**
     * 
     * @param cnt
     * @param _req
     * @return
     */
    public static String getProcessFaildMsg(int cnt, ExtHttpRequestParam _req) {
        return getMessage("msg.processfail", ObjectUtil.toArray(cnt), _req.getLocale());
    }
    
    /**
     * 중목메시지 출력
     * 
     * @param _req
     * @param obj
     * @return
     */
    public static String getDuplicatedMsg(Object obj, ExtHttpRequestParam _req) {
        return getMessage("msg.obj.duplicate", obj, _req.getLocale());
    }
    
    /**
     * 성공메시지
     * 
     * @param obj
     * @param _req
     * @return
     */
    public static String getProcessSuccessMsg(Object obj, ExtHttpRequestParam _req) {
        return getMessage("msg.process.success", obj, _req.getLocale());
    }
    
    /**
     * 성공메시지
     * 
     * @param obj
     * @param _req
     * @return
     */
    public static String getUpdateedNotFoundMsg(Object obj, ExtHttpRequestParam _req) {
        return getMessage("msg.updated.not.found", obj, _req.getLocale());
    }
    
    /**
     * 성공메시지
     * 
     * @param obj
     * @param _req
     * @return
     */
    public static String getiIsertedNotFoundMsg(Object obj, ExtHttpRequestParam _req) {
        return getMessage("msg.inserted.not.found", obj, _req.getLocale());
    }
    
    /**
     * 성공메시지
     * 
     * @param obj
     * @param _req
     * @return
     */
    public static String getDeletedNotFoundMsg(Object obj, ExtHttpRequestParam _req) {
        return getMessage("msg.deleted.not.found", obj, _req.getLocale());
    }
    
}
