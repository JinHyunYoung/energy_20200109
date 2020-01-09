package kr.or.wabis.dao.contents;

import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("logoDao")
public class LogoDao extends AbstractDao {
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectLogo(Map<String, Object> param) throws Exception {
        return selectOne("LogoDao.selectLogo", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertLogo(Map<String, Object> param) throws Exception {
        return update("LogoDao.insertLogo", param);
    }
    
}