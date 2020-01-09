package kr.or.wabis.stats.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.ProjectConfigUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.stats.service.StatsReportService;
import kr.or.wabis.stats.service.StatsResearchService;

@Controller("statsResearchController")
public class StatsResearchController extends AbstractController {
    
    private Logger logger = Logger.getLogger(StatsResearchController.class);
    
    private final static String WEB_PATH = "/web/stats/";
    
    @Resource(name = "statsReportService")
    private StatsReportService statsReportService;

    @Resource(name = "statsResearchService")
    private StatsResearchService statsResearchService;
        
    /**
     * 통계조사결과 업종별, 규모별 조회 코드 리스트를 조회한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/researchStatsTable.do")
    public String restarchStatsTable(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();

        List<Map<String, Object>> list = statsReportService.selectListExcelUpload(param);

        model.addAttribute("list", list);

    	return WEB_PATH+"researchStatsTable";
    }

    
    /**
     * 통계조사결과 업종별, 규모별 조회 코드 리스트를 조회한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/statisticsResearch.do")
    public String statisticsResearch(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();

        List<Map<String, Object>> list = statsReportService.selectListExcelUpload(param);

        model.addAttribute("list", list);

    	return WEB_PATH+"statisticsResearch";
    }

    /**
     * 통계조사결과 항목설정 화면을 조회한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/researchStatsItemPop.do")
    public String statisticsResearchPop(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
    	return  "/sub" + WEB_PATH+"researchStatsItemPop";
    }    
    
    /**
     * 항목 물산업분류 체계 트리 리스트
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/wbizTreeList.do")
    public @ResponseBody List<Map<String, Object>> managerMenuTreeList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        param.put("site_name", "업종전체");
        
        List<Map<String, Object>> list = statsResearchService.selectResearchItemTreeList(param);
        
        Map<String, Object> data = null;
        Map<String, Object> normal = new HashMap<String, Object>();
        normal.put("selected", false);
        
        Map<String, Object> checked = new HashMap<String, Object>();
        checked.put("selected", true);
        
        if (list != null && list.size() > 0){
            
            for (int i = 0; i < list.size(); i++) {
                
                data = (Map<String, Object>) list.get(i);
                
                if (data.get("auth_yn").equals("Y"))
                    data.put("state", checked);
                else
                    data.put("state", normal);
            }
        }
        
        return list;
    }
    /**
     * 통계조사결과 구분, 통계구분, 통계표를 조회한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/researchCodeList.do")
    public ModelAndView selectStatsResearchCodeList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        String gubun = StringUtil.nvl(param.get("gubun"));
        
        if (gubun.equals("T")) {
        	gubun ="STATS_TP_CD";
        } else if (gubun.equals("L")) {
        	gubun ="STATS_L_CD";
        	
        } else if (gubun.equals("M")) {
        	gubun ="STATS_M_CD";
        }
        param.put("gubun", gubun);
                    
    	List<Map<String, Object>> codeList = statsResearchService.selectResearchCodeList(param);

    	param.put("list", codeList);
            
        return ViewHelper.getJsonView(param);
        
    }
    
    /**
     * 통계조사결과 내역 조회한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/researchStatsList.do")
    public String statisticsResearchList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        logger.debug(param);

        model.addAttribute("params", param);
    	return WEB_PATH+"researchStatsList";
    }
    
    /**
     * 통계조사결과 내역 조회한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/loadResearchData.do")
    public String loadResearchData(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        if (param.get("stats_s_list") != null){
            String stats = (String)param.get("stats_s_list");
            stats = stats.replace("[", "").replace("]","");
        	String[] stats_s_list = StringUtil.split(stats,",");
        	param.put("stats_s_list", stats_s_list);
        }
        if (param.get("wbiz_tp_s_list") != null){
            String wbiz = (String)param.get("wbiz_tp_s_list");
            wbiz = wbiz.replace("[", "").replace("]","");
        	String[] wbiz_tp_s_list = StringUtil.split(wbiz, ",");
        	param.put("wbiz_tp_s_list", wbiz_tp_s_list);
        }

        param.put("gubun", "STATS_M_CD");
        param.put("code", param.get("stats_m_cd"));
//        List<Map<String, Object>> codes = statsResearchService.selectResearchCodeList(param);
 //       model.addAttribute("codes", codes);

        List<Map<String, Object>> header = statsResearchService.selectResearchTableHeader(param);
        model.addAttribute("stats_title", header);

        List<Map<String, Object>> tables = statsResearchService.selectResearchTableList(param);
        model.addAttribute("stats_list", tables);
        model.addAttribute("params", param);
    	return "/sub"+WEB_PATH+"researchStatsListResult";
    }
    
    @RequestMapping(value = "/admin/stats/statsResearchtExcelDownload.do")
    public ModelAndView statisticsResearchExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param = navigator.getParam();
		logger.debug(param);
		
		model.put( "excelName", "통계조사결과" );
		model.put( "sheetName" , "통계표");
		
		List<String[]> headerMap = new ArrayList<String[]>();
		headerMap.add( new String[]{ "기준년도", "표본여부" , "업종구분코드" ,"업종구분" , 
				"대분류코드" , "대분류명" , "중분류코드", "중분류명" , "소분류코드" , "소분류명",
				"사업자번호", "사업체명", "시도", "군구", "읍면동", "사업분류코드", "사업분류",
				"종사자수", "종사자규모코드","종사장규묘"  } );
		 
		String[] columnMap = new String[]{ "bs_yy", "smpl_nm", "inds_tp_cd" , "inds_tp_nm" ,
				"wbiz_tp_l_cd" , "wbiz_tp_l_cd" , "wbiz_tp_m_cd" , "wbiz_tp_m_cd" , "wbiz_tp_s_cd" , "wbiz_tp_s_cd",
				"biz_reg_no", "cmpy_nm","addr1", "addr2","addr3","biz_cate_cd","biz_cate_nm",
				"empl_cnt", "scale_cd", "scale_nm"  };
		short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER, 
				 HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER,
				 HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.ALIGN_RIGHT, 
				 HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER};
		 
		model.put( "headerMap" , headerMap );
		model.put( "columnMap" , columnMap );
		model.put( "alignMap" , alignMap );
//		model.put( "dataMap" , statsPersonMtService.selectPersonList(param));
 
		return new ModelAndView( "excelDownView" , "model" , model );
    }
     
}
