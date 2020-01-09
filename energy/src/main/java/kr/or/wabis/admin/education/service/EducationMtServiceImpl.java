package kr.or.wabis.admin.education.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.dao.education.EducationDao;
import kr.or.wabis.framework.util.StringUtil;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service("educationMtService")
public class EducationMtServiceImpl implements EducationMtService {
	
    private Logger logger = Logger.getLogger(EducationMtServiceImpl.class);
    
    @Resource(name = "educationDao")
    protected EducationDao educationDao;
    
	/**
     * 교육신청 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEducationApplyPageList(Map<String, Object> param) throws Exception{
		 return educationDao.selectEducationApplyPageList(param);
	}
	
	/**
     * 교육신청 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectEducationApply(Map<String, Object> param) throws Exception{
		return educationDao.selectEducationApply(param);
	}
    
    /**
     * 교육신청을 등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEducationApply(Map<String, Object> param) throws Exception {
        return educationDao.insertEducationApply(param);
    }
    
	/**
     * 지원신청을 수정해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateEducationApply(Map<String, Object> param) throws Exception{
    	return educationDao.updateEducationApply(param);
    }
    
	/**
     * 지원신청을 삭제해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteEducationApply(Map<String, Object> param) throws Exception{
    	return educationDao.deleteEducationApply(param);
    }
    
	 /**
	  * 교육신청을 수강승인해준다.
	  * 
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int approvalEducationApply(Map<String, Object> param) throws Exception {
			int rt = 0;
			Map data = new HashMap();
			data.put("apply_status", StringUtil.nvl(param.get("result")).equals("F")?"N":"Y");
			data.put("apply_reject_reason", StringUtil.nvl(param.get("fail_reason")));
			List<Map<String, Object>> aplyList = (ArrayList)param.get("aply_list");
			Map aply = null;
			for(int i = 0; i < aplyList.size();i++){
				aply = aplyList.get(i);
				data.put("seq_id", aply.get("seq_id"));
				data.put("user_ci", aply.get("user_ci"));
				educationDao.approvalEducationApply(data);
				
				rt++;
			}
			
		    return rt;
	 }
		
	 /**
	  * 교육신청을 합격승인해준다.
	  * 
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int passEducationApply(Map<String, Object> param) throws Exception{
			int rt = 0;
			Map data = new HashMap();
			data.put("pass_status", StringUtil.nvl(param.get("result")).equals("F")?"N":"Y");
			data.put("pass_reject_reason", StringUtil.nvl(param.get("fail_reason")));
			List<Map<String, Object>> aplyList = (ArrayList)param.get("aply_list");
			Map aply = null;
			for(int i = 0; i < aplyList.size();i++){
				aply = aplyList.get(i);
				data.put("seq_id", aply.get("seq_id"));
				data.put("user_ci", aply.get("user_ci"));
				educationDao.passEducationApply(data);
				
				rt++;
			}
			
		    return rt;
	 }
	 
	/**
     * 자격검증 운영 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEduseqPageList(Map<String, Object> param) throws Exception {
        return educationDao.selectEduseqPageList(param);
    }
    
	/**
     * 자격검증 운영 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectEduseq(Map<String, Object> param) throws Exception{
		return educationDao.selectEduseq(param);
	}
	
	
	/**
     * 자격검증 운영을  등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEduseq(Map<String, Object> param) throws Exception {
        
    	int rv = educationDao.insertEduseq(param);
    	String[] subjCd = (String[])param.get("subjCd");
    	String[] subjScore = (String[])param.get("subjScore");
    	Map<String, Object> data = new HashMap();
    	data.put("seq_id", param.get("seq_id"));
    	if(subjCd != null && subjCd.length > 0)
    		for(int i =0; i < subjCd.length;i++){
    			data.put("subj_cd", subjCd[i]);
    			data.put("score", subjScore[i]);
    			
    			educationDao.insertEduseqsubj(data);
    		}
    	return rv;
    }

    /**
     * 자격검증 운영을  수정해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateEduseq(Map<String, Object> param) throws Exception {
        
    	int rv = educationDao.updateEduseq(param);
      	String[] subjCd = (String[])param.get("subjCd");
    	String[] subjScore = (String[])param.get("subjScore");
    	
    	Map<String, Object> data = new HashMap();
    	data.put("seq_id", param.get("seq_id"));
    	if(subjCd != null && subjCd.length > 0){
    		educationDao.deleteEduseqsubj(data);
    		for(int i =0; i < subjCd.length;i++){
    			data.put("subj_cd", subjCd[i]);
    			data.put("score", subjScore[i]);
    			
    			educationDao.insertEduseqsubj(data);
    		}
    	}
    	return rv;
    }

    /**
     * 자격검증 운영을  삭제해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteEduseq(Map<String, Object> param) throws Exception {
    	educationDao.deleteEduseqsubj(param);
    	return educationDao.deleteEduseq(param);
    }

    /**
     * 자격검증 운영을  완료처리해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateEduseqComplete(Map<String, Object> param) throws Exception{
    	return educationDao.updateEduseqComplete(param);
    }
	
	/**
     * 회차코드 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEduseqCodeList(Map<String, Object> param) throws Exception{
		return educationDao.selectEduseqCodeList2(param);
	}
	
	/**
     * 자격검증 운영과목 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEduseqsubjList(Map<String, Object> param) throws Exception{
		return educationDao.selectEduseqsubjList(param);
	}
	
	
	/**
     * 자격검증 운영과목을  등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEduseqsubj(Map<String, Object> param) throws Exception {
    	return educationDao.insertEduseqsubj(param);
    }

    /**
     * 자격검증 운영과목을  삭제해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteEduseqsubj(Map<String, Object> param) throws Exception {
    	return educationDao.deleteEduseqsubj(param);
    }
}
