package kr.or.wabis.dao.directory;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

/**
 * T_기업디렉토리연혁 정보를 관리
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Repository("cmpyDirHstrDao")
public class CmpyDirHstrDao extends AbstractDao {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * 기업디렉토리 연혁 정보를 상세조회한다.
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirHstrList(Map<String, Object> param) throws Exception {
        return sqlSession.selectList("CmpyDirHstrDao.selectCmpyDirHstrList", param);
    }
    
    /**
     * 기업디렉토리 연혁 정보를 등록한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirHstr(Map<String, Object> param) throws Exception {
        return sqlSession.insert("CmpyDirHstrDao.insertCmpyDirHstr", param);
    }
    
    /**
     * 기업디렉토리 연혁 정보를 수정한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirHstr(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirHstrDao.updateCmpyDirHstr", param);
    }
    
    /**
     * 기업디렉토리 연혁 정보를 삭제한다.
     *
     * @param CmpyDirHstrVo iCmpyDirHstr
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirHstr(Map<String, Object> param) throws Exception {
        return sqlSession.delete("CmpyDirHstrDao.deleteCmpyDirHstr", param);
    }
    
}
