package kr.or.wabis.framework.exception;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class ValidationException extends Exception {
    
    private static final long serialVersionUID = 1L;
    
    /** 대상 입력명 */
    private String inputName = null;
    
    /** 대상 그룹명 =! */
    private String group = null;
    
    /** 대상 라벨 */
    private String label = null;
    
    /** excelRowIndex */
    private int excelRowIndex = -1;
    
    public ValidationException(String message, String inputName, String group, String label) {
        
        super(message);
        
        this.inputName = inputName;
        this.label = label;
    }
    
    public ValidationException(String message, String inputName, String group, String label, int excelRowIndex) {
        
        super(message);
        
        this.inputName = inputName;
        this.label = label;
        this.excelRowIndex = excelRowIndex;
    }
    
    public ValidationException(String message) {
        super(message);
    }
    
    public String getInputName() {
        return inputName;
    }
    
    public void setInputName(String inputName) {
        this.inputName = inputName;
    }
    
    public String getGroup() {
        return group;
    }
    
    public void setGroup(String group) {
        this.group = group;
    }
    
    public String getLabel() {
        return label;
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public int getExcelRowIndex() {
        return excelRowIndex;
    }
    
    public void setExcelRowIndex(int excelRowIndex) {
        this.excelRowIndex = excelRowIndex;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
