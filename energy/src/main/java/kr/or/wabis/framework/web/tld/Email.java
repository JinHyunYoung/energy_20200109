package kr.or.wabis.framework.web.tld;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.wabis.framework.code.CommCdCondVo;
import kr.or.wabis.framework.code.CommCdVo;
import kr.or.wabis.framework.util.CodeUtil;
import kr.or.wabis.framework.util.StringUtil;

public class Email extends ExtendedTagSupport {
    
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Override
    public void doTag() throws JspException, IOException {
        
        StringBuffer tagBuffer = new StringBuffer();
        
        tagBuffer.append(startTag()).append(getType("text")).append(getId("1")).append(getName("1")).append(getCssClass()).append(getTitle()).append(getStyle()).append(getSubStringValue(1)).append(getReadOnly(true)).append(getSize(10)).append(getDisabled()).append(getOnclick()).append(endTag()).append("\n");
        
        tagBuffer.append(startTag()).append(getType("text")).append(getId("2")).append(getName("2")).append(getCssClass()).append(getTitle()).append(getStyle()).append(getSubStringValue(1)).append(getReadOnly(true)).append(getSize(10)).append(getDisabled()).append(getOnclick()).append(endTag()).append("\n");
        
        tagBuffer.append("<select").append(getId("3")).append(getName("3")).append(getCssClass()).append(getTitle()).append(" style=\"width:80px;\"").append(">").append("\n").append(generateComboOption()).append("</select>").append("\n");
        
        tagBuffer.append(startTag()).append(getType("hidden")).append(getId("")).append(getName("")).append(getSubStringValue(0)).append(endTag()).append("\n");
        
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
    
    private String getSubStringValue(int index) {
        if (StringUtil.isEmpty(getValue())) {
            return "value=\"\"";
        }
        String excludeFixValue = StringUtils.substringBetween(getValue(), "{", "}");
        if (index == 0) {
            return "value=\"" + getValue() + "\"";
        } else if (index == 1) {
            return "value=\"${fn:substring(" + excludeFixValue + ",0,fn:indexOf(" + excludeFixValue + ",'@'))}\"";
        } else if (index == 2) {
            return "${fn:substring(" + excludeFixValue + ",fn:indexOf(" + excludeFixValue + ",'@')+1,fn:length(" + excludeFixValue + "))}";
        } else if (index == 3) {
            return "${fn:substring(" + excludeFixValue + ",13,fn:length(" + excludeFixValue + "))}";
        }
        return null;
    }
    
    private String generateComboOption() {
        
        List<CommCdVo> codeList = null;
        try {
            CommCdCondVo vo = new CommCdCondVo();
            vo.setCdId(code);
            vo.setLngaCd(lngaCd.toUpperCase());
            codeList = CodeUtil.getCode(vo);
        } catch (Exception e) {
            logger.error("{}", e.getMessage());
        }
        
        if (codeList == null) {
            return "";
        }
        StringBuffer optionBuffer = new StringBuffer();
        for (CommCdVo cdVo : codeList) {
            optionBuffer.append("<option value=\"").append(cdVo.getCdItemId()).append("\">").append(cdVo.getCdItemNm()).append("</option>").append("\n");
        }
        return optionBuffer.toString();
    }
    
    private String name;
    private String id;
    private String cssClass;
    private String title;
    private String style;
    private String code;
    private String value;
    private String disabled;
    private String onclick;
    
    public String getName(String index) {
        return " name=\"" + name + index + "\"";
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getId(String index) {
        return !StringUtil.isEmpty(id) ? " id=\"" + id + index + "\"" : "";
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getCssClass() {
        return !StringUtil.isEmpty(cssClass) ? " class=\"" + cssClass + "\"" : "";
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
        return !StringUtil.isEmpty(style) ? " style=\"" + style + "\"" : "";
    }
    
    public void setStyle(String style) {
        this.style = style;
    }
    
    public String getcode() {
        return code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public String getValue() {
        return value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public String getDisabled() {
        return !StringUtil.isEmpty(disabled) ? " disabled=\"" + disabled + "\"" : "";
    }
    
    public void setDisabled(String disabled) {
        this.disabled = disabled;
    }
    
    public String getSize(int size) {
        return " size=\"" + size + "\"";
    }
    
    public String getReadOnly(boolean readonly) {
        return readonly ? " readonly=\"readonly\"" : "";
    }
    
    public String getOnclick() {
        return !StringUtil.isEmpty(onclick) ? " onclick=\"" + onclick + "\"" : "";
    }
    
    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }
}
