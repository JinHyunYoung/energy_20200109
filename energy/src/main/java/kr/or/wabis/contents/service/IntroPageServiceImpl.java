package kr.or.wabis.contents.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.IntroPageDao;

@Service("introPageService")
public class IntroPageServiceImpl implements IntroPageService {
    
    private Logger logger = Logger.getLogger(IntroPageServiceImpl.class);
    
    @Resource(name = "introPageDao")
    protected IntroPageDao introPageDao;
        
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectIntropage(Map<String, Object> param) throws Exception {
        return introPageDao.selectIntropage(param);
    }
}
