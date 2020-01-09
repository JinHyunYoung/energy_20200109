package kr.or.wabis.framework.exception;

public class ErrorInfoDtlVo {
    
    private String index = "";
    
    /** Input-box id or name */
    private String target = "";
    
    /** Label */
    private String label = "";
    
    /** Error description */
    private String errorDesc = "";
    
    /** Excel RowIndex, if Excel */
    private int excelRowIndex = 0;
    
    public String getIndex() {
        return index;
    }
    
    public void setIndex(String index) {
        this.index = index;
    }
    
    public String getTarget() {
        return target;
    }
    
    public void setTarget(String target) {
        this.target = target;
    }
    
    public String getLabel() {
        return label;
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public String getErrorDesc() {
        return errorDesc;
    }
    
    public void setErrorDesc(String errorDesc) {
        this.errorDesc = errorDesc;
    }
    
    public int getExcelRowIndex() {
        return excelRowIndex;
    }
    
    public void setExcelRowIndex(int excelRowIndex) {
        this.excelRowIndex = excelRowIndex;
    }
    
}