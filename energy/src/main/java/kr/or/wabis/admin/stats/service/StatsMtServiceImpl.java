package kr.or.wabis.admin.stats.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.stats.StatsDao;

/**
 * @author P068995
 *
 */
@Service("statsMtService")
public class StatsMtServiceImpl implements StatsMtService {
    
    private final static Logger logger = Logger.getLogger(StatsMtServiceImpl.class);
    
    @Resource(name = "statsDao")
    protected StatsDao statsDao; 
    
    /**
     * 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertHomepageconn(Map<String, Object> param) throws Exception {
        return statsDao.insertHomepageconn(param);
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
        return statsDao.selectHomepageconnTotal(param);
    }
    
    /**
     * 시간대별 접속현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectHomepageconnHour(Map<String, Object> param) throws Exception {
        return statsDao.selectHomepageconnHour(param);
    }
    
    /**
     * 일별접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageconnDay(Map<String, Object> param) throws Exception {
        return statsDao.selectHomepageconnDay(param);
    }
    
    /**
     * 년별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageconnYear(Map<String, Object> param) throws Exception {
        return statsDao.selectHomepageconnYear(param);
    }
    
    /**
     * 메뉴 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertMenuconn(Map<String, Object> param) throws Exception {
        return statsDao.insertMenuconn(param);
    }
    
    /**
     * 메뉴 기간별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnPeriod(Map<String, Object> param) throws Exception {
        return statsDao.selectMenuconnPeriod(param);
    }
    
    /**
     * 메뉴 월별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnMonth(Map<String, Object> param) throws Exception {
        return statsDao.selectMenuconnMonth(param);
    }
    
    /**
     * 메뉴 일자별 접속 현황을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuconnDay(Map<String, Object> param) throws Exception {
        return statsDao.selectMenuconnDay(param);
    }
}
