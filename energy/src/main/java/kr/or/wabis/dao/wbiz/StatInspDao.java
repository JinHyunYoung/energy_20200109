package kr.or.wabis.dao.wbiz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("statInspDao")
public class StatInspDao extends AbstractDao {
	
	 /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertStatInspApply(Map<String, Object> param) throws Exception {
        return update("StatInspDao.statInspApplyInsert", param);
    }
    
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectStatInspApply(Map<String, Object> param) throws Exception {
        return selectOne("StatInspDao.statInspApplySelect", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectStatInspApplyPageList(Map<String, Object> param) throws Exception {
        return selectPageList("StatInspDao.selectStatInspApplyPageList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectStatInspApplyPageListExcel(Map<String, Object> param) throws Exception {
        return selectPageList("StatInspDao.selectStatInspApplyPageListExcel", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateStatInspApply(Map<String, Object> param) throws Exception {
        return update("StatInspDao.statInspApplyUpdate", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteStatInspApply(Map<String, Object> param) throws Exception {
        return update("StatInspDao.statInspApplyDelete", param);
    }

}
