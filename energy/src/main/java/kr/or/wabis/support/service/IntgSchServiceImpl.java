package kr.or.wabis.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.DictionaryDao;
import kr.or.wabis.dao.support.IntgSchDao;
import kr.or.wabis.dao.support.OrganDao;
import kr.or.wabis.framework.util.StringUtil;

@Service("intgSchService")
public class IntgSchServiceImpl implements IntgSchService {
	
    private Logger logger = Logger.getLogger(IntgSchServiceImpl.class);
    
    @Resource(name = "intgSchDao")
    protected IntgSchDao intgSchDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectIntgSchPageList(Map<String, Object> param) throws Exception {
    	
    	if( ! StringUtil.nvl( param.get( "keyword" ) ).equals( "" ) ){
    		intgSchDao.insertIntgSchHistory(param);    		
    	}
    	
        return intgSchDao.selectIntgSchPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> searchIntgSchTop5(Map<String, Object> param) throws Exception {  
    	
        return intgSchDao.searchIntgSchHistoryTop5(param);
    }
    

}
