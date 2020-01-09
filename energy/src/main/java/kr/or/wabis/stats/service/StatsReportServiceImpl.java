package kr.or.wabis.stats.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.stats.StatsReportDao;

/**
 * @author P068995
 *
 */
@Service("statsReportService")
public class StatsReportServiceImpl implements StatsReportService {

	private final static Logger logger = Logger.getLogger(StatsReportServiceImpl.class);

	@Resource(name = "statsReportDao")
	protected StatsReportDao statsReportDao;
	
	/**
	 * 통계 데이터 엑셀 업로드 이력 내역을 조회한다.
	 */
	public List<Map<String, Object>>  selectListExcelUpload(Map<String, Object> param) throws Exception {
	    logger.debug(param);
	    
		return statsReportDao.selectExcelUploadList(param);
	}
	
	/**
	 * 업종별  현황을 가져온다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIndustryGraph(Map<String, Object> param) throws Exception {

		return statsReportDao.selectIndustryGraph(param);
	}
	
	/**
	 *  규모 현황을 가져온다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectScaleGraph(Map<String, Object> param) throws Exception {
       	return statsReportDao.selectScaleGraph(param);
        	
	}

	/**
	 * 3년간 주요 지표를 가져온다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMajorIndices(Map<String, Object> param) throws Exception {

		return statsReportDao.selectMajorIndices(param);
	}
	/**
	 * 통계해설서 내용을 가져온다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStatsInfoMValues(Map<String, Object> param) throws Exception {

		return statsReportDao.selectStatsInfoMValues(param);
	}

}
