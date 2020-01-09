package kr.or.wabis.education.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.education.service.EducationService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by my on 2017-11-01.
 */
@Controller("educationController")
public class EducationController  extends AbstractController {
	
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/education/";
    
    @Resource(name = "educationService")
    private EducationService educationService;

    /**
     * 교육신청 안내 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/education/educationApplyInfo.do")
    public String educationApplyInfo(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
         
        return WEB_PATH + "educationApplyInfo";
    }
    
    /**
     * 교육신청 인증 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/education/educationApplyCerti.do")
    public String educationApplyCerti(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
         
        return WEB_PATH + "educationApplyCerti";
    }

    /**
     * 교육신청 등록 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/education/educationApplyWrite.do")
    public String educationApplyWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
        String birth = StringUtil.nvl(param.get("birth"));
        if(!birth.equals("")) param.put("birth",DateUtil.getConvertDate(birth,"1"));
        model.addAttribute("education", param);
        
        return WEB_PATH + "educationApplyWrite";
    }
    
    /**
     * 교육신청을 등록한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/education/insertEducationApply.do")
    public ModelAndView insertEducationApply(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int exist = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
        	exist = educationService.selectEducationApplyExist(param);
        	if(exist < 1){
	            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("education/"));
	            FileUploadModel file = null;
	            CommonFileVO commonFileVO = new CommonFileVO();
	            if (fileList != null && fileList.size() > 0) {
	                
	                for (int i = 0; i < fileList.size(); i++) {
	                    
	                    file = (FileUploadModel) fileList.get(i);
	                    
	                    // 사진
	                    if ("picFile".equals(file.getFieldName())) { 
	                        commonFileVO.setGroup_id(CommonUtil.createUUID());
	                        commonFileVO.setFile_nm(file.getFileName());
	                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
	                        commonFileVO.setFile_type(file.getExtension());
	                        commonFileVO.setFile_size(file.getFileSize());
	                        commonFileVO.setFile_path("education/");
	                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
	                        commonFileService.insertCommonFile(commonFileVO);
	                        param.put("picture", commonFileVO.getFile_id());
	                    } 
	                    
	                    // 사업자등록증
	                    if ("uploadFile1".equals(file.getFieldName())) { 
	                        commonFileVO.setGroup_id(CommonUtil.createUUID());
	                        commonFileVO.setFile_nm(file.getFileName());
	                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
	                        commonFileVO.setFile_type(file.getExtension());
	                        commonFileVO.setFile_size(file.getFileSize());
	                        commonFileVO.setFile_path("education/");
	                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
	                        commonFileService.insertCommonFile(commonFileVO);
	                        param.put("busi_license", commonFileVO.getFile_id());
	                    } 
	                    
	                    // 고용보험목록
	                    if ("uploadFile2".equals(file.getFieldName())) { 
	                        commonFileVO.setGroup_id(CommonUtil.createUUID());
	                        commonFileVO.setFile_nm(file.getFileName());
	                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
	                        commonFileVO.setFile_type(file.getExtension());
	                        commonFileVO.setFile_size(file.getFileSize());
	                        commonFileVO.setFile_path("education/");
	                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
	                        commonFileService.insertCommonFile(commonFileVO);
	                        param.put("unemp_ins_list", commonFileVO.getFile_id());
	                    }
	                    
	                    // 기타서류
	                    if ("uploadFile3".equals(file.getFieldName())) { 
	                        commonFileVO.setGroup_id(CommonUtil.createUUID());
	                        commonFileVO.setFile_nm(file.getFileName());
	                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
	                        commonFileVO.setFile_type(file.getExtension());
	                        commonFileVO.setFile_size(file.getFileSize());
	                        commonFileVO.setFile_path("education/");
	                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
	                        commonFileService.insertCommonFile(commonFileVO);
	                        param.put("etc_doc", commonFileVO.getFile_id());
	                    }
	                }
	            }
	            
	            rv = educationService.insertEducationApply(param);
	            
	            if (rv > 0) { 
	                param.put("success", "true");
	                param.put("message", "교육신청을 등록하였습니다.");
	            } else {
	                param.put("success", "false"); 
	                param.put("message", "교육신청에 실패하였습니다."); 
	            }
        	}else{
                param.put("success", "false"); 
                param.put("message", "이미 교육신청을 하셨습니다. 교육신청내역을 확인하여 주십시요."); 
        	}
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "교육신청 등록 시  오류가  발생하였습니다."); 
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);        
    }
    
    /**
     * 지원신청 완료 페이지로 이동한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/education/educationApplyComplete.do")
    public String educationApplyComplete(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        return WEB_PATH + "educationApplyComplete";
    }
	
	/**
	 *  교육차수 리스트를 가져온다.
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/education/eduseqCodeList.do")
	public ModelAndView eduseqCodeList(ExtHttpRequestParam _req, ModelMap model)  throws Exception{
		Map<String, Object> param 		= _req.getParameterMap();
		
		List<Map<String, Object>> seqList = educationService.selectEduseqCodeList(param);
		
		HashMap retMap = new HashMap();
		retMap.put("list",seqList);	    
	
	    return ViewHelper.getJsonView(retMap);
	}
	
    /**
     * 교육신청 리스트 인증 페이지 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/education/educationApplyListCerti.do")
    public String educationApplyListCerti(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
         
        return WEB_PATH + "educationApplyListCerti";
    }
    
    /**
     * 교육신청 리스트 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/education/educationApplyList.do")
	public String educationApplyList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
		String jsp = WEB_PATH+"educationApplyList";
		
		Map<String, Object> param = _req.getParameterMap();
	
		List applyList = educationService.selectEducationApplyList(param);
		model.addAttribute("applyList", applyList);
		model.addAttribute("param", param);
		
        return jsp;
	}
    
	/**
	 *  교육신청을 했는지를 체크한다.
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/education/educationApplyCheck.do")
	public ModelAndView educationApplyCheck(ExtHttpRequestParam _req, ModelMap model)  throws Exception{
		Map<String, Object> param 		= _req.getParameterMap();
		
		int checkVal = educationService.selectEducationApplyExist(param);
		
		HashMap retMap = new HashMap();
		retMap.put("check_val", checkVal);	    
	
	    return ViewHelper.getJsonView(retMap);
	}
    
}
