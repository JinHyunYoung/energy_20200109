package kr.or.wabis.framework.exception;

import java.util.ArrayList;

@SuppressWarnings("serial")
public class ValidationListException extends Exception {
    
    private ArrayList<ValidationException> validationExceptionList = new ArrayList<ValidationException>();
    
    public ValidationListException() {        
    }
    
    public void add(ValidationException e) {
        validationExceptionList.add(e);
    }
    
    public void add(int index, ValidationException e) {
        validationExceptionList.add(index, e);
    }
    
    public void addAll(ArrayList<ValidationException> e) {
        validationExceptionList.addAll(e);
    }
    
    public void remove(ValidationException e) {
        validationExceptionList.remove(e);
    }
    
    public ArrayList<ValidationException> getValidationListException() {
        return validationExceptionList;
    }
    
    public boolean isEmpty() {
        return validationExceptionList.isEmpty();
    }
}
