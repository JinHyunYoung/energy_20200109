package kr.or.wabis.request.service;

import java.util.Map;

public interface RequestService {

    /**
     * 지원신청을 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertRequest(Map<String, Object> param) throws Exception;
	
}
