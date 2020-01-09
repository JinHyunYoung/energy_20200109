package kr.or.wabis.admin.stats.service;

import java.util.List;
import java.util.Map;

public interface StatsInfoPageMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectStatsInfopagePageList(Map<String, Object> param) throws Exception;
    
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectStatsInfopage(Map<String, Object> param) throws Exception;
    
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertStatsInfopage(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateStatsInfopage(Map<String, Object> param) throws Exception;
    
    /**
     * 통계 해설 코드를 가져온다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteStatsInfopage(Map<String, Object> param) throws Exception;
    
    public List<Map<String, Object>>  selectStatsInfoCode(Map<String, Object> param) throws Exception;

    /**
     * 업로드된 통계의 연도별 내역을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>>  selectListExcelUpload(Map<String, Object> param) throws Exception;

}
