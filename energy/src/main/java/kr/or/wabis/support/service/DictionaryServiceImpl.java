package kr.or.wabis.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.DictionaryDao;
import kr.or.wabis.dao.support.OrganDao;
import kr.or.wabis.framework.util.StringUtil;

@Service("dictionaryService")
public class DictionaryServiceImpl implements DictionaryService {
	
    private Logger logger = Logger.getLogger(DictionaryServiceImpl.class);
    
    @Resource(name = "dictionaryDao")
    protected DictionaryDao dictionaryDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectPortalDictionaryPageList(Map<String, Object> param) throws Exception {
    	
    	if( ! StringUtil.nvl( param.get( "dic_keyword" ) ).equals( "" ) ){
    		Map<String, Object> term = dictionaryDao.searchTermHistory(param);
    		if( term != null && ! term.isEmpty() ){
    			term.put( "term_kr_nm" , param.get( "dic_keyword" ) );
    			dictionaryDao.insertTermHistory(term);
    		}
    	}
    	
        return dictionaryDao.selectPortalDictionaryPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> searchTermHistoryTop5(Map<String, Object> param) throws Exception {  
    	
        return dictionaryDao.searchTermHistoryTop5(param);
    }
    

}
