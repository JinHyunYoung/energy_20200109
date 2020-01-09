package kr.or.wabis.framework.fileupload.vo;

public class FileVO {
    
    // URL
    private String url;
    
    // 썸네일 경로
    private String thumbnailUrl;
    
    // 파일명
    private String name;
    
    // 파일타입
    private String type;
    
    // 파일 사이즈
    private long size;
    
    // 삭제 URL
    private String deleteUrl;
    
    // 삭제 타입
    private String deleteType;
    
    // 썸네일 파일명
    private String thumbnailFilename;
    
    // 신규 파일명
    private String newFilename;
    
    // 컨텐츠 타입
    private String contentType;
    
    // 파일명
    private String fieldName;
    
    // 그룹ID
    private String groupId;
    
    // 파일경로
    private String filePath;
    
    // 파일ID
    private String fileId;
    
    public String getUrl() {
        return url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
    
    public String getThumbnailUrl() {
        return thumbnailUrl;
    }
    
    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public long getSize() {
        return size;
    }
    
    public void setSize(long size) {
        this.size = size;
    }
    
    public String getDeleteUrl() {
        return deleteUrl;
    }
    
    public void setDeleteUrl(String deleteUrl) {
        this.deleteUrl = deleteUrl;
    }
    
    public String getDeleteType() {
        return deleteType;
    }
    
    public void setDeleteType(String deleteType) {
        this.deleteType = deleteType;
    }
    
    public String getThumbnailFilename() {
        return thumbnailFilename;
    }
    
    public void setThumbnailFilename(String thumbnailFilename) {
        this.thumbnailFilename = thumbnailFilename;
    }
    
    public String getNewFilename() {
        return newFilename;
    }
    
    public void setNewFilename(String newFilename) {
        this.newFilename = newFilename;
    }
    
    public String getContentType() {
        return contentType;
    }
    
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
    
    public String getFieldName() {
        return fieldName;
    }
    
    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }
    
    public String getGroupId() {
        return groupId;
    }
    
    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }
    
    public String getFileId() {
        return fileId;
    }
    
    public void setFileId(String fileId) {
        this.fileId = fileId;
    }
    
    public String getFilePath() {
        return filePath;
    }
    
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    
}
