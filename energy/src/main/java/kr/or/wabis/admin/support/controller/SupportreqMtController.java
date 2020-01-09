package kr.or.wabis.admin.support.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.or.wabis.admin.support.service.SupportreqMtService;
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
@Controller("supportreqMtController")
public class SupportreqMtController  extends AbstractController {
	
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String ADMIN_PATH = "/admin/support/";
    
    @Resource(name = "supportreqMtService")
    private SupportreqMtService supportreqMtService;

    /**
     * 지원사업통계 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/supportbusiStatPage.do")
    public String supportbusiStatPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        model.addAttribute("curYear", DateUtil.getCurrentYear());
    	
    	return ADMIN_PATH + "supportbusiStatPage";
    }
    
    /**
     * 지원사업통계 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/supportbusiStatList.do")
    public ModelAndView supportbusiList(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
		
		List<Map<String, Object>> list = supportreqMtService.selectSupportbusiStatList(param);
		 
		Map retMap = new HashMap();
		retMap.put("rows",list);	    
	
	    return ViewHelper.getJsonView(retMap);
    }
    
    /**
     * 지원사업통계를 등록한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/insertSupportbusiStat.do")
    public ModelAndView insertSupportbusiStat(ExtHttpRequestParam _req, HttpServletRequest request, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        try {
            String year = (String)param.get("p_year");
          	String[] regionCd = request.getParameterValues("region_cd");
        	String[] houseNum = request.getParameterValues("house_num");
        	String[] amt = request.getParameterValues("amt");

        	List list = new ArrayList();
        	Map data = null;
        	for(int i = 0;i < regionCd.length;i++){
        		data = new HashMap();
        		data.put("year",year);
        		data.put("region_cd", regionCd[i]);
        		data.put("house_num", houseNum[i]);
        		data.put("amt", amt[i]);
        		rv += supportreqMtService.insertSupportbusiStat(data); 
        	}
        	
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "지원사업 통계가 등록되었습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "지원사업 통계 등록에 실패하였습니다."); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "지원사업 통계 등록 시  오류가  발생하였습니다."); 
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);        
    }
    
    /**
     * 모금및 후원통계 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/supportfundStatPage.do")
    public String supportfundStatPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {  
    	model.addAttribute("curYear", DateUtil.getCurrentYear());
    	
        return ADMIN_PATH + "supportfundStatPage";
    }
 
    /**
     * 모금및후원통계 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/supportfundStatList.do")
    public ModelAndView supportfundStatList(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
		
		List<Map<String, Object>> list = supportreqMtService.selectSupportfundStatList(param);
		 
		Map retMap = new HashMap();
		retMap.put("rows",list);	    
	
	    return ViewHelper.getJsonView(retMap);
    }
    
    /**
     * 모금및후원통계를 저장한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/insertSupportfundStat.do")
    public ModelAndView insertSupportfundStat(ExtHttpRequestParam _req, HttpServletRequest request, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
        	String[] fundId = request.getParameterValues("fund_id");
        	String[] rowId = request.getParameterValues("row_id");
        	String[] year = request.getParameterValues("year");
        	String[] amt = request.getParameterValues("amt");

        	List list = new ArrayList();
        	Map data = null;
        	for(int i = 0;i < year.length;i++){
        		data = new HashMap();
        		data.put("fund_id", fundId[i]);
        		data.put("year", year[i]);
        		data.put("amt", amt[i]);
        		data.put("use_yn", StringUtil.nvl(request.getParameter("use_yn"+rowId[i]),"Y"));
        		if(fundId[i].equals("")) rv += supportreqMtService.insertSupportfundStat(data);
        		else rv += supportreqMtService.updateSupportfundStat(data); 
        	}
        	
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
     * 모금및후원통계를 삭제한다
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/deleteSupportfundStat.do")
    public ModelAndView deleteSupportfundStat(ExtHttpRequestParam _req, HttpServletRequest request, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
        	
        	rv = supportreqMtService.deleteSupportfundStat(param);
        	
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
     * 지원신청 리스트 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/supportreqListPage.do")
    public String supportreqListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception { 

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		
        return ADMIN_PATH + "supportreqListPage";
    }
 
    /**
     * 지원신청 페이지리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/supportreqPageList.do")
    public ModelAndView supportreqPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
    	NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(supportreqMtService.selectSupportreqPageList(param));		
        
        return ViewHelper.getJqGridView(navigator);	
    }
    
    /**
     * 쓰기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/supportreqWrite.do")
    public String supportreqWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> supportreq = new HashMap();
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // supportreq 정보를 가져온다.
            supportreq = supportreqMtService.selectSupportreq(param);
			String userMobile = StringUtil.nvl(supportreq.get("handphone"));
			if (!userMobile.equals("")) {
				String[] mobile = StringUtil.split(userMobile, "-");
				supportreq.put("mobile_1", mobile[0]);
				supportreq.put("mobile_2", mobile[1]);
				supportreq.put("mobile_3", mobile[2]);
			}
        } else {
            supportreq.put("gener_cnt", "0");
            supportreq.put("child_cnt", "0");
            supportreq.put("disable_cnt", "0");
        }
        
        model.addAttribute("supportreq", supportreq);
        model.addAttribute("param", param);
        
        return ADMIN_PATH + "supportreqWrite";
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
    @RequestMapping(value = "/admin/support/insertSupportreq.do")
    public ModelAndView insertSupportreq(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("supportreq/"));
            FileUploadModel file = null;
            
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                file = (FileUploadModel) fileList.get(0);
                commonFileVO.setGroup_id(CommonUtil.createUUID());
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("supportreq");
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(commonFileVO);
                param.put("obj_prof_doc", commonFileVO.getFile_id());
            }
            
            rv = supportreqMtService.insertSupportreq(param);
            
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
    @RequestMapping(value = "/admin/support/updateSupportreq.do")
    public ModelAndView updateSupportreq(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("supportreq/"));
            FileUploadModel file = null;
            
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                file = (FileUploadModel) fileList.get(0);
                commonFileVO.setGroup_id(CommonUtil.createUUID());
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("supportreq");
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(commonFileVO);
                param.put("obj_prof_doc", commonFileVO.getFile_id());
            }
            
            rv = supportreqMtService.updateSupportreq(param);
            
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
    @RequestMapping(value = "/admin/support/deleteSupportreq.do")
    public ModelAndView deleteSupportreq(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
            
            rv = supportreqMtService.deleteSupportreq(param);
            
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
     * 지원신청 승인을 해준다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/approvalSupportreq.do")
    public ModelAndView approvalSupportreq(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
            String resultNm = (String)param.get("eval_result_nm");
            String curDate = DateUtil.getTodayStr("yyyy-MM-dd");
            param.put("eval_date", curDate);
            
            rv = supportreqMtService.approvalSupportreq(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", resultNm+" 처리되었습니다");
            } else {
                param.put("success", "false"); 
                param.put("message", resultNm+" 처리에 실패하였습니다."); 
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
	 *  시군코드 리스트를 가져온다.
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/support/sigunCodeList.do")
	public ModelAndView sigunCodeList(ExtHttpRequestParam _req, ModelMap model)  throws Exception{
		Map<String, Object> param 		= _req.getParameterMap();
		
		List<Map<String, Object>> seqList = supportreqMtService.selectSigunCodeList(param);
		
		HashMap retMap = new HashMap();
		retMap.put("list",seqList);	    
	
	    return ViewHelper.getJsonView(retMap);
	}
	
    /**
     * 지원신청 리스트를 엑셀 다운로드 해준다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/supportreqPageListExcel.do")
    public ModelAndView supportreqPageListExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        navigator.setPageSize( 99999 );
        Map<String, Object> param = navigator.getParam();
        
        param.put("miv_end_index", 9999999);
        logger.debug(param);
        
        model.put( "excelName", "지원신청" );
		model.put( "sheetName" , "지원신청" );    	 
		 
		List<String[]> headerMap = new ArrayList<String[]>();
		headerMap.add( new String[]{ "지원신청동의여부","신청일시","신청인(이름)","생년월일","보호구분","보호유형","세대유형","세대원수","아동수","장앤수","우편번호","기본주소","상세주소","연락처","주거실태","난방종류","대상가구 증명서류 제출여부","신청기관명","신청기관담당자","심사결과","심사처리일","관리자메모" } );
		String[] columnMap = new String[]{ "reg_date","reg_date","req_nm","birth","prot_gb_nm","prot_type_nm","gener_type_nm","gener_cnt","child_cnt","disable_cnt","zipcode","addr1","addr2","handphone","live_type_nm","heat_type_nm","obj_prof_doc_yn","apply_org_nm","apply_org_usernm","eval_result_nm","eval_date","memo" };
		short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT
		                              };
		 
		model.put( "headerMap" , headerMap );
		model.put( "columnMap" , columnMap );
		model.put( "alignMap" , alignMap );		
		model.put( "dataMap" , supportreqMtService.selectSupportreqPageList(param) );
		 
		 
		return new ModelAndView( "excelDownView" , "model" , model );        
    }
}
