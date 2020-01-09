package kr.or.wabis.dao.stats;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.user.vo.UserVO;

@Repository("statsDao")
public class StatsDao extends AbstractDao {
    
    /**
     * 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertHomepageconn(Map<String, Object> param) throws Exception {
        return update("StatsDao.insertHomepageconn", param);
    }
    
    /**
     * 오늘 방문 접속자
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int selectTodayConn(Map<String, Object> param) throws Exception {
        return selectOne("StatsDao.selectTodayConn", param);
    }
    
    /**
     * 접속현황 통계를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectHomepageconnTotal(Map<String, Object> param) throws Exception {
        return selectOne("StatsDao.selectHomepageconnTotal", param);
    }
    
    /**
     * 시간대별 접속현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectHomepageconnHour(Map<String, Object> param) throws Exception {
        return selectOne("StatsDao.selectHomepageconnHour", param);
    }
    
    /**
     * 일별접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageconnDay(Map<String, Object> param) throws Exception {
        return selectList("StatsDao.selectHomepageconnDay", param);
    }
    
    /**
     * 년별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageconnYear(Map<String, Object> param) throws Exception {
        return selectList("StatsDao.selectHomepageconnYear", param);
    }   
    
    /**
     * 메뉴 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertMenuconn(Map<String, Object> param) throws Exception {
        return update("StatsDao.insertMenuconn", param);
    }
    
    /**
     * 메뉴 기간별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnPeriod(Map<String, Object> param) throws Exception {
        return selectList("StatsDao.selectMenuconnPeriod", param);
    }   
    
    /**
     * 메뉴 월별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnMonth(Map<String, Object> param) throws Exception {
        return selectList("StatsDao.selectMenuconnMonth", param);
    }   
    
    /**
     * 메뉴 일자별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnDay(Map<String, Object> param) throws Exception {
        return selectList("StatsDao.selectMenuconnDay", param);
    }   
}