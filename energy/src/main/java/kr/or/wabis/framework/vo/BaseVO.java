package kr.or.wabis.framework.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class BaseVO implements Serializable {
    
    private static final long serialVersionUID = 5964387415789635560L;
    
    // 생성자
    public String created_by;
    
    // 생성자명
    public String created_by_nm;
    
    // 생성일자
    public String created_dttm;
    
    // 수정자
    public String modify_by;
    
    // 수정자명
    public String modify_by_nm;
    
    // 수정일자
    public String modify_dttm;
    
    // 총건수
    public int total_cnt;
    
    // row number
    public int rnum;
    
    // 리스트
    public List list;
    
    // 페이지 사이즈
    private Integer miv_pageSize;
    
    // 페이지 번호
    private Integer miv_pageNo;
    
    // 정렬
    private String sord;
    
    // 인덱스
    private String sidx;
    
    @Override
    public String toString() {
        try {
            return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
        } catch (Exception e) {
            return "";
        }
    }
    
    @Override
    public boolean equals(Object o) {
        return EqualsBuilder.reflectionEquals(this, o);
    }
    
    @Override
    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode(this);
    }
    
    public String getCreated_by() {
        return created_by;
    }
    
    public void setCreated_by(String created_by) {
        this.created_by = created_by;
    }
    
    public String getCreated_dttm() {
        return created_dttm;
    }
    
    public void setCreated_dttm(String created_dttm) {
        this.created_dttm = created_dttm;
    }
    
    public String getModify_by() {
        return modify_by;
    }
    
    public void setModify_by(String modify_by) {
        this.modify_by = modify_by;
    }
    
    public String getModify_by_nm() {
        return modify_by_nm;
    }
    
    public void setModify_by_nm(String modify_by_nm) {
        this.modify_by_nm = modify_by_nm;
    }
    
    public String getModify_dttm() {
        return modify_dttm;
    }
    
    public void setModify_dttm(String modify_dttm) {
        this.modify_dttm = modify_dttm;
    }
    
    public int getTotal_cnt() {
        return total_cnt;
    }
    
    public void setTotal_cnt(int total_cnt) {
        this.total_cnt = total_cnt;
    }
    
    public int getRnum() {
        return rnum;
    }
    
    public void setRnum(int rnum) {
        this.rnum = rnum;
    }
    
    public List getList() {
        return list;
    }
    
    public void setList(List list) {
        this.list = list;
    }
    
    public String getCreated_by_nm() {
        return created_by_nm;
    }
    
    public void setCreated_by_nm(String created_by_nm) {
        this.created_by_nm = created_by_nm;
    }
    
    public Integer getMiv_pageSize() {
        return miv_pageSize;
    }
    
    public void setMiv_pageSize(Integer miv_pageSize) {
        this.miv_pageSize = miv_pageSize;
    }
    
    public Integer getMiv_pageNo() {
        return miv_pageNo;
    }
    
    public void setMiv_pageNo(Integer miv_pageNo) {
        this.miv_pageNo = miv_pageNo;
    }
    
    public String getSord() {
        return sord;
    }
    
    public void setSord(String sord) {
        this.sord = sord;
    }
    
    public String getSidx() {
        return sidx;
    }
    
    public void setSidx(String sidx) {
        this.sidx = sidx;
    }
    
}
