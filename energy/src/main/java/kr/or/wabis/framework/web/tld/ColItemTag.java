package kr.or.wabis.framework.web.tld;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import kr.or.wabis.framework.util.LocaleUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.ObjectUtil;

public class ColItemTag extends HtmlTagSupport {
    
    private final static long serialVersionUID = 1L;
    
    private String code;    
    private String text;
    
    /**
     * 
     */
    public int doStartTag() throws JspException {
        
        String msg = null;
        if (this.text == null) {
            try {
                msg = MessageUtil.getMessage("LABEL." + code, LocaleUtil.getSafeLocale((HttpServletRequest) this.pageContext.getRequest()));
            } catch (Exception e) {
                msg = text;
            }
        } else {
            msg = text;
        }
        
        Object obj = getParent();
        if (obj instanceof ColNamesTag) {
            ((ColNamesTag) obj).addItem(ObjectUtil.nvl(msg, "#" + this.code));
        }
        
        return SKIP_BODY;
    }
    
    public void release() {
        super.release();
        this.code = null;
        this.text = null;
    }
    
    public void setDesc(String dummy) {        
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public void setText(String text) {
        this.text = text;
    }
}
