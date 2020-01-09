package kr.or.wabis.framework.web.tld;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;

import org.apache.commons.lang.StringUtils;

import kr.or.wabis.framework.code.CommCdCondVo;
import kr.or.wabis.framework.code.CommCdVo;
import kr.or.wabis.framework.util.CodeUtil;
import kr.or.wabis.framework.util.StringUtil;

public class Select extends ExtendedTagSupport {
    
    // if type="text", combobox hidden. != type="text" 이면 combobox가 생기지 않고 코드명만 보인다. 코드값은 hidden으로 생성한다. =!
    private String TYPE_TEXT = "text"; 
    
    // if type="code", optionText displayed "[CODE] CODE_MN". != type="code" 이면 optionText에 '[코드] 코드명' 로 보여진다. =!
    private String TYPE_CODE = "code"; 
    
    // if mode="nodata", no option generated. != mode="nodata" 이면 option목록을 만들지 않는다. =!
    private String MODE_NODATA = "nodata";
    
    public void doTag() throws JspException, IOException {
        
        StringBuffer buffer = new StringBuffer();
        String valueText = "";
        
        String tempName = name;
        if ("disabled".equals(disabled)) {
            tempName = tempName + "Temp";
        }
        
        buffer.append("<select name=\"").append(tempName).append("\"");
        if (id != null)
            buffer.append(" id=\"").append(id).append("\"");
        if (title != null)
            buffer.append(" title=\"").append(title).append("\"");
        if (cssClass != null)
            buffer.append(" class=\"").append(cssClass + "\"");
        if (style != null)
            buffer.append(" style=\"").append(style).append("\"");
        if (disabled != null || (mode != null && (mode.equals("readonly") || mode.equals(MODE_NODATA)))) {
            buffer.append(" disabled=\"disabled\"");
        }
        if (required != null)
            buffer.append(" required=\"required\"");
        
        if (onchange != null)
            buffer.append(" onchange=\"").append(onchange).append(";return false;\"");
        if (onclick != null)
            buffer.append(" onclick=\"").append(onclick).append(";return false;\"");
        if (parentId != null)
            buffer.append(" data-parent-id=\"").append(parentId).append("\"");
        if (childId != null)
            buffer.append(" data-child-id=\"").append(childId).append("\"");
        
        buffer.append(">");
        
        if (topMessage != null && !topMessage.equals("")) {
            buffer.append("<option value=\"\">").append(topMessage).append("</option>");
        }
        
        String selected = "";
        if (code != null) {
            try {
                List<CommCdVo> list = getCommonCodeList();
                String optionText = "";
                for (int i = 0; i < list.size(); i++) {
                    selected = "";
                    CommCdVo item = list.get(i);
                    if (type != null && type.equals(TYPE_CODE)) {
                        optionText = "[" + item.getCdItemId() + "] " + item.getCdItemNm();
                    } else {
                        optionText = item.getCdItemNm();
                    }
                    
                    buffer.append("<option value=\"").append(item.getCdItemId()).append("\"");
                    
                    if (item.getCdItemId().equals(value)) {
                        valueText = item.getCdItemNm();
                        selected = " selected=\"selected\"";
                    }
                    
                    buffer.append(selected);
                    buffer.append(">").append(optionText).append("</option>");
                    
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        buffer.append("</select>");
        
        if (mode != null && mode.equals("label")) {
            if (type != null && type.equals(TYPE_CODE)) {
                getJspContext().getOut().print("[" + value + "]" + valueText);
            } else {
                getJspContext().getOut().print(valueText);
            }
        } else {
            if (type != null && type.equals(TYPE_TEXT) && valueText != null) {
                getJspContext().getOut().print(valueText);
                getJspContext().getOut().print("<input type=\"hidden\" name=\"" + name + "\" value=\"" + value + "\" />");
            } else if ("disabled".equals(disabled)) {
                getJspContext().getOut().print(buffer.toString());
                getJspContext().getOut().print("<input type=\"hidden\" name=\"" + name + "\" value=\"" + value + "\" />");
            } else {
                getJspContext().getOut().print(buffer.toString());
            }
        }
    }
    
    public List<CommCdVo> getCommonCodeList() throws Exception {
        
        if (StringUtils.equals(getMode(), MODE_NODATA)) {
            return new ArrayList<CommCdVo>();
        } else if (getItems() != null) {
            List<CommCdVo> codeList = new ArrayList<CommCdVo>();
            @SuppressWarnings({ "unchecked" })
            List<Object> objList = (List<Object>) getItems();
            for (Object obj : objList) {
                codeList.add((CommCdVo) obj);
            }
            return codeList;
        } else if (!StringUtil.isEmpty(getValue()) && !StringUtil.isEmpty(getCodeNameValue())) {
            List<CommCdVo> codeList = new ArrayList<CommCdVo>();
            CommCdVo vo = new CommCdVo();
            vo.setCdItemId(getValue());
            vo.setCdItemNm(getCodeNameValue());
            codeList.add(vo);
            setTopMessage(null);
            return codeList;
        }
        
        CommCdCondVo vo = new CommCdCondVo();
        vo.setCdId(code);
        vo.setLngaCd(lngaCd.toUpperCase());
        
        if (whereCondition != null) {
            vo.setCodeItemCondition(whereCondition);
        }
        
        return CodeUtil.getCode(vo);
    }
    
    private String name;
    private String id;
    private String title;
    private String cssClass;
    private String style;
    private String code;
    private String whereCondition;
    private String value;
    private String codeNameValue;
    private String topMessage;
    private Object items;
    private String disabled;
    private String type;
    private String mode;
    
    private Object onchange;
    private Object onclick;
    private String required;
    private String parentId;
    private String childId;
    
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
    
    public String getWhereCondition() {
        return whereCondition;
    }
    
    public void setWhereCondition(String whereCondition) {
        this.whereCondition = whereCondition;
    }
    
    public String getValue() {
        return value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public String getCodeNameValue() {
        return codeNameValue;
    }
    
    public void setCodeNameValue(String codeNameValue) {
        this.codeNameValue = codeNameValue;
    }
    
    public String getTopMessage() {
        return topMessage;
    }
    
    public void setTopMessage(String topMessage) {
        this.topMessage = topMessage;
    }
    
    public Object getItems() {
        return items;
    }
    
    public void setItems(Object items) {
        this.items = items;
    }
    
    public Object getOnchange() {
        return onchange;
    }
    
    public void setOnchange(Object onchange) {
        this.onchange = onchange;
    }
    
    public Object getOnclick() {
        return onclick;
    }
    
    public void setOnclick(Object onclick) {
        this.onclick = onclick;
    }
    
    public String getDisabled() {
        return disabled;
    }
    
    public void setDisabled(String disabled) {
        this.disabled = disabled;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public String getMode() {
        return mode;
    }
    
    public void setMode(String mode) {
        this.mode = mode;
    }
    
    public void setRequired(String required) {
        this.required = required;
    }
    
    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    
    public void setChildId(String childId) {
        this.childId = childId;
    }
    
}
