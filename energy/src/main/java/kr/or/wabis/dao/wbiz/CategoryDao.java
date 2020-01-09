package kr.or.wabis.dao.wbiz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("categoryDao")
public class CategoryDao extends AbstractDao {
	
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int categoryInsert(Map<String, Object> param) throws Exception {
        return update("CategoryDao.categoryInsert", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int categoryUpdate(Map<String, Object> param) throws Exception {
    	
        int result = update("CategoryDao.categoryUpdate", param);
        update("CategoryDao.categoryUpdateChild", param);
        return result;
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int categoryDelete(Map<String, Object> param) throws Exception {
    	int result = update("CategoryDao.categoryDelete", param);
        update("CategoryDao.categoryDeleteChild", param);
        return result;
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> categorySelectList(Map<String, Object> param) throws Exception {
    	if( param.get( "language" ) != null && "en".equals( (String)param.get( "language" ) ) ){
    		return selectList("CategoryDao.categorySelectListEn", param);
    	}
    	
    	return selectList("CategoryDao.categorySelectList", param);
    	
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> categorySelect(Map<String, Object> param) throws Exception {
        return selectOne("CategoryDao.categorySelect", param);
    }
    
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> categoryLoad(Map<String, Object> param) throws Exception {
        return selectList("CategoryDao.categoryLoad", param);
    }
    
    
    

}
