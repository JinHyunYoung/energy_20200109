package kr.or.wabis.admin.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.ScheduleDao;

@Service("scheduleMtService")
public class ScheduleMtServiceImpl implements ScheduleMtService {
	
    private Logger logger = Logger.getLogger(ScheduleMtServiceImpl.class);
    
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
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectSchedule(Map<String, Object> param) throws Exception {
        return scheduleDao.selectSchedule(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertSchedule(Map<String, Object> param) throws Exception {
        return scheduleDao.insertSchedule(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateSchedule(Map<String, Object> param) throws Exception {
        return scheduleDao.updateSchedule(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteSchedule(Map<String, Object> param) throws Exception {
        return scheduleDao.deleteSchedule(param);
    }

    /**
     * group id 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateGroupId(Map<String, Object> param) throws Exception {
        return scheduleDao.updateGroupId(param);
    }}
