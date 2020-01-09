package kr.or.wabis.dao.directory;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

/**
 * <PRE>
 * Directory Product Picture information management
 * !=
 * T_기업디렉토리제품사진 정보를 관리
 *
 * </PRE>
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Repository("cmpyDirPrdtPctrDao")
public class CmpyDirPrdtPctrDao extends AbstractDao {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * 기업디렉토리 제품사진 정보를 상세조회한다.
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirPrdtPctrList(Map<String, Object> param) throws Exception {
        return sqlSession.selectList("CmpyDirPrdtPctrDao.selectCmpyDirPrdtPctrList", param);
    }
    
    /**
     * 기업디렉토리 제품사진 정보를 수정한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirPrdtPctr(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirPrdtPctrDao.updateCmpyDirPrdtPctr", param);
    }
    
    /**
     * 기업디렉토리 제품사진 정보를 등록한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirPrdtPctr(Map<String, Object> param) throws Exception {
        return sqlSession.insert("CmpyDirPrdtPctrDao.insertCmpyDirPrdtPctr", param);
    }
    
    /**
     * 기업디렉토리 제품사진 정보를 삭제한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirPrdtPctr(Map<String, Object> param) throws Exception {
        return sqlSession.delete("CmpyDirPrdtPctrDao.deleteCmpyDirPrdtPctr", param);
    }
    
}
