package kr.or.wabis.framework.exception;

@SuppressWarnings("serial")
public class AttachFileException extends Exception {
    
    public AttachFileException(String message) {
        super(message);
    }
    
    public AttachFileException(String message, Throwable cause) {
        super(message, cause);
    }
}
