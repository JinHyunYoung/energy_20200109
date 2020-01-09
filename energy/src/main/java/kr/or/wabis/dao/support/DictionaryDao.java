package kr.or.wabis.dao.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("dictionaryDao")
public class DictionaryDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectDictionaryPageList(Map<String, Object> param) throws Exception {
        return selectPageList("DictionaryDao.selectDictionaryPageList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectPortalDictionaryPageList(Map<String, Object> param) throws Exception {
        return selectPageList("DictionaryDao.selectPortalDictionaryPageList", param);
    }
	
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectDictionary(Map<String, Object> param) throws Exception {
        return selectOne("DictionaryDao.selectDictionary", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertDictionary(Map<String, Object> param) throws Exception {
        return update("DictionaryDao.insertDictionary", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateDictionary(Map<String, Object> param) throws Exception {
        return update("DictionaryDao.updateDictionary", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteDictionary(Map<String, Object> param) throws Exception {
        return update("DictionaryDao.deleteDictionary", param);
    }
    
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> searchTermHistory(Map<String, Object> param) throws Exception {
        return selectOne("DictionaryDao.searchTermHistory", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> searchTermHistoryTop5(Map<String, Object> param) throws Exception {
        return selectPageList("DictionaryDao.searchTermHistoryTop5", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertTermHistory(Map<String, Object> param) throws Exception {
        return update("DictionaryDao.insertTermHistory", param);
    }

}
