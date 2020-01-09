package kr.or.wabis.framework.fileupload.vo;

import org.apache.ibatis.type.Alias;

import kr.or.wabis.framework.vo.BaseVO;

@Alias("CommonFileVO")
public class CommonFileVO extends BaseVO {
    
    // 파일 ID
    private String file_id;
    
    // 파일명
    private String file_nm;
    
    // 파일타입
    private String file_type;
    
    // 파일 사이즈
    private long file_size;
    
    // 원본 파일명
    private String origin_file_nm;
    
    // 그룹 ID
    private String group_id;
    
    // 파일 경로
    private String file_path;
    
    // 파일 제목
    private String file_title;
    
    // 순서
    private long sort;
    
    // 사용여부
    private String use_yn;
    
    // 사용자번호
    private String s_user_no;
    
    public String getFile_id() {
        return file_id;
    }
    
    public void setFile_id(String file_id) {
        this.file_id = file_id;
    }
    
    public String getFile_nm() {
        return file_nm;
    }
    
    public void setFile_nm(String file_nm) {
        this.file_nm = file_nm;
    }
    
    public String getFile_type() {
        return file_type;
    }
    
    public void setFile_type(String file_type) {
        this.file_type = file_type;
    }
    
    public long getFile_size() {
        return file_size;
    }
    
    public void setFile_size(long file_size) {
        this.file_size = file_size;
    }
    
    public String getOrigin_file_nm() {
        return origin_file_nm;
    }
    
    public void setOrigin_file_nm(String origin_file_nm) {
        this.origin_file_nm = origin_file_nm;
    }
    
    public String getGroup_id() {
        return group_id;
    }
    
    public void setGroup_id(String group_id) {
        this.group_id = group_id;
    }
    
    public String getFile_path() {
        return file_path;
    }
    
    public void setFile_path(String file_path) {
        this.file_path = file_path;
    }
    
    public String getUse_yn() {
        return use_yn;
    }
    
    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }
    
    public String getS_user_no() {
        return s_user_no;
    }
    
    public void setS_user_no(String s_user_id) {
        this.s_user_no = s_user_id;
    }

    public String getFile_title() {
        return file_title;
    }

    public void setFile_title(String file_title) {
        this.file_title = file_title;
    }

    public long getSort() {
        return sort;
    }

    public void setSort(long sort) {
        this.sort = sort;
    }  
    
    
    // ===================================================================
    // Mybatis에서 컬럼명을 자동을 자동 카멜 표기법으로 표시하기 위해 아래의 내용을 추가함
    // ===================================================================
    
    
    public String getFileId() {
        return file_id;
    }
    
    public void setFileId(String file_id) {
        this.file_id = file_id;
    }
    
    public String getFileNm() {
        return file_nm;
    }
    
    public void setFileNm(String file_nm) {
        this.file_nm = file_nm;
    }
    
    public String getFileType() {
        return file_type;
    }
    
    public void setFileType(String file_type) {
        this.file_type = file_type;
    }
    
    public long getFileSize() {
        return file_size;
    }
    
    public void setFileSize(long file_size) {
        this.file_size = file_size;
    }
    
    public String getOriginFileNm() {
        return origin_file_nm;
    }
    
    public void setOriginFileNm(String origin_file_nm) {
        this.origin_file_nm = origin_file_nm;
    }
    
    public String getGroupId() {
        return group_id;
    }
    
    public void setGroupId(String group_id) {
        this.group_id = group_id;
    }
    
    public String getFilePath() {
        return file_path;
    }
    
    public void setFilePath(String file_path) {
        this.file_path = file_path;
    }
    
    public String getUseYn() {
        return use_yn;
    }
    
    public void setUseYn(String useYn) {
        this.use_yn = useYn;
    }
    
    public String getSUserNo() {
        return s_user_no;
    }
    
    public void setSUserNo(String s_user_no) {
        this.s_user_no = s_user_no;
    }

    public String getFileTitle() {
        return file_title;
    }

    public void setFileTitle(String file_title) {
        this.file_title = file_title;
    }

}
