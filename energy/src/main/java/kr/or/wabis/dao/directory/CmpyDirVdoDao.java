package kr.or.wabis.dao.directory;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

/**
 * <PRE>
 * Directory Video information management
 * !=
 * T_기업디렉토리동영상 정보를 관리
 * =!
 * </PRE>
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Repository("cmpyDirVdoDao")
public class CmpyDirVdoDao extends AbstractDao {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * != 기업디렉토리 동영상 정보를 상세조회한다. =!
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirVdoList(Map<String, Object> param) throws Exception {
        return sqlSession.selectList("CmpyDirVdoDao.selectCmpyDirVdoList", param);
    }
    
    /**
     * != 기업디렉토리 동영상 정보를 등록한다. =!
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDirVdo(Map<String, Object> param) throws Exception {
        return sqlSession.insert("CmpyDirVdoDao.insertCmpyDirVdo", param);
    }
    
    /**
     * != 기업디렉토리 동영상 정보를 수정한다. =!
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirVdo(Map<String, Object> param) throws Exception {
        return sqlSession.insert("CmpyDirVdoDao.updateCmpyDirVdo", param);
    }
    
    /**
     * != 기업디렉토리 동영상 정보를 삭제한다. =!
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDirVdo(Map<String, Object> param) throws Exception {
        return sqlSession.delete("CmpyDirVdoDao.deleteCmpyDirVdo", param);
    }
    
}
