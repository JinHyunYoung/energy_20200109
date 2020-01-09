package kr.or.wabis.framework.exception;

@SuppressWarnings("serial")
public class BizException extends Exception {
    
    public BizException() {
        super();
    }
    
    public BizException(String message) {
        super(message);
    }
    
}
