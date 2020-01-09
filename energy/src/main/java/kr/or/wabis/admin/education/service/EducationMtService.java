package kr.or.wabis.admin.education.service;

import java.util.List;
import java.util.Map;

public interface EducationMtService {

	/**
     * 교육신청 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEducationApplyPageList(Map<String, Object> param) throws Exception;

	/**
     * 교육신청 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectEducationApply(Map<String, Object> param) throws Exception;
    
	/**
     * 지원신청을 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEducationApply(Map<String, Object> param) throws Exception;
    
	/**
     * 지원신청을 수정해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateEducationApply(Map<String, Object> param) throws Exception;
    
	/**
     * 지원신청을 삭제해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteEducationApply(Map<String, Object> param) throws Exception;
    
	/**
     * 자격검증 운영 페이지 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEduseqPageList(Map<String, Object> param) throws Exception;
	
	/**
     * 회차코드 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEduseqCodeList(Map<String, Object> param) throws Exception;
	
	/**
     * 자격검증 운영 정보
     * @param param
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectEduseq(Map<String, Object> param) throws Exception;
	
	/**
     * 자격검증 운영을  등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEduseq(Map<String, Object> param) throws Exception;

    /**
     * 자격검증 운영을  수정해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateEduseq(Map<String, Object> param) throws Exception;

    /**
     * 자격검증 운영을  완료처리해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateEduseqComplete(Map<String, Object> param) throws Exception;
    
	 /**
	  * 교육신청을 수강승인해준다.
	  * 
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int approvalEducationApply(Map<String, Object> param) throws Exception;
		
	 /**
	  * 교육신청을 합격승인해준다.
	  * 
	  * @param param
	  * @return int
	  * @throws Exception
	  */
	 public int passEducationApply(Map<String, Object> param) throws Exception;
	 
    /**
     * 자격검증 운영을  삭제해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteEduseq(Map<String, Object> param) throws Exception;
    
	/**
     * 자격검증 운영과목 리스트
     * @param param
     * @return
     * @throws Exception
     */
	public List<Map<String, Object>> selectEduseqsubjList(Map<String, Object> param) throws Exception;
	
	/**
     * 자격검증 운영과목을  등록해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertEduseqsubj(Map<String, Object> param) throws Exception;

    /**
     * 자격검증 운영과목을  삭제해준다.
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteEduseqsubj(Map<String, Object> param) throws Exception;
}
