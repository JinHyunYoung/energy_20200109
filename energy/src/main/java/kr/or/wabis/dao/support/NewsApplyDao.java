package kr.or.wabis.dao.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("newsApplyDao")
public class NewsApplyDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectNewsApplyPageList(Map<String, Object> param) throws Exception {
        return selectPageList("NewsApplyDao.selectNewsApplyPageList", param);
    }
    
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectNewsApply(Map<String, Object> param) throws Exception {
        return selectOne("NewsApplyDao.selectNewsApply", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertNewsApply(Map<String, Object> param) throws Exception {
        return update("NewsApplyDao.insertNewsApply", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateNewsApply(Map<String, Object> param) throws Exception {
        return update("NewsApplyDao.updateNewsApply", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteNewApply(String param) throws Exception {
    	
        return update("NewsApplyDao.deleteNewApply", param);
    }
    

}
