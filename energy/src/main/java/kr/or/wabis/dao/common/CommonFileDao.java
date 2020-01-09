package kr.or.wabis.dao.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;

@Repository("commonFileDao")
public class CommonFileDao extends AbstractDao {
    
    public CommonFileVO getCommonFile(Map<String, Object> param) throws Exception {
        CommonFileVO data = (CommonFileVO) selectOne("getCommonFile", param);
        
        return data;
    }
    
    public List<CommonFileVO> getCommonFileList(Map<String, Object> param) throws Exception {
        List<CommonFileVO> list = null;
        
        list = selectList("CommonFileDao.getCommonFileList", param);
        
        return list;
    }
    
    public int insertCommonFile(CommonFileVO param) throws Exception {
        int retVal = 0;
        
        retVal = update("CommonFileDao.insertCommonFile", param);
        
        return retVal;
    }
    
    public int updateCommonFile(CommonFileVO param) throws Exception {
        int retVal = 0;
        
        retVal = update("CommonFileDao.updateCommonFile", param);
        
        return retVal;
    }
    
    public int deleteCommonFile(String param) throws Exception {
        int retVal = 0;
        
        retVal = delete("CommonFileDao.deleteCommonFile", param);
        
        return retVal;
    }
    
    public int deleteCommonFileAll(Map<String, Object> param) throws Exception {
        int retVal = 0;
        
        retVal = delete("CommonFileDao.deleteCommonFileAll", param);
        
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
        
        list = (List<Object>) selectList("CommonFileDao.getCommonFilePageList", param);
        
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
        return selectList("CommonFileDao.getCommonFileCodeList", param);
    }
    
    /**
     * 공통파일 순서조정 정보를 수정한다.
     * @param param
     * @return
     * @throws Exception
     */
    public int updateFileListReorder(Map<String, Object> param) throws Exception {
    	List<Map<String, Object>> list = (List<Map<String, Object>>) param.get("file_list");
    	
    	Map<String, Object> data = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            data.put("file_id", list.get(i).get("file_id"));
            data.put("sort", list.get(i).get("sort"));
            update("CommonFileDao.updateFileListSort", data);
        }
        return list.size();
    }
}
