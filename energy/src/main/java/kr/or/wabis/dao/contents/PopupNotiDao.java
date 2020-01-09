package kr.or.wabis.dao.contents;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("popupNotiDao")
public class PopupNotiDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectPopnotiPageList(Map<String, Object> param) throws Exception {
        return selectPageList("PopupNotiDao.selectPopnotiPageList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectPopnotiList(Map<String, Object> param) throws Exception {
        return selectList("PopupNotiDao.selectPopnotiList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectPopnoti(Map<String, Object> param) throws Exception {
        return selectOne("PopupNotiDao.selectPopnoti", param);
    }
    
    /**
     * 중복검사를 한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectPopnotiExist(Map<String, Object> param) throws Exception {
        return selectOne("PopupNotiDao.selectPopnotiExist", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertPopnoti(Map<String, Object> param) throws Exception {
        return update("PopupNotiDao.insertPopnoti", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePopnoti(Map<String, Object> param) throws Exception {
        return update("PopupNotiDao.updatePopnoti", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deletePopnoti(Map<String, Object> param) throws Exception {
        return delete("PopupNotiDao.deletePopnoti", param);
    }
    
    /**
     * 메인페이지 팝업 리스트
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectMainPopnotiList(Map<String, Object> param) throws Exception {
        return selectList("PopupNotiDao.selectMainPopnotiList", param);
    }
}
