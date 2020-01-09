package kr.or.wabis.admin.stats.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.stats.StatsReportDao;
import kr.or.wabis.framework.util.StringUtil;

/**
 * @author P068995
 *
 */
@Service("statsPersonMtService")
public class StatsPersonMtServiceImpl implements StatsPersonMtService {

	private final static Logger logger = Logger.getLogger(StatsPersonMtServiceImpl.class);

	@Resource(name = "statsReportDao")
	protected StatsReportDao statsReportDao;

	/**
	 * 통계 모집단 내역 조회한다.
	 */
	public List<Map<String, Object>>  selectPersonList(Map<String, Object> param) throws Exception {
	    
		return statsReportDao.selectPersonList(param);
	}
		
	/**
	 * 통계 데이터 엑셀 업로드 이력 내역을 등록한다.
	 */
	public int insertListExcelUpload(Map<String, Object> param) throws Exception {
	    
		return statsReportDao.insertExcelUploadList(param);
	}
	

	
		
	/**
	 * 통계 데이터 엑셀 파일에서 업종별 자료를 저장한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> personExcelValid(Map<String, Object> param, List<Map<String, Object>> datas ) throws Exception {
	    ArrayList rowExcel = null;
	    String message = "";
	    List<Map<String, Object>> results = new ArrayList();
	    
	    String bs_yy =  (String)param.get("bs_yy");

	    for(int i = 2; i < datas.size();i++){  //헤더가 있어서 데이터가 3에서부터 시작함
	    	
	    	rowExcel = (ArrayList)datas.get(i);
	    	
	    	Map<String, Object> rowData = new HashMap<String, Object>();
	    	Map<String, Object> queryParam = new HashMap<String, Object>();

	    	message="";//row마다 메세지 초기화
	    	
	    	rowData.put("bs_yy", bs_yy);
	    	
	    	String smpl_cd = StringUtil.nvl((String)rowExcel.get(0),"");
	    	if (smpl_cd.equals("")) {
	    		message += "표본여부는 필수입니다.<br/>";
	    	} else {
				rowData.put("smpl_cd", smpl_cd);
    			queryParam.put("gubun", "SMPL_CD");
	    		queryParam.put("code", smpl_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);
	    		if (nameMap == null) {
	    			rowData.put("smpl_nm", "");
		    		message += "등록되지 않은 표본 여부 코드입니다.<br/>";
	    		} else {
	    			rowData.put("smpl_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}	    

	    	String inds_tp_cd = StringUtil.nvl((String)rowExcel.get(2),"");
    		inds_tp_cd = "" + (int)(Double.parseDouble(inds_tp_cd));
	    	
	    	if (inds_tp_cd.equals("")) {
	    		message += "산업 구분은 필수입니다.<br/>";
	    	} else {
	    		inds_tp_cd = "" + (int)(Double.parseDouble(inds_tp_cd));
				rowData.put("inds_tp_cd", inds_tp_cd);
    			queryParam.put("gubun", "INDS_TP_CD");
	    		queryParam.put("code", inds_tp_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);
	    		if (nameMap == null) {
	    			rowData.put("inds_tp_nm", "");
		    		message += "등록되지 않은 산업 구분입니다.<br/>";
	    		} else {
	    			rowData.put("inds_tp_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}
	    	
	    	String wbiz_tp_l_cd = StringUtil.nvl((String)rowExcel.get(4),"");
	    	if (wbiz_tp_l_cd.equals("")) {
	    		message += "대분류코드는 필수입니다.<br/>";
	    	} else {
	    		wbiz_tp_l_cd = "" + (int)(Double.parseDouble(wbiz_tp_l_cd));
	    		if(wbiz_tp_l_cd.length()==1){
	    			wbiz_tp_l_cd = "0"+wbiz_tp_l_cd;
	    		}
				rowData.put("wbiz_tp_l_cd", wbiz_tp_l_cd);
		    	queryParam.put("wbiz_tp_l_cd", wbiz_tp_l_cd);
	    		queryParam.put("wbiz_cd_tp", "L");
	    		Map<String, Object> nameMap = statsReportDao.selectCategory(queryParam);
	    		if (nameMap == null) {
	    			rowData.put("wbiz_tp_l_nm", "");
		    		message += "등록되지 않은 대분류 코드입니다.<br/>";
	    		} else {
	    			rowData.put("wbiz_tp_l_nm", StringUtil.nvl(nameMap.get("wbiz_clsf_nm")));
	    		}
	    	}
	    	
	    	
	    	
	    	String wbiz_tp_m_cd = StringUtil.nvl((String)rowExcel.get(6),"");
	    	if (wbiz_tp_m_cd.equals("")) {
	    		message += "중분류코드는 필수입니다.<br/>";
	    	} else {
		    	rowData.put("wbiz_tp_m_cd", wbiz_tp_m_cd);
		    	queryParam.put("wbiz_tp_m_cd", wbiz_tp_m_cd);
	    		queryParam.put("wbiz_cd_tp", "M");
	    		Map<String, Object> nameMap = statsReportDao.selectCategory(queryParam);
	    		if (nameMap == null) {
			    	rowData.put("wbiz_tp_m_nm", "");
		    		message += "등록되지 않은 중분류 코드입니다.<br/>";
	    		} else{
			    	rowData.put("wbiz_tp_m_nm", StringUtil.nvl(nameMap.get("wbiz_clsf_nm")));
	    		}
	    	}
	  
	    	String wbiz_tp_s_cd = StringUtil.nvl((String)rowExcel.get(8),"");
	    	if (wbiz_tp_s_cd.equals("")) {
	    		message += "세분류코드는 필수입니다.<br/>";
	    	} else {
	    		rowData.put("wbiz_tp_s_cd", wbiz_tp_s_cd);
	    		queryParam.put("wbiz_tp_s_cd", wbiz_tp_s_cd);
	    		queryParam.put("wbiz_cd_tp", "S");
	    		Map<String, Object> nameMap = statsReportDao.selectCategory(queryParam);

	    		if (nameMap == null) {
	    			rowData.put("wbiz_tp_s_nm", "");
		    		message += "등록되지 않은 세분류 코드입니다.<br/>";
	    		} else{
	    			rowData.put("wbiz_tp_s_nm", StringUtil.nvl(nameMap.get("wbiz_clsf_nm")));
	    		}
	    	}

	    	String biz_reg_no = StringUtil.nvl((String)rowExcel.get(10),"");
	    	if (biz_reg_no.equals("")) {
	    		message += "세분류코드는 필수입니다.<br/>";
	    	} else {
	    		rowData.put("biz_reg_no", biz_reg_no);
	    	}

	    	String cmpy_nm = StringUtil.nvl((String)rowExcel.get(11),"");
	    	if (cmpy_nm.equals("")) {
	    		message += "세분류코드는 필수입니다.<br/>";
	    	} else {
	    		rowData.put("cmpy_nm", cmpy_nm);
	    	}
	    	
	    	String scale_cd = StringUtil.nvl((String)rowExcel.get(17),"");
	    	if (scale_cd.equals("")) {
	    		message += "규모코드는 필수입니다.<br/>";
	    	} else{
	    		rowData.put("scale_cd", scale_cd);
    			queryParam.put("gubun", "SCALE_CD");
	    		queryParam.put("code", scale_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);
	    		if (nameMap != null) {
		    		message += "등록되지 않은 규모코드입니다.<br/>";
	    			rowData.put("scale_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}

	    	if(!message.equals("")) {
	    		rowData.put("status", "실패 사유 : "+message);
		    	results.add(rowData);
	    	}

	    }//for

		return results;
		
	}
			
	/**
	 * 통계 데이터 엑셀 파일에서 업종별 자료를 저장한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> personExcelUpload(Map<String, Object> param, List<Map<String, Object>> datas ) throws Exception {
	    ArrayList rowExcel = null;
	    String message = "";
	    List<Map<String, Object>> results = new ArrayList();
	    
	    String bs_yy =  (String)param.get("bs_yy");

	    for(int i = 2; i < datas.size();i++){  //헤더가 있어서 데이터가 3에서부터 시작함
	    	
	    	rowExcel = (ArrayList)datas.get(i);
	    	
	    	Map<String, Object> rowData = new HashMap<String, Object>();
	    	Map<String, Object> queryParam = new HashMap<String, Object>();

	    	message="";//row마다 메세지 초기화
	    	
	    	rowData.put("bs_yy", bs_yy);

	    	String smpl_cd = StringUtil.nvl((String)rowExcel.get(0),"");
	    	if (smpl_cd.equals("")) {
	    		message += "표본여부는 필수입니다.<br/>";
	    	} else {
				rowData.put("smpl_cd", smpl_cd);
    			queryParam.put("gubun", "SMPL_CD");
	    		queryParam.put("code", smpl_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);
	    		if (nameMap == null) {
	    			rowData.put("smpl_nm", "");
		    		message += "등록되지 않은 표본여부 코드입니다.<br/>";
	    		} else {
	    			rowData.put("smpl_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}	    
	    	
	    	String inds_tp_cd = StringUtil.nvl((String)rowExcel.get(2),"");
	    	if (inds_tp_cd.equals("")) {
	    		message += "산업 구분은 필수입니다.<br/>";
	    	} else {
	    		inds_tp_cd = "" + (int)(Double.parseDouble(inds_tp_cd));
				rowData.put("inds_tp_cd", inds_tp_cd);
    			queryParam.put("gubun", "INDS_TP_CD");
	    		queryParam.put("code", inds_tp_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);
	    		if (nameMap == null) {
	    			rowData.put("inds_tp_nm", "");
		    		message += "등록되지 않은 산업 구분입니다.<br/>";
	    		} else {
	    			rowData.put("inds_tp_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}
	    	
	    	String wbiz_tp_l_cd = StringUtil.nvl((String)rowExcel.get(4),"");

	    	if (wbiz_tp_l_cd.equals("")) {
	    		message += "대분류코드는 필수입니다.<br/>";
	    	} else {
	    		wbiz_tp_l_cd = "" + (int)(Double.parseDouble(wbiz_tp_l_cd));
	    		if(wbiz_tp_l_cd.length()==1){
	    			wbiz_tp_l_cd = "0"+wbiz_tp_l_cd;
	    		}
		    	queryParam.put("wbiz_tp_l_cd", wbiz_tp_l_cd);
				rowData.put("wbiz_tp_l_cd", wbiz_tp_l_cd);
	    		queryParam.put("wbiz_cd_tp", "L");
	    		Map<String, Object> nameMap = statsReportDao.selectCategory(queryParam);
	    		if (nameMap == null) {
	    			rowData.put("wbiz_tp_l_nm", "");
		    		message += "등록되지 않은 대분류 코드입니다.<br/>";
	    		} else {
	    			rowData.put("wbiz_tp_l_nm", StringUtil.nvl(nameMap.get("wbiz_clsf_nm")));
	    		}
	    	}
	    	
	    	
	    	String wbiz_tp_m_cd = StringUtil.nvl((String)rowExcel.get(6),"");
	    	if (wbiz_tp_m_cd.equals("")) {
	    		message += "중분류코드는 필수입니다.<br/>";
	    	} else {
		    	rowData.put("wbiz_tp_m_cd", wbiz_tp_m_cd);
		    	queryParam.put("wbiz_tp_m_cd", wbiz_tp_m_cd);
	    		queryParam.put("wbiz_cd_tp", "M");
	    		Map<String, Object> nameMap = statsReportDao.selectCategory(queryParam);
	    		if (nameMap == null) {
			    	rowData.put("wbiz_tp_m_nm", "");
		    		message += "등록되지 않은 중분류 코드입니다.<br/>";
	    		} else{
			    	rowData.put("wbiz_tp_m_nm", StringUtil.nvl(nameMap.get("wbiz_clsf_nm")));
	    		}
	    	}
	  
	    	String wbiz_tp_s_cd = StringUtil.nvl((String)rowExcel.get(8),"");
	    	if (wbiz_tp_s_cd.equals("")) {
	    		message += "세분류코드는 필수입니다.<br/>";
	    	} else {
	    		rowData.put("wbiz_tp_s_cd", wbiz_tp_s_cd);
	    		queryParam.put("wbiz_tp_s_cd", wbiz_tp_s_cd);
	    		queryParam.put("wbiz_cd_tp", "S");
	    		Map<String, Object> nameMap = statsReportDao.selectCategory(queryParam);

	    		if (nameMap == null) {
	    			rowData.put("wbiz_tp_s_nm", "");
		    		message += "등록되지 않은 세분류 코드입니다.<br/>";
	    		} else{
	    			rowData.put("wbiz_tp_s_nm", StringUtil.nvl(nameMap.get("wbiz_clsf_nm")));
	    		}
	    	}

	    	String biz_reg_no = StringUtil.nvl((String)rowExcel.get(10),"");
	    	if (!biz_reg_no.equals("")) {
	    		rowData.put("biz_reg_no", biz_reg_no);
	    	}

	    	String cmpy_nm = StringUtil.nvl((String)rowExcel.get(11),"");
	    	if (!cmpy_nm.equals("")) {
	    		rowData.put("cmpy_nm", cmpy_nm);
	    	}
	    	
	    	rowData.put("addr1", StringUtil.nvl((String)rowExcel.get(12),""));
	    	rowData.put("addr2", StringUtil.nvl((String)rowExcel.get(13),""));
	    	rowData.put("addr3", StringUtil.nvl((String)rowExcel.get(14),""));

	    	String biz_cate_cd = StringUtil.nvl((String)rowExcel.get(15),"");
	    	if (!biz_cate_cd.equals("")) {
	    		rowData.put("biz_cate_cd", biz_cate_cd);
    			queryParam.put("gubun", "STATS_CATE_CD");
	    		queryParam.put("code", biz_cate_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);
	    		if (nameMap != null) {
	    			rowData.put("biz_cate_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}
	    	
	    	rowData.put("empl_cnt", StringUtil.nvl((String)rowExcel.get(16),""));
	    	
	    	String scale_cd = StringUtil.nvl((String)rowExcel.get(17),"");
	    	if (!scale_cd.equals("")) {
	    		rowData.put("scale_cd", scale_cd);
    			queryParam.put("gubun", "SCALE_CD");
	    		queryParam.put("code", scale_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);
	    		if (nameMap != null) {
	    			rowData.put("scale_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}
	    	
	    	if(message.equals("")) {
				statsReportDao.insertPersonList(rowData);
				
	    		rowData.put("status", "성공");
	    		
	    	} else{
	    		rowData.put("status", "실패 사유 : "+message);
	    	}
	    	results.add(rowData);
	    }//for

		return results;
		
	}
		
	/**
	 * 통계 데이터 엑셀 파일에서 모집단 명부를 삭제한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteExcelUpload(Map<String, Object> param ) throws Exception {
	    int result = statsReportDao.deletePersonList(param);
    	result = statsReportDao.deleteExcelUploadList(param);
	    return result;
	}


}
