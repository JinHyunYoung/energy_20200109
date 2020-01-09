package kr.or.wabis.admin.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.DictionaryDao;
import kr.or.wabis.dao.support.NewsApplyDao;


@Service("newsApplyMtService")
public class NewsApplyMtServiceImpl implements NewsApplyMtService {
	
    private Logger logger = Logger.getLogger(NewsApplyMtServiceImpl.class);
    
    @Resource(name = "newsApplyDao")
    protected NewsApplyDao newsApplyDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectNewsApplyPageList(Map<String, Object> param) throws Exception {
        return newsApplyDao.selectNewsApplyPageList(param);
    }
        
     /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteNewApply(String  param) throws Exception {
        int result = newsApplyDao.deleteNewApply(param);
   		return 1;
    }
    


}
