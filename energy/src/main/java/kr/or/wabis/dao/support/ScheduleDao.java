package kr.or.wabis.dao.support;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("scheduleDao")
public class ScheduleDao extends AbstractDao {
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectScheduleList(Map<String, Object> param) throws Exception {
        return selectList("ScheduleDao.selectScheduleList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectScheduleListMain(Map<String, Object> param) throws Exception {
        return selectList("ScheduleDao.selectScheduleListMain", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectSchedule(Map<String, Object> param) throws Exception {
        return selectOne("ScheduleDao.selectSchedule", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertSchedule(Map<String, Object> param) throws Exception {
        return insert("ScheduleDao.insertSchedule", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateSchedule(Map<String, Object> param) throws Exception {
        return update("ScheduleDao.updateSchedule", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteSchedule(Map<String, Object> param) throws Exception {        
        return update("ScheduleDao.deleteSchedule", param);
    }

    /**
     * group id를 수정한다.
     * @param param
     * @return
     * @throws Exception
     */
    public int updateGroupId(Map<String, Object> param) throws Exception {
        return update("ScheduleDao.updateGroupId", param);
    }

}
