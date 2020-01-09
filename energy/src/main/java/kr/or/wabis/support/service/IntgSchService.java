package kr.or.wabis.support.service;

import java.util.List;
import java.util.Map;

public interface IntgSchService {

	/**
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIntgSchPageList(Map<String, Object> param) throws Exception;
	
	
	
	/**
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> searchIntgSchTop5(Map<String, Object> param) throws Exception;

}
