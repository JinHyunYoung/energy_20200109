package kr.or.wabis.admin.education.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.or.wabis.admin.education.service.EducationMtService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by my on 2017-11-01.
 */
@Controller("educationMtController")
public class EducationMtController  extends AbstractController {
	
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String ADMIN_PATH = "/admin/education/";
    
    @Resource(name = "educationMtService")
    private EducationMtService educationMtService;

    /**
     * 운영관리 리스트 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/eduseqListPage.do")
    public String eduseqListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {      
    	model.addAttribute("curYear", DateUtil.getCurrentYear());
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
    	
        return ADMIN_PATH + "eduseqListPage";
    }
    
    /**
     * 운영관리 페이지리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/eduseqPageList.do")
    public ModelAndView eduseqPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
    	NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(educationMtService.selectEduseqPageList(param));		
        
        return ViewHelper.getJqGridView(navigator);	
    }
    
    /**
     * 운영관리 등록 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/eduseqWrite.do")
    public String eduseqWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> eduseq = new HashMap();
        model.addAttribute("curYear", DateUtil.getCurrentYear());
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // eduseq 정보를 가져온다.
        	eduseq = educationMtService.selectEduseq(param);
        	List subjList = educationMtService.selectEduseqsubjList(param);
        	model.addAttribute("subjList", subjList);

        } else {
        	eduseq.put("run_year", DateUtil.getCurrentYear());
        	eduseq.put("open_yn", "Y");
        	eduseq.put("apply_strdt_date", DateUtil.getTodayStr("yyyy-MM-dd"));
        	eduseq.put("apply_enddt_date", DateUtil.getTodayStr("yyyy-MM-dd"));
        }
        
        model.addAttribute("eduseq", eduseq);
        model.addAttribute("param", param);
        
        return ADMIN_PATH + "eduseqWrite";
    }
    
    /**
     * 운영관리를 등록한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/insertEduseq.do")
    public ModelAndView insertEduseq(ExtHttpRequestParam _req, HttpServletRequest request, ModelMap model) throws Exception {
        
    	Integer rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
     
        	String[] subjCd = request.getParameterValues("subj_cd");
        	String[] subjScore = request.getParameterValues("subj_score");
        	param.put("subjCd", subjCd);
        	param.put("subjScore", subjScore);
        	rv = educationMtService.insertEduseq(param);
            
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
     * 운영관리를 수정한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/updateEduseq.do")
    public ModelAndView updateEduseq(ExtHttpRequestParam _req, HttpServletRequest request, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
     
        	String[] subjCd = request.getParameterValues("subj_cd");
        	String[] subjScore = request.getParameterValues("subj_score");
        	param.put("subjCd", subjCd);
        	param.put("subjScore", subjScore);
        	rv = educationMtService.updateEduseq(param);

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
     * 운영관리를 삭제한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/deleteEduseq.do")
    public ModelAndView deleteEduseq(ExtHttpRequestParam _req, HttpServletRequest request, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
        	educationMtService.deleteEduseqsubj(param);
        	rv = educationMtService.deleteEduseq(param);
        	
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
     * 운영관리를 완료처리 해준다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/eduseqComplete.do")
    public ModelAndView eduseqComplete(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
          
            rv = educationMtService.updateEduseqComplete(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "교육완료 처리되었습니다");
            } else {
                param.put("success", "false"); 
                param.put("message", "교육완료 처리에 실패하였습니다."); 
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
	 *  교육차수 리스트를 가져온다.
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/education/eduseqCodeList.do")
	public ModelAndView eduseqCodeList(ExtHttpRequestParam _req, ModelMap model)  throws Exception{
		Map<String, Object> param 		= _req.getParameterMap();
		
		List<Map<String, Object>> seqList = educationMtService.selectEduseqCodeList(param);
		
		HashMap retMap = new HashMap();
		retMap.put("list",seqList);	    
	
	    return ViewHelper.getJsonView(retMap);
	}
    
    /**
     * 교육신청 리스트 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/educationApplyListPage.do")
    public String educationApplyListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {      
    	model.addAttribute("curYear", DateUtil.getCurrentYear());
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);
    	
        return ADMIN_PATH + "educationApplyListPage";
    }
    
    /**
     * 교육신청 페이지리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/educationApplyPageList.do")
    public ModelAndView educationApplyPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
    	NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(educationMtService.selectEducationApplyPageList(param));		
       
        return ViewHelper.getJqGridView(navigator);	
    }

    /**
     * 교육신청 리스트를 엑셀 다운로드 해준다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/educationApplyPageListExcel.do")
    public ModelAndView educationApplyPageListExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        navigator.setPageSize( 99999 );
        Map<String, Object> param = navigator.getParam();
        
        param.put("miv_end_index", 9999999);
        logger.debug(param);
        
        model.put( "excelName", "교육신청" );
		model.put( "sheetName" , "교육신청" );    	 
		 
		List<String[]> headerMap = new ArrayList<String[]>();
		headerMap.add( new String[]{ "약관동의여부","신청일시","교육구분","성명","생년월일","성별","휴대전화","유선전화","이메일","자택우편번호","자택기본주소","자택상세주소","사진파일존재여부","사업자구분","업체명(상호)","사업자등록번호","대표자명","등록업종","등록연월일","전화번호","팩스","업체우편번호","업체기본주소","업체상세주소","사업자등록증파일여부","고용보험목록파일존재여부","기타서류파일존재여부","수강상채","수강처리일","합격상태","합격처리일","관리자메모"} );
		String[] columnMap = new String[]{ "reg_date","reg_date","edu_gb_nm","user_nm","birth","gender_nm","handphone","telephone","email","zipcode","address","address2","picture_yn","license_gb_nm","busi_nm","busi_no","repre_nm","busi_field","busi_reg_date","busi_tel","fax","busi_zipcode","busi_address","busi_address2","busi_license_yn","unemp_ins_list_yn","etc_doc_yn","apply_status_nm","apply_proc_date_nm","pass_status_nm","pass_proc_date_nm","memo" };
		short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT
		                              };
		 
		model.put( "headerMap" , headerMap );
		model.put( "columnMap" , columnMap );
		model.put( "alignMap" , alignMap );		
		model.put( "dataMap" , educationMtService.selectEducationApplyPageList(param) );
		 
		return new ModelAndView( "excelDownView" , "model" , model );        
    }
    
    /**
     * 교육신청 등록 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/educationApplyWrite.do")
    public String educationApplyWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> education = new HashMap();
        model.addAttribute("curYear", DateUtil.getCurrentYear());
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // 교육신청 정보를 가져온다.
        	education = educationMtService.selectEducationApply(param);
            String userMobile = StringUtil.nvl(education.get("handphone"));
            if(!userMobile.equals("")){
	           	 String [] userMobiles = StringUtil.split(userMobile,"-");
	           	 education.put("mobile_1", userMobiles[0]);
	           	 education.put("mobile_2", userMobiles[1]);
	           	 education.put("mobile_3", userMobiles[2]);
           }
            
            String userTel = StringUtil.nvl(education.get("telephone"));
            if(!userTel.equals("")){
	           	 String [] userTels = StringUtil.split(userTel,"-");
	           	 education.put("tele_1", userTels[0]);
	           	 education.put("tele_2", userTels[1]);
	           	 education.put("tele_3", userTels[2]);
           }

            String userEmail = StringUtil.nvl(education.get("email"));
            if(!userEmail.equals("")){
	           	 String [] userEmails = StringUtil.split(userEmail,"@");
	           	 education.put("email_1", userEmails[0]);
	           	 education.put("email_2", userEmails[1]);
           }
            String busiNo = StringUtil.nvl(education.get("busi_no"));
            if(!busiNo.equals("")){
	           	 String [] busiNos = StringUtil.split(busiNo,"-");
	           	 education.put("busi_no1", busiNos[0]);
	           	 education.put("busi_no2", busiNos[1]);
	           	 education.put("busi_no3", busiNos[2]);
          }
           
           String busiTel = StringUtil.nvl(education.get("busi_tel"));
           if(!busiTel.equals("")){
	           	 String [] busiTels = StringUtil.split(busiTel,"-");
	           	 education.put("busi_tel1", busiTels[0]);
	           	 education.put("busi_tel2", busiTels[1]);
	           	 education.put("busi_tel3", busiTels[2]);
          }

           String fax = StringUtil.nvl(education.get("fax"));
           if(!fax.equals("")){
	           	 String [] faxs = StringUtil.split(fax,"-");
	           	 education.put("fax1", faxs[0]);
	           	 education.put("fax2", faxs[1]);
	           	 education.put("fax3", faxs[2]);
          }
           
        } else {
        	education.put("run_year", DateUtil.getCurrentYear());
        }
        
        model.addAttribute("education", education);
        model.addAttribute("param", param);
        
        return ADMIN_PATH + "educationApplyWrite";
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
    @RequestMapping(value = "/admin/education/insertEducationApply.do")
    public ModelAndView insertEducationApply(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
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
            
            rv = educationMtService.insertEducationApply(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "교육신청을 등록되었습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "교육신청 등록에 실패하였습니다."); 
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
     * 교육신청을 등록한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/education/updateEducationApply.do")
    public ModelAndView updateEducationApply(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
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
            
            rv = educationMtService.updateEducationApply(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "교육신청을 수정하였습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "교육신청 수정에 실패하였습니다."); 
            }
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "교육신청 수정 시  오류가  발생하였습니다."); 
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);        
    }
    
	/**
	 * 수강신청 삭제처리를 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/education/deleteEducationApply.do")
	public ModelAndView deleteEducationApply(ExtHttpRequestParam _req, ModelMap model) throws Exception {
	    
	    int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();
  
	   	try{
	       	rv = educationMtService.deleteEducationApply(param);
	       	
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getDeteleMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}					
	    }catch(Exception e){
	    	e.printStackTrace();
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}						
	    									
	    return ViewHelper.getJsonView(param);
	}
	
	/**
	 * 수강승인 처리를 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/education/approvalEducationApply.do")
	public ModelAndView approvalEducationApply(ExtHttpRequestParam _req, ModelMap model) throws Exception {
	    
	    int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("aply_list").toString().replace("&quot;","'"));
        param.put("aply_list", list);

	   	try{
	       	rv = educationMtService.approvalEducationApply(param);
	       	
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}					
	    }catch(Exception e){
	    	e.printStackTrace();
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}						
	    									
	    return ViewHelper.getJsonView(param);
	}
    
	/**
	 * 합격승인 처리를 해준다.
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/education/passEducationApply.do")
	public ModelAndView passEducationApply(ExtHttpRequestParam _req, ModelMap model) throws Exception {
	    
	    int rv = 0;
	    Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = (ArrayList<Map<String ,Object>>)JsonUtil.fromJsonStr(param.get("aply_list").toString().replace("&quot;","'"));
        param.put("aply_list", list);

	   	try{
	       	rv = educationMtService.passEducationApply(param);
	       	
	       	if(rv > 0){																	// 저장한다
				param.put("success", "true" );													
	        	param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
			}else{
				param.put("success", "false"); // 오류 또는 실패시  에 false를 집어넣는다
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); // 실패 메시지
			}					
	    }catch(Exception e){
	    	e.printStackTrace();
				param.put("success", "false"); 													// 실패여부 삽입
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 				// 실패 메시지
				return ViewHelper.getJsonView(param);
			}						
	    									
	    return ViewHelper.getJsonView(param);
	}
}
