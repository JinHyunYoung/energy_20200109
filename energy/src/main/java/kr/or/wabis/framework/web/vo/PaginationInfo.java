package kr.or.wabis.framework.web.vo;

/**
 * PaginationInfo.java
 * <p>
 * <b>NOTE:</b>
 * 
 * <pre>
 * 페이징 처리를 위한 데이터가 담기는 빈.
 * 페이징 처리에 필요한 데이터를 Required Fields, Not Required Fields 로 나누었다.
 * 
 * [Required Fields]
 * 
 *     currentPageNo      != 현재 페이지 번호 =!
 *     recordCountPerPage != 한 페이지당 게시되는 게시물 건 수 =!
 *     pageSize           != 페이지 리스트에 게시되는 페이지 건수 =!
 *     totalRecordCount   != 전체 게시물 건 수 =!
 * 
 * [Not Required Fields]
 * 
 *     totalPageCount        != 페이지 개수 =!
 *     firstPageNoOnPageList != 페이지 리스트의 첫 페이지 번호 =!
 *     lastPageNoOnPageList  != 페이지 리스트의 마지막 페이지 번호 =!
 *     firstRecordIndex      != 페이징 SQL의 조건절에 사용되는 시작 rownum =! 
 *     lastRecordIndex       != 페이징 SQL의 조건절에 사용되는 마지막 rownum =!
 * 
 * 페이징 Custom 태그인 &lt;ui:pagination&gt; 사용시에 paginationInfo 필드에 PaginationInfo 객체를 값으로 주어야 한다.
 * </pre>
 * 
 * <pre class="code">
 *     &lt;ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" /&gt;
 * </pre>
 */
public class PaginationInfo {
    
    /**
     * Required Fields
     */
    private int currentPageNo = 1;
    private int recordCountPerPage = 10;
    private int pageSize = 10;
    private int totalRecordCount = 0;
    
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
    
    public int getCurrentPageNo() {
        return currentPageNo;
    }
    
    public void setCurrentPageNo(int currentPageNo) {
        this.currentPageNo = currentPageNo;
    }
    
    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
    }
    
    public int getTotalRecordCount() {
        return totalRecordCount;
    }
    
    /**
     * Not Required Fields
     */
    private int totalPageCount;
    private int firstPageNoOnPageList;
    private int lastPageNoOnPageList;
    private int firstRecordIndex;
    private int lastRecordIndex;
    
    public int getTotalPageCount() {
        totalPageCount = ((getTotalRecordCount() - 1) / getRecordCountPerPage()) + 1;
        return totalPageCount;
    }
    
    public int getFirstPageNo() {
        return 1;
    }
    
    public int getLastPageNo() {
        return getTotalPageCount();
    }
    
    public int getFirstPageNoOnPageList() {
        firstPageNoOnPageList = ((getCurrentPageNo() - 1) / getPageSize()) * getPageSize() + 1;
        return firstPageNoOnPageList;
    }
    
    public int getLastPageNoOnPageList() {
        lastPageNoOnPageList = getFirstPageNoOnPageList() + getPageSize() - 1;
        if (lastPageNoOnPageList > getTotalPageCount()) {
            lastPageNoOnPageList = getTotalPageCount();
        }
        return lastPageNoOnPageList;
    }
    
    public int getFirstRecordIndex() {
        firstRecordIndex = (getCurrentPageNo() - 1) * getRecordCountPerPage() + 1;
        return firstRecordIndex;
    }
    
    public int getLastRecordIndex() {
        lastRecordIndex = getCurrentPageNo() * getRecordCountPerPage();
        return lastRecordIndex;
    }
}
