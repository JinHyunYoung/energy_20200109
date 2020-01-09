package kr.or.wabis.support.service;

import java.util.List;
import java.util.Map;

public interface DictionaryService {

	/**
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPortalDictionaryPageList(Map<String, Object> param) throws Exception;
	
	
	
	/**
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> searchTermHistoryTop5(Map<String, Object> param) throws Exception;

}
