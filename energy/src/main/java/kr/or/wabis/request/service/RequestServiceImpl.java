package kr.or.wabis.request.service;

import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.dao.request.RequestDao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service("requestService")
public class RequestServiceImpl implements RequestService {
	
    private Logger logger = Logger.getLogger(RequestServiceImpl.class);
    
    @Resource(name = "requestDao")
    protected RequestDao requestDao;
    
    /**
     * 신문고를 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertRequest(Map<String, Object> param) throws Exception {
        return requestDao.insertRequest(param);
    }

}
