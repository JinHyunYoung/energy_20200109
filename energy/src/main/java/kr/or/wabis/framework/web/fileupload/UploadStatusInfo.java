package kr.or.wabis.framework.web.fileupload;

public class UploadStatusInfo {
    
    private static final long serialVersionUID = 1L;
    
    public static final String SESSION_KEY = UploadStatusInfo.class.getName() + ".SESSKEY";
    
    private int items = 0;
    private long bytesRead = 0;
    private long contentLength = 0;
    
    public UploadStatusInfo() {        
    }
    
    public long getBytesRead() {
        return bytesRead;
    }
    
    public void setBytesRead(long bytesRead) {
        this.bytesRead = bytesRead;
    }
    
    public long getContentLength() {
        return contentLength;
    }
    
    public void setContentLength(long contentLength) {
        this.contentLength = contentLength;
    }
    
    public int getItems() {
        return items;
    }
    
    public void setItems(int items) {
        this.items = items;
    }
    
}
