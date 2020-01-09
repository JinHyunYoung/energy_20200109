package kr.or.wabis.dao.contents;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("introPageDao")
public class IntroPageDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectIntropagePageList(Map<String, Object> param) throws Exception {
        return selectPageList("IntroPageDao.selectIntropagePageList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectIntropageList(Map<String, Object> param) throws Exception {
        return selectList("IntroPageDao.selectIntropageList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectIntropage(Map<String, Object> param) throws Exception {
        return selectOne("IntroPageDao.selectIntropage", param);
    }
    
    /**
     * 중복검사를 한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectIntropageExist(Map<String, Object> param) throws Exception {
        return selectOne("IntroPageDao.selectIntropageExist", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertIntropage(Map<String, Object> param) throws Exception {
        return update("IntroPageDao.insertIntropage", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateIntropage(Map<String, Object> param) throws Exception {
        return update("IntroPageDao.updateIntropage", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteIntropage(Map<String, Object> param) throws Exception {
        return delete("IntroPageDao.deleteIntropage", param);
    }
    
    /**
     * group id를 수정한다.
     * @param param
     * @return
     * @throws Exception
     */
    public int updateGroupId(Map<String, Object> param) throws Exception {
        return update("IntroPageDao.updateGroupId", param);
    }
}
