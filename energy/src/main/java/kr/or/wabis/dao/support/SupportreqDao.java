package kr.or.wabis.dao.support;

import java.util.List;
import java.util.Map;

import kr.or.wabis.framework.dao.AbstractDao;

import org.springframework.stereotype.Repository;

@Repository("supportreqDao")
public class SupportreqDao extends AbstractDao {
	   
	/**
    * 지원신청서 페이지 리스트를 가져온다.
    * @param param
    * @return
    * @throws Exception
    */
    @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectSupportreqPageList(Map<String, Object> param) throws Exception{
		return selectPageList("SupportreqDao.selectSupportreqPageList", param);
	}
    
  	/**
     * 지원사업통계 리스트
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectSupportreq(Map<String, Object> param) throws Exception {
	    return select("SupportreqDao.selectSupportreq", param);
	}
	    
     /**
     * 지원서를 등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertSupportreq(Map<String, Object> param) throws Exception {
        return update("SupportreqDao.insertSupportreq", param);
    }

    /**
    * 지원서를 수정해준다.
    * @param param
    * @return int
    * @throws Exception
    */
   public int updateSupportreq(Map<String, Object> param) throws Exception {
       return update("SupportreqDao.updateSupportreq", param);
   }

   /**
   * 지원서를 삭제해준다.
   * @param param
   * @return int
   * @throws Exception
   */
  public int deleteSupportreq(Map<String, Object> param) throws Exception {
      return delete("SupportreqDao.deleteSupportreq", param);
  }
  
  /**
   * 지원신청 승인처리를 해준다.
   * @param param
   * @return int
   * @throws Exception
   */
  public int approvalSupportreq(Map<String, Object> param) throws Exception{
      return delete("SupportreqDao.approvalSupportreq", param);
  }
  
	/**
     * 지원사업통계 리스트
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectSupportbusiStatList(Map<String, Object> param) throws Exception {
        return selectList("SupportreqDao.selectSupportbusiStatList", param);
    }
    
    /**
    * 지원사업 통계를 등록해준다.
    * @param param
    * @return int
    * @throws Exception
    */
   public int insertSupportbusiStat(Map<String, Object> param) throws Exception {
       return update("SupportreqDao.insertSupportbusiStat", param);
   }
   
  	/**
	   * 모금후원통계 리스트
	   * @param param
	   * @return
	   * @throws Exception
	   */
	  @SuppressWarnings("unchecked")
	  public List<Map<String, Object>> selectSupportfundStatList(Map<String, Object> param) throws Exception {
	      return selectList("SupportreqDao.selectSupportfundStatList", param);
	  }
	  
	  /**
	  * 모금후원통계를 등록해준다.
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int insertSupportfundStat(Map<String, Object> param) throws Exception {
	     return update("SupportreqDao.insertSupportfundStat", param);
	 }
	  
	  /**
	  * 모금후원통계를 수정해준다.
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int updateSupportfundStat(Map<String, Object> param) throws Exception {
	     return update("SupportreqDao.updateSupportfundStat", param);
	 }
	 
	  /**
	  * 모금후원통계를 삭제해준다.
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int deleteSupportfundStat(Map<String, Object> param) throws Exception {
	     return delete("SupportreqDao.deleteSupportfundStat", param);
	 }
	 
	  /**
	   * 모금후원통계 리스트
	   * @param param
	   * @return
	   * @throws Exception
	   */
	  @SuppressWarnings("unchecked")
	  public List<Map<String, Object>> selectSigunCodeList(Map<String, Object> param) throws Exception {
	      return selectList("SupportreqDao.selectSigunCodeList", param);
	  }
}
