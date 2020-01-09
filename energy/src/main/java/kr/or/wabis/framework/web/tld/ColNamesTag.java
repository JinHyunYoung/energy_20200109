package kr.or.wabis.framework.web.tld;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.or.wabis.framework.util.JsonUtil;

public class ColNamesTag extends HtmlTagSupport {
    
    private final static long serialVersionUID = 1L;
        
    private List<String> jarr = null;
    
    private String name;
    
    public ColNamesTag() {
        super();        
        jarr = new ArrayList<String>();
    }
    
    /**
     * 
     */
    public int doStartTag() throws JspException {        
        return EVAL_BODY_INCLUDE;
    }
    
    /**
     * 
     */
    public int doEndTag() throws JspException {
        StringBuffer sb = new StringBuffer();
        sb.append("<script type=\"text/javascript\">\n");
        sb.append(" var " + name + " = ");
        sb.append(JsonUtil.toJsonStr(jarr));
        sb.append(";\n");
        sb.append("</script>\n");
        
        try {            
            this.pageContext.getOut().write(sb.toString());
        } catch (Exception e) {
            throw new JspException("Could not write data " + e.toString());
        }
        
        release();
        return EVAL_PAGE;
    }
    
    public void release() {
        super.release();
        jarr = new ArrayList<String>();
    }
    
    public void setDesc(String dummy) {        
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void addItem(String json) {
        jarr.add(json);
    }
}
