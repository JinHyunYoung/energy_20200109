package kr.or.wabis.framework.exception;

import java.util.ArrayList;
import java.util.List;

public class ErrorInfoVo {
    
    private String excelYn = "N";
    private String url = "";
    private String errMsg = "";
    private List<ErrorInfoDtlVo> errorDtlList = new ArrayList<>();
    
    public ErrorInfoVo() {
        url = "";
        errMsg = "";
    }
    
    public String getExcelYn() {
        return excelYn;
    }
    
    public void setExcelYn(String excelYn) {
        this.excelYn = excelYn;
    }
    
    public ErrorInfoVo(String url, Exception ex) {
        this(url, ex.getLocalizedMessage());
    }
    
    public ErrorInfoVo(String url, String msg) {
        this.url = url;
        this.errMsg = msg;
    }
    
    public String getErrMsg() {
        return errMsg;
    }
    
    public void setErrMsg(String errMsg) {
        this.errMsg = errMsg;
    }
    
    public String getUrl() {
        return url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
    
    public List<ErrorInfoDtlVo> getErrorDtlList() {
        return errorDtlList;
    }
    
    public void setErrorDtlList(List<ErrorInfoDtlVo> errorDtlList) {
        this.errorDtlList = errorDtlList;
    }
    
}