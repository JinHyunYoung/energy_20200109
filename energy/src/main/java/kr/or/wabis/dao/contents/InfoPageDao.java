package kr.or.wabis.dao.contents;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("infoPageDao")
public class InfoPageDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectInfopagePageList(Map<String, Object> param) throws Exception {
        return selectPageList("InfoPageDao.selectInfopagePageList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectInfopage(Map<String, Object> param) throws Exception {
        return selectOne("InfoPageDao.selectInfopage", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectInfopageShow(Map<String, Object> param) throws Exception {
        return selectOne("InfoPageDao.selectInfopageShow", param);
    }
            
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertInfopage(Map<String, Object> param) throws Exception {
        return update("InfoPageDao.insertInfopage", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateInfopage(Map<String, Object> param) throws Exception {
        return update("InfoPageDao.updateInfopage", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteInfopage(Map<String, Object> param) throws Exception {
        return delete("InfoPageDao.deleteInfopage", param);
    }
    
}
