package kr.or.wabis.dao.request;

import java.util.List;
import java.util.Map;

import kr.or.wabis.framework.dao.AbstractDao;

import org.springframework.stereotype.Repository;

@Repository("requestDao")
public class RequestDao extends AbstractDao {
    
     /**
     * 신문고를 등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertRequest(Map<String, Object> param) throws Exception {
        return update("RequestDao.insertRequest", param);
    }
    
	/**
     * 신문고 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectRequestPageList(Map<String, Object> param) throws Exception{
		return selectPageList("RequestDao.selectRequestPageList", param);
	}
	
	/**
     * 신문고 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectRequest(Map<String, Object> param) throws Exception{
		return select("RequestDao.selectRequest", param);
    }
	
    /**
     * 답변을 등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateRequestAnswer(Map<String, Object> param) throws Exception {
        return update("RequestDao.updateRequestAnswer", param);
    }
	 
    /**
     * 신문고를 삭제해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteRequest(Map<String, Object> param) throws Exception{
    	return update("RequestDao.deleteRequest", param);
    }
}
