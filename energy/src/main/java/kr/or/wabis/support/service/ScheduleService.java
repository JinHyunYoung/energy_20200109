package kr.or.wabis.support.service;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
	
	 /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectScheduleList(Map<String, Object> param) throws Exception;
    
    /**
    * 
    * @param param
    * @return
    * @throws Exception
    */
   public List<Map<String, Object>> selectScheduleListMain(Map<String, Object> param) throws Exception;
	
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectSchedule(Map<String, Object> param) throws Exception;    
	

}
