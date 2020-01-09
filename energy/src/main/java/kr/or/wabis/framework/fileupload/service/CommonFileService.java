package kr.or.wabis.framework.fileupload.service;

import java.util.List;
import java.util.Map;

import kr.or.wabis.framework.fileupload.vo.CommonFileVO;

public interface CommonFileService {
    
    /**
     * 공통파일 정보를 반환해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public CommonFileVO getCommonFile(Map<String, Object> param) throws Exception;
    
    /**
     * 공통파일 리스트를 반환해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<CommonFileVO> getCommonFileList(Map<String, Object> param) throws Exception;
    
    /**
     * 공통파일을 등록 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int insertCommonFile(CommonFileVO commonFileVO) throws Exception;
    
    /**
     * 공통파일들을 등록 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int insertCommonFiles(List<CommonFileVO> list) throws Exception;
    
    /**
     * 공통파일을 수정 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int updateCommonFile(CommonFileVO commonFileVO) throws Exception;
    
    /**
     * 공통파일을 삭제 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int deleteCommonFile(String file_id) throws Exception;
    
    /**
     * 그룹의 모든 공통파일을 삭제 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int deleteCommonFileAll(Map<String, Object> param) throws Exception;
    
    /**
     * 공통파일 페이지리스트를 반환해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Object> getCommonFilePageList(Map<String, Object> param) throws Exception;
    
    /**
     * 공통파일 코드 리스트를 반환해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> getCommonFileCodeList(Map<String, Object> param) throws Exception;
    
    /**
     * 공통파일 순서조정 정보를 수정한다.
     * @param param
     * @return
     * @throws Exception
     */
    public int updateFileListReorder(Map<String, Object> param) throws Exception;
}
