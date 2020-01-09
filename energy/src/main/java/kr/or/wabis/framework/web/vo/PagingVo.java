package kr.or.wabis.framework.web.vo;

import javax.xml.bind.annotation.XmlTransient;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

@XmlTransient
public class PagingVo {
    
    /** PageIndex **/
    private int pageIndex = 1;
    
    /** PageCount **/
    private int pageUnit = 10;
    
    /** PageSize **/
    private int pageSize = 10;
    
    /** FirstIndex **/
    private int firstIndex = 0;
    
    /** LastIndex **/
    private int lastIndex = Integer.MAX_VALUE;
    
    /** RecordCountPerPage **/
    private int recordCountPerPage = 10;
    
    /** Rownum Alias **/
    private String rnum;
    
    /** TotalRecordCount **/
    private int totalRecordCount = 0;
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
    
    public int getPageIndex() {
        return pageIndex;
    }
    
    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }
    
    public int getPageUnit() {
        return pageUnit;
    }
    
    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }
    
    public int getPageSize() {
        return pageSize;
    }
    
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    
    public int getFirstIndex() {
        return firstIndex;
    }
    
    public void setFirstIndex(int firstIndex) {
        this.firstIndex = firstIndex;
    }
    
    public int getLastIndex() {
        return lastIndex;
    }
    
    public void setLastIndex(int lastIndex) {
        this.lastIndex = lastIndex;
    }
    
    public int getRecordCountPerPage() {
        return recordCountPerPage;
    }
    
    public void setRecordCountPerPage(int recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }
    
    public String getRnum() {
        return rnum;
    }
    
    public void setRnum(String rnum) {
        this.rnum = rnum;
    }
    
    public int getTotalRecordCount() {
        return totalRecordCount;
    }
    
    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
    }
    
}
