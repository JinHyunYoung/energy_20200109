package kr.or.wabis.dao.directory;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

/**
 * T_기업디렉토리제품 정보를 관리
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Repository("cmpyDirPrdtDao")
public class CmpyDirPrdtDao extends AbstractDao {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * 기업디렉토리 제품 정보를 상세조회한다.
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirPrdtList(Map<String, Object> param) throws Exception {
        return sqlSession.selectList("CmpyDirPrdtDao.selectCmpyDirPrdtList", param);
    }
    
    /**
     * 기업디렉토리 제품 정보를 등록한다.
     *
     * @param CmpyDirPrdtVo iCmpyDirPrdt
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirPrdt(Map<String, Object> param) throws Exception {
        return sqlSession.insert("CmpyDirPrdtDao.insertCmpyDirPrdt", param);
    }
    
    /**
     * 기업디렉토리 제품 정보를 수정한다.
     *
     * @param CmpyDirPrdtVo iCmpyDirPrdt
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirPrdt(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirPrdtDao.updateCmpyDirPrdt", param);
    }
    
    /**
     * 기업디렉토리 제품 정보를 삭제한다.
     *
     * @param CmpyDirPrdtVo iCmpyDirPrdt
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirPrdt(Map<String, Object> param) throws Exception {
        return sqlSession.delete("CmpyDirPrdtDao.deleteCmpyDirPrdt", param);
    }
    
}
