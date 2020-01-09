package kr.or.wabis.framework.web.tld;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;

import kr.or.wabis.framework.code.CommCdCondVo;
import kr.or.wabis.framework.code.CommCdVo;
import kr.or.wabis.framework.util.CodeUtil;

public class Radio extends ExtendedTagSupport {
    
    public void doTag() throws JspException, IOException {
        
        // one radio
        if (code == null) {
            
            if (label != null) {
                getJspContext().getOut().print("<label>");
            }
            
            getJspContext().getOut().print("<input type=\"radio\" name=\"" + name + "\" ");
            if (id != null) {
                getJspContext().getOut().print("id=\"" + id + "\" ");
            } else {
                getJspContext().getOut().print("id=\"" + name + "\" ");
            }
            if (cssClass != null)
                getJspContext().getOut().print("class=\"" + cssClass + "\" ");
            if (style != null)
                getJspContext().getOut().print("style=\"" + style + "\" ");
            if (value != null)
                getJspContext().getOut().print("value=\"" + value + "\" ");
            if (disabled != null)
                getJspContext().getOut().print("disabled=\"" + disabled + "\" ");
            if (checked != null)
                getJspContext().getOut().print("checked=\"" + checked + "\" ");
            if (title != null)
                getJspContext().getOut().print("title=\"" + title + "\" ");
            if (onclick != null)
                getJspContext().getOut().print("onclick=\"" + onclick + "\" ");
            if (required != null)
                getJspContext().getOut().print("required=\"" + required + "\" ");
            getJspContext().getOut().print("/>");
            
            if (label != null) {
                getJspContext().getOut().print(label + "</label>\n");
            }
            
            // one more radio
        } else {
            
            try {
                List<CommCdVo> list = getCommonCodeList();
                
                if (topMessage != null && !topMessage.equals("")) {
                    CommCdVo allVo = new CommCdVo();
                    allVo.setCdItemId("");
                    allVo.setCdItemNm(topMessage);
                    list.add(0, allVo);
                }
                
                for (int i = 0; i < list.size(); i++) {
                    CommCdVo item = list.get(i);
                    
                    getJspContext().getOut().print("<label>");
                    getJspContext().getOut().print("<input type=\"radio\" name=\"" + name + "\" ");
                    
                    if (id != null) {
                        getJspContext().getOut().print("id=\"" + id);
                    } else {
                        getJspContext().getOut().print("id=\"" + name);
                    }
                    if (index != null)
                        getJspContext().getOut().print("_" + index);
                    if (!"".equals(item.getCdItemId())) {
                        getJspContext().getOut().print("_" + item.getCdItemId());
                    }
                    getJspContext().getOut().print("\" ");
                    
                    if (cssClass != null)
                        getJspContext().getOut().print("class=\"" + cssClass + "\" ");
                    if (style != null)
                        getJspContext().getOut().print("style=\"" + style + "\" ");
                    
                    getJspContext().getOut().print("value=\"" + item.getCdItemId() + "\" ");
                    
                    if (disabled != null)
                        getJspContext().getOut().print("disabled=\"" + disabled + "\" ");
                    
                    if (value != null) {
                        
                        if (value.equals(item.getCdItemId())) {
                            getJspContext().getOut().print("checked=\"checked\" ");
                        }
                    } else {
                        if (defaultValue != null) {
                            if (defaultValue.equals(item.getCdItemId())) {
                                getJspContext().getOut().print("checked=\"" + checked + "\" ");
                            }
                        }
                    }
                    
                    if (title != null)
                        getJspContext().getOut().print("title=\"" + title + "\" ");
                    if (onclick != null)
                        getJspContext().getOut().print("onclick=\"" + onclick + "\" ");
                    if (required != null)
                        getJspContext().getOut().print("required=\"" + required + "\" ");
                    
                    getJspContext().getOut().print("/>");
                    
                    getJspContext().getOut().print(item.getCdItemNm() + "</label>\n");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public List<CommCdVo> getCommonCodeList() throws Exception {
        if (getItems() != null) {
            List<CommCdVo> codeList = new ArrayList<CommCdVo>();
            @SuppressWarnings({ "unchecked" })
            List<Object> objList = (List<Object>) getItems();
            for (Object obj : objList) {
                codeList.add((CommCdVo) obj);
            }
            return codeList;
        }
        
        CommCdCondVo vo = new CommCdCondVo();
        vo.setCdId(code);
        vo.setLngaCd(lngaCd.toUpperCase());
        if (iDataCondition != null) {
            vo.setCodeItemCondition(iDataCondition);
        }
        return CodeUtil.getCode(vo);
    }
    
    private String lngaCd = super.lngaCd;
    
    private String name;
    private String id;
    private String title;
    private String index;
    private String cssClass;
    private String style;
    private String code;
    private String iCode;
    private String iData;
    private String iDataCondition;
    private String value;
    private Object items;
    private String checked;
    private String label;
    private String disabled;
    private String onclick;
    private String defaultValue;
    private String required;
    private String topMessage;
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getIndex() {
        return index;
    }
    
    public void setIndex(String index) {
        this.index = index;
    }
    
    public String getCssClass() {
        return cssClass;
    }
    
    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }
    
    public String getStyle() {
        return style;
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
    
    public String getiCode() {
        return iCode;
    }
    
    public void setiCode(String iCode) {
        this.iCode = iCode;
    }
    
    public String getiData() {
        return iData;
    }
    
    public void setiData(String iData) {
        this.iData = iData;
    }
    
    public String getiDataCondition() {
        return iDataCondition;
    }
    
    public void setiDataCondition(String iDataCondition) {
        this.iDataCondition = iDataCondition;
    }
    
    public String getValue() {
        return value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public Object getItems() {
        return items;
    }
    
    public void setItems(Object items) {
        this.items = items;
    }
    
    public String getChecked() {
        return checked;
    }
    
    public void setChecked(String checked) {
        this.checked = checked;
    }
    
    public String getLabel() {
        return label;
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public String getOnclick() {
        return onclick;
    }
    
    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }
    
    public String getDisabled() {
        return disabled;
    }
    
    public void setDisabled(String disabled) {
        this.disabled = disabled;
    }
    
    public String getDefaultValue() {
        return defaultValue;
    }
    
    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }
    
    public void setRequired(String required) {
        this.required = required;
    }
    
    public String getTopMessage() {
        return topMessage;
    }
    
    public void setTopMessage(String topMessage) {
        this.topMessage = topMessage;
    }
    
}
