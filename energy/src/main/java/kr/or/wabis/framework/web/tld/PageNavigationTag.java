package kr.or.wabis.framework.web.tld;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspTagException;

import kr.or.wabis.framework.util.ObjectUtil;
import kr.or.wabis.framework.vo.NavigatorInfo;

public class PageNavigationTag extends HtmlTagSupport {
    
    private static final long serialVersionUID = 1L;
    
    private static final String baseForm = "_baseForm";
    
    private String form, target, action, method;
    
    private String prevImage, prev2Image, nextImage, next2Image;
    private int nPageNo, nPageSize, nScreenSize, nTotalCnt, nTotalPage, nPBlockIndex, nPBlockIdxCount;
    private String CPATH = "";
    
    private boolean popupYn;
    
    public PageNavigationTag() {        
        init();
    }
    
    private void init() {
        
        this.form = null;
        this.target = null;
        this.action = null;
        this.method = null;
        
        this.prevImage = null;
        
        // 이전 screen
        this.prev2Image = null;
        this.nextImage = null;
       
        // 다음 screen
        this.next2Image = null;
        
        this.nPageNo = 0;
        this.nPageSize = 0;
        this.nScreenSize = 0;
        this.nTotalCnt = 0;
        this.nTotalPage = 0;
        this.nPBlockIndex = 0;
        this.nPBlockIdxCount = 0;
        this.target = null;
        this.action = null;
        this.method = null;
        
        this.popupYn = false;        
    }
    
    public void release() {
        super.release();
        init();
    }
    
    public void setNavigator(NavigatorInfo navigator) {
        this.nPageNo = navigator.getPageNo();
        this.nScreenSize = navigator.getScreenSize();
        this.nTotalCnt = navigator.getTotalCnt();
        this.nPageSize = navigator.getPageSize();
    }
    
    /**
     * 초기값 세팅
     */
    public void setProc() {
        
        if (ObjectUtil.isEmpty(form)) {
            form = baseForm;
        }
        
        if (nPageSize < 1) {
            nPageSize = NavigatorInfo.DEFAULT_PAGE_SIZE;
        }
        if (nScreenSize < 1) {
            nScreenSize = NavigatorInfo.DEFAULT_SCREEN_SIZE;
        }
        
    }
    
    /**
     * 기본 javascript 출력 처리
     */
    public void baseScript(StringBuffer output) {
        
        output.append("<script type='text/javascript'> \n");
        output.append("function miv_goPage(pno) { \n");
        
        if (action != null && !action.trim().equals("")) {
            output.append(" document." + form + ".action = '" + action + "'; \n");
        }
        
        if (target != null && !target.trim().equals("")) {
            output.append(" document." + form + ".target = '" + target + "'; \n");
        }
        
        if (method != null && !method.trim().equals("")) {
            output.append(" document." + form + ".method = '" + method + "'; \n");
        }
        
        output.append(" document." + form + "." + NavigatorInfo.MIV_PAGE + ".value=pno; \n");
        output.append(" document." + form + ".submit(); \n");
        output.append("} \n");
        output.append("function miv_changePageSize(psize) { \n");
        output.append(" document." + form + "." + NavigatorInfo.MIV_PAGESIZE + ".value=psize; \n");
        output.append(" document." + form + ".submit(); \n");
        output.append("} \n");
        output.append("</script>");
    }
    
    /**
     * 관리자
     */
    public void skinProcA() {
        String prefix = "<img src=\"" + CPATH + "/css/cm/images/";
        prevImage = prefix + "btn-prev.gif\" alt=\"Prev \" />"; 
        prev2Image = prefix + "btn-prevpage.gif\" alt=\"Prev Screen\" />"; 
        nextImage = prefix + "btn-next.gif\" alt=\"Next\" />";
        next2Image = prefix + "btn-nextpage.gif\" alt=\"Next Screen\" />";
    }
    
