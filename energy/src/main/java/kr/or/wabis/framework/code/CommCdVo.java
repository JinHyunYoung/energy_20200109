package kr.or.wabis.framework.code;

public class CommCdVo {
    
    /** 코드ID */
    private String cdId = "";
    
    /** 언어코드 */
    private String lngaCd = "";
    
    /** 코드명 */
    private String cdNm = "";
    
    /** 코드설명 */
    private String cdDesc = "";
    
    /** 코드항목ID */
    private String cdItemId = "";
    
    /** 코드항목명 */
    private String cdItemNm = "";
    
    /** 코드항목설명 */
    private String cdItemDesc = "";
    
    /** 코드항목순서 */
    private String cdItemSn = "";
    
    /** 상위코드항목ID */
    private String uprCdItemId = "";
    
    /**
     * ---------------------------------------------------------- For Jquery AutoComplete ---------------------------------------------------------
     */
    private String label = "";
    private String value = "";
    private String text = "";
    private String desc = "";
    
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
    
    public String getCdNm() {
        return cdNm;
    }
    
    public void setCdNm(String cdNm) {
        this.cdNm = cdNm;
    }
    
    public String getCdDesc() {
        return cdDesc;
    }
    
    public void setCdDesc(String cdDesc) {
        this.cdDesc = cdDesc;
    }
    
    public String getCdItemId() {
        return cdItemId;
    }
    
    public void setCdItemId(String cdItemId) {
        this.cdItemId = cdItemId;
    }
    
    public String getCdItemNm() {
        return cdItemNm;
    }
    
    public void setCdItemNm(String cdItemNm) {
        this.cdItemNm = cdItemNm;
    }
    
    public String getCdItemDesc() {
        return cdItemDesc;
    }
    
    public void setCdItemDesc(String cdItemDesc) {
        this.cdItemDesc = cdItemDesc;
    }
    
    public String getCdItemSn() {
        return cdItemSn;
    }
    
    public void setCdItemSn(String cdItemSn) {
        this.cdItemSn = cdItemSn;
    }
    
    public String getUprCdItemId() {
        return uprCdItemId;
    }
    
    public void setUprCdItemId(String uprCdItemId) {
        this.uprCdItemId = uprCdItemId;
    }
    
    /**
     * ---------------------------------------------------------- For Jquery AutoComplete ---------------------------------------------------------
     */
    public String getLabel() {
        return label;
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public String getValue() {
        return value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public String getText() {
        return text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    
    public String getDesc() {
        return desc;
    }
    
    public void setDesc(String desc) {
        this.desc = desc;
    }
    
}
