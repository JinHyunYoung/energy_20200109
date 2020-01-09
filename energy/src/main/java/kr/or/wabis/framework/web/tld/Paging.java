package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.jsp.JspException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Paging extends ExtendedTagSupport {
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    private String formName;
    private String pageUrl;
    private int currentPageNo;
    private int recordCountPerPage;
    private int pageSize;
    private int totalRecordCount;
    
    public void doTag() throws JspException, IOException {
        
        log.debug("### Paging Tag Library. currentPageNo     : {}", currentPageNo);
        log.debug("### Paging Tag Library. recordCountPerPage: {}", recordCountPerPage);
        log.debug("### Paging Tag Library. pageSize          : {}", pageSize);
        log.debug("### Paging Tag Library. totalRecordCount  : {}", totalRecordCount);
        
        if (totalRecordCount <= 0) {
            return;
        }
        
        if (currentPageNo <= 0)
            return;
        if (recordCountPerPage <= 0)
            return;
        if (pageSize <= 0)
            return;
        if (totalRecordCount <= 0)
            return;
        
        String contextPath = getRequest().getContextPath();
        
        // String firstPageGroupHtml = "<img src=\"" + contextPath +
        // "/images/common/icon_paging_first.gif\" />";
        // String prevPageGroupHtml = "<img src=\"" + contextPath +
        // "/images/common/icon_paging_prev.gif\" />";
        // String nextPageGroupHtml = "<img src=\"" + contextPath +
        // "/images/common/icon_paging_next.gif\" />";
        // String lastPageGroupHtml = "<img src=\"" + contextPath +
        // "/images/common/icon_paging_last.gif\" />";
        
        String firstPageGroupHtml = "<span aria-hidden=\"true\">&laquo;&laquo;</span>";
        String prevPageGroupHtml = "<span aria-hidden=\"true\">&laquo;</span>";
        String nextPageGroupHtml = "<span aria-hidden=\"true\">&raquo;</span>";
        String lastPageGroupHtml = "<span aria-hidden=\"true\">&raquo;&raquo;</span>";
        
        String pageString = "";
        
        pageString += "<nav class=\"text-center\">\n";
        pageString += "    <ul class=\"pagination\">\n";
        
        int totalPage = (int) Math.ceil((double) totalRecordCount / (double) recordCountPerPage);
        int totalPageGroup = (int) Math.ceil((double) totalPage / (double) pageSize);
        int currentPageGroup = 0;
        int startPage = 0;
        int endPage = 0;
        
        pageUrl = contextPath + pageUrl;
        
        if (currentPageNo > totalPage) {
            currentPageNo = (int) totalPage;
        }
        
        currentPageGroup = (int) Math.ceil((double) currentPageNo / (double) pageSize);
        
        if (totalPageGroup > 1) {
            pageString += "<li><a href=\"javascript:cf_goPage( 1 , '" + pageUrl + "' , '" + formName + "' );\" aria-label=\"First\">" + firstPageGroupHtml + "</a></li>";
        }
        
        if (currentPageGroup > 1) {
            pageString += "<li><a href=\"javascript:cf_goPage(" + ((currentPageGroup - 1) * pageSize) + " , '" + pageUrl + "' , '" + formName + "' );\" aria-label=\"Previous\">" + prevPageGroupHtml + "</a></li>";
        }
        
        startPage = (int) (((currentPageGroup - 1) * pageSize) + 1);
        endPage = (int) ((currentPageGroup * pageSize));
        
        if (endPage > totalPage) {
            endPage = (int) totalPage;
        }
        
        for (int i = startPage; i <= endPage; i++) {
            if (i == currentPageNo) {
                pageString += "<li><a class=\"on\" href=\"javascript:cf_goPage('" + i + "' , '" + pageUrl + "' , '" + formName + "' );\">" + i + "</a></li>";
            } else {
                pageString += "<li><a href=\"javascript:cf_goPage(" + i + " , '" + pageUrl + "' , '" + formName + "' );\">" + i + "</a></li>";
            }
        }
        
        if (currentPageGroup < totalPageGroup) {
            pageString += "<li><a href=\"javascript:cf_goPage(" + ((currentPageGroup * pageSize) + 1) + " , '" + pageUrl + "' , '" + formName + "' );\" aria-label=\"Next\">" + nextPageGroupHtml + "</a></li>";
        }
        
        if (totalPageGroup > 1) {
            pageString += "<li><a href=\"javascript:cf_goPage(" + totalPage + " , '" + pageUrl + "' , '" + formName + "' );\" aria-label=\"Last\">" + lastPageGroupHtml + "</a></li>";
        }
        
        pageString += "\n";
        pageString += "    </ul>\n";
        pageString += "</nav>\n";
        
        getJspContext().getOut().print(pageString);
    }
    
    public String getFormName() {
        return formName;
    }
    
    public void setFormName(String formName) {
        this.formName = formName;
    }
    
    public String getPageUrl() {
        return pageUrl;
    }
    
    public void setPageUrl(String pageUrl) {
        this.pageUrl = pageUrl;
    }
    
    public int getCurrentPageNo() {
        return currentPageNo;
    }
    
    public void setCurrentPageNo(int currentPageNo) {
        this.currentPageNo = currentPageNo;
    }
    
    public int getRecordCountPerPage() {
        return recordCountPerPage;
    }
    
    public void setRecordCountPerPage(int recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }
    
    public int getPageSize() {
        return pageSize;
    }
    
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    
    public int getTotalRecordCount() {
        return totalRecordCount;
    }
    
    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
    }
    
}
