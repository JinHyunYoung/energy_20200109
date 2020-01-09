package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.jsp.JspException;

import kr.or.wabis.framework.util.StringUtil;

public class CodePopup extends ExtendedTagSupport {
    
    private String name;
    private String cssClass;
    private String title;
    private String value;
    private String codeNameVar;
    private String codeNameValue;
    private String mode;
    private String readonly;
    private String size;
    private String style;
    private String buttonId;
    
    public void doTag() throws JspException, IOException {
        
        StringBuffer tagBuffer = new StringBuffer();
        
        String readonly = " readonly=\"readonly\"";
        
        String textValue = !StringUtil.isEmpty(value) ? " value=\"[" + value + "] " + codeNameValue + "\"" : " value=\"\"";
        
        tagBuffer.append(startTag()).append(getType("text")).append(getName("CdPpup")).append(textValue).append(readonly).append(getSize()).append(getStyle()).append(endTag()).append("\n");
        tagBuffer.append(startTag()).append(getType("hidden")).append(getName()).append(getValue()).append(endTag()).append("\n");
        tagBuffer.append(startTag()).append(getType("hidden")).append(getCodeNameVar()).append(getCodeNameValue()).append(endTag()).append("\n");
        if (!"readonly".equals(mode)) {
            tagBuffer.append("<a href=\"#" + buttonId + "\"><img src=\"").append(getRequest().getContextPath()).append("/images/common/btn_zoom.png\" /></a>");
        }
        
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
    
    public String getName(String postfix) {
        return " name=\"" + name + "_" + postfix + "\"";
    }
    
    public String getName() {
        return " name=\"" + name + "\"";
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getCssClass() {
        return !StringUtil.isEmpty(cssClass) ? " class=\"" + cssClass + "\"" : "";
    }
    
    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }
    
    public String getTitle() {
        return " title=\"" + getMessage(title) + "\"";
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getValue() {
        return " value=\"" + StringUtil.nvl(value) + "\"";
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public String getStyle() {
        return " style=\"" + StringUtil.nvl(style) + "\"";
    }
    
    public void setStyle(String style) {
        this.style = style;
    }
    
    public String getSize() {
        if (size != null) {
            return " size=\"" + size + "\"";
        }
        return "";
    }
    
    public void setSize(String size) {
        this.size = size;
    }
    
    public String getReadOnly(boolean readonly) {
        return readonly ? " readonly=\"readonly\"" : "";
    }
    
    public String getCodeNameVar() {
        return " name=\"" + codeNameVar + "\"";
    }
    
    public void setCodeNameVar(String codeNameVar) {
        this.codeNameVar = codeNameVar;
    }
    
    public String getCodeNameValue() {
        return " value=\"" + StringUtil.nvl(codeNameValue) + "\"";
    }
    
    public void setCodeNameValue(String codeNameValue) {
        this.codeNameValue = codeNameValue;
    }
    
    public String getMode() {
        return mode;
    }
    
    public void setMode(String mode) {
        this.mode = mode;
    }
    
    public String getReadonly() {
        return readonly;
    }
    
    public void setReadonly(String readonly) {
        this.readonly = readonly;
    }
    
    public String getButtonId() {
        return buttonId;
    }
    
    public void setButtonId(String buttonId) {
        this.buttonId = buttonId;
    }
    
}
