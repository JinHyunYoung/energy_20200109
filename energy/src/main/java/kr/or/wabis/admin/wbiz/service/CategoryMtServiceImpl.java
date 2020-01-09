package kr.or.wabis.admin.wbiz.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.ScheduleDao;
import kr.or.wabis.dao.wbiz.CategoryDao;

@Service("categoryMtService")
public class CategoryMtServiceImpl implements CategoryMtService {
	
    private Logger logger = Logger.getLogger(CategoryMtServiceImpl.class);
    
    @Resource(name = "categoryDao")
    protected CategoryDao categoryDao;
    
   
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int categoryInsert(Map<String, Object> param) throws Exception {
        return categoryDao.categoryInsert(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int categoryUpdate(Map<String, Object> param) throws Exception {
        return categoryDao.categoryUpdate(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int categoryDelete(Map<String, Object> param) throws Exception {
        return categoryDao.categoryDelete(param);
    }
    
    /**
     * 값을 조회한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> categorySelectList(Map<String, Object> param) throws Exception {
        return categoryDao.categorySelectList(param);
    }
    
    /**
     * 값을 조회한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> categorySelect(Map<String, Object> param) throws Exception {
        return categoryDao.categorySelect(param);
    }
    
    /**
     * 값을 조회한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> categoryLoad(Map<String, Object> param) throws Exception {
        return categoryDao.categoryLoad(param);
    }
    

}
