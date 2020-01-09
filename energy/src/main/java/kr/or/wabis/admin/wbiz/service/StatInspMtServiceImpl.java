package kr.or.wabis.admin.wbiz.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.ScheduleDao;
import kr.or.wabis.dao.wbiz.CategoryDao;
import kr.or.wabis.dao.wbiz.StatInspDao;

@Service("statInspMtService")
public class StatInspMtServiceImpl implements StatInspMtService {
	
    private Logger logger = Logger.getLogger(StatInspMtServiceImpl.class);
    
    @Resource(name = "statInspDao")
    protected StatInspDao statInspDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectStatInspApplyPageList(Map<String, Object> param) throws Exception {
        return statInspDao.selectStatInspApplyPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectStatInspApplyPageListExcel(Map<String, Object> param) throws Exception {
        return statInspDao.selectStatInspApplyPageListExcel(param);
    }
        
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectStatInspApply(Map<String, Object> param) throws Exception {
        return statInspDao.selectStatInspApply(param);
    }

    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateStatInspApply(Map<String, Object> param) throws Exception {
        return statInspDao.updateStatInspApply(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteStatInspApply(Map<String, Object> param) throws Exception {
        return statInspDao.deleteStatInspApply(param);
    }
   
    
}
