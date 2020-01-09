package kr.or.wabis.directory.service;

import java.util.Map;

import kr.or.wabis.admin.directory.service.CmpyDirMtService;

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
public interface CmpyDirService extends CmpyDirMtService {   
    
    /**
     * 기업정보 중복확인
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Map<String, Object> checkCmpyDir(Map<String, Object> param) throws Exception;   
    
    /**
     * 기업정보 인증번호 확인
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Map<String, Object> checkCmpyDirAuth(Map<String, Object> param) throws Exception;   
    
    /**
     * 기업정보를 수정한다. (기업 디렉토리 생성시)
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirForMake(Map<String, Object> param) throws Exception; 
}
