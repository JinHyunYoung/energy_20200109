package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class PeriodButton extends SimpleTagSupport {
    
    public void doTag() throws JspException, IOException {
        
        StringBuffer buffer = new StringBuffer();
        buffer.append("&nbsp;&nbsp;");
        buffer.append("<a href=\"#\" class=\"btn_04\" id=\"setToday\"><span>당일</span></a> ");
        buffer.append("<a href=\"#\" class=\"btn_04\" id=\"afterOneWeek\"><span>1주일</span></a> ");
        buffer.append("<a href=\"#\" class=\"btn_04\" id=\"afterOneMonth\"><span>1개월</span></a> ");
        buffer.append("<a href=\"#\" class=\"btn_04\" id=\"afterThreeMonth\"><span>3개월</span></a> ");
        getJspContext().getOut().print(buffer.toString());
        
    }
    
}
