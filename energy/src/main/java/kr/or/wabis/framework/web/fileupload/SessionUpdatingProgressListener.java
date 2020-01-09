package kr.or.wabis.framework.web.fileupload;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;

public class SessionUpdatingProgressListener implements ProgressListener {
    
    private HttpServletRequest requestRef = null;
    
    private long oldBytesRead = 0;
    
    public SessionUpdatingProgressListener(HttpServletRequest req) {
        this.requestRef = req;
    }
    
    public void update(long pBytesRead, long pContentLength, int pItems) {
        
        if (Math.abs(pBytesRead - oldBytesRead) > (1024 * .5)) {
            
            if (requestRef != null) {
                
                UploadStatusInfo statusInfo = new UploadStatusInfo();
                
                statusInfo.setBytesRead(pBytesRead);
                statusInfo.setContentLength(pContentLength);
                statusInfo.setItems(pItems);
                
                HttpSession session = requestRef.getSession();
                session.setAttribute(UploadStatusInfo.SESSION_KEY, statusInfo);
                
            }
        }
        oldBytesRead = pBytesRead;
    }
    
}
