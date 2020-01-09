package kr.or.wabis.framework.web.tld;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.util.HtmlUtils;

import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.LocaleUtil;
import kr.or.wabis.framework.util.ObjectUtil;

public class RadioTag extends HtmlTagSupport {
    
    private static final long serialVersionUID = 1L;
        
    @SuppressWarnings("unchecked")
    private String titleCode = null;    
    private Object curValue = null;
    private String onChange = null;
    private String option = null;
    private String seperator = null;
    private String connector = null;
    private String checked = null;
    private String id = null;
    private String name = null;
    private String cls = null;
    private String exclude = null;    
    private String codeGroup = null;
    
    private Map<String, Object> tagAttributes = new HashMap<String, Object>();

    private List<Object> optionList = null;
    
    public RadioTag() {
        init();
    }
    
    private void init() {
        this.curValue = null;
        this.onChange = null;
        this.codeGroup = null;
        this.optionList = null;
        this.option = null;
        this.seperator = null;
        this.connector = null;
        this.id = null;
        this.checked = null;
        this.exclude = null;
        this.cls = null;
    }
    
    public void release() {
        super.release();
        init();
    }
    
    @SuppressWarnings("unchecked")
    public int doStartTag() throws JspException {
        
        StringBuffer sb = new StringBuffer();
        
        try {
            
            if (this.titleCode != null) {
                
                String msg = this.titleCode;
                startOneTag(sb);
                if (this.curValue == null || "".equals(this.curValue)) {
                    sb.append(" checked='checked' ");
                }
                
                sb.append(" value='' ");
                sb.append(" />" + msg + "&nbsp;");
            }
            
            // master코드나 optionMap이 있으면 기존 option List 무시
            if (this.codeGroup != null) {
                optionList = (List) CommonUtil.getCodeList(this.codeGroup);
            }
            
            if (this.optionList != null) {
                
                Locale locale = LocaleUtil.getSafeLocale((HttpServletRequest) this.pageContext.getRequest());
                List<KV> nList = new ArrayList<KV>();
                
                int cnt = 0;                
                for (Object option : optionList) {
                    
                    String opValue = "";
                    String opText = "";
                    int opOrd = 0;
                    if (option instanceof Map) {
                        opValue = (String) (((Map) option).get("code"));
                        opText = (String) (((Map) option).get("codenm"));
                        
                        nList.add(new KV(opValue, opText, 0));
                    }
                }
                
                Collections.sort(nList, new KVCompare());
                String tConnector = ObjectUtil.nvl(connector, ":");
                for (KV kv : nList) {
                    
                    if (exclude != null && exclude.indexOf(kv.getKey()) > -1) continue;
                    
                    startOneTag(sb);
                    sb.append(" value='" + kv.getKey() + "'");
                    
                    if ("checked".equals(this.checked)) {
                        sb.append(" checked='checked' ");
                    } 
                    
                    else if (this.curValue != null) {
                        
                        if (curValue instanceof String) {
                            if (curValue.equals(kv.getKey())) {
                                sb.append(" checked='checked' ");
                            } else if (curValue.equals("")) {
                                sb.append(" ");
                            }
                        } 
                        
                        else if (curValue instanceof Collection) {
                            if (((Collection) curValue).contains(kv.getKey())) {
                                sb.append(" checked='checked' ");
                            }
                        }
                        
                        else if (curValue instanceof Object[]) {
                            if (ArrayUtils.contains((Object[]) curValue, kv.getKey())) {
                                sb.append(" checked='checked' ");
                            }
                        }
                        
                    } else if (this.curValue == null && kv.getSeq() < 2) {
                        sb.append(" checked='checked' ");
                    }
                    
                    sb.append(" />");
                    sb.append(htmlEscape(kv.getText()));
                    sb.append("</label>");
                    
                    if (this.seperator != null) {
                        sb.append(this.seperator);
                    }
                    
                    sb.append(" ");
                }
                
                if (this.seperator != null && sb.length() > 0) {
                    sb.delete(sb.length() - this.seperator.length(), sb.length());
                }
            }
            
            this.pageContext.getOut().write(sb.toString());
            
        } catch (Exception e) {
            throw new JspException("Could not write data " + e.toString());
        }
        
        return EVAL_BODY_INCLUDE;
    }
    
    /**
     * 
     * @param sb
     * @throws JspException
     */
    protected void startOneTag(StringBuffer sb) throws JspException {
        
        sb.append("<label class='radio-inline'><input type='radio' ");
        
        if (this.name != null) {
            sb.append(" name='");
            sb.append(this.name);
            sb.append("'");
        }
        
        if (this.id != null) {
            sb.append(" id='");
            sb.append(this.id);
            sb.append("'");
        }
        
        if (this.cls != null) {
            sb.append(" class='");
            sb.append(this.cls);
            sb.append("'");
        }
        
        for (String attrName : tagAttributes.keySet()) {
            sb.append(" ");
            sb.append(attrName);
            sb.append("='");
            sb.append(tagAttributes.get(attrName));
            sb.append("'");
        }
        
        if (getDisabled()){
            sb.append(" disabled");
        }
        
        if (this.onChange != null) {
            sb.append(" onChange='");
            sb.append(this.onChange);
            sb.append("'");
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
    
    
    public void setId(String id) {
        this.id = id;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setDynamicAttribute(String uri, String localName, Object value) throws JspException {
        tagAttributes.put(localName, value);
    }
    
    public void setOption(String option) {
        this.option = option;
    }
   
    public void setConnector(String connector) {
        this.connector = connector;
    }
    
    public void setSeperator(String seperator) {
        this.seperator = seperator;
    }
    
    public void setCurValue(Object curValue) {
        this.curValue = curValue;
    }
    
    public void setOnChange(String onChange) {
        this.onChange = onChange;
    }
    
    public void setCodeGroup(String codeGroup) {
        this.codeGroup = codeGroup;        
    }
    
    public void setChecked(String checked) {
        this.checked = checked;
    }
    
    public void setCls(String cls) {
        this.cls = cls;
    }
    
    public void setTitleCode(String titleCode) {
        this.titleCode = titleCode;
    }
    
    public void setExclude(String exclude) {
        this.exclude = exclude;
    }
    
    public void setSource(List paramObject) {
        optionList = paramObject;
    }      
    
    class KV {
        private String key = null;
        private String text = null;
        private int seq = 0;
        
        public KV(String key, String text, int seq) {
            this.key = key;
            this.text = text;
            this.seq = seq;
        }
        
        public String getKey() {
            return key;
        }
        
        public String getText() {
            return text;
        }
        
        public int getSeq() {
            return seq;
        }        
    }
    
    class KVCompare implements Comparator {
        
        public KVCompare() {
        }
        
        public int compare(Object arg1, Object arg2) {
            
            KV a = (KV) arg1;
            KV b = (KV) arg2;
            
            if (a.getSeq() == b.getSeq()) {
                
                if (a.getText().compareTo(b.getText()) < 0) {
                    return 0;
                } else {
                    return 1;
                }
                
            } else if (a.getSeq() > b.getSeq()) {
                return 1;
            }
            
            return 0;            
        }        
    }
}
