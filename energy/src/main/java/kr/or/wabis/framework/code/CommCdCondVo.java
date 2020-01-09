package kr.or.wabis.framework.code;

public class CommCdCondVo {
    
    /** 코드그룹 아이디 */
    private String cdId;
    
    /** 언어구분코드 */
    private String lngaCd;
    
    /** 코드 항목 아이디*/
    private String cdItemId;
    
    /** 코드 명 */
    private String cdNm;
    
    /** 코드 아이템 조건 */
    private String codeItemCondition;
    
    public String getCdId() {
        return cdId;
    }
    
    public void setCdId(String cdId) {
        this.cdId = cdId;
    }
    
    public String getLngaCd() {
        return lngaCd;
    }
    
    public void setLngaCd(String lngaCd) {
        this.lngaCd = lngaCd;
    }
    
    public String getCdItemId() {
        return cdItemId;
    }
    
    public void setCdItemId(String cdItemId) {
        this.cdItemId = cdItemId;
    }
    
    public String getCdNm() {
        return cdNm;
    }
    
    public void setCdNm(String cdNm) {
        this.cdNm = cdNm;
    }
    
    public String getCodeItemCondition() {
        return codeItemCondition;
    }
    
    public void setCodeItemCondition(String codeItemCondition) {
        this.codeItemCondition = codeItemCondition;
    }
    
}
