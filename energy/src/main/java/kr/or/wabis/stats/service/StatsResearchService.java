package kr.or.wabis.stats.service;

import java.util.List;
import java.util.Map;

public interface StatsResearchService {

	public List<Map<String, Object>>  selectResearchCodeList(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>>  selectResearchItemTreeList(Map<String, Object> param) throws Exception ;
	public List<Map<String, Object>>  selectResearchTableList(Map<String, Object> param) throws Exception ;
	public List<Map<String, Object>>  selectResearchTableHeader(Map<String, Object> param) throws Exception ;
	
}
