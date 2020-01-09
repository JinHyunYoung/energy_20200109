package kr.or.wabis.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.ScheduleDao;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {
	
    private Logger logger = Logger.getLogger(ScheduleServiceImpl.class);
    
    @Resource(name = "scheduleDao")
    protected ScheduleDao scheduleDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectScheduleList(Map<String, Object> param) throws Exception {
        return scheduleDao.selectScheduleList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectScheduleListMain(Map<String, Object> param) throws Exception {
        return scheduleDao.selectScheduleListMain(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectSchedule(Map<String, Object> param) throws Exception {
        return scheduleDao.selectSchedule(param);
    }    
    

}
