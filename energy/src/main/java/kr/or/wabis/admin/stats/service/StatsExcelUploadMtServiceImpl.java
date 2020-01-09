package kr.or.wabis.admin.stats.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.NumberUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.stats.StatsReportDao;
import kr.or.wabis.framework.util.StringUtil;

/**
 * @author P068995
 *
 */
@Service("statsExcelUploadMtService")
public class StatsExcelUploadMtServiceImpl implements StatsExcelUploadMtService {

	private final static Logger logger = Logger.getLogger(StatsExcelUploadMtServiceImpl.class);

	@Resource(name = "statsReportDao")
	protected StatsReportDao statsReportDao;


	/**
	 * 통계 데이터 엑셀 업로드 이력 내역을 등록한다.
	 */
	public int insertListExcelUpload(Map<String, Object> param) throws Exception {
	    
		return statsReportDao.insertExcelUploadList(param);
	}
	
	/**
	 * 통계 데이터 엑셀 업로드 이력 내역을 조회한다.
	 */
	public List<Map<String, Object>>  selectListExcelUpload(Map<String, Object> param) throws Exception {
	    
		return statsReportDao.selectExcelUploadList(param);
	}
	
	/**
	 * 통계 데이터 엑셀 파일에서 규모별 자료를  저장한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> scaleExcelValid(Map<String, Object> param, List<Map<String, Object>> datas ) throws Exception {
	    ArrayList rowExcel = null;
	    String message = "";
	    List<Map<String, Object>> results = new ArrayList();
	    
	    String bs_yy =  (String)param.get("bs_yy");

	    
	    for(int i = 3; i < datas.size();i++){  //헤더가 있어서 데이터가 4에서부터 시작함
	    	rowExcel = (ArrayList)datas.get(i);
	    	
	    	Map<String, Object> rowData = new HashMap<String, Object>();
	    	message="";//row마다 메세지 초기화
	    	

	    	rowData.put("bs_yy", bs_yy);
	    	rowData.put("auth_id", param.get("s_auth_id"));

	    	Map<String, Object> queryParam = new HashMap<String, Object>();

	    	String scale_cd = (String)rowExcel.get(3);
	    	if (!scale_cd.equals("")) {
	    		scale_cd = "0" + (int)(Double.parseDouble(scale_cd));
	    	}
	    	
    		rowData.put("scale_cd", scale_cd);
	    	if (scale_cd.equals("")) {
	    		message += "규모코드는 필수입니다.<br/>";
	    	} else {
	    		queryParam.put("gubun", "SCALE_CD");
	    		queryParam.put("code", scale_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);

	    		if (nameMap == null) {
		    		message += "등록되지 않은 규모 코드입니다.<br/>";
	    			rowData.put("scale_nm", "");
	    			rowData.put("status", message);
	    		} else{
	    			rowData.put("scale_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}

	    	if(!message.equals("")) {
	    		results.add(rowData);
	    	}
	    }//for

		return results;
		
	}
	/**
	 * 통계 데이터 엑셀 파일에서 규모별 자료를  저장한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> scaleExcelUpload(Map<String, Object> param, List<Map<String, Object>> datas ) throws Exception {
	    ArrayList rowExcel = null;
	    String message = "";
	    List<Map<String, Object>> results = new ArrayList();
	    
	    String bs_yy =  (String)param.get("bs_yy");

	    for(int i = 3; i < datas.size();i++){  //헤더가 있어서 데이터가 4에서부터 시작함
	    	rowExcel = (ArrayList)datas.get(i);
	    	
	    	Map<String, Object> rowData = new HashMap<String, Object>();
	    	message="";//row마다 메세지 초기화
	    	

	    	rowData.put("bs_yy", bs_yy);
	    	rowData.put("auth_id", param.get("s_auth_id"));

	    	Map<String, Object> queryParam = new HashMap<String, Object>();

	    	String scale_cd = (String)rowExcel.get(3);
	    	if (!scale_cd.equals("")) {
	    		scale_cd = "0" + (int)(Double.parseDouble(scale_cd));
	    	}
	    	
    		rowData.put("scale_cd", scale_cd);
	    	if (scale_cd.equals("")) {
	    		message += "규모코드는 필수입니다.<br/>";
	    	} else {
	    		queryParam.put("gubun", "SCALE_CD");
	    		queryParam.put("code", scale_cd);
	    		Map<String, Object> nameMap = statsReportDao.selectCode(queryParam);

	    		if (nameMap == null) {
	    			rowData.put("scale_nm", "");
		    		message += "등록되지 않은 규모 코드입니다.<br/>";
	    		} else{
	    			rowData.put("scale_nm", StringUtil.nvl(nameMap.get("code_nm")));
	    		}
	    	}

	    	if(message.equals("")) {
		    	// 사업체현황 / 물산업사업체수 /  
				scaleDataInsert(rowExcel, rowData, "01-01", 5, 5);
				// 사업체현황 / 1-2 주사업유형 / 
				scaleDataInsert(rowExcel, rowData, "01-02", 10, 5);
				// 사업체현황 / 1-3 제공서비스의 특성(%) / S 
				scaleDataInsert(rowExcel, rowData, "01-03", 15, 6 );
				// 사업체현황 / (1-4) 조직형태(%) / X 
				scaleDataInsert(rowExcel, rowData, "01-04", 21, 4 );
				// 사업체현황 / (1-5) 기업유형(%) / X 
				scaleDataInsert(rowExcel, rowData, "01-05", 25, 5 );
				// 사업체현황 / (1-6) 사업연한(%) / AG 
				scaleDataInsert(rowExcel, rowData, "01-06", 30, 5 );
				// 사업체현황 / (1-7) 사업체 유형(%) / AL 
				scaleDataInsert(rowExcel, rowData, "01-07", 35, 3 );
				// 2. 수출입현황 = 해외진출현황 / (2-1) 해외진출형태별 사업체 수(규모별)(%) /
				scaleDataInsert(rowExcel, rowData, "02-01", 38, 5 );
				// 2. 수출입현황 = 해외진출현황 / (2-2) 향후 해외진출 계획 및 진출 형태(%) / 
				scaleDataInsert(rowExcel, rowData, "02-02", 43, 7 );
				// 2. 수출입현황 = 해외진출현황 / (2-3) 수출액 / 
				scaleDataInsert(rowExcel, rowData, "02-03", 50, 1 );
				// 2. 수출입현황 = 해외진출현황 / (2-4) 최근 2개년 품목별 수출액 /  
				scaleDataInsert(rowExcel, rowData, "02-04", 51, 3 );
				// 2. 수출입현황 = 해외진출현황 / (2-5) 품목별 수출국가 및 수출액 /  
				scaleDataInsert(rowExcel, rowData, "02-05", 25, 3 );
				// 2. 수출입현황 = 해외진출현황 / (2-6) 수출 증감 현황 (%) / 
				scaleDataInsert(rowExcel, rowData, "02-06", 79, 3 );
				// 2. 수출입현황 = 해외진출현황 / (2-7) 수출 증가 원인(%) / 
				scaleDataInsert(rowExcel, rowData, "02-07", 82, 6 );
				// 2. 수출입현황 = 해외진출현황 / (2-8) 수출 감소 원인(%) /  
				scaleDataInsert(rowExcel, rowData, "02-08", 88, 7 );
				// 2. 수출입현황 = 해외진출현황 / (2-9) 수입액 / 
				scaleDataInsert(rowExcel, rowData, "02-09", 95, 1 );
				// 2. 수출입현황 = 해외진출현황 / (2-10) 원재료의 국·내외 조달비율(%) / 
				scaleDataInsert(rowExcel, rowData, "02-10", 96, 2 );
				// 2. 수출입현황 = 해외진출현황 / (2-11)  원재료 해외조달 국가(%) / 
				scaleDataInsert(rowExcel, rowData, "02-11", 98, 9 );
				// 2. 수출입현황 = 해외진출현황 / (2-12)  원재료 해외조달 국가(%) /  
				scaleDataInsert(rowExcel, rowData, "02-12", 107, 6 );
				// 2. 수출입현황 = 해외진출현황 / (2-13)  원재료 해외조달시 출처(%) /  
				scaleDataInsert(rowExcel, rowData, "02-13", 113, 6 );
				// 3. 인력현황 = 해외진출현황 / (3-1) 총 종사자수 /  
				scaleDataInsert(rowExcel, rowData, "03-01", 119, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-2) 물산업 종사자 수 /  
				scaleDataInsert(rowExcel, rowData, "03-02", 124, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-3) 자격증 보유자수 / 
				scaleDataInsert(rowExcel, rowData, "03-03", 129, 2 );
				// 3. 인력현황 = 해외진출현황 / (3-4) 물산업관련 신규채용자 수 / 
				scaleDataInsert(rowExcel, rowData, "03-04", 131, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-5) 물산업 종사자의 부족인원 수 / 
				scaleDataInsert(rowExcel, rowData, "03-05", 136, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-6) 물산업관련 인력 채용계획 / 
				scaleDataInsert(rowExcel, rowData, "03-06", 141, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-7) 인력에 대한 교육․훈련 형태(%) /  
				scaleDataInsert(rowExcel, rowData, "03-07", 146, 5 );
				// 4. 계약 및 입찰 현황 / (4-1) 평균입찰 건수(건) /  
				scaleDataInsert(rowExcel, rowData, "04-01", 151, 1 );
				// 4. 계약 및 입찰 현황 / (4-2) 입찰정보 획득경로(%) /  
				scaleDataInsert(rowExcel, rowData, "04-02", 152, 7 );
				// 4. 계약 및 입찰 현황 / (4-3) 평균판매 (수주) 계약 건수(건) /  
				scaleDataInsert(rowExcel, rowData, "04-03", 159, 1 );
				// 4. 계약 및 입찰 현황 / (4-4) 판매 및 수주계약 방법(%) /  
				scaleDataInsert(rowExcel, rowData, "04-04", 160, 5 );
				// 5. 경영현황(매출액) / (5-1) 전체 매출액(백만원) /  
				scaleDataInsert(rowExcel, rowData, "05-01", 165, 1 );
				// 5. 경영현황(매출액) / (5-2) 물산업 매출액(백만원) /  
				scaleDataInsert(rowExcel, rowData, "05-02", 166, 1 );
				// 5. 경영현황(매출액) / (5-3) 영업비용(백만원) /  
				scaleDataInsert(rowExcel, rowData, "05-03", 167, 1 );
				// 5. 경영현황(매출액) / (5-4) 제조원가 및 판매비와 관리비(백만원) /  
				scaleDataInsert(rowExcel, rowData, "05-04", 168, 2 );
				// 5. 경영현황(매출액) / (5-5) 매출액 발생경로 현황(%) /  
				scaleDataInsert(rowExcel, rowData, "05-05", 170, 4 );
				// 5. 경영현황(매출액) / (5-6) 주거래 업체의 업종(%) /  
				scaleDataInsert(rowExcel, rowData, "05-06", 174, 6 );
				// 5. 경영현황(매출액) / (5-7) 주거래업체와 거래 시 애로사항(%)  /  
				scaleDataInsert(rowExcel, rowData, "05-07", 180, 8 );
				// 5. 경영현황(매출액) / (5-8) 규모별, 업종별 연구개발비(백만원) /  
				scaleDataInsert(rowExcel, rowData, "05-08", 188, 2 );
				// 5. 경영현황(매출액) / (5-9) 연구개발비 비용 지출 여부(%) /  
				scaleDataInsert(rowExcel, rowData, "05-09", 190, 2 );
				// 5. 경영현황(매출액) / (5-10) 업종별 연구개발시 애로사항(%) /  
				scaleDataInsert(rowExcel, rowData, "05-10", 192, 8 );
				
				// 6. 인증현황 / (6-1) 국내 검․인증현황(%) /  
				scaleDataInsert(rowExcel, rowData, "06-01", 200, 12 );
				// 6. 인증현황 / (6-2) 해외 검․인증현황(%)/  
				scaleDataInsert(rowExcel, rowData, "06-02", 212, 12 );
				// 6. 인증현황 / (6-3) 해외인증 문제로 수출 시 지장을 받은 경험(%) /  
				scaleDataInsert(rowExcel, rowData, "06-03", 224, 5 );
				// 6. 인증현황 / (6-4) 해외인증 취득 시 애로사항(%) /  
				scaleDataInsert(rowExcel, rowData, "06-04", 229, 8 );
				// 6. 인증현황 / (6-5) 해외인증 취득 시 가장 필요한 요소(%)/  
				scaleDataInsert(rowExcel, rowData, "06-05", 237, 6 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-1) 특허권 보유 및 활용현황(%) /  
				scaleDataInsert(rowExcel, rowData, "07-01", 243, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-2) 실용신안권 보유 및 활용 현황(%) /  
				scaleDataInsert(rowExcel, rowData, "07-02", 246, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-3) 디자인권 보유 및 활용현황(%) /  
				scaleDataInsert(rowExcel, rowData, "07-03", 249, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-4) 상표권 보유 및 활용현황(%) /  
				scaleDataInsert(rowExcel, rowData, "07-04", 252, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-5) 출원 보유 및 활용 현황(%) /  
				scaleDataInsert(rowExcel, rowData, "07-05", 255, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-6) 등록 보유 및 활용현황(%) /  
				scaleDataInsert(rowExcel, rowData, "07-06", 258, 3 );

	    		rowData.put("status", "성공");
	    		
	    	} else{
	    		rowData.put("status", "실패");
	    	}
	    	results.add(rowData);
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
	public List<Map<String, Object>> industryExcelValid(Map<String, Object> param, List<Map<String, Object>> datas ) throws Exception {
	    ArrayList rowExcel = null;
	    String message = "";
	    List<Map<String, Object>> results = new ArrayList();
	    
	    String bs_yy =  (String)param.get("bs_yy");

	    for(int i = 3; i < datas.size();i++){  //헤더가 있어서 데이터가 3에서부터 시작함
	    	
	    	rowExcel = (ArrayList)datas.get(i);
	    	
	    	Map<String, Object> rowData = new HashMap<String, Object>();
	    	Map<String, Object> queryParam = new HashMap<String, Object>();

	    	message="";//row마다 메세지 초기화
	    	
	    	rowData.put("bs_yy", bs_yy);


	    	String inds_tp_cd = StringUtil.nvl((String)rowExcel.get(3),"");
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
	    	
	    	String wbiz_tp_l_cd = StringUtil.nvl((String)rowExcel.get(5),"");
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
	    	
	    	
	    	
	    	String wbiz_tp_m_cd = StringUtil.nvl((String)rowExcel.get(7),"");
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
	  
	    	String wbiz_tp_s_cd = StringUtil.nvl((String)rowExcel.get(9),"");
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
	public List<Map<String, Object>> industryExcelUpload(Map<String, Object> param, List<Map<String, Object>> datas ) throws Exception {
	    ArrayList rowExcel = null;
	    String message = "";
	    List<Map<String, Object>> results = new ArrayList();
	    
	    String bs_yy =  (String)param.get("bs_yy");

	    for(int i = 3; i < datas.size();i++){  //헤더가 있어서 데이터가 3에서부터 시작함
	    	
	    	rowExcel = (ArrayList)datas.get(i);
	    	
	    	Map<String, Object> rowData = new HashMap<String, Object>();
	    	Map<String, Object> queryParam = new HashMap<String, Object>();

	    	message="";//row마다 메세지 초기화
	    	
	    	rowData.put("bs_yy", bs_yy);

	    	String inds_tp_cd = StringUtil.nvl((String)rowExcel.get(3),"");
	    	if (!inds_tp_cd.equals("")) {//엑셀에서 수치로 설정되어 올라오면 문자로 보정
	    		inds_tp_cd = "" + (int)(Double.parseDouble(inds_tp_cd));
	    	}
	    	
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
	    	
	    	String wbiz_tp_l_cd = StringUtil.nvl((String)rowExcel.get(5),"");

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
	    	
	    	
	    	String wbiz_tp_m_cd = StringUtil.nvl((String)rowExcel.get(7),"");
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
	  
	    	String wbiz_tp_s_cd = StringUtil.nvl((String)rowExcel.get(9),"");
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

	    	if(message.equals("")) {
		    	// 사업체현황 / 물산업사업체수 /  
				industryDataInsert(rowExcel, rowData, "01-01", 11, 5);
				// 사업체현황 / 1-2 주사업유형 / 
				industryDataInsert(rowExcel, rowData, "01-02", 16, 5);
				// 사업체현황 / 1-3 제공서비스의 특성(%) / S 
				industryDataInsert(rowExcel, rowData, "01-03", 21, 6 );
				// 사업체현황 / (1-4) 조직형태(%) / X 
				industryDataInsert(rowExcel, rowData, "01-04", 27, 4 );
				// 사업체현황 / (1-5) 기업유형(%) / X 
				industryDataInsert(rowExcel, rowData, "01-05", 31, 5 );
				// 사업체현황 / (1-6) 사업연한(%) / AG 
				industryDataInsert(rowExcel, rowData, "01-06", 36, 5 );
				// 사업체현황 / (1-7) 사업체 유형(%) / AL 
				industryDataInsert(rowExcel, rowData, "01-07", 41, 3 );
				// 2. 수출입현황 = 해외진출현황 / (2-1) 해외진출형태별 사업체 수(규모별)(%) /
				industryDataInsert(rowExcel, rowData, "02-01", 44, 5 );
				// 2. 수출입현황 = 해외진출현황 / (2-2) 향후 해외진출 계획 및 진출 형태(%) / 
				industryDataInsert(rowExcel, rowData, "02-02", 49, 7 );
				// 2. 수출입현황 = 해외진출현황 / (2-3) 수출액 / 
				industryDataInsert(rowExcel, rowData, "02-03", 56, 1 );
				// 2. 수출입현황 = 해외진출현황 / (2-4) 최근 2개년 품목별 수출액 /  
				industryDataInsert(rowExcel, rowData, "02-04", 57, 3 );
				// 2. 수출입현황 = 해외진출현황 / (2-5) 품목별 수출국가 및 수출액 /  
				industryDataInsert(rowExcel, rowData, "02-05", 60, 25 );
				// 2. 수출입현황 = 해외진출현황 / (2-6) 수출 증감 현황 (%) / 
				industryDataInsert(rowExcel, rowData, "02-06", 85, 3 );
				// 2. 수출입현황 = 해외진출현황 / (2-7) 수출 증가 원인(%) / 
				industryDataInsert(rowExcel, rowData, "02-07", 88, 6 );
				// 2. 수출입현황 = 해외진출현황 / (2-8) 수출 감소 원인(%) /  
				industryDataInsert(rowExcel, rowData, "02-08", 94, 7 );
				// 2. 수출입현황 = 해외진출현황 / (2-9) 수입액 / 
				industryDataInsert(rowExcel, rowData, "02-09", 101, 1 );
				// 2. 수출입현황 = 해외진출현황 / (2-10) 원재료의 국·내외 조달비율(%) / 
				industryDataInsert(rowExcel, rowData, "02-10", 102, 2 );
				// 2. 수출입현황 = 해외진출현황 / (2-11)  원재료 해외조달 국가(%) / 
				industryDataInsert(rowExcel, rowData, "02-11", 104, 9 );
				// 2. 수출입현황 = 해외진출현황 / (2-12)  원재료 해외조달 국가(%) /  
				industryDataInsert(rowExcel, rowData, "02-12", 113, 6 );
				// 2. 수출입현황 = 해외진출현황 / (2-13)  원재료 해외조달시 출처(%) /  
				industryDataInsert(rowExcel, rowData, "02-13", 119, 6 );
				// 3. 인력현황 = 해외진출현황 / (3-1) 총 종사자수 /  
				industryDataInsert(rowExcel, rowData, "03-01", 125, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-2) 물산업 종사자 수 /  
				industryDataInsert(rowExcel, rowData, "03-02", 130, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-3) 자격증 보유자수 / 
				industryDataInsert(rowExcel, rowData, "03-03", 135, 2 );
				// 3. 인력현황 = 해외진출현황 / (3-4) 물산업관련 신규채용자 수 / 
				industryDataInsert(rowExcel, rowData, "03-04", 137, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-5) 물산업 종사자의 부족인원 수 / 
				industryDataInsert(rowExcel, rowData, "03-05", 142, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-6) 물산업관련 인력 채용계획 / 
				industryDataInsert(rowExcel, rowData, "03-06", 147, 5 );
				// 3. 인력현황 = 해외진출현황 / (3-7) 인력에 대한 교육․훈련 형태(%) /  
				industryDataInsert(rowExcel, rowData, "03-07", 152, 5 );
				// 4. 계약 및 입찰 현황 / (4-1) 평균입찰 건수(건) /  
				industryDataInsert(rowExcel, rowData, "04-01", 157, 1 );
				// 4. 계약 및 입찰 현황 / (4-2) 입찰정보 획득경로(%) /  
				industryDataInsert(rowExcel, rowData, "04-02", 158, 7 );
				// 4. 계약 및 입찰 현황 / (4-3) 평균판매 (수주) 계약 건수(건) /  
				industryDataInsert(rowExcel, rowData, "04-03", 165, 1 );
				// 4. 계약 및 입찰 현황 / (4-4) 판매 및 수주계약 방법(%) /  
				industryDataInsert(rowExcel, rowData, "04-04", 166, 5 );
				// 5. 경영현황(매출액) / (5-1) 전체 매출액(백만원) /  
				industryDataInsert(rowExcel, rowData, "05-01", 171, 1 );
				// 5. 경영현황(매출액) / (5-2) 물산업 매출액(백만원) /  
				industryDataInsert(rowExcel, rowData, "05-02", 172, 1 );
				// 5. 경영현황(매출액) / (5-3) 영업비용(백만원) /  
				industryDataInsert(rowExcel, rowData, "05-03", 173, 1 );
				// 5. 경영현황(매출액) / (5-4) 제조원가 및 판매비와 관리비(백만원) /  
				industryDataInsert(rowExcel, rowData, "05-04", 174, 2 );
				// 5. 경영현황(매출액) / (5-5) 매출액 발생경로 현황(%) /  
				industryDataInsert(rowExcel, rowData, "05-05", 176, 4 );
				// 5. 경영현황(매출액) / (5-6) 주거래 업체의 업종(%) /  
				industryDataInsert(rowExcel, rowData, "05-06", 180, 6 );
				// 5. 경영현황(매출액) / (5-7) 주거래업체와 거래 시 애로사항(%)  /  
				industryDataInsert(rowExcel, rowData, "05-07", 186, 8 );
				// 5. 경영현황(매출액) / (5-8) 규모별, 업종별 연구개발비(백만원) /  
				industryDataInsert(rowExcel, rowData, "05-08", 194, 2 );
				// 5. 경영현황(매출액) / (5-9) 연구개발비 비용 지출 여부(%) /  
				industryDataInsert(rowExcel, rowData, "05-09", 196, 2 );
				// 5. 경영현황(매출액) / (5-10) 업종별 연구개발시 애로사항(%) /  
				industryDataInsert(rowExcel, rowData, "05-10", 198, 8 );
				
				// 6. 인증현황 / (6-1) 국내 검․인증현황(%) /  
				industryDataInsert(rowExcel, rowData, "06-01", 206, 12 );
				// 6. 인증현황 / (6-2) 해외 검․인증현황(%)/  
				industryDataInsert(rowExcel, rowData, "06-02", 218, 12 );
				// 6. 인증현황 / (6-3) 해외인증 문제로 수출 시 지장을 받은 경험(%) /  
				industryDataInsert(rowExcel, rowData, "06-03", 230, 5 );
				// 6. 인증현황 / (6-4) 해외인증 취득 시 애로사항(%) /  
				industryDataInsert(rowExcel, rowData, "06-04", 206, 8 );
				// 6. 인증현황 / (6-5) 해외인증 취득 시 가장 필요한 요소(%)/  
				industryDataInsert(rowExcel, rowData, "06-05", 243, 6 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-1) 특허권 보유 및 활용현황(%) /  
				industryDataInsert(rowExcel, rowData, "07-01", 249, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-2) 실용신안권 보유 및 활용 현황(%) /  
				industryDataInsert(rowExcel, rowData, "07-02", 252, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-3) 디자인권 보유 및 활용현황(%) /  
				industryDataInsert(rowExcel, rowData, "07-03", 255, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-4) 상표권 보유 및 활용현황(%) /  
				industryDataInsert(rowExcel, rowData, "07-04", 258, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-5) 출원 보유 및 활용 현황(%) /  
				industryDataInsert(rowExcel, rowData, "07-05", 261, 3 );
				// 7. 지적소유권 현황 = 경쟁력현황 / (7-6) 등록 보유 및 활용현황(%) /  
				industryDataInsert(rowExcel, rowData, "07-06", 264, 3 );
	    		rowData.put("status", "성공");
	    		
	    	} else{
	    		rowData.put("status", "실패 사유 : "+message);
	    	}
	    	results.add(rowData);
	    }//for

		return results;
		
	}
		
	private void industryDataInsert(ArrayList rowExcel, Map<String, Object> data,  String stat_s_cd, int nPos, int maxCode) throws Exception{
		String emptyData="";
		String point="";
		ArrayList<Object> list = new ArrayList<Object>();
		
		for (int i = 0; i < maxCode; i++) {//소분류 갯수 만큼 반복
			if( i>= 9){
				data.put("stats_s_cd", stat_s_cd+"-"+(i+1));//통계 분류 코드
			} else {
				data.put("stats_s_cd", stat_s_cd+"-0"+(i+1));//통계 분류 코드
			}
			point = StringUtil.trim(StringUtil.nvl(rowExcel.get(nPos+i)));
			emptyData += point;

			if (point.equals("") || point.equals("-")){
				point="0";
			}
			data.put("point", point);
			
			HashMap<String, Object> row = new HashMap<String, Object>();
			row.putAll(data);
			list.add(row);
			
		}
		
		if (!emptyData.equals("")) {//중분류 하위로 데이터가 없으면 레코드 삽입을 안함.
			HashMap<String, Object> rows = new HashMap<String, Object>();
			rows.put("list", list);
			statsReportDao.insertResearchIndustry(rows);
		}
		
	}

	private void scaleDataInsert(ArrayList rowExcel, Map<String, Object> data,  String stat_s_cd, int nPos, int maxCode) throws Exception{
		String emptyData="";
		String point="";
		ArrayList<Object> list = new ArrayList<Object>();
		
		for (int i = 0; i < maxCode; i++) {//소분류 갯수 만큼 반복
			if( i>= 9){
				data.put("stats_s_cd", stat_s_cd+"-"+(i+1));//통계 분류 코드
			} else {
				data.put("stats_s_cd", stat_s_cd+"-0"+(i+1));//통계 분류 코드
			}
			
			point = StringUtil.trim(StringUtil.nvl(rowExcel.get(nPos+i)));
			emptyData += point;

			if (point.equals("") || point.equals("-")){
				point="0";
			}
			data.put("point", point);
			
			HashMap<String, Object> row = new HashMap<String, Object>();
			row.putAll(data);
			list.add(row);
		}
		
		if (!emptyData.equals("")) {//중분류 하위로 데이터가 없으면 레코드 삽입을 안함.
			HashMap<String, Object> rows = new HashMap<String, Object>();
			rows.put("list", list);
			statsReportDao.insertResearchScale(rows);
		}
		
	}
	
	/**
	 * 통계 데이터 엑셀 파일에서 규모별 자료를  저장한다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteExcelUpload(Map<String, Object> param ) throws Exception {
	    String bs_yy =  StringUtil.nvl(param.get("bs_yy"));
	    //기준년도에 해당하는 자료 삭제
	    int result =1;
	    if (!bs_yy.equals("")) {
	    	String xls_tp =  StringUtil.nvl(param.get("xls_tp"));
	    	if (xls_tp.equals("1")) {
		    	statsReportDao.deleteResearchScale(param);
		    	statsReportDao.deleteResearchIndustry(param);
	    	}
	    	else{
	    		//모집단 명부 삭제 루틴 추가
	    	}
	    	statsReportDao.deleteExcelUploadList(param);
	    }
	    return result;
	}


}
