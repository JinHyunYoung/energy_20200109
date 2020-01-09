package kr.or.wabis.admin.stats.service;

import java.util.List;
import java.util.Map;

public interface StatsMtService {
    
    /**
     * 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertHomepageconn(Map<String, Object> param) throws Exception;
    
    /**
     * 접속현황 통계를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectHomepageconnTotal(Map<String, Object> param) throws Exception;
    
    /**
     * 시간대별 접속현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectHomepageconnHour(Map<String, Object> param) throws Exception;
    
    /**
     * 일별접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageconnDay(Map<String, Object> param) throws Exception;
    
    /**
     * 년별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageconnYear(Map<String, Object> param) throws Exception;
    
    
    /**
     * 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertMenuconn(Map<String, Object> param) throws Exception;
    
    /**
     * 메뉴 기간별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnPeriod(Map<String, Object> param) throws Exception;
    
    /**
     * 메뉴 월별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnMonth(Map<String, Object> param) throws Exception;
    
    /**
     * 메뉴 일자별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnDay(Map<String, Object> param) throws Exception;
    
}
