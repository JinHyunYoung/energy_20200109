package kr.or.wabis.stats.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.stats.StatsResearchDao;

/**
 * @author P068995
 *
 */
@Service("statsResearchService")
public class StatsResearchServiceImpl implements StatsResearchService {

	private final static Logger logger = Logger.getLogger(StatsResearchServiceImpl.class);

	@Resource(name = "statsResearchDao")
	protected StatsResearchDao statsResearchDao;
	
	/**
	 * 통계 조사결과 구분, 통계구분, 통계표 코드 내역을 조회한다.
	 */
	public List<Map<String, Object>>  selectResearchCodeList(Map<String, Object> param) throws Exception {
		return statsResearchDao.selectResearchCodeList(param);
	}
	
	/**
	 * 항목 내역을 조회한다.
	 */
	public List<Map<String, Object>>  selectResearchItemTreeList(Map<String, Object> param) throws Exception {
	    
		return statsResearchDao.selectResearchItemTreeList(param);
	}
	
	/**
	 * 통계조사표 내역을 조회한다.
	 */
	public List<Map<String, Object>>  selectResearchTableList(Map<String, Object> param) throws Exception {
	    logger.debug(param);
		return statsResearchDao.selectResearchTableList(param);
	}

	/**
	 * 통계조사표의 컬럼 해데를  조회한다.
	 */
	public List<Map<String, Object>>  selectResearchTableHeader(Map<String, Object> param) throws Exception {
	    
	    logger.debug(param);
		return statsResearchDao.selectResearchTableHeader(param);
	}
}
