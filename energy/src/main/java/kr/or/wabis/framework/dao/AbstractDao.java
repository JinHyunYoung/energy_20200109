package kr.or.wabis.framework.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import kr.or.wabis.framework.vo.BaseVO;

public abstract class AbstractDao {
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    @Autowired
    @Resource(name = "sqlSession")
    protected SqlSession sqlSession;
    
    /**
     * 쿼리를 로고 보여준다.
     * 
     * @param queryId
     */
    protected final void printQueryId(final String queryId) {
        if (log.isDebugEnabled()) {
            log.debug("\t QueryId  \t:  " + queryId);
        }
    }
    
    /**
     * 입력 처리 SQL mapping 을 실행한다.
     *
     * @param queryId - 입력 처리 SQL mapping 쿼리 ID
     * @return DBMS가 지원하는 경우 insert 적용 결과 count
     */
    public final int insert(final String queryId) {
        printQueryId(queryId);
        return sqlSession.insert(queryId);
    }
    
    /**
     * 입력 처리 SQL mapping 을 실행한다.
     *
     * @param queryId - 입력 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 입력 처리 SQL mapping 입력 데이터를 세팅한 파라메터 객체 (보통 VO 또는 Map)
     * @return DBMS가 지원하는 경우 insert 적용 결과 count
     */
    public final int insert(final String queryId, final Object parameterObject) {
        printQueryId(queryId);
        return sqlSession.insert(queryId, parameterObject);
    }
    
    /**
     * 수정 처리 SQL mapping 을 실행한다.
     *
     * @param queryId - 수정 처리 SQL mapping 쿼리 ID
     * @return DBMS가 지원하는 경우 update 적용 결과 count
     */
    public final int update(final String queryId) {
        printQueryId(queryId);
        return sqlSession.update(queryId);
    }
    
    /**
     * 수정 처리 SQL mapping 을 실행한다.
     *
     * @param queryId - 수정 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 수정 처리 SQL mapping 입력 데이터(key 조건 및 변경 데이터)를 세팅한 파라메터 객체(보통 VO 또는 Map)
     * @return DBMS가 지원하는 경우 update 적용 결과 count
     */
    public final int update(final String queryId, final Object parameterObject) {
        printQueryId(queryId);
        return sqlSession.update(queryId, parameterObject);
    }
    
    /**
     * 삭제 처리 SQL mapping 을 실행한다.
     *
     * @param queryId - 삭제 처리 SQL mapping 쿼리 ID
     * @return DBMS가 지원하는 경우 delete 적용 결과 count
     */
    public final int delete(final String queryId) {
        printQueryId(queryId);
        return sqlSession.delete(queryId);
    }
    
    /**
     * 삭제 처리 SQL mapping 을 실행한다.
     *
     * @param queryId - 삭제 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 삭제 처리 SQL mapping 입력 데이터(일반적으로 key 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
     * @return DBMS가 지원하는 경우 delete 적용 결과 count
     */
    public final int delete(final String queryId, final Object parameterObject) {
        printQueryId(queryId);
        return sqlSession.delete(queryId, parameterObject);
    }
    
    /**
     * 명명규칙에 맞춰 selectOne()로 변경한다.
     * 
     * @see EgovAbstractMapper.selectOne()
     * @param queryId
     * @param parameterObject
     * @return Object
     */
    @Deprecated
    public final Object selectByPk(final String queryId, final Object parameterObject) {
        printQueryId(queryId);
        return sqlSession.selectOne(queryId, parameterObject);
    }
    
    /**
     * 단건조회 처리 SQL mapping 을 실행한다.
     * 
     * @param <T>
     * @param queryId - 단건 조회 처리 SQL mapping 쿼리 ID
     * @return 결과 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 단일 결과 객체(보통 VO 또는 Map)
     */
    public final <T> T selectOne(final String queryId) {
        printQueryId(queryId);
        return sqlSession.selectOne(queryId);
    }
    
    /**
     * 단건조회 처리 SQL mapping 을 실행한다.
     * 
     * @param <T>
     * @param queryId - 단건 조회 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 단건 조회 처리 SQL mapping 입력 데이터(key)를 세팅한 파라메터 객체(보통 VO 또는 Map)
     * @return 결과 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 단일 결과 객체(보통 VO 또는 Map)
     */
    public final <T> T selectOne(final String queryId, final Object parameterObject) {
        printQueryId(queryId);
        return sqlSession.selectOne(queryId, parameterObject);
    }
    
