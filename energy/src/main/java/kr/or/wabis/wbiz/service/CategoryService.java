package kr.or.wabis.wbiz.service;

import java.util.List;
import java.util.Map;

public interface CategoryService {

	/**
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCategoryList(Map<String, Object> param) throws Exception;

	
}
