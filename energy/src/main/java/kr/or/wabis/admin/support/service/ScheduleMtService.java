package kr.or.wabis.admin.support.service;

import java.util.List;
import java.util.Map;

public interface ScheduleMtService {
	
	 /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectScheduleList(Map<String, Object> param) throws Exception;
	
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectSchedule(Map<String, Object> param) throws Exception;
    
	/**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertSchedule(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateSchedule(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteSchedule(Map<String, Object> param) throws Exception;
    
    /**
     * group id 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateGroupId(Map<String, Object> param) throws Exception ;
}
