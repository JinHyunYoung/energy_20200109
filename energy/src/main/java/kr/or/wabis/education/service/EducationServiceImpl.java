package kr.or.wabis.education.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.dao.education.EducationDao;
import kr.or.wabis.framework.util.StringUtil;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service("educationService")
public class EducationServiceImpl implements EducationService {
	
    private Logger logger = Logger.getLogger(EducationServiceImpl.class);
    
    @Resource(name = "educationDao")
    protected EducationDao educationDao;
    
    /**
     * 지원신청을 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEducationApply(Map<String, Object> param) throws Exception {
        return educationDao.insertEducationApply(param);
    }

    /**
     * 교육차수 코드 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEduseqCodeList(Map<String, Object> param) throws Exception{
    	return educationDao.selectEduseqCodeList(param);
    }
	
    /**
    * 교육신청 여부를 가져온다.
    * @param param
    * @return int
    * @throws Exception
    */
   public int selectEducationApplyExist(Map<String, Object> param) throws Exception{
	   return educationDao.selectEducationApplyExist(param);
   }
   
	/**
     * 교육신청 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEducationApplyList(Map<String, Object> param) throws Exception{
		return educationDao.selectEducationApplyList(param);
	}
	
    /**
     * 지원사업통계를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectYearBusiStat(Map<String, Object> param) throws Exception{
	    Map ret = new HashMap();
	    Map retdata = new HashMap();
	    Map data = null;
	    String houseTot = "";
	    long amtTotal = 0, houseTotal = 0;
    	List list = educationDao.selectYearBusiStat(param);  	
    	if(list != null && list.size() > 0)
    		for(int i =0; i < list.size();i++){
    	        data = (Map)list.get(i);
    	        houseTot = (String)data.get("house_tot");
    	        amtTotal += Long.parseLong((String)data.get("amt_tot"));
    	        houseTotal += Long.parseLong(houseTot);
    	        retdata.put(StringUtil.nvl("R"+data.get("region_cd")),StringUtil.amountFormater(houseTot));		
    		}
    	
    	ret.put("busiStat", retdata);
    	ret.put("busiAmtTotal", StringUtil.amountFormater(""+amtTotal));
    	ret.put("busiHouseTotal", StringUtil.amountFormater(""+houseTotal));
    	
    	return ret;
	}
    
    /**
     * 모금및후원통계를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectYearFundStat(Map<String, Object> param) throws Exception{
	    Map retdata = new HashMap();
	    Map data = null;
    	List list = educationDao.selectYearFundStat(param);
    	int idx = 5;
		for(int i =0; i < list.size();i++){
	        data = (Map)list.get(i);
	        data.put("rnum", ""+idx);
	        idx--;
		}
    	
    	return list;
	}
    
}
