package kr.or.wabis.framework.web.vo;

import javax.xml.bind.annotation.XmlTransient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Electronic Document's Attach File Info != 전자문서의 첨부파일 정보 vo =!
 */
@XmlTransient
public class ElecDocAttchFileInfoVo {
    
    /** Attach Multipart File != 첨부파일 =! */
    @JsonIgnore
    MultipartFile attchFile;
    
    /** Document Code != 문서코드 =! */
    private String docCd = "";
    
    /** Agency Code != 기관코드 =! */
    private String agcCd = "";
    
    /** Attaching Document Sequence Number != 첨부문서일련번호 =! */
    private String attchDocSn = "";
    
    /** Attaching Document Title != 첨부문서제목 =! */
    private String attchDocNm = "";
    
    /** Attaching Document Description != 첨부문서설명 =! */
    private String attchDocDesc = "";
    
    /** Attaching Document Essential Yes Or No != 첨부문서필수여부 =! */
    private String attchDocMdtYn = "";
    
    /** Message Identification != 메시지ID =! */
    private String msgId = "";
    
    /** Attaching File Sequence Number != 첨부파일일련번호 =! */
    private String attchFileSn = "";
    
    /** Attaching File Reference Document Code != 첨부파일참조문서코드 =! */
    private String attchFileRefDocCd = "";
    
    /** Attaching File Reference Declaration Number != 첨부파일참조신고번호 =! */
    private String attchFileRefDclrNo = "";
    
    /** Attaching File Reference Sequence Number != 첨부파일참조일련번호 =! */
    private String attchFileRefSn = "";
    
    /** Attaching File Original File Name != 첨부파일원본파일명 =! */
    private String attchFileOgnlFileNm = "";
    
    /** Attaching File Path Name != 첨부파일경로명 =! */
    private String attchFilePathNm = "";
    
    /** Attaching File Storage Name != 첨부파일저장명 =! */
    private String attchFileStrgNm = "";
    
    /** Attaching File Size != 첨부파일크기 =! */
    private long attchFileSize = 0L;
    
    /** Attaching File Contents Type Name != 첨부파일컨텐츠구분명 =! */
    private String attchFileCtenTpNm = "";
    
    public MultipartFile getAttchFile() {
        return attchFile;
    }
    
    public void setAttchFile(MultipartFile attchFile) {
        this.attchFile = attchFile;
    }
    
    public String getDocCd() {
        return docCd;
    }
    
    public void setDocCd(String docCd) {
        this.docCd = docCd;
    }
    
    public String getAgcCd() {
        return agcCd;
    }
    
    public void setAgcCd(String agcCd) {
        this.agcCd = agcCd;
    }
    
    public String getAttchDocSn() {
        return attchDocSn;
    }
    
    public void setAttchDocSn(String attchDocSn) {
        this.attchDocSn = attchDocSn;
    }
    
    public String getAttchDocNm() {
        return attchDocNm;
    }
    
    public void setAttchDocNm(String attchDocNm) {
        this.attchDocNm = attchDocNm;
    }
    
    public String getAttchDocDesc() {
        return attchDocDesc;
    }
    
    public void setAttchDocDesc(String attchDocDesc) {
        this.attchDocDesc = attchDocDesc;
    }
    
    public String getAttchDocMdtYn() {
        return attchDocMdtYn;
    }
    
    public void setAttchDocMdtYn(String attchDocMdtYn) {
        this.attchDocMdtYn = attchDocMdtYn;
    }
    
    public String getMsgId() {
        return msgId;
    }
    
    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }
    
    public String getAttchFileSn() {
        return attchFileSn;
    }
    
    public void setAttchFileSn(String attchFileSn) {
        this.attchFileSn = attchFileSn;
    }
    
    public String getAttchFileRefDocCd() {
        return attchFileRefDocCd;
    }
    
    public void setAttchFileRefDocCd(String attchFileRefDocCd) {
        this.attchFileRefDocCd = attchFileRefDocCd;
    }
    
    public String getAttchFileRefDclrNo() {
        return attchFileRefDclrNo;
    }
    
    public void setAttchFileRefDclrNo(String attchFileRefDclrNo) {
        this.attchFileRefDclrNo = attchFileRefDclrNo;
    }
    
    public String getAttchFileRefSn() {
        return attchFileRefSn;
    }
    
    public void setAttchFileRefSn(String attchFileRefSn) {
        this.attchFileRefSn = attchFileRefSn;
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
    
    public long getAttchFileSize() {
        return attchFileSize;
    }
    
    public void setAttchFileSize(long attchFileSize) {
        this.attchFileSize = attchFileSize;
    }
    
    public String getAttchFileCtenTpNm() {
        return attchFileCtenTpNm;
    }
    
    public void setAttchFileCtenTpNm(String attchFileCtenTpNm) {
        this.attchFileCtenTpNm = attchFileCtenTpNm;
    }
    
}
