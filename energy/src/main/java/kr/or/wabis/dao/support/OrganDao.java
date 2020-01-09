package kr.or.wabis.dao.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("organDao")
public class OrganDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectOrganPageList(Map<String, Object> param) throws Exception {
        return selectPageList("OrganDao.selectOrganPageList", param);
    }
	
	/**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectMainOrganList(Map<String, Object> param) throws Exception {
        return selectList("OrganDao.selectMainOrganList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectOrgan(Map<String, Object> param) throws Exception {
        return selectOne("OrganDao.selectOrgan", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertOrgan(Map<String, Object> param) throws Exception {
        return update("OrganDao.insertOrgan", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateOrgan(Map<String, Object> param) throws Exception {
        return update("OrganDao.updateOrgan", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteOrgan(Map<String, Object> param) throws Exception {      
        update("OrganDao.deleteOrganReorder", param);  
        return update("OrganDao.deleteOrgan", param);
    }
    
    /**
     * faq 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateOrganReorder(List<Map<String, Object>> list) throws Exception {
        for (Map<String, Object> param : list) {
            update("OrganDao.updateOrganSort", param);
        }        
        return list.size();
    }

}
