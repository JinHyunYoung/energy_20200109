package kr.or.wabis.framework.web.vo;

import java.math.BigDecimal;

import javax.xml.bind.annotation.XmlTransient;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Attach File Info (Normal attachments, not Electronic Document) != 첨부파일 정보 vo (전자문서가 아닌 일반화면) =!
 */
@XmlTransient
public class AttchFileInfoVo {
    
    /** Attach Multipart File != 첨부파일 =! */
    @JsonIgnore
    MultipartFile attchFile;
    
    /** Attaching File Management Number != 첨부파일관리번호 =! */
    private String attchFileMtNo;
    
    /** Attaching File Sequence Number != 첨부파일일련번호 =! */
    private Integer attchFileSn;
    
    /** Attaching File Original File Name != 첨부파일원본파일명 =! */
    private String attchFileOgnlFileNm = "";
    
    /** Attaching File Path Name != 첨부파일경로명 =! */
    private String attchFilePathNm;
    
    /** Attaching File Storage Name != 첨부파일저장명 =! */
    private String attchFileStrgNm;
    
    /** Attaching File Size != 첨부파일크기 =! */
    private BigDecimal attchFileSize;
    
    /** Attaching File Contents Type Name != 첨부파일컨텐츠구분명 =! */
    private String attchFileCtenTpNm;
    
    /** Electron Document TRGT Yes Or No != 전자문서대상여부 =! */
    private String elecDocTrgtYn;
    
    /** First Register Id */
    private String frstRegstId;
    
    /** Last Changer Id */
    private String lastChprId;
    
    public MultipartFile getAttchFile() {
        return attchFile;
    }
    
    public void setAttchFile(MultipartFile attchFile) {
        this.attchFile = attchFile;
    }
    
    public String getAttchFileMtNo() {
        return attchFileMtNo;
    }
    
    public void setAttchFileMtNo(String attchFileMtNo) {
        this.attchFileMtNo = attchFileMtNo;
    }
    
    public Integer getAttchFileSn() {
        return attchFileSn;
    }
    
    public void setAttchFileSn(Integer attchFileSn) {
        this.attchFileSn = attchFileSn;
    }
    
    public String getAttchFileOgnlFileNm() {
        return attchFileOgnlFileNm;
    }
    
    public void setAttchFileOgnlFileNm(String attchFileOgnlFileNm) {
        this.attchFileOgnlFileNm = attchFileOgnlFileNm;
    }
    
    public String getAttchFilePathNm() {
        return attchFilePathNm;
    }
    
    public void setAttchFilePathNm(String attchFilePathNm) {
        this.attchFilePathNm = attchFilePathNm;
    }
    
    public String getAttchFileStrgNm() {
        return attchFileStrgNm;
    }
    
    public void setAttchFileStrgNm(String attchFileStrgNm) {
        this.attchFileStrgNm = attchFileStrgNm;
    }
    
    public BigDecimal getAttchFileSize() {
        return attchFileSize;
    }
    
    public void setAttchFileSize(BigDecimal attchFileSize) {
        this.attchFileSize = attchFileSize;
    }
    
    public String getAttchFileCtenTpNm() {
        return attchFileCtenTpNm;
    }
    
    public void setAttchFileCtenTpNm(String attchFileCtenTpNm) {
        this.attchFileCtenTpNm = attchFileCtenTpNm;
    }
    
    public String getElecDocTrgtYn() {
        return elecDocTrgtYn;
    }
    
    public void setElecDocTrgtYn(String elecDocTrgtYn) {
        this.elecDocTrgtYn = elecDocTrgtYn;
    }
    
    public String getFrstRegstId() {
        return frstRegstId;
    }
    
    public void setFrstRegstId(String frstRegstId) {
        this.frstRegstId = frstRegstId;
    }
    
    public String getLastChprId() {
        return lastChprId;
    }
    
    public void setLastChprId(String lastChprId) {
        this.lastChprId = lastChprId;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
    
}
