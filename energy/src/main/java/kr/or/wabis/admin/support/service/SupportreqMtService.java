package kr.or.wabis.admin.support.service;

import java.util.List;
import java.util.Map;

public interface SupportreqMtService {
	/**
     * 지원신청 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSupportreqPageList(Map<String, Object> param) throws Exception;
    
  	/**
     * 지원사업통계 리스트
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSupportreq(Map<String, Object> param) throws Exception; 
	
    /**
     * 지원신청을  등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertSupportreq(Map<String, Object> param) throws Exception;

    /**
     * 지원신청을  수정해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateSupportreq(Map<String, Object> param) throws Exception;

    /**
     * 지원신청을  삭제해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteSupportreq(Map<String, Object> param) throws Exception;

    /**
     * 지원신청 승인처리를 해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int approvalSupportreq(Map<String, Object> param) throws Exception;
    
	 /**
     * 지원사업 통계 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectSupportbusiStatList(Map<String, Object> param) throws Exception;
    
    /**
     * 지원사업 통계를 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertSupportbusiStat(Map<String, Object> param) throws Exception;
    
  	/**
	  * 모금후원통계 리스트
	  * @param param
	  * @return
	  * @throws Exception
	  */
	  @SuppressWarnings("unchecked")
	  public List<Map<String, Object>> selectSupportfundStatList(Map<String, Object> param) throws Exception;
	  
	  /**
	  * 모금후원통계를 등록해준다.
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int insertSupportfundStat(Map<String, Object> param) throws Exception;
	  
	  /**
	  * 모금후원통계를 수정해준다.
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int updateSupportfundStat(Map<String, Object> param) throws Exception;
	 
	  /**
	  * 모금후원통계를 삭제해준다.
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int deleteSupportfundStat(Map<String, Object> param) throws Exception;
	
	 /**
     * 시군코드 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectSigunCodeList(Map<String, Object> param) throws Exception;
	    
}
