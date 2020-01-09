package kr.or.wabis.admin.board.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.board.FaqDao;

@Service("faqMtService")
public class FaqMtServiceImpl implements FaqMtService {
    
    private Logger logger = Logger.getLogger(FaqMtServiceImpl.class);
    
    @Resource(name = "faqDao")
    protected FaqDao faqDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFaqPageList(Map<String, Object> param) throws Exception {
        return faqDao.selectFaqPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFaqList(Map<String, Object> param) throws Exception {
        return faqDao.selectFaqList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectFaq(Map<String, Object> param) throws Exception {
        return faqDao.selectFaq(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertFaq(Map<String, Object> param) throws Exception {
        return faqDao.insertFaq(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateFaq(Map<String, Object> param) throws Exception {
        return faqDao.updateFaq(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteFaq(Map<String, Object> param) throws Exception {
        return faqDao.deleteFaq(param);
    }
    
    /**
     * faq 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateFaqReorder(Map<String, Object> param) throws Exception {
        return faqDao.updateFaqReorder(param);
    }
}
