package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.jsp.JspException;

import kr.or.wabis.framework.util.CodeUtil;
import kr.or.wabis.framework.util.StringUtil;

public class UserFunctionCode extends ExtendedTagSupport {
    
    @Override
    public void doTag() throws JspException, IOException {
        getJspContext().getOut().print("Tag Library " + this.getClass().getSimpleName());
    }
    
    /**
     * Get CodeName by code id.
     * 
     * @param cdId
     * @param cdNameValue
     * @param cdIdValue
     * @return
     */
    public static String codeName(String cdId, String cdNameValue, String cdIdValue) {
        
        String ret = "";
        
        if (StringUtil.isNotEmpty(cdNameValue)) {
            ret = cdNameValue;
        } else {
            try {
                ret = CodeUtil.getCodeItemNm(cdId, cdIdValue);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        return ret;
    }
}
