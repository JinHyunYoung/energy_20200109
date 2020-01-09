package kr.or.wabis.framework.web.vo;

import java.util.Date;
import java.util.List;

import javax.xml.bind.annotation.XmlTransient;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.wabis.framework.contants.DateFormatConstant;

/**
 * Basic Vo
 * 
 * @author Jangsoo Kim
 * @version 1.0
 * @since 04-08-2016
 */
@XmlTransient
public class DefaultVo extends PagingVo {
    
    /** Language Code */
    private String lngaCd;
    
    /** Session's User ID !=세션 사용자ID=! */
    private String sessionUserId;
    
    /** Search Start Date != 조회시작일자 =! */
    @DateTimeFormat(pattern = DateFormatConstant.JAVA_DATE_FORMAT)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = DateFormatConstant.UI_DATE_FORMAT)
    private Date srchStrtDt;
    
    /** Search End Date != 조회종료일자 =! */
    @DateTimeFormat(pattern = DateFormatConstant.JAVA_DATE_FORMAT)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = DateFormatConstant.UI_DATE_FORMAT)
    private Date srchEndDt;
    
    /** First Register Id */
    private String frstRegstId;
    
    /** First Register Name */
    private String frstRegstNm;
    
    /** Last Changer Id */
    private String lastChprId;
    
    /** Last Changer Name */
    private String lastChprNm;
    
    /** newQry Y or N */
    private String newQryYn;
    
    /** First Regist Detail Datetime */
    @DateTimeFormat(pattern = DateFormatConstant.JAVA_DATE_FORMAT)
    private Date frstRgsrDtlDttm;
    
    /** Last Change Detail Datetime */
    @DateTimeFormat(pattern = DateFormatConstant.JAVA_DATE_FORMAT)
    private Date lastChngDtlDttm;
    
    /** Grid Selection != 그리스 선택 =! */
    private String gridSlct;
    
    /** Normal Attach Multipart File != 일반화면 첨부파일 =! */
    @XmlTransient
    @JsonIgnore
    List<AttchFileInfoVo> attchFileList;
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
    
    public String getLngaCd() {
        return lngaCd;
    }
    
    public void setLngaCd(String lngaCd) {
        this.lngaCd = lngaCd;
    }
    
    public String getSessionUserId() {
        return sessionUserId;
    }
    
    public void setSessionUserId(String sessionUserId) {
        this.sessionUserId = sessionUserId;
    }
    
    public Date getSrchStrtDt() {
        return srchStrtDt;
    }
    
    public void setSrchStrtDt(Date srchStrtDt) {
        this.srchStrtDt = srchStrtDt;
    }
    
    public Date getSrchEndDt() {
        return srchEndDt;
    }
    
    public void setSrchEndDt(Date srchEndDt) {
        this.srchEndDt = srchEndDt;
    }
    
    public String getFrstRegstId() {
        return frstRegstId;
    }
    
    public void setFrstRegstId(String frstRegstId) {
        this.frstRegstId = frstRegstId;
    }
    
    public String getFrstRegstNm() {
        return frstRegstNm;
    }
    
    public void setFrstRegstNm(String frstRegstNm) {
        this.frstRegstNm = frstRegstNm;
    }
    
    public String getLastChprId() {
        return lastChprId;
    }
    
    public void setLastChprId(String lastChprId) {
        this.lastChprId = lastChprId;
    }
    
    public String getLastChprNm() {
        return lastChprNm;
    }
    
    public void setLastChprNm(String lastChprNm) {
        this.lastChprNm = lastChprNm;
    }
    
    public Date getFrstRgsrDtlDttm() {
        return frstRgsrDtlDttm;
    }
    
    public void setFrstRgsrDtlDttm(Date frstRgsrDtlDttm) {
        this.frstRgsrDtlDttm = frstRgsrDtlDttm;
    }
    
    public Date getLastChngDtlDttm() {
        return lastChngDtlDttm;
    }
    
    public void setLastChngDtlDttm(Date lastChngDtlDttm) {
        this.lastChngDtlDttm = lastChngDtlDttm;
    }
    
    public String getGridSlct() {
        return gridSlct;
    }
    
    public void setGridSlct(String gridSlct) {
        this.gridSlct = gridSlct;
    }
    
    public List<AttchFileInfoVo> getAttchFileList() {
        return attchFileList;
    }
    
    public void setAttchFileList(List<AttchFileInfoVo> attchFileList) {
        this.attchFileList = attchFileList;
    }
    
    public String getNewQryYn() {
        return newQryYn;
    }
    
    public void setNewQryYn(String newQryYn) {
        this.newQryYn = newQryYn;
    }
}
