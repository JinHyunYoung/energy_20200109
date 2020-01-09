package kr.or.wabis.admin.support.service;

import java.util.List;
import java.util.Map;

public interface OrganMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectOrganPageList(Map<String, Object> param) throws Exception;
	
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOrgan(Map<String, Object> param) throws Exception;
    
	/**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertOrgan(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateOrgan(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteOrgan(Map<String, Object> param) throws Exception;
    
    /**
     * 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateOrganReorder(List<Map<String, Object>> list) throws Exception;

}
