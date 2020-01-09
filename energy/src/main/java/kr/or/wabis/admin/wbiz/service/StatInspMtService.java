package kr.or.wabis.admin.wbiz.service;

import java.util.List;
import java.util.Map;

public interface StatInspMtService { 
   
    
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectStatInspApplyPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectStatInspApplyPageListExcel(Map<String, Object> param) throws Exception;
	
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectStatInspApply(Map<String, Object> param) throws Exception;
    
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateStatInspApply(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteStatInspApply(Map<String, Object> param) throws Exception;    
   
   
}