    /**
     * 페이지 계산 처리
     */
    public void pageProc() {
        
        this.nTotalPage = this.nTotalCnt / this.nPageSize;
        
        if (this.nTotalCnt % this.nPageSize != 0) {
            this.nTotalPage++;
        }
        
        this.nPBlockIndex = (int) (this.nPageNo / this.nScreenSize);
        
        if (this.nPageNo % this.nScreenSize != 0) {
            this.nPBlockIndex++;
        }
        
        this.nPBlockIdxCount = (int) (this.nTotalPage / this.nScreenSize);
        
        if (this.nTotalPage % this.nScreenSize != 0) {
            this.nPBlockIdxCount++;
        }
    }
    
    /**
     * 페이징 관련 html 출력 start 단
     */
    public void writeStartProc(StringBuffer output) {
        
        if (form.equals(baseForm)) {
            output.append("<form name='" + form + "'>");
        }
        
        output.append("<input type='hidden' name='" + NavigatorInfo.MIV_PAGE + "' value=\"\"/> \n");
        output.append("<input type='hidden' name='" + NavigatorInfo.MIV_PAGESIZE + "' value=\"" + this.nPageSize + "\"/> \n");
        
    }
    
    /**
     * 관리자 페이징 관련 html 출력 end 단
     */
    public void writeEndProcA(StringBuffer output) {
        
        // form end
        if (form.equals(baseForm)) {
            output.append("</form>");
        }
        
        output.append("<div class=\"text-center\"><ul class=\"pagination pagination-sm m-t-0 m-b-10\">");
        if (this.nTotalCnt > 0 && this.nTotalPage > 0) {
            
            // 이전 10
            int p_10 = ((this.nPageNo - 11) / 10) * 10 + 1;
            if (this.nPageNo > 10) {
                output.append("<li ><a href=\"javascript:miv_goPage('" + (p_10) + "')\">≪</a></li>");
            } else {
                output.append("<li class=\"disabled\" ><a href=\"#none\">≪</a></li>\n");
            }
            
            // 중간 페이지
            int nStart = (this.nPBlockIndex - 1) * this.nScreenSize + 1;
            int nFinish = Math.min(this.nPBlockIndex * this.nScreenSize, this.nTotalPage);
            for (int i = nStart; i <= nFinish; i++) {
                if (i == this.nPageNo) {
                    output.append("<li class=\"active\"><a href=\"#none\">" + i + "</a></li>");
                } else {
                    output.append("<li><a href=\"javascript:miv_goPage('" + i + "')\">" + i + "</a></li>\n");
                }
            }
            
            // 다음 10
            int n_10 = ((this.nPageNo + 9) / 10) * 10 + 1;
            
            if (n_10 <= this.nTotalPage) {
                output.append("<li><a href=\"javascript:miv_goPage('" + (n_10) + "')\">≫</a></li>");
            } else {
                output.append("<li class=\"disabled\"><a href=\"#none\">≫</a></li>\n");
            }            
        }
        
        output.append("</ul>\n</div>\n");
    }
    
    /**
     * 
     */
    public int doStartTag() throws JspTagException {
        
        CPATH = ((HttpServletRequest) pageContext.getRequest()).getContextPath();
        
        try {
            
            StringBuffer output = new StringBuffer();
            setProc();
            baseScript(output);
            
            skinProcA();
            
            pageProc();
            writeStartProc(output);
            pageContext.getOut().write(output.toString());
            
        } catch (Exception e) {
            throw new JspTagException("IO Error : " + e.getMessage());
        }
        
        return EVAL_BODY_INCLUDE;
    }
    
    /**
     * 
     */
    public int doEndTag() throws JspTagException {
        
        try {
            
            StringBuffer output = new StringBuffer();            
            writeEndProcA(output);            
            pageContext.getOut().write(output.toString());
            release();
            
        } catch (IOException e) {
            throw new JspTagException("IO Error : " + e.getMessage());
        }
        
        return EVAL_PAGE;
    }
    
    public void setForm(String form) {
        this.form = form;
    }
    
    public void setTarget(String target) {
        this.target = target;
    }
    
    public void setAction(String action) {
        this.action = action;
    }
    
    public void setMethod(String method) {
        this.method = method;
    }
    
    public void setPopupYn(boolean popupYn) {
        this.popupYn = popupYn;
    }
    
}
