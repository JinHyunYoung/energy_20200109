package kr.or.wabis.contents.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.InfoPageDao;

@Service("infoPageService")
public class InfoPageServiceImpl implements InfoPageService {
    
    private Logger logger = Logger.getLogger(InfoPageServiceImpl.class);
    
    @Resource(name = "infoPageDao")
    protected InfoPageDao infoPageDao;
    
	/**
	 * 선택된 행의 값을 가지고 온다
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectInfopage(Map<String, Object> param) throws Exception {
	    return infoPageDao.selectInfopage(param);
	}
        
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectInfopageShow(Map<String, Object> param) throws Exception {
        return infoPageDao.selectInfopageShow(param);
    }
}
