package kr.or.wabis.admin.stats.service;

import java.util.List;
import java.util.Map;

public interface StatsExcelUploadMtService {
    
    public List<Map<String, Object>>  selectListExcelUpload(Map<String, Object> param) throws Exception;
	public int insertListExcelUpload(Map<String, Object> param ) throws Exception;
    public List<Map<String, Object>> industryExcelUpload(Map<String, Object> param, List<Map<String, Object>> data) throws Exception;
    public List<Map<String, Object>> industryExcelValid(Map<String, Object> param, List<Map<String, Object>> data) throws Exception;
    public List<Map<String, Object>> scaleExcelUpload(Map<String, Object> param, List<Map<String, Object>> data) throws Exception;
    public List<Map<String, Object>> scaleExcelValid(Map<String, Object> param, List<Map<String, Object>> data) throws Exception;
	public int deleteExcelUpload(Map<String, Object> param ) throws Exception ;

}
