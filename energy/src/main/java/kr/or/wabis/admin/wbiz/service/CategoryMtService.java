package kr.or.wabis.admin.wbiz.service;

import java.util.List;
import java.util.Map;

public interface CategoryMtService {
	
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int categoryInsert(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int categoryUpdate(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int categoryDelete(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> categorySelectList(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> categorySelect(Map<String, Object> param) throws Exception;
	
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> categoryLoad(Map<String, Object> param) throws Exception;
    
    
   
}
