package kr.or.wabis.stats.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.stats.StatsDao;

/**
 * @author P068995
 *
 */
@Service("statsService")
public class StatsServiceImpl implements StatsService {
    
    private final static Logger logger = Logger.getLogger(StatsServiceImpl.class);
    
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
     * 메뉴 접속 처리
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertMenuconn(Map<String, Object> param) throws Exception {
        return statsDao.insertMenuconn(param);
    }    
}
