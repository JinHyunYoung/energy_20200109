package kr.or.wabis.dao.directory;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

/**
 * T_기업디렉토리 인증 정보를 관리
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Repository("cmpyDirCertDao")
public class CmpyDirCertDao extends AbstractDao {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * 기업디렉토리 인증 정보를 조회한다.
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirCertList(Map<String, Object> param) throws Exception {
        return sqlSession.selectList("CmpyDirCertDao.selectCmpyDirCertList", param);
    }
    
    /**
     * 기업디렉토리 인증 정보를 등록한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirCert(Map<String, Object> param) throws Exception {
        return sqlSession.insert("CmpyDirCertDao.insertCmpyDirCert", param);
    }
    
    /**
     * 기업디렉토리 인증 정보를 수정한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirCert(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirCertDao.updateCmpyDirCert", param);
    }
    
    /**
     * 기업디렉토리 인증 정보를 삭제한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirCert(Map<String, Object> param) throws Exception {
        return sqlSession.delete("CmpyDirCertDao.deleteCmpyDirCert", param);
    }
    
}