    /**
     * 결과 목록을 Map 을 변환한다. 모든 구문이 파라미터를 필요로 하지는 않기 때문에, 파라미터 객체를 요구하지 않는 형태로 오버로드되었다.
     *
     * @param <K>
     * @param <V>
     * @param queryId - 단건 조회 처리 SQL mapping 쿼리 ID
     * @param mapKey - 결과 객체의 프로퍼티 중 하나를 키로 사용
     * @return 결과 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 단일 결과 객체(보통 VO 또는 Map)의 Map
     */
    public final <K, V> Map<K, V> selectMap(final String queryId, final String mapKey) {
        printQueryId(queryId);
        return sqlSession.selectMap(queryId, mapKey);
    }
    
    /**
     * 결과 목록을 Map 을 변환한다. 모든 구문이 파라미터를 필요로 하지는 않기 때문에, 파라미터 객체를 요구하지 않는 형태로 오버로드되었다.
     *
     * @param <K>
     * @param <V>
     * @param queryId - 단건 조회 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 맵 조회 처리 SQL mapping 입력 데이터(조회 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
     * @param mapKey - 결과 객체의 프로퍼티 중 하나를 키로 사용
     * @return 결과 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 단일 결과 객체(보통 VO 또는 Map)의 Map
     */
    public final <K, V> Map<K, V> selectMap(final String queryId, final Object parameterObject, final String mapKey) {
        printQueryId(queryId);
        return sqlSession.selectMap(queryId, parameterObject, mapKey);
    }
    
    /**
     * 결과 목록을 Map 을 변환한다. 모든 구문이 파라미터를 필요로 하지는 않기 때문에, 파라미터 객체를 요구하지 않는 형태로 오버로드되었다.
     *
     * @param <K>
     * @param <V>
     * @param queryId - 단건 조회 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 맵 조회 처리 SQL mapping 입력 데이터(조회 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
     * @param mapKey - 결과 객체의 프로퍼티 중 하나를 키로 사용
     * @param rowBounds - 특정 개수 만큼의 레코드를 건너띄게 함
     * @return 결과 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 단일 결과 객체(보통 VO 또는 Map)의 Map
     */
    public final <K, V> Map<K, V> selectMap(final String queryId, final Object parameterObject, final String mapKey, final RowBounds rowBounds) {
        printQueryId(queryId);
        return sqlSession.selectMap(queryId, parameterObject, mapKey, rowBounds);
    }
    
    /**
     * 명명규칙에 맞춰 selectList()로 변경한다.
     * 
     * @see EgovAbstractMapper.selectList()
     * @param queryId
     * @param parameterObject
     * @return List<?>
     */
    @Deprecated
    public final List<?> list(final String queryId, final Object parameterObject) {
        printQueryId(queryId);
        return sqlSession.selectList(queryId, parameterObject);
    }
    
    /**
     * 리스트 조회 처리 SQL mapping 을 실행한다.
     *
     * @param <E>
     * @param queryId - 리스트 조회 처리 SQL mapping 쿼리 ID
     * @return 결과 List 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 결과 객체(보통 VO 또는 Map)의 List
     */
    public final <E> List<E> selectList(final String queryId) {
        printQueryId(queryId);
        return sqlSession.selectList(queryId);
    }
    
    /**
     * 
     * @param queryId
     * @return
     */
    public final Map<String, Object> selectPageList(final String queryId) {
        printQueryId(queryId);
        Map<String, Object> data = new HashMap();
        List<Map<String, Object>> list = sqlSession.selectList(queryId);
        data.put("list", list);
        return data;
    }
    
    /**
     * 리스트 조회 처리 SQL mapping 을 실행한다.
     *
     * @param <E>
     * @param queryId - 리스트 조회 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 리스트 조회 처리 SQL mapping 입력 데이터(조회 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
     * @return 결과 List 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 결과 객체(보통 VO 또는 Map)의 List
     */
    public final <E> List<E> selectList(final String queryId, final Object parameterObject) {
        printQueryId(queryId);
        return sqlSession.selectList(queryId, parameterObject);
    }
    
