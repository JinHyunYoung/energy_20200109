package kr.or.wabis.dao.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("faqDao")
public class FaqDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectFaqPageList(Map<String, Object> param) throws Exception {
        return selectPageList("FaqDao.selectFaqPageList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectFaqList(Map<String, Object> param) throws Exception {
        return selectList("FaqDao.selectFaqList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectFaq(Map<String, Object> param) throws Exception {
        return selectOne("FaqDao.selectFaq", param);
    }
    
    /**
     * 중복검사를 한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectFaqExist(Map<String, Object> param) throws Exception {
        return selectOne("FaqDao.selectFaqExist", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertFaq(Map<String, Object> param) throws Exception {
        return update("FaqDao.insertFaq", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateFaq(Map<String, Object> param) throws Exception {
        return update("FaqDao.updateFaq", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteFaq(Map<String, Object> param) throws Exception {
        update("FaqDao.deleteFaqReorder", param);
        return delete("FaqDao.deleteFaq", param);
    }
    
    /**
     * faq 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateFaqReorder(Map<String, Object> param) throws Exception {
        List<Map<String, Object>> list = (List<Map<String, Object>>) param.get("faq_list");
        Map<String, Object> data = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            data.put("faq_id", list.get(i).get("faq_id"));
            data.put("sort", list.get(i).get("sort"));
            update("FaqDao.updateFaqSort", data);
        }
        
        return list.size();
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectLoadMainFaq(Map<String, Object> param) throws Exception {
        return selectList("FaqDao.selectLoadMainFaq", param);
    }
}