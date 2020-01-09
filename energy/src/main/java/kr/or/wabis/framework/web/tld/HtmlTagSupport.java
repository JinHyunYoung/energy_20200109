package kr.or.wabis.framework.web.tld;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.DynamicAttributes;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.taglibs.standard.tag.common.core.OutSupport;
import org.springframework.web.util.HtmlUtils;

public class HtmlTagSupport extends OutSupport implements DynamicAttributes {
    
    private static final long serialVersionUID = 1L;
    
    protected Map<String, Object> tagAttributes = new HashMap<String, Object>();
    
    public String id = null;
    public String name = null;
    public String onChange = null;
    public String style = null;
    public boolean disabled = false;
    
    public HtmlTagSupport() {
        init();
    }
    
    private void init() {
        id = null;
        name = null;
        onChange = null;
        style = null;
        disabled = false;
        tagAttributes.clear();
    }
    
    public void release() {
        super.release();
        this.init();
    }
    
    /**
     * 
     * @param tagName
     * @throws JspException
     */
    protected void startHtmlTag(String tagName) throws JspException {
        
        StringBuffer sb = new StringBuffer();
        sb.append("<");
        sb.append(tagName);
        
        if (this.name != null) {
            sb.append(" name=\"");
            sb.append(this.name);
            sb.append("\"");
        }
        
        if (this.id != null) {
            sb.append(" id=\"");
            sb.append(this.id);
            sb.append("\"");
        }
        
        if (this.style != null) {
            sb.append(" style=\"");
            sb.append(this.style);
            sb.append("\"");
        }
        
        if (this.disabled){
            sb.append(" disabled='disabled' ");
        }
        
        if (this.onChange != null) {
            sb.append(" onChange=\"");
            sb.append(this.onChange);
            sb.append("\"");
        }
        
        for (String attrName : tagAttributes.keySet()) {
            sb.append(" ");
            sb.append(attrName);
            sb.append("=\"");
            sb.append(tagAttributes.get(attrName));
            sb.append("\"");
        }
        
        try {
            pageContext.getOut().write(sb.toString());
        } catch (Exception e) {
            throw new JspException("Could not write data " + e.toString());
        }
        
    }
    
    /**
     * Html Escape 처리
     * 
     * @param msg
     * @return
     */
    protected String htmlEscape(String msg) {
        return HtmlUtils.htmlEscape(msg);
    }
    
    public void setDynamicAttribute(String uri, String localName, Object value) throws JspException {
        tagAttributes.put(localName, value);
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public void setOnChange(String onChange) {
        this.onChange = onChange;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }
    
    public void setStyle(String style) {
        this.style = style;
    }
    
    public boolean getDisabled() {
        return this.disabled;
    }
    
}
