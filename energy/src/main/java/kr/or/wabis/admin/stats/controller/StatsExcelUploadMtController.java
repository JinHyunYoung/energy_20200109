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
import org.springframework.web.servlet.ModelAndView;

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

@Controller("statsExcelUploadMtController")
public class StatsExcelUploadMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(StatsExcelUploadMtController.class);
    
    private final static String ADMIN_PATH = "/admin/stats/";
    
    @Resource(name = "statsExcelUploadMtService")
    private StatsExcelUploadMtService statsExcelUploadMtService;
        
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsExcelUploadList.do")
    public String excelUploadList(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		Map<String, Object> param = _req.getParameterMap();
      
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);        

    	return ADMIN_PATH + "statsExcelUploadList";
        
    }
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsExcelUploadListPage.do")
    public ModelAndView excelUploadListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();

		List<Map<String, Object>> results = statsExcelUploadMtService.selectListExcelUpload(param);
        navigator.setList(results);

        return ViewHelper.getJqGridView(navigator);        
    }

   
    /**
     * 통계 데이터 엑셀을 업로드 하는 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsResearchUpload.do")
    public String researchExcelUpload(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute(param);
        
    	return ADMIN_PATH + "statsResearchUpload";
        
    }
    
    /**
     * 통계 데이터 엑셀 내용을 검증한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    
    @RequestMapping(value = "/admin/stats/statsResearchValid.do")
    public String researchExcelValid(ExtHttpRequestParam _req, ModelMap model) throws Exception {
		Map<String, Object> param = _req.getParameterMap();
		
		String fileName = "";
		//엑셀 파일을 저장.
		String updir = getUploadPath("excel/");       
		List<FileUploadModel> fileList = _req.saveAllFilesTo(updir);
			
		FileUploadModel file = null;
		try{
			CommonFileVO commonFileVO = new CommonFileVO();
			if(fileList != null && fileList.size()>0){
				//엑셀 업로드는 파일 1개만 들어옴.
				file = (FileUploadModel)fileList.get(0);
				fileName = file.getFileName();

				String issue_yy = (String)param.get("bs_yy");
    	        param.put("issue_yy", String.valueOf(Integer.parseInt(issue_yy) +1)); 
    	        
    			List<Map<String, Object>> industry = null;
    			industry = statsExcelUploadMtService.industryExcelValid(param, ExcelUtil.procExcelFile(updir, fileName, 0));//업종별 시트
    	        model.addAttribute("industry", industry);
    			List<Map<String, Object>> scale = null;
    			scale = statsExcelUploadMtService.scaleExcelValid(param, ExcelUtil.procExcelFile(updir, fileName, 1));//규모별 시트
    	        model.addAttribute("scale", scale);
    			if(industry.isEmpty() && scale.isEmpty()) {
    				model.addAttribute("valid", "success");
    			} else {
    				model.addAttribute("valid", "fail");
    			}
    	        
			}
		} catch(Exception e) {
            logger.warn("엑셀 업로드 오류", e);
            param.put("status", "실패"+MessageUtil.getProcessFaildMsg(1, _req)); 
		}

		return "/sub"+ADMIN_PATH + "statsResearchValid";
    }

    
    @RequestMapping(value = "/admin/stats/statsResearchResult.do")
    public String researchExcelUploadResult(ExtHttpRequestParam _req, ModelMap model) throws Exception {
		Map<String, Object> param = _req.getParameterMap();
		
		String fileName = "";
		//엑셀 파일을 저장.
		String updir = getUploadPath("excel/");       
		List<FileUploadModel> fileList = _req.saveAllFilesTo(updir);
			
		FileUploadModel file = null;
		try{
			CommonFileVO commonFileVO = new CommonFileVO();
			if(fileList != null && fileList.size()>0){
				   //엑셀 업로드는 파일 1개만 들어옴.
				   file = (FileUploadModel)fileList.get(0);
				   fileName = file.getFileName();
	               commonFileVO.setGroup_id(CommonUtil.createUUID());
	               param.put("group_id", commonFileVO.getGroup_id());

	               commonFileVO.setFile_nm(file.getFileName());
		           commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
		           commonFileVO.setFile_type(file.getExtension());
		           commonFileVO.setFile_size(file.getFileSize());
		           commonFileVO.setFile_path("excel/");
		           commonFileVO.setS_user_no((String) param.get("s_auth_id"));
		           commonFileService.insertCommonFile(commonFileVO);
                

    	        //통계 데이터 업로드 이력 관리
    	        param.put("xls_tp", "1"); //1:통계 데이터 , 2: 통계 모집단 명부
    	        String issue_yy = (String)param.get("bs_yy");
    	        param.put("issue_yy", String.valueOf(Integer.parseInt(issue_yy) +1)); 
    	        
    	        statsExcelUploadMtService.insertListExcelUpload(param);

    			List<Map<String, Object>> industry = null;
    			industry = statsExcelUploadMtService.industryExcelUpload(param, ExcelUtil.procExcelFile(updir, fileName, 0));//업종별 시트
    	        model.addAttribute("industry", industry);
    			List<Map<String, Object>> scale = null;
    			scale = statsExcelUploadMtService.scaleExcelUpload(param, ExcelUtil.procExcelFile(updir, fileName, 1));//규모별 시트
    	        model.addAttribute("scale", scale);

    			if(industry.isEmpty() && scale.isEmpty()) {
    				model.addAttribute("valid", "success");
    			} else {
    				model.addAttribute("valid", "fail");
    			}
 
			}
		} catch(Exception e) {
            logger.warn("엑셀 업로드 오류", e);
            param.put("status", "실패"+MessageUtil.getProcessFaildMsg(1, _req)); 
		}

		return "/sub"+ADMIN_PATH + "statsResearchResult";
    }


    /**
     * 엑셀업로드 자료 및 파일을 삭제한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/deleteExcelUpload.do")
    public ModelAndView deleteExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        String group_id = StringUtil.nvl(param.get("group_id"));
        
        //엑셀파일을 삭제
        if (!group_id.isEmpty()){
            deleteFileInfo(group_id);
        }
        
        //deleteListExcelUpload
        int cnt =  statsExcelUploadMtService.deleteExcelUpload(param);

		if (cnt >= 0) {
			param.put("success", "true");
			param.put("message", MessageUtil.getDeteleMsg(cnt, _req));
		} 
		else if (cnt == 0) {
			param.put("success", "true");
			param.put("message", MessageUtil.getDeletedNotFoundMsg(cnt, _req));
		}			
		else {
			param.put("success", "false");
			param.put("message", MessageUtil.getDeteleNotCountMsg(cnt, _req));
		}


        return ViewHelper.getJsonView(param);        
    }

}