    /**
     * 
     * @param queryId
     * @param parameterObject
     * @return
     */
    public final List<Map<String, Object>> selectPageList(final String queryId, final Object parameterObject) {
        printQueryId(queryId);
        List<Map<String, Object>> list = sqlSession.selectList(queryId, parameterObject);
        return list;
    }
    
    /**
     * 리스트 조회 처리 SQL mapping 을 실행한다.
     * 
     * @param <E>
     * @param queryId - 리스트 조회 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 리스트 조회 처리 SQL mapping 입력 데이터(조회 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
     * @param rowBounds - 특정 개수 만큼의 레코드를 건너띄게 함
     * @return 결과 List 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 결과 객체(보통 VO 또는 Map)의 List
     */
    public final <E> List<E> selectList(final String queryId, final Object parameterObject, final RowBounds rowBounds) {
        printQueryId(queryId);
        return sqlSession.selectList(queryId, parameterObject, rowBounds);
    }
    
    /**
     * 리스트 조회 처리 SQL mapping을 실행한다.
     * 
     * @param queryID - 리스트 조회 처리 SQL mapping 쿼리 ID
     * @param paramVO - 리스트 조회 처리 SQL mapping 입력 데이터(조회 조건)를 세팅한 파라메터 VO
     * @return 결과 List 객체
     */
    public final <T> List<T> selectGridPageList(String queryID, BaseVO paramVO) {
        Integer pageNo = paramVO.getMiv_pageNo() != null && !"".equals(paramVO.getMiv_pageNo()) ? paramVO.getMiv_pageNo() : 1;
        Integer pageSize = paramVO.getMiv_pageSize() != null && !"".equals(paramVO.getMiv_pageSize()) ? paramVO.getMiv_pageSize() : 999;
        
        paramVO.setMiv_pageNo(pageNo);
        paramVO.setMiv_pageSize(pageSize);
        
        Integer skipResult = (pageNo - 1) * pageSize;
        Integer maxResult = pageSize;
        
        RowBounds rowBounds = new RowBounds(skipResult, maxResult);
        printQueryId(queryID);
        List<T> rstList = sqlSession.selectList(queryID, paramVO, rowBounds);
        
        return rstList;
    }
    
    public <T> T select(String queryId) {
        return sqlSession.selectOne(queryId);
    }
    
    public <T> T select(String queryId, Object params) {
        return sqlSession.selectOne(queryId, params);
    }
    
    /**
     * 부분 범위 리스트 조회 처리 SQL mapping 을 실행한다. (부분 범위 - pageIndex 와 pageSize 기반으로 현재 부분 범위 조회를 위한 skipResults, maxResults 를 계산하여 ibatis 호출)
     *
     * @param queryId - 리스트 조회 처리 SQL mapping 쿼리 ID
     * @param parameterObject - 리스트 조회 처리 SQL mapping 입력 데이터(조회 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
     * @param pageIndex - 현재 페이지 번호
     * @param pageSize - 한 페이지 조회 수(pageSize)
     * @return 부분 범위 결과 List 객체 - SQL mapping 파일에서 지정한 resultType/resultMap 에 의한 부분 범위 결과 객체(보통 VO 또는 Map) List
     */
    public final List<?> listWithPaging(final String queryId, final Object parameterObject, final int pageIndex, final int pageSize) {
        printQueryId(queryId);
        int skipResults = pageIndex * pageSize;
        RowBounds rowBounds = new RowBounds(skipResults, pageSize);
        return sqlSession.selectList(queryId, parameterObject, rowBounds);
    }
    
    /**
     * SQL 조회 결과를 ResultHandler를 이용해서 출력한다. ResultHandler를 상속해 구현한 커스텀 핸들러의 handleResult() 메서드에 따라 실행된다.
     *
     * @param queryId - 리스트 조회 처리 SQL mapping 쿼리 ID
     * @param parameterObject
     * @param handler - 조회 결과를 제어하기 위해 구현한 ResultHandler
     */
    public final void listToOutUsingResultHandler(final String queryId, final Object parameterObject, final AbstractResultHandler handler) {
        printQueryId(queryId);
        sqlSession.select(queryId, parameterObject, handler);
        handler.close();
    }
}
