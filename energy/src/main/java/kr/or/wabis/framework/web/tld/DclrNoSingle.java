package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.jsp.JspException;

import kr.or.wabis.framework.util.StringUtil;

public class DclrNoSingle extends ExtendedTagSupport {
    
    @Override
    public void doTag() throws JspException, IOException {
        
        StringBuffer tagBuffer = new StringBuffer();
        
        tagBuffer.append(startTag())
        .append(getType("text"))
        .append(getId())
        .append(getName())
        .append(getCssClass())
        .append(getTitle())
        .append(getStyle())
        .append(getValue())
        .append(getReadOnly(true))
        .append(getDisabled())
        .append("data-mask=\"0000000000-0000-0000000\" required=\"required\"")
        .append(getOnclick())
        .append(endTag())
        .append("\n");
        
        getJspContext().getOut().print(tagBuffer.toString());
        
    }
    
    private String startTag() {
        return "<input";
    }
    
    private String endTag() {
        return " />";
    }
    
    private String getType(String type) {
        return " type=\"" + type + "\"";
    }
    
    private String name;
    private String id;
    private String cssClass;
    private String title;
    private String style;
    private String value;
    private String disabled;
    private String onclick;
    private String mode;
    
    public String getName() {
        return " name=\"" + name + "\"";
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getId() {
        return StringUtil.isNotEmpty(id) ? " id=\"" + id + "\"" : "";
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getCssClass() {
        return StringUtil.isNotEmpty(cssClass) ? " class=\"" + cssClass + "\"" : "";
    }
    
    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }
    
    public String getTitle() {
        return " title=\"" + title + "\"";
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getStyle() {
        return StringUtil.isNotEmpty(style) ? " style=\"" + style + "\"" : "";
    }
    
    public void setStyle(String style) {
        this.style = style;
    }
    
    public String getValue() {
        return " value=\"" + value + "\"";
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public String getDisabled() {
        return StringUtil.isNotEmpty(disabled) ? " disabled=\"" + disabled + "\"" : "";
    }
    
    public void setDisabled(String disabled) {
        this.disabled = disabled;
    }
    
    public String getReadOnly(boolean readonly) {
        return readonly ? " readonly=\"readonly\"" : "";
    }
    
    public String getOnclick() {
        return StringUtil.isNotEmpty(onclick) ? " onclick=\"" + onclick + "\"" : "";
    }
    
    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }
    
    public String getMode() {
        return mode;
    }
    
    public void setMode(String mode) {
        this.mode = mode;
    }
    
}
