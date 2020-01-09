package kr.or.wabis.framework.exception;

@SuppressWarnings("serial")
public class AuthenticationException extends Exception {
    
    private String message;
    
    public AuthenticationException(String message) {
        super(message);
        this.message = message;
    }
    
    @Override
    public String getMessage() {
        return message;
    }
        
    public void setMessage(String message) {
        this.message = message;
    }
    
}
