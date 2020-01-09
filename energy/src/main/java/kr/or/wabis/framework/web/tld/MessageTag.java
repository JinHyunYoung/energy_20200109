package kr.or.wabis.framework.web.tld;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import kr.or.wabis.framework.util.LocaleUtil;
import kr.or.wabis.framework.util.MessageUtil;

public class MessageTag extends RequestContextAwareTag {
    
    private final static long serialVersionUID = -687755899636921977L;
    
    private final static Log logger = LogFactory.getLog(MessageTag.class);
    
    private String _code;
    private String _default = "";
    
    // stores EL-based property
    private String escapeJS_;
    private String[] params;
    
    public MessageTag() {
        super();
        init();
    }
    
    private void init() {
        _code = null;
        _default = null;
        escapeJS_ = null;
        params = null;
    }
    
    /**
     * 
     */
    public int doStartTagInternal() throws JspException {
        
        try {
            
            JspWriter out = pageContext.getOut();
            
            String msg = null;
            if (params != null && params.length > 0) {
                // msg = GResourceStore.getMessage(_code,params,LocaleUtils.getSafeLocale((HttpServletRequest)this.pageContext.getRequest()));
                msg = MessageUtil.getMessage(_code, params, LocaleUtil.getSafeLocale((HttpServletRequest) this.pageContext.getRequest()));
            } else {
                msg = MessageUtil.getMessage(_code, LocaleUtil.getSafeLocale((HttpServletRequest) this.pageContext.getRequest()));
            }
            
            // TODO 일단 Spring 3.x 에서 4.x로 변경하면서 ExpressionEvaluationUtils 에러가 나서 임시적으로 주석처리 함
            // boolean escapeJS =
            // ExpressionEvaluationUtils.evaluateBoolean("escapeJS", escapeJS_,
            // pageContext);
            //
            // if (escapeJS) {
            // msg = JavaScriptUtils.javaScriptEscape(msg);
            // // } else {
            // // msg = HtmlUtils.htmlEscape(msg); // 원래 주석처리 되어 있었음.
            // }
            
            out.print(msg);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return EVAL_PAGE;
    }
    
    public void release() {
        super.release();
    }
    
    public void setDesc(String dummy) {        
    }
    
    public void setCode(String code) {
        this._code = code;
    }
    
    public void setParam(String param) {
        this.params = param.split(";");
    }
    
    public void setDefault(String defaultStr) {
        this._default = defaultStr;
    }
    
    public void setEscapeJS(String escapeJS_) {
        this.escapeJS_ = escapeJS_;
    }
    
}
