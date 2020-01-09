package kr.or.wabis.board.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.board.FaqDao;

@Service("faqService")
public class FaqServiceImpl implements FaqService {
    
    private Logger logger = Logger.getLogger(FaqServiceImpl.class);
    
    @Resource(name = "faqDao")
    protected FaqDao faqDao;
    
    /**
     * FAQ를 조회한다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFaqList(Map<String, Object> param) throws Exception {
        return faqDao.selectFaqList(param);
    }
    
    /**
     * 게시판 메인 출력용 게시물
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectLoadMainFaq(Map<String, Object> param) throws Exception {
        return faqDao.selectLoadMainFaq(param);
    }
    
}
