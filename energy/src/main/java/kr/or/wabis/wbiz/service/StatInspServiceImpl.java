package kr.or.wabis.wbiz.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.OrganDao;
import kr.or.wabis.dao.wbiz.CategoryDao;
import kr.or.wabis.dao.wbiz.StatInspDao;

@Service("statInspService")
public class StatInspServiceImpl implements StatInspService {
	
    private Logger logger = Logger.getLogger(StatInspServiceImpl.class);
    
    @Resource(name = "statInspDao")
    protected StatInspDao statInspDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int insertStatInspApply(Map<String, Object> param) throws Exception {    	
    	
    	Map<String, Object> statInspApply = statInspDao.selectStatInspApply(param);
      	
    	// 신청데이터가 있는 경우
    	if( statInspApply != null && ! statInspApply.isEmpty() ){
    		return 0;    		
    	}else{
    		statInspDao.insertStatInspApply( param );
    		return 1;
    	}
        
    }   

}
