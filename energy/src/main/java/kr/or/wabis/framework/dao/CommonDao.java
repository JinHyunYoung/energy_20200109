package kr.or.wabis.framework.dao;

import org.springframework.stereotype.Repository;

@Repository("commonDao")
public class CommonDao extends AbstractDao{    
    
    public <T> T select(String queryId) {
        return sqlSession.selectOne(queryId);
    }
    
    public <T> T select(String queryId, Object params) {
        return sqlSession.selectOne(queryId, params);
    }
}
