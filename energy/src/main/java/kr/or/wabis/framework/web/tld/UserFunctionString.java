package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.jsp.JspException;

import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;

public class UserFunctionString extends ExtendedTagSupport {
    
    public void doTag() throws JspException, IOException {
        getJspContext().getOut().print("Tag Library " + this.getClass().getSimpleName());
    }
    
    public static String label(String labelId) {
        return MessageUtil.getMessage(labelId);
    }
    
    /**
     * NVL
     * 
     * @param dateStr
     * @param toFormatStr
     * @param fromFormatStr
     * @return
     */
    public static String defaultString(String dataStr, String defaultStr) {
        
        if (dataStr == null || "".equals(dataStr)) {
            return defaultStr;
        }
        return dataStr;
    }
    
    public static String toHtml(String text) {
        
        if (text == null || "".equals(text)) {
            return "";
        }
        
        text = text.replaceAll(" ", "&nbsp;");
        text = text.replaceAll("\n", "<br />");
        text = text.replaceAll("\"", "&quot;");
        return text;
    }
    
    /**
     * \n, \r replace to {@code <br/>
     * } != \n, \r 을 {@code <br/>
     * } 로 변경 =!
     * 
     * @param value
     * @return
     */
    public static String replaceEnter(String value) {
        if (StringUtil.isEmpty(value)) {
            return value;
        }
        return value.replaceAll("\n", "<br/>").replaceAll("\r", "<br/>");
    }
    
    /**
     * 
     * != 긴 문자열을 줄여서 ... 을 붙인다. =!
     * 
     * @param value
     * @param endIndex
     * @return
     */
    public static String reduceString(String value, Integer endIndex) {
        if (StringUtil.isEmpty(value)) {
            return value;
        }
        int valueLength = value.length();
        if (valueLength <= endIndex) {
            return value;
        }
        
        return value.substring(0, endIndex) + "...";
    }
}
