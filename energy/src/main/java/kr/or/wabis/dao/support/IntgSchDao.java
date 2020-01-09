package kr.or.wabis.dao.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("intgSchDao")
public class IntgSchDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectIntgSchPageList(Map<String, Object> param) throws Exception {
        return selectPageList("IntgSchDao.selectIntgSchPageList", param);
    }
    
    
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertIntgSchHistory(Map<String, Object> param) throws Exception {
        return update("IntgSchDao.insertIntgSchHistory", param);
    }
    
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> searchIntgSchHistoryTop5(Map<String, Object> param) throws Exception {
        return selectPageList("IntgSchDao.searchIntgSchHistoryTop5", param);
    }
    


}
