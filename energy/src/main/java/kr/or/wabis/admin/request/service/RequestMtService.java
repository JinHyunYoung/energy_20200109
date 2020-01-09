package kr.or.wabis.admin.request.service;

import java.util.List;
import java.util.Map;

public interface RequestMtService {
	
	/**
     * 신문고 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectRequestPageList(Map<String, Object> param) throws Exception;

	/**
     * 신문고 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectRequest(Map<String, Object> param) throws Exception;
	 
    /**
     * 답변을 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateRequestAnswer(Map<String, Object> param) throws Exception;
	 
    /**
     * 신문고를 삭제해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteRequest(Map<String, Object> param) throws Exception;
    
}
