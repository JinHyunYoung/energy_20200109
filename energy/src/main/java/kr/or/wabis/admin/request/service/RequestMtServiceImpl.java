package kr.or.wabis.admin.request.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.dao.request.RequestDao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service("requestMtService")
public class RequestMtServiceImpl implements RequestMtService {
	
    private Logger logger = Logger.getLogger(RequestMtServiceImpl.class);
    
    @Resource(name = "requestDao")
    protected RequestDao requestDao;
    
	/**
     * 신문고 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectRequestPageList(Map<String, Object> param) throws Exception{
		 return requestDao.selectRequestPageList(param);
	}
	
	/**
     * 신문고 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectRequest(Map<String, Object> param) throws Exception{
		return requestDao.selectRequest(param);
	}
	
    /**
     * 답변을 등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateRequestAnswer(Map<String, Object> param) throws Exception {
        return requestDao.updateRequestAnswer(param);
    }
	 
    /**
     * 신문고를 삭제해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteRequest(Map<String, Object> param) throws Exception{
    	return requestDao.deleteRequest(param);
    }
}
