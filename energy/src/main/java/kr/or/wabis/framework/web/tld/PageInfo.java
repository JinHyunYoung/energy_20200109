package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class PageInfo extends SimpleTagSupport {
    
    private String name;
    private int totalRecordCount = 0;
    private int recordCountPerPage = 0;
    private int unitCount = 10;
    private int[] pageCountArray = new int[] { 10, 20, 30, 50, 100 };
    
    public void doTag() throws JspException, IOException {
        
        if (name == null)
            return;
        StringBuffer pageString = new StringBuffer();
        pageString.append("<select class=\"form-control\" name=\"").append(name).append("\">");
        String selected = "";
        
        for (int i = 0; i < pageCountArray.length; i++) {
            selected = (pageCountArray[i] == recordCountPerPage) ? " selected=\"selected\"" : "";
            pageString.append("<option value=\"").append(String.valueOf(pageCountArray[i])).append("\"");
            pageString.append(selected).append(">").append(String.valueOf(pageCountArray[i])).append("</option>");
        }
        pageString.append("</select>");
        
        getJspContext().getOut().print(pageString.toString());
        
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public int getTotalRecordCount() {
        return totalRecordCount;
    }
    
    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
    }
    
    public int getRecordCountPerPage() {
        return recordCountPerPage;
    }
    
    public void setRecordCountPerPage(int recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }
    
    public int getUnitCount() {
        return unitCount;
    }
    
    public void setUnitCount(int unitCount) {
        this.unitCount = unitCount;
    }
    
}
