package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.jsp.JspException;

import kr.or.wabis.framework.util.CodeUtil;
import kr.or.wabis.framework.util.StringUtil;

public class AutoComplete extends ExtendedTagSupport {
    
    private String id;
    private String name;
    private String code;
    private String cssClass;
    private String title;
    private String value;
    private String codeNameVar;
    private String codeNameValue;
    private String mode;
    private String readonly;
    private String size;
    private String style;
    private String required;
    private String placeholder;
    private String parentId;
    private String childId;
    private String whereCondition;
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public void setStyle(String style) {
        this.style = style;
    }
    
    public void setSize(String size) {
        this.size = size;
    }
    
    public void setCodeNameVar(String codeNameVar) {
        this.codeNameVar = codeNameVar;
    }
    
    public void setCodeNameValue(String codeNameValue) {
        this.codeNameValue = codeNameValue;
    }
    
    public void setMode(String mode) {
        this.mode = mode;
    }
    
    public void setReadonly(String readonly) {
        this.readonly = readonly;
    }
    
    public void setRequired(String required) {
        this.required = required;
    }
    
    public void setPlaceholder(String placeholder) {
        this.placeholder = placeholder;
    }
    
    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    
    public void setChildId(String childId) {
        this.childId = childId;
    }
    
    public String getWhereCondition() {
        return whereCondition;
    }
    
    public void setWhereCondition(String whereCondition) {
        this.whereCondition = whereCondition;
    }
    
    @Override
    public void doTag() throws JspException, IOException {
        
        StringBuffer tagBuffer = new StringBuffer();
        
        // search item_code_nm by item_code_id
        if (value != null && codeNameValue == null) {
            try {
                codeNameValue = CodeUtil.getCodeItemNm(code, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        if (mode != null && mode.equals("label")) {
            tagBuffer.append(value).append(" ").append(codeNameValue);
        } else {
            
            String readonly = "";
            if ("readonly".equals(mode)) {
                readonly = " readonly=\"readonly\"";
            }
            
            String textValue = !StringUtil.isEmpty(value) ? " value=\"[" + value + "] " + codeNameValue + "\"" : " value=\"\"";
            
            tagBuffer.append(startTag()).append(getType("text")).append(getName("AutoCmpl")).append(getCode()).append(textValue).append(readonly).append(getSize()).append(getCssClass()).append(getStyle()).append(getTitle()).append(getRequired()).append(getPlaceholder()).append(getParentId()).append(getChildId()).append(endTag()).append("\n");
            tagBuffer.append(startTag()).append(getType("hidden")).append(getName()).append(getValue()).append(endTag()).append("\n");
            if (codeNameVar != null) {
                tagBuffer.append(startTag()).append(getType("hidden")).append(getCodeNameVar()).append(getCodeNameValue()).append(endTag()).append("\n");
            }
            
            String hidden = "";
            if ("readonly".equals(mode)) {
                hidden = " hidden";
            }
            tagBuffer.append("<span class=\"input-group-btn\">\n");
            tagBuffer.append("    <button id=\"btn_" + id + "\" class=\"btn btn-default" + hidden + "\" type=\"button\"><span class=\"glyphicon glyphicon-search\" aria-hidden=\"true\"></span></button>\n");
            tagBuffer.append("</span>\n");
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
    
    private String getName(String postfix) {
        String autoCmplId = id + "_" + postfix;
        String autoCmplName = name + "_" + postfix;
        
        String ret = " name=\"" + autoCmplName + "\" id=\"" + autoCmplId + "\" data-input-cd=\"" + id + "\"";
        if (codeNameVar != null) {
            String tempId = codeNameVar.indexOf(".") == -1 ? codeNameVar : StringUtil.substringAfter(codeNameVar, ".");
            ret += " data-input-nm=\"" + tempId + "\" ";
        }
        return ret;
    }
    
    private String getName() {
        return " name=\"" + name + "\" id=\"" + id + "\"";
    }
    
    private String getCode() {
        if (whereCondition == null) {
            return " data-code=\"" + StringUtil.nvl(code) + "\"";
        } else {
            return " data-code=\"" + StringUtil.nvl(code) + "\" data-condition=\"" + whereCondition + "\"";
        }
    }
    
    public String getCssClass() {
        return !StringUtil.isEmpty(cssClass) ? " class=\"" + cssClass + "\"" : "";
    }
    
    public String getValue() {
        return " value=\"" + StringUtil.nvl(value) + "\"";
    }
    
    public String getStyle() {
        return " style=\"" + StringUtil.nvl(style) + "\"";
    }
    
    public String getTitle() {
        return " title=\"" + StringUtil.nvl(title) + "\"";
    }
    
    public String getSize() {
        if (size != null) {
            return " size=\"" + size + "\"";
        }
        return "";
    }
    
    public String getReadOnly(boolean readonly) {
        return readonly ? " readonly=\"readonly\"" : "";
    }
    
    public String getCodeNameVar() {
        String tempId = codeNameVar.indexOf(".") == -1 ? codeNameVar : StringUtil.substringAfter(codeNameVar, ".");
        return " name=\"" + codeNameVar + "\" id=\"" + tempId + "\"";
    }
    
    public String getCodeNameValue() {
        return " value=\"" + StringUtil.nvl(codeNameValue) + "\"";
    }
    
    public String getRequired() {
        return required == null ? "" : " required=\"" + StringUtil.nvl(required) + "\"";
    }
    
    public String getPlaceholder() {
        return placeholder == null ? "" : " placeholder=\"" + StringUtil.nvl(placeholder) + "\"";
    }
    
    public String getParentId() {
        return parentId == null ? "" : " data-parent-id=\"" + StringUtil.nvl(parentId) + "\"";
    }
    
    public String getChildId() {
        return childId == null ? "" : " data-child-id=\"" + StringUtil.nvl(childId) + "\"";
    }
    
    public String getMode() {
        return mode;
    }
    
    public String getReadonly() {
        return readonly;
    }
}
