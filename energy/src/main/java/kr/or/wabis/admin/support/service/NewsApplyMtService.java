package kr.or.wabis.admin.support.service;

import java.util.List;
import java.util.Map;

public interface NewsApplyMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectNewsApplyPageList(Map<String, Object> param) throws Exception;
	
  
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteNewApply(String param) throws Exception;    
   

}
