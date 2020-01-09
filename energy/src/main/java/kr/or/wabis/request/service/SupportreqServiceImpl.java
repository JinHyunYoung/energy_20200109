package kr.or.wabis.request.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.dao.support.SupportreqDao;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service("supportreqService")
public class SupportreqServiceImpl implements SupportreqService {
	
    private Logger logger = Logger.getLogger(SupportreqServiceImpl.class);
    
    @Resource(name = "supportreqDao")
    protected SupportreqDao supportreqDao;
    
    /**
     * 지원신청을 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertSupportreq(Map<String, Object> param) throws Exception {
        return supportreqDao.insertSupportreq(param);
    }

}
