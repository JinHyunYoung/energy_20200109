package kr.or.wabis.stats.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.stats.service.StatsReportService;

@Controller("statsReportController")
public class StatsReportController extends AbstractController {
    
    private Logger logger = Logger.getLogger(StatsReportController.class);
    
    private final static String WEB_PATH = "/web/stats/";
    
    @Resource(name = "statsReportService")
    private StatsReportService statsReportService;
        
    /**
     * 주요통계 - 사업체 현황 관련 통계를 작성한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/companyCountReport.do")
    public String companyCountReport(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsReportService.selectListExcelUpload(param);
        String bs_yy = StringUtil.nvl(param.get("bs_yy") );
        //bs_yy가 처음 들어올때는 empty이니까 업로드 기록에서 첫번째(가장최근, desc) 것으로 셋팅
        if (bs_yy.equals("")) {
        	bs_yy = StringUtil.nvl(list.get(0).get("bs_yy"));
        	param.put("bs_yy", bs_yy);
        };

        model.addAttribute("list", list);

        param.put("stats_s_cd", "01-01");
    	param.put("type", "industry");
    	model.addAttribute("industry",  statsReportService.selectIndustryGraph(param));
    	
    	param.put("type", "industry_year");
    	model.addAttribute("industry_year", statsReportService.selectIndustryGraph(param));
    	
    	param.put("type", "industry_scale");
    	model.addAttribute("scale",  statsReportService.selectIndustryGraph(param));
    	
    	param.put("type", "industry_scale_year");
    	model.addAttribute("scale_year", statsReportService.selectIndustryGraph(param));

    	model.addAttribute("indicesList", statsReportService.selectMajorIndices(param));

        param.put("stats_info_l_cd", "01");
    	model.addAttribute("infoList", statsReportService.selectStatsInfoMValues(param));
    	
    	model.addAttribute("params", param);
    	
    	return WEB_PATH+"companyCountReport";
    }

    /**
     * 주요통계 - 인력 현황 관련 통계를 작성한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/employeeCountReport.do")
    public String employeeCountReport(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsReportService.selectListExcelUpload(param);
        String bs_yy = StringUtil.nvl(param.get("bs_yy") );
        if (bs_yy.equals("")) {
        	param.put("bs_yy", list.get(0).get("bs_yy"));
        }

        model.addAttribute("list", list);
    	
        param.put("stats_s_cd", "03-01");

    	param.put("type", "industry");
    	model.addAttribute("industry",  statsReportService.selectIndustryGraph(param));
    	
    	param.put("type", "industry_year");
    	model.addAttribute("industry_year", statsReportService.selectIndustryGraph(param));
    	
    	param.put("type", "scale");
		model.addAttribute("scale",  statsReportService.selectScaleGraph(param));
		
		param.put("type", "scale_year");
		model.addAttribute("scale_year", statsReportService.selectScaleGraph(param));

    	param.put("type", "job_year");
    	model.addAttribute("job_year", statsReportService.selectIndustryGraph(param));

        param.put("stats_info_l_cd", "02");
    	model.addAttribute("infoList", statsReportService.selectStatsInfoMValues(param));

    	model.addAttribute("params", param);
    	return WEB_PATH+"employeeCountReport";
    }

    
    /**
     * 주요통계 - 매출액 현황 관련 통계를 작성한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/saleAmountReport.do")
    public String saleAmountReport(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsReportService.selectListExcelUpload(param);
        String bs_yy = StringUtil.nvl(param.get("bs_yy") );
        if (bs_yy.equals("")) {
        	param.put("bs_yy", list.get(0).get("bs_yy"));
        }

        model.addAttribute("list", list);
    	
    	param.put("stats_s_cd", "05-01");

    	param.put("type", "industry_year");
    	model.addAttribute("sale_year", statsReportService.selectIndustryGraph(param));
    	param.put("type", "scale_year");
		model.addAttribute("scale_sale_year", statsReportService.selectScaleGraph(param));
    	
    	param.put("type", "industry_year");
    	param.put("stats_s_cd", "02-03");//수출액
    	model.addAttribute("exp_year", statsReportService.selectIndustryGraph(param));
    	param.put("type", "scale_year");
		model.addAttribute("scale_exp_year", statsReportService.selectScaleGraph(param));

    	param.put("type", "industry_year");
    	param.put("stats_s_cd", "02-09");//수입액
    	model.addAttribute("imp_year", statsReportService.selectIndustryGraph(param));
    	param.put("type", "scale_year");
		model.addAttribute("scale_imp_year", statsReportService.selectScaleGraph(param));


        param.put("stats_info_l_cd", "03");
    	model.addAttribute("infoList", statsReportService.selectStatsInfoMValues(param));
    	model.addAttribute("params", param);
    	return WEB_PATH+"saleAmountReport";
    }

    /**
     * 주요통계 - 연구개발 현황 관련 통계를 작성한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/stats/rndReport.do")
    public String rndReport(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsReportService.selectListExcelUpload(param);
        String bs_yy = StringUtil.nvl(param.get("bs_yy") );
        if (bs_yy.equals("")) {
        	param.put("bs_yy", list.get(0).get("bs_yy"));
        }

        model.addAttribute("list", list);

        param.put("stats_s_cd", "05-08");
    	param.put("type", "industry_year");//연구개발비 추이
    	model.addAttribute("list_1", statsReportService.selectIndustryGraph(param));
    	param.put("type", "scale_year");
		model.addAttribute("list_2", statsReportService.selectScaleGraph(param));
    	
    	param.put("type", "industry");
    	model.addAttribute("list_3", statsReportService.selectIndustryGraph(param));
    	param.put("type", "scale");
		model.addAttribute("list_4", statsReportService.selectScaleGraph(param));

    	param.put("type", "industry_year");
    	param.put("stats_s_cd", "05-08-01");//자체 연구개발비 추이
    	model.addAttribute("list_5", statsReportService.selectIndustryGraph(param));
    	param.put("type", "scale_year");
		model.addAttribute("list_6", statsReportService.selectScaleGraph(param));

    	param.put("type", "industry_year");
    	param.put("stats_s_cd", "05-08-02");//수탁 연구개발비 추이
    	model.addAttribute("list_7", statsReportService.selectIndustryGraph(param));
    	param.put("type", "scale_year");
		model.addAttribute("list_8", statsReportService.selectScaleGraph(param));

        param.put("stats_info_l_cd", "04");
    	model.addAttribute("infoList", statsReportService.selectStatsInfoMValues(param));
    	model.addAttribute("params", param);
    	return WEB_PATH+"rndReport";
    }
}
