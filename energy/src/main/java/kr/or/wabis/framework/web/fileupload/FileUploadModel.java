package kr.or.wabis.framework.web.fileupload;

import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.fileupload.FileItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadModel {
    private static final long serialVersionUID = 1L;
    
    private final Logger logger = LoggerFactory.getLogger(getClass());
    
    private MultipartFile multiPartFileItem = null;
    private FileItem fileItem = null;
    
    private String contentType = null;
    private String originalFileName = null;
    private String fileName = null;
    private String fieldName = null;
    private String guid = null;
    private String uploadStatus = null;
    private String type = null;
    private String lusn = null;
    private long fileSize = 0;
    private String grpId = null;
    private String extension = null;
    private String atchFileId = null;
    private String fileSn = null;
    private String fileStreCours = null;
    private int index = 0;
    
    private long imgHeight = 0;
    private long imgWidth = 0;
    
    public String getFileStreCours() {
        return fileStreCours;
    }
    
    public void setFileStreCours(String fileStreCours) {
        this.fileStreCours = fileStreCours;
    }
    
    public String getFileSn() {
        return fileSn;
    }
    
    public void setFileSn(String fileSn) {
        this.fileSn = fileSn;
    }
    
    public FileUploadModel() {
        
    }
    
    public FileUploadModel(MultipartFile fileItem) {
        
        if (fileItem != null) {
            
            this.fieldName = fileItem.getName();
            this.multiPartFileItem = fileItem;
            this.contentType = fileItem.getContentType();
            
            // ie 7이하는 name에 client path정보를 포함하고 있으므로 제거 함
            // String fileWithPath = fileItem.getName();
            // fileWithPath = StringUtils.cleanPath(fileWithPath);
            this.extension = getFileExtetion(fileItem.getOriginalFilename());
            this.fileName = getFileRename();
            this.originalFileName = fileItem.getOriginalFilename();
            this.fileSize = fileItem.getSize();
            
        }
    }
    
    public FileUploadModel(FileItem fileItem) {
        
        if (fileItem != null) {
            
            this.fieldName = fileItem.getFieldName();
            this.fileItem = fileItem;
            this.contentType = fileItem.getContentType();
            
            // ie 7이하는 name에 client path정보를 포함하고 있으므로 제거 함
            // String fileWithPath = fileItem.getName();
            // fileWithPath = StringUtils.cleanPath(fileWithPath);
            this.extension = getFileExtetion(fileItem.getName());
            this.fileName = getFileRename();
            this.originalFileName = this.fileName;
            this.fileSize = fileItem.getSize();
        }
    }
    
    /**
     * 파일 확자장명을 돌려준다
     * 
     * @param fileName
     * @return
     */
    public String getFileExtetion(String fileName) {
        
        String ret = "";
        
        if (multiPartFileItem != null || fileItem != null) {
            ret = fileName.substring(fileName.lastIndexOf(".") + 1);
        } else {
            ret = "";
        }
        return ret;
    }
    
    /**
     * 
     * @return
     */
    public String getFileRename() {
        
        String ret = "";
        if (multiPartFileItem != null || fileItem != null) {
            
            if (!"".equals(this.extension)) {
                ret = System.currentTimeMillis() + "." + this.extension;
            } else {
                ret = System.currentTimeMillis() + "";
            }
            
        } else {
            ret = "";
        }
        
        for (long i = 0; i < 10000000; i++) {
            i++;
        }
        return ret;
    }
    
    /**
     * 업로드시 필드명을 돌려 준다.
     * 
     * @return
     */
    public String getFieldName() {
        return fieldName;
    }
    
    /**
     * 파일명을 돌려준다.
     * 
     * @return
     */
    public String getFilename() {
        
        if (multiPartFileItem != null) {
            return this.fileName;
        } 
        
        else {
            return (fileItem != null) ? this.fileName : "";
        }
        
    }
    
    public InputStream getInputStream() throws IOException {
        
        if (fileItem != null) {
            return fileItem.getInputStream();
        } 
       
        else if (multiPartFileItem != null) {
            return multiPartFileItem.getInputStream();
        }
        
        else {
            return null;
        }
    }
    
    /**
     * 파일 사이즈를 돌려 준다.
     * 
     * @return
     */
    public long getSize() {
        
        if (multiPartFileItem != null) {
            return multiPartFileItem.getSize();
        } 
        
        else {
            return (fileItem != null) ? fileItem.getSize() : -1;
        }
    }
    
    /**
     * file의 mime type을 돌려 준다.
     * 
     * @return
     */
    public String getContentType() {
        return contentType;
    }
    
    /**
     * filePath에 파일을 저장 한다.(중복파일이 있으면 새로운 이름 생성 )
     * 
     * @param filePath
     * @return
     * @throws Exception
     */
    public String saveTo(String filePath) throws Exception {
        return this.saveAs(filePath, this.getFilename());
    }
    
    /**
     * 지정된 경로에 newFileName으로 저장 하고 저장된 파일명을 돌려 줌. (만약 같이 파일이 있으면 새로운 파일명으로 변경하여 저장됨)
     * 
     */
    public String saveAs(String filePath, String newFileName) throws Exception {
        
        return UploadedFileUtil.saveAs(this, filePath, newFileName, false);
    }
    
    /**
     * 원본 파일명을 돌려 줌(서버에 저장된 파일명은 getFileName() 사용!!!
     * 
     * @return
     */
    public String getOriginalFileName() {
        return originalFileName;
    }
    
    /**
     * 서버에 저장된 파일명으로 변경
     * 
     * @param newFileName
     */
    public void setNewFileName(String newFileName) {
        this.fileName = newFileName;
    }
        
    public String getGuid() {
        return guid;
    }
    
    public void setGuid(String guid) {
        this.guid = guid;
    }
    
    public String getUploadStatus() {
        return uploadStatus;
    }
    
    /**
     * I : 업로드중, O:업로드 완료
     * 
     * @param uploadStatus
     */
    public void setUploadStatus(String uploadStatus) {
        this.uploadStatus = uploadStatus;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public String getLusn() {
        return lusn;
    }
    
    public void setLusn(String lusn) {
        this.lusn = lusn;
    }
    
    public long getFileSize() {
        return fileSize;
    }
    
    public void setExtension(String extension) {
        this.extension = extension;
    }
    
    public String getExtension() {
        return extension;
    }
    
    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }
    
    public FileItem getFileItem() {
        return fileItem;
    }
    
    public void setFileItem(FileItem fileItem) {
        this.fileItem = fileItem;
    }
    
    public String getFileName() {
        return fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public String getGrpId() {
        return grpId;
    }
    
    public void setGrpId(String grpId) {
        this.grpId = grpId;
    }
    
    public String getAtchFileId() {
        return atchFileId;
    }
    
    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
    }
    
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
    
    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }
    
    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }
    
    public int getIndex() {
        return index;
    }
    
    public void setIndex(int index) {
        this.index = index;
    }
    
    public long getImgHeight() {
        return imgHeight;
    }
    
    public void setImgHeight(long imgHeight) {
        this.imgHeight = imgHeight;
    }
    
    public long getImgWidth() {
        return imgWidth;
    }
    
    public void setImgWidth(long ingWidth) {
        this.imgWidth = ingWidth;
    }
    
}
