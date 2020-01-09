package kr.or.wabis.stats.service;

import java.util.List;
import java.util.Map;

public interface StatsReportService {

	public List<Map<String, Object>>  selectListExcelUpload(Map<String, Object> param) throws Exception;
	
    public List<Map<String, Object>> selectIndustryGraph(Map<String, Object> param) throws Exception;
    
    public List<Map<String, Object>> selectScaleGraph(Map<String, Object> param) throws Exception;
    
	public List<Map<String, Object>> selectMajorIndices(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> selectStatsInfoMValues(Map<String, Object> param) throws Exception ;


}
