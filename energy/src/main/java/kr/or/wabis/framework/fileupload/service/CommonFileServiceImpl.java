package kr.or.wabis.framework.fileupload.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.common.CommonFileDao;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;

@Service("commonFileService")
public class CommonFileServiceImpl implements CommonFileService {
    
    Logger logger = LoggerFactory.getLogger(CommonFileServiceImpl.class);
    
    @Resource(name = "commonFileDao")
    private CommonFileDao commonFileDao;
    
    /**
     * 공통파일 정보를 반환해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public CommonFileVO getCommonFile(Map<String, Object> param) throws Exception {
        
        CommonFileVO data = commonFileDao.getCommonFile(param);
        
        return data;
    }
    
    /**
     * 공통파일 리스트를 반환해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<CommonFileVO> getCommonFileList(Map<String, Object> param) throws Exception {
        
        List<CommonFileVO> list = null;
        
        list = commonFileDao.getCommonFileList(param);
        
        return list;
    }
    
    /**
     * 공통파일을 등록 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int insertCommonFile(CommonFileVO param) throws Exception {
        
        int retVal = 0;
        
        retVal = commonFileDao.insertCommonFile(param);
        
        return retVal;
    }
    
    /**
     * 공통파일들을 등록 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int insertCommonFiles(List<CommonFileVO> list) throws Exception {
        
        int retVal = 0;
        
        CommonFileVO param = null;
        for (int i = 0; i < list.size(); i++) {
            param = list.get(i);
            retVal += commonFileDao.insertCommonFile(param);
        }
        
        return retVal;
    }
    
    /**
     * 공통파일을 수정 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int updateCommonFile(CommonFileVO param) throws Exception {
        
        int retVal = 0;
        
        retVal = commonFileDao.updateCommonFile(param);
        
        return retVal;
    }
    
    /**
     * 공통파일을 삭제 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int deleteCommonFile(String param) throws Exception {
        
        int retVal = 0;
        
        retVal = commonFileDao.deleteCommonFile(param);
        
        return retVal;
    }
    
    /**
     * 그룹의 모든 공통파일을 삭제 처리해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int deleteCommonFileAll(Map<String, Object> param) throws Exception {
        
        int retVal = 0;
        
        retVal = commonFileDao.deleteCommonFileAll(param);
        
        return retVal;
    }
    
    /**
     * 공통파일 페이지리스트를 반환해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Object> getCommonFilePageList(Map<String, Object> param) throws Exception {
        
        List<Object> list = null;
        
        list = (List<Object>) commonFileDao.getCommonFilePageList(param);
        
        return list;
    }
    
    /**
     * 공통파일 코드 리스트를 반환해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> getCommonFileCodeList(Map<String, Object> param) throws Exception {
        return commonFileDao.getCommonFileCodeList(param);
    }
    
    /**
     * 공통파일 순서조정 정보를 수정한다.
     * @param param
     * @return
     * @throws Exception
     */
    public int updateFileListReorder(Map<String, Object> param) throws Exception{
    	return commonFileDao.updateFileListReorder(param);
    }
    
}
