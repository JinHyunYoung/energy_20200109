package kr.or.wabis.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.DictionaryDao;
import kr.or.wabis.dao.support.NewsApplyDao;
import kr.or.wabis.dao.support.OrganDao;
import kr.or.wabis.framework.util.StringUtil;

@Service("newsApplyService")
public class NewsApplyServiceImpl implements NewsApplyService {
	
    private Logger logger = Logger.getLogger(NewsApplyServiceImpl.class);
    
    @Resource(name = "newsApplyDao")
    protected NewsApplyDao newsApplyDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int updateNewsApply(Map<String, Object> param) throws Exception {
    	
    	
    	Map<String, Object> newsApply = newsApplyDao.selectNewsApply(param);
    	String app_stt_cd_now = (String)param.get( "app_stt_cd" );
    	String app_stt_cd_past = "N"; 
    	boolean exist = false;
    	boolean sameName = false;
    	
    	// 신청데이터가 있는 경우
    	if( newsApply != null && ! newsApply.isEmpty() ){
    		
    		if( newsApply.get( "name" ).equals( param.get( "name" ) ) ){
    			sameName = true;
    		}
    		exist = true;
    		app_stt_cd_past = (String)newsApply.get( "app_stt_cd" );
    	}
    	
    	// 이미 신청한 이메일을 다시 신청한 경우   	
    	if( exist && "Y".equals( app_stt_cd_past ) &&  "Y".equals( app_stt_cd_now ) ){
    		//뉴스레터를 이미 신청한 이메일입니다.
    		return 1;
    	// 이미 신청한 이메일이 해지 상태인데 다시 신청한 경우
    	}else if( exist && "N".equals( app_stt_cd_past ) &&  "Y".equals( app_stt_cd_now ) ){
    		param.put( "app_sn" , newsApply.get( "app_sn" ) );
    		newsApplyDao.updateNewsApply(param);
    		//해당 이메일은 뉴스레터가 해지된 이메일입니다. 다시 구독신청되었습니다.
    		return 2;
   		// 이미 신청한 이메일을 해지신청하는 경우 (이름이 틀림 )
    	}else if( exist && "Y".equals( app_stt_cd_past ) &&  "N".equals( app_stt_cd_now ) && ! sameName ){    		
    		//신청시 입력하신 이름이 정확하지 않습니다.
    		return 3;
    	// 이미 신청한 이메일을 해지신청하는 경우 (이름이 같음 )
    	}else if( exist && "Y".equals( app_stt_cd_past ) &&  "N".equals( app_stt_cd_now ) && sameName ){   
    		param.put( "app_sn" , newsApply.get( "app_sn" ) );
    		newsApplyDao.updateNewsApply(param);
    		//해당 이메일의 뉴스레터 구독이 해지되었습니다.
    		return 4;
    	// 해지 신청을 하였는데, 뉴스레터 신청 정보가 없을 경우	
    	}else if( ! exist && "N".equals( app_stt_cd_now ) ){
    		//뉴스레터 구독 신청을 하지 않은 이메일입니다.
    		return 5;
    	}else if( exist && "N".equals( app_stt_cd_past ) &&  "N".equals( app_stt_cd_now ) ){
    		//이미 뉴스레터 구독이 해지된 이메일입니다.
    		return 6;
    	// 뉴스레터 구독신청 완료	
    	}else if( "Y".equals( app_stt_cd_now ) ){
    		newsApplyDao.insertNewsApply(param);
    		// 뉴스레터 구독신청이 완료되었습니다.
    		return 7;
    	}
    	
    	return 0;
        
    }
    
    
    

}
