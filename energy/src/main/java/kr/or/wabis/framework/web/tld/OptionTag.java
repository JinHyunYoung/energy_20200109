package kr.or.wabis.framework.web.tld;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.LocaleUtil;

public class OptionTag extends HtmlTagSupport {
    
    private static final long serialVersionUID = -687755899636921977L;
        
    private int size = 1;
    private boolean multiple = false;
    private boolean showTitle = false;

    private String titleCode = null;
    private String selected = null;
    private String dispStyle = null;
    private String option = null;
    private String codeGroup = null;
    private String exclude = null;
    private String include = null;
    private String required = null;
    
    private List<Object> optionList = null;
    
    public OptionTag() {
        init();
    }
    
    private void init() {
        this.size = 1;
        this.multiple = false;
        this.selected = null;
        this.codeGroup = null;
        this.dispStyle = null;
        this.option = null;
        this.style = null;
        this.include = null;
        this.required = null;
    }
    
    public void release() {
        super.release();
        init();
    }
    
    /**
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    private String render() {
        
        // master코드나 optionMap이 있으면 기존 option List 무시
        if (this.codeGroup != null) {
            optionList = (List) CommonUtil.getCodeList(this.codeGroup);
        }
        
        StringBuffer sb = new StringBuffer();
        StringBuffer sbt = new StringBuffer();
        
        if (this.optionList != null) {
            
            Locale locale = LocaleUtil.getSafeLocale((HttpServletRequest) this.pageContext.getRequest());
            List<KV> nList = new ArrayList<KV>();
            
            for (Object option : optionList) {
                
                String opValue = "";
                String opText = "";
                
                if (option instanceof Map) {
                    opValue = (String) (((Map) option).get("code"));
                    opText = (String) (((Map) option).get("codenm"));
                    nList.add(new KV(opValue, opText, 0));
                }
                
            }
            
            int optionCnt = 0;
            if (this.codeGroup != null) {
                Collections.sort(nList, new KVCompare());
            }
            
            for (KV kv : nList) {
                
                if (exclude != null && exclude.indexOf(kv.getKey()) > -1) continue;
                if (include != null && !"".equals(include) && include.indexOf(kv.getKey()) == -1) continue;
                
                optionCnt++;
                
                sb.append("<option value='" + kv.getKey() + "' ");
                if (this.selected != null) {
                    if (selected.equals(kv.getKey()))
                        sb.append(" selected='selected' ");
                }
                
                sb.append(">");
                sb.append(super.htmlEscape(kv.getText()));
                sb.append("</option>");
            }
            
            if (this.titleCode != null) {
                String msg = this.titleCode;
                sbt.append("<option value=''>::::" + msg + "::::</option>");
            }
            
            sbt.append(sb.toString());
            
        } else {
            if (this.titleCode != null) {
                String msg = this.titleCode;
                sbt.append("<option value=''>::::" + msg + "::::</option>");
            }
        }
        
        sbt.append("</select>");
        
        return sbt.toString();
    }
    
    /**
     * 
     */
    public int doEndTag() throws JspException {
        try {
            this.pageContext.getOut().write(render());
        } catch (Exception e) {
            e.printStackTrace();
            throw new JspException("Could not write data " + e.toString());
        }
        return EVAL_PAGE;
    }
    
    @SuppressWarnings("unchecked")
    public void setSource(List paramObject) {
        optionList = paramObject;
    }
    
    public void setItems(Object obj) {        
        if (obj instanceof List) {
            this.optionList = (List) obj;
        }
    }
    
    public void setDispStyle(String dispStyle) {
        this.dispStyle = dispStyle;
    }
    
    public void setOption(String option) {
        this.option = option;
    }
    
    public String getTitleCode() {
        return titleCode;
    }
    
    public void setTitleCode(String title) {
        this.titleCode = title;
        this.showTitle = true;
    }
    
    public void setSize(int size) {
        this.size = size;
    }
    
    public void setMultiple(boolean multiple) {
        this.multiple = multiple;
    }
    
    public void setSelected(String selected) {
        this.selected = selected;
    }
    
    public void setCodeGroup(String codeGroup) {
        this.codeGroup = codeGroup;        
    }
    
    public boolean isShowTitle() {
        return showTitle;
    }
    
    public void setShowTitle(boolean showTitle) {
        this.showTitle = showTitle;
    }
    
    public void setStyle(String style) {
        this.style = style;
    }
    
    public void setExclude(String exclude) {
        this.exclude = exclude;
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

    
    public class KV {
        
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
}