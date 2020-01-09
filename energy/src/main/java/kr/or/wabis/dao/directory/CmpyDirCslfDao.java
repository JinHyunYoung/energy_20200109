package kr.or.wabis.dao.directory;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

/**
 * T_기업디렉토리 물산업분류 정보를 관리
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Repository("cmpyDirCslfDao")
public class CmpyDirCslfDao extends AbstractDao {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * 기업디렉토리 물산업분류 정보를 조회한다.
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirCslfList(Map<String, Object> param) throws Exception {
        return sqlSession.selectList("CmpyDirCslfDao.selectCmpyDirCslfList", param);
    }
    
    /**
     * 기업디렉토리 물산업분류 정보를 등록한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirCslf(Map<String, Object> param) throws Exception {
        return sqlSession.insert("CmpyDirCslfDao.insertCmpyDirCslf", param);
    }
    
    /**
     * 기업디렉토리 물산업분류 정보를 수정한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirCslf(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirCslfDao.updateCmpyDirCslf", param);
    }
    
    /**
     * 기업디렉토리 물산업분류 정보를 삭제한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirCslf(Map<String, Object> param) throws Exception {
        return sqlSession.delete("CmpyDirCslfDao.deleteCmpyDirCslf", param);
    }
    
}
