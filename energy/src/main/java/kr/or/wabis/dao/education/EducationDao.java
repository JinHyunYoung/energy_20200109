package kr.or.wabis.dao.education;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("educationDao")
public class EducationDao extends AbstractDao {
	/**
     * 지원신청 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEducationApplyPageList(Map<String, Object> param) throws Exception{
		return selectPageList("EducationDao.selectEducationApplyPageList", param);
	}
    
	/**
     * 교육신청 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectEducationApply(Map<String, Object> param) throws Exception {
		return select("EducationDao.selectEducationApply", param);
    }
	
     /**
     * 교육신청을 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEducationApply(Map<String, Object> param) throws Exception {
        return update("EducationDao.insertEducationApply", param);
    }
	
    /**
    * 교육신청을 수정해준다.
    * 
    * @param param
    * @return int
    * @throws Exception
    */
   public int updateEducationApply(Map<String, Object> param) throws Exception {
       return update("EducationDao.updateEducationApply", param);
   }
	
   /**
   * 교육신청을 삭제해준다.
   * 
   * @param param
   * @return int
   * @throws Exception
   */
  public int deleteEducationApply(Map<String, Object> param) throws Exception {
      return delete("EducationDao.deleteEducationApply", param);
  }
		
	 /**
	  * 교육신청을 수강승인해준다.
	  * 
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int approvalEducationApply(Map<String, Object> param) throws Exception {
	     return delete("EducationDao.approvalEducationApply", param);
	 }
		
	 /**
	  * 교육신청을 합격승인해준다.
	  * 
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int passEducationApply(Map<String, Object> param) throws Exception {
	     return delete("EducationDao.passEducationApply", param);
	 }
	 
    /**
     * 교육차수 코드 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEduseqCodeList(Map<String, Object> param) throws Exception {
        return selectList("EducationDao.selectEduseqCodeList", param);
    }
	 
    /**
     * 교육차수 코드 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEduseqCodeList2(Map<String, Object> param) throws Exception {
        return selectList("EducationDao.selectEduseqCodeList2", param);
    }
    
    /**
    * 교육신청 여부를 가져온다.
    * 
    * @param param
    * @return int
    * @throws Exception
    */
   public int selectEducationApplyExist(Map<String, Object> param) throws Exception {
       return selectOne("EducationDao.selectEducationApplyExist", param);
   }
   
	/**
     * 교육신청 리스트를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEducationApplyList(Map<String, Object> param) throws Exception{
		return selectPageList("EducationDao.selectEducationApplyList", param);
	}
    
	/**
     * 자격검증 운영 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEduseqPageList(Map<String, Object> param) throws Exception {
		return selectPageList("EducationDao.selectEduseqPageList", param);
    }
    
	/**
     * 자격검증 운영 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectEduseq(Map<String, Object> param) throws Exception {
		return select("EducationDao.selectEduseq", param);
    }
	
	/**
     * 자격검증 운영을  등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEduseq(Map<String, Object> param) throws Exception {
    	return insert("EducationDao.insertEduseq", param);
    }

    /**
     * 자격검증 운영을  수정해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateEduseq(Map<String, Object> param) throws Exception {
    	return update("EducationDao.updateEduseq", param);
    }

    /**
     * 자격검증 운영을  삭제해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteEduseq(Map<String, Object> param) throws Exception {
    	return delete("EducationDao.deleteEduseq", param);
    }

    /**
     * 자격검증 운영을  완료처리해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateEduseqComplete(Map<String, Object> param) throws Exception{
    	return update("EducationDao.updateEduseqComplete", param);
    }
    
	/**
     * 자격검증 운영과목 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEduseqsubjList(Map<String, Object> param) throws Exception {
		return selectList("EducationDao.selectEduseqsubjList", param);
    }
	
	/**
     * 자격검증 운영과목을  등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEduseqsubj(Map<String, Object> param) throws Exception {
    	return update("EducationDao.insertEduseqsubj", param);
    }

    /**
     * 자격검증 운영과목을  삭제해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteEduseqsubj(Map<String, Object> param) throws Exception {
    	return delete("EducationDao.deleteEduseqsubj", param);
    }
    
    /**
     * 지원사업통계를 가져온다.
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectYearBusiStat(Map<String, Object> param) throws Exception {
        return selectList("EducationDao.selectYearBusiStat", param);
    }
    
    /**
     * 모금및후원통계를 가져온다. 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectYearFundStat(Map<String, Object> param) throws Exception {
        return selectList("EducationDao.selectYearFundStat", param);
    }
}
