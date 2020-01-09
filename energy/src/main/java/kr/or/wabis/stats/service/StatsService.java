package kr.or.wabis.stats.service;

import java.util.Map;

public interface StatsService {
    
    /**
     * 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertHomepageconn(Map<String, Object> param) throws Exception;
    
    /**
     * 메뉴 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertMenuconn(Map<String, Object> param) throws Exception;
    
}
