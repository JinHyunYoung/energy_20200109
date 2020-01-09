package kr.or.wabis.framework.web.fileupload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

public class FileDownloadInfo {
    
    private static final long serialVersionUID = -8594092365759476575L;
    
    private File file = null;
    
    private String fileName = null;
    private String originalFileName = null;
    private String contentType = null;
    private String path = null;
    private boolean inLineYn = false;
    private boolean isStream = false;
    private OutputStream stream = null;
    
    public boolean isStream() {
        return isStream;
    }
    
    public void setStream(FileOutputStream stream) {
        this.isStream = true;
        this.stream = stream;
    }
    
    public OutputStream getStream() {
        return this.stream;
    }
    
    public FileDownloadInfo() {        
    }
    
    public FileDownloadInfo(String path, String fileName, String orginFileName) {
        this.path = path;
        this.fileName = fileName;
        this.originalFileName = orginFileName;
        this.file = new File(path, fileName);
    }
    
    public String getFileName() {
        return fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public String getOriginalFileName() {
        return originalFileName;
    }
    
    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }
    
    public boolean isInLineYn() {
        return inLineYn;
    }
    
    public void setInLineYn(boolean inLineYn) {
        this.inLineYn = inLineYn;
    }
    
    public File getFile() {
        return file;
    }
    
    public void setFile(File file) {
        this.file = file;
    }
    
    public String getContentType() {
        return contentType;
    }
    
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
    
    public String getPath() {
        return path;
    }
    
    public void setPath(String path) {
        this.path = path;
    }
    
}
