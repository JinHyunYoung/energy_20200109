package kr.or.wabis.education.service;

import java.util.List;
import java.util.Map;

public interface EducationService {

    /**
     * 교육신청을 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEducationApply(Map<String, Object> param) throws Exception;
    
    /**
     * 교육차수 코드 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEduseqCodeList(Map<String, Object> param) throws Exception;
	
    /**
    * 교육신청 여부를 가져온다.
    * 
    * @param param
    * @return int
    * @throws Exception
    */
   public int selectEducationApplyExist(Map<String, Object> param) throws Exception;
   
	/**
     * 교육신청 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEducationApplyList(Map<String, Object> param) throws Exception;
	
    /**
     * 지원사업통계를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectYearBusiStat(Map<String, Object> param) throws Exception;
    
    /**
     * 모금및후원통계를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectYearFundStat(Map<String, Object> param) throws Exception;
	
}
