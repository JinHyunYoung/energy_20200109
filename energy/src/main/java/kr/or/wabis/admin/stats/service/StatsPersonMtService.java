package kr.or.wabis.admin.stats.service;

import java.util.List;
import java.util.Map;

public interface StatsPersonMtService {
    
    public List<Map<String, Object>>  selectPersonList(Map<String, Object> param) throws Exception;
	public int insertListExcelUpload(Map<String, Object> param ) throws Exception;

    public List<Map<String, Object>> personExcelUpload(Map<String, Object> param, List<Map<String, Object>> data) throws Exception;
    public List<Map<String, Object>> personExcelValid(Map<String, Object> param, List<Map<String, Object>> data) throws Exception;
	public int deleteExcelUpload(Map<String, Object> param ) throws Exception ;

}
