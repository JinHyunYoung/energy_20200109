package kr.or.wabis.admin.stats.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.contents.service.InfoPageMtService;
import kr.or.wabis.admin.stats.service.StatsInfoPageMtService;
import kr.or.wabis.admin.stats.service.StatsExcelUploadMtService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExcelUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("statsInfoMtController")
public class StatsInfoMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(StatsInfoMtController.class);
    
    private final static String ADMIN_PATH = "/admin/stats/";
    
    @Resource(name = "statsInfoPageMtService")
    private StatsInfoPageMtService statsInfoPageMtService;
    
    /**
     * 작성 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsInfopageWrite.do")
    public String infopageWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {        
        
        Map<String, Object> param = _req.getParameterMap();                
        model.addAttribute("bs_yy", param.get("bs_yy"));
        
        param.put("gubun", "STATS_INFO_L_CD");
        model.addAttribute("stats_info_l_list", statsInfoPageMtService.selectStatsInfoCode(param));
        
        
        return ADMIN_PATH + "statsInfopageWrite";
    }
    
    /**
     * 작성 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/loadStatsInfoMCode.do")
    public ModelAndView loadStats_info_m_cd(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {        
        
        Map<String, Object> param = _req.getParameterMap();                
        
        logger.debug(param);
        param.put("type", "STATS_INFO_M_CD_MINUS");
        model.addAttribute("stats_info_m_list", statsInfoPageMtService.selectStatsInfoCode(param));
        
//        return ADMIN_PATH + "statsInfopageWrite";
        return ViewHelper.getJsonView(model);
    }
        
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsInfopagePageList.do")
    public ModelAndView infopagePageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();

        String bs_yy = StringUtil.nvl(param.get("bs_yy"));
        if (bs_yy.equals("")) {
        	return ViewHelper.getJqGridView(navigator);
        } else {
        	navigator.setList(statsInfoPageMtService.selectStatsInfopagePageList(param));
        	return ViewHelper.getJqGridView(navigator);
        }
        
    }
       
    /**
     * 선택된 정보페이지를 가져온다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/selectStatsInfopage.do")
    public @ResponseBody Map<String, Object> selectInfopage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        Map<String, Object> infopage = statsInfoPageMtService.selectStatsInfopage(param);       
        param.put("statsInfopage", infopage);
        
        return param;
    }
    
    /**
     * 데이타를 저장한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/insertStatsInfopage.do")
    public ModelAndView insertInfopage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = statsInfoPageMtService.insertStatsInfopage(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getInsertMsg(rv, _req));
            } else {
                param.put("success", "false");
                param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
        
    }
    
    /**
     * 데이타를 수정한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/updateStatsInfopage.do")
    public ModelAndView updateInfopage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = statsInfoPageMtService.updateStatsInfopage(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
            } else {
                param.put("success", "false");
                param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 데이타를 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/deleteStatsInfopage.do")
    public ModelAndView deleteInfopage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = statsInfoPageMtService.deleteStatsInfopage(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getDeteleMsg(rv, _req));
            } else {
                param.put("success", "false");
                param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 미리보기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsInfopagePreview.do")
    public String infopagePreview(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute("infopage", param);
        
        return "/popup" + ADMIN_PATH + "statsInfopagePreview";
    }
}
