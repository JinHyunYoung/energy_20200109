package kr.or.wabis.admin.directory.service;

import java.util.List;
import java.util.Map;

import kr.or.wabis.directory.vo.CmpyDirInfoVo;

/**
 * <PRE>
 * !=
 * 기업디렉토리 상세 정보를 수정하는 기능
 *
 * </PRE>
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
public interface CmpyDirMtService {
    
    /**
     * 기업디렉토리 조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return List<CmpyDirVo>
     * @throws Exception
     */
	public List<Map<String, Object>> searchCmpyDirPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 기업디렉토리 조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return List<CmpyDirVo>
     * @throws Exception
     */
	public List<Map<String, Object>> selectCmpyDirListExcel(Map<String, Object> param) throws Exception;
    
    /**
     * 기업디렉토리 상세조회
     *
     * @param Map<String, Object> param
     * @return CmpyDirInfoVo
     * @throws Exception
     */
    public Map<String, Object> searchCmpyDir(Map<String, Object> param) throws Exception;
    
    public Map<String, Object> searchCmpyDirExpCountry(Map<String, Object> param) throws Exception;
        
    /**
     * 중복확인
     *
     * @param Map<String, Object> param
     * @return Map<String, Object> 
     * @throws Exception
     */
    public Map<String, Object> confirmDupl(Map<String, Object> param) throws Exception;
    
    /**
     * 기업디렉토리 승인 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer approveCmpyDir(Map<String, Object> param) throws Exception;
    
    /** 
     * 기업디렉토리 반려 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer rejectCmpyDir(Map<String, Object> param) throws Exception;
    
    /**
     * 기업디렉토리 회원여부 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateMember(Map<String, Object> param) throws Exception;
    
    
    /**
     * 기업디렉토리 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDir(Map<String, Object> param) throws Exception;
    
    /**
     * 기업정보 상세조회
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
    public Map<String, Object> selectCmpyDir(Map<String, Object> param) throws Exception;
    
    /**
     * 기업정보 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDir(Map<String, Object> param) throws Exception;
    
    /**
     * 기업정보 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDir(Map<String, Object> param) throws Exception;
    
    /**
     * 담당자정보 상세조회
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
    public Map<String, Object> selectCmpyDirManager(Map<String, Object> param) throws Exception;
    
    /**
     * 담당자정보 저장
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirManager(Map<String, Object> param) throws Exception;
    
    /**
     * 찾아오시는길 상세조회
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
    public Map<String, Object> selectCmpyDirMap(Map<String, Object> param) throws Exception;
    
    /**
     * 찾아오시는길 저장
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirMap(Map<String, Object> param) throws Exception;
    
	 /**
     * 실적 상세조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public Map<String, Object> selectCmpyDirBrec(Map<String, Object> param) throws Exception;
	
    /**
     * 실적 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirBrec(Map<String, Object> param) throws Exception;
	   
	/**
	* 물산업분류 조회
	*
	* @param CmpyDirVo iCmpyDir
	* @return List<CmpyDirFncVo>
	* @throws Exception
	*/
	public List<Map<String, Object>> selectCmpyDirCslfList(Map<String, Object> param) throws Exception;
	
	/**
	* 물산업분류 등록
	*
	* @param Map<String, Object> param
	* @return Integer
	* @throws Exception
	*/
	public Integer insertCmpyDirCslf(Map<String, Object> param) throws Exception;
	
	/**
	* 물산업분류 수정
	*
	* @param Map<String, Object> param
	* @return Integer
	* @throws Exception
	*/
	public Integer updateCmpyDirCslf(Map<String, Object> param) throws Exception;
	
	/**
	* 물산업분류 삭제
	*
	* @param Map<String, Object> param
	* @return Integer
	* @throws Exception
	*/
	public Integer deleteCmpyDirCslf(Map<String, Object> param) throws Exception;
    	   
    /**
     * 재무현황 조회
     *
     * @param CmpyDirVo iCmpyDir
     * @return List<CmpyDirFncVo>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirFncList(Map<String, Object> param) throws Exception;
	
    /**
     * 재무현황 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirFnc(Map<String, Object> param) throws Exception;

    /**
     * 재무현황 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirFnc(Map<String, Object> param) throws Exception;

    /**
     * 재무현황 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirFnc(Map<String, Object> param) throws Exception;
    
    /**
     * 수출현황 조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirExpList(Map<String, Object> param) throws Exception;

    /**
     * 수출현황 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirExp(Map<String, Object> param) throws Exception;
    
    /**
     * 수출현황 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirExp(Map<String, Object> param) throws Exception;

    /**
     * 수출현황 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirExp(Map<String, Object> param) throws Exception;
    
    /**
     * 인증내역 상세조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirCertList(Map<String, Object> param) throws Exception;
    
    /**
     * 인증현황 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirCert(Map<String, Object> param) throws Exception;
    
    /**
     * 인증현황 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirCert(Map<String, Object> param) throws Exception;
    
    /**
     * 인증현황 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirCert(Map<String, Object> param) throws Exception;
    
    /**
     * 연혁 상세조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirHstrList(Map<String, Object> param) throws Exception;
    
    /**
     * 연혁 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirHstr(Map<String, Object> param) throws Exception;
    
    /**
     * 연혁 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirHstr(Map<String, Object> param) throws Exception;
    
    /**
     * 연혁 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirHstr(Map<String, Object> param) throws Exception;
    
    /**
     * 제품 조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirPrdtList(Map<String, Object> param) throws Exception;
    
    /**
     * 제품 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirPrdt(Map<String, Object> param) throws Exception;
    
    /**
     * 제품 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirPrdt(Map<String, Object> param) throws Exception;
    
    /**
     * 제품 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirPrdt(Map<String, Object> param) throws Exception;
    
    /**
     * 제품사진 조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirPrdtPctrList(Map<String, Object> param) throws Exception;
    
    /**
     * 제품사진 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirPrdtPctr(Map<String, Object> param) throws Exception;
    
    /**
     * 제품사진 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirPrdtPctr(Map<String, Object> param) throws Exception;
    
    /**
     * 제품사진 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirPrdtPctr(Map<String, Object> param) throws Exception;
    
    /**
     * 동영상 조회
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirVdoList(Map<String, Object> param) throws Exception;
    
    /**
     * 동영상 등록
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirVdo(Map<String, Object> param) throws Exception;
    
    /**
     * 동영상 수정
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirVdo(Map<String, Object> param) throws Exception;
    
    /**
     * 동영상 삭제
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirVdo(Map<String, Object> param) throws Exception;
    
}
