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

import kr.or.wabis.admin.stats.service.StatsPersonMtService;
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

@Controller("statsPersonMtController")
public class StatsPersonMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(StatsPersonMtController.class);
    
    private final static String ADMIN_PATH = "/admin/stats/";
    
    @Resource(name = "statsPersonMtService")
    private StatsPersonMtService statsPersonMtService;

    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsPersonList.do")
    public String statisticsExcelUploadList(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
		Map<String, Object> param = _req.getParameterMap();

    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);        

    	return ADMIN_PATH + "statsPersonList";
        
    }

    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsPersonListPage.do")
    public ModelAndView statisticsExcelUploadListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
      
		List<Map<String, Object>> results = statsPersonMtService.selectPersonList(param);
        navigator.setList(results);

        return ViewHelper.getJqGridView(navigator);        
    }

    /**
     * 통계 데이터 모집단 명부 엑셀파일을 등록할 수 있는 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/statsPersonUpload.do")
    public String personExcelUpload(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute(param);
        
    	return ADMIN_PATH + "statsPersonUpload";
        
    }
    
    /**
     * 통계 데이터 모집단 엑셀 파일을 검증한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    
    @RequestMapping(value = "/admin/stats/statsPersonValid.do")
    public String statisticsExcelValid(ExtHttpRequestParam _req, ModelMap model) throws Exception {
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
    	        
    			List<Map<String, Object>> results = null;
    			results = statsPersonMtService.personExcelValid(param, ExcelUtil.procExcelFile(updir, fileName, 0));//업종별 시트
    	        model.addAttribute("person", results);
    	        
    			if(results.isEmpty()) {
    				model.addAttribute("valid", "success");
    			} else {
    				model.addAttribute("valid", "fail");
    			}
			}
		} catch(Exception e) {
            logger.warn("엑셀 업로드 오류", e);
            model.put("status", "실패"+MessageUtil.getProcessFaildMsg(1, _req)); 
		}

		return "/sub"+ADMIN_PATH + "statsPersonValid";
    }

    
    @RequestMapping(value = "/admin/stats/statsPersonResult.do")
    public String statisticsExcelUploadResult(ExtHttpRequestParam _req, ModelMap model) throws Exception {
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
    	        param.put("xls_tp", "2"); //1:통계 데이터 , 2: 통계 모집단 명부
    	        String issue_yy = (String)param.get("bs_yy");
    	        param.put("issue_yy", String.valueOf(Integer.parseInt(issue_yy) +1)); 
    	        
    	        statsPersonMtService.insertListExcelUpload(param);

    			List<Map<String, Object>> results = null;
    			results = statsPersonMtService.personExcelUpload(param, ExcelUtil.procExcelFile(updir, fileName, 0));//업종별 시트
    	        model.addAttribute("person", results);
    	        
			}
		} catch(Exception e) {
            logger.warn("엑셀 업로드 오류", e);
            model.put("status", "실패"+MessageUtil.getProcessFaildMsg(1, _req)); 
		}

		return "/sub"+ADMIN_PATH + "statsPersonResult";
    }

    /**
     * 엑셀업로드 자료 및 파일을 삭제한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/deletePersonExcel.do")
    public ModelAndView deleteExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        param.put("xls_tp", "2"); //1:통계 데이터 , 2: 통계 모집단 명부
        String group_id = StringUtil.nvl(param.get("group_id"));
        
        //엑셀파일을 삭제
        if (!group_id.isEmpty()){
            deleteFileInfo(group_id);
        }
        
        //deleteListExcelUpload
        int cnt =  statsPersonMtService.deleteExcelUpload(param);

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

    @RequestMapping(value = "/admin/stats/statsPersonListExcelDownload.do")
    public ModelAndView statisticsReportExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param = navigator.getParam();
		logger.debug(param);
		
		model.put( "excelName", "모집단 명부" );
		model.put( "sheetName" , "모집단목록");
		
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
		model.put( "dataMap" , statsPersonMtService.selectPersonList(param));
 
		return new ModelAndView( "excelDownView" , "model" , model );
    }
     
}
