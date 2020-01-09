package kr.or.wabis.dao.directory;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

/**
 * <PRE>
 * Directory information management
 * !=
 * T_기업디렉토리 정보를 관리
 *
 * </PRE>
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Repository("cmpyDirDao")
public class CmpyDirDao extends AbstractDao {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * 기업디렉토리 정보를 조회한다.
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> searchCmpyDirPageList(Map<String, Object> param) throws Exception {
        return sqlSession.selectList("CmpyDirDao.searchCmpyDirPageList", param);
    }
    
    /**
     * 기업디렉토리 정보를 조회한다.
     *
     * @param Map<String, Object> param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> selectCmpyDirListExcel(Map<String, Object> param) throws Exception {
        return sqlSession.selectList("CmpyDirDao.selectCmpyDirListExcel", param);
    }
    
    /**
     * 기업 정보를 상세조회한다.
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
    public Map<String, Object> selectCmpyDir(Map<String, Object> param) throws Exception {
        return sqlSession.selectOne("CmpyDirDao.selectCmpyDir", param);
    }
    
    /**
     * 기업 정보를 중복 확인한다.
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
    public Map<String, Object> checkCmpyDir(Map<String, Object> param) throws Exception {
        return sqlSession.selectOne("CmpyDirDao.checkCmpyDir", param);
    }
    
    /**
     * 기업 정보를 인증번호 확인
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
    public Map<String, Object> checkCmpyDirAuth(Map<String, Object> param) throws Exception {
        return sqlSession.selectOne("CmpyDirDao.checkCmpyDirAuth", param);
    }
    
    /**
     * 기업디렉토리 정보를 등록한다.
     *
     * @param Map<String, Object> param
     * @return Integer
     * @throws Exception
     */
    public Integer insertCmpyDir(Map<String, Object> param) throws Exception {
        return sqlSession.insert("CmpyDirDao.insertCmpyDir", param);
    }
    
    /**
     * 기업디렉토리 정보를 수정한다.
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirForMake(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirDao.updateCmpyDirForMake", param);
    }
    
    /**
     * 기업디렉토리 정보를 수정한다.
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDir(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirDao.updateCmpyDir", param);
    }
    
    /**
     * 기업디렉토리 정보를 삭제한다.
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    public Integer deleteCmpyDir(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirDao.deleteCmpyDir", param);
    }
    
    /**
     * 기업디렉토리 조직형태를 수정한다.
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    public Integer updateMember(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirDao.updateMember", param);
    }
    
    /**
     * 기업디렉토리를 승인한다.
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    public Integer approveCmpyDir(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirDao.approveCmpyDir", param);
    }
    
    /**
     * 기업디렉토리를 반려한다.
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    public Integer rejectCmpyDir(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirDao.rejectCmpyDir", param);
    }
    
    /**
     * 담당자 상세조회한다.
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
    public Map<String, Object> selectCmpyDirManager(Map<String, Object> param) throws Exception {
        return sqlSession.selectOne("CmpyDirDao.selectCmpyDirManager", param);
    }
    
    /**
     * 담당자를 수정한다.
     *
     * @param CmpyDirVo iCmpyDir
     * @return Integer
     * @throws Exception
     */
    public Integer updateCmpyDirManager(Map<String, Object> param) throws Exception {
        return sqlSession.update("CmpyDirDao.updateCmpyDirManager", param);
    }
    
    /**
     * 찾아오는길 상세조회한다.
     *
     * @param Map<String, Object>
     * @return Map<String, Object> param
     * @throws Exception
     */
     public Map<String, Object> selectCmpyDirMap(Map<String, Object> param) throws Exception {
        return sqlSession.selectOne("CmpyDirDao.selectCmpyDirMap", param);
    }
     
     /**
      * 찾아오는길를 수정한다.
      *
      * @param Map<String, Object> param
      * @return Integer
      * @throws Exception
      */
     public Integer updateCmpyDirMap(Map<String, Object> param) throws Exception {
         return sqlSession.update("CmpyDirDao.updateCmpyDirMap", param);
     }

     
     /**
      * 실적 상세조회한다.
      *
      * @param Map<String, Object>
      * @return Map<String, Object> param
      * @throws Exception
      */
      public Map<String, Object> selectCmpyDirBrec(Map<String, Object> param) throws Exception {
         return sqlSession.selectOne("CmpyDirDao.selectCmpyDirBrec", param);
     }
      
      /**
       * 실적를 수정한다.
       *
       * @param Map<String, Object> param
       * @return Integer
       * @throws Exception
       */
      public Integer updateCmpyDirBrec(Map<String, Object> param) throws Exception {
          return sqlSession.update("CmpyDirDao.updateCmpyDirBrec", param);
      }
      
      /**
       * 주요수출국 수정한다.
       *
       * @param Map<String, Object> param
       * @return Integer
       * @throws Exception
       */
      public Integer updateCmpyDirExpCountry(Map<String, Object> param) throws Exception {
          return sqlSession.update("CmpyDirDao.updateCmpyDirExpCountry", param);
      }
      
      /**
       * 실적 상세조회한다.
       *
       * @param Map<String, Object>
       * @return Map<String, Object> param
       * @throws Exception
       */
       public Map<String, Object> selectCmpyDirExpCountry(Map<String, Object> param) throws Exception {
          return sqlSession.selectOne("CmpyDirDao.selectCmpyDirExpCountry", param);
      }
}
