package kr.or.wabis.admin.directory.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.directory.service.CmpyDirMtService;
import kr.or.wabis.directory.controller.CmpyDirController;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.util.email.DirectoryAppService;
import kr.or.wabis.framework.util.email.DirectoryApprovalService;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

/**
 * <PRE>
 * !=
 * 기업디렉토리 정보를 관리하는 기능
 *
 * </PRE>
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Controller("cmpyDirMtController")
public class CmpyDirMtController extends AbstractController {
    
    private static final Logger logger = Logger.getLogger(CmpyDirController.class);
    
    public final static String ADMIN_PATH = "/admin/directory/";
    
    @Resource(name="cmpyDirMtServiceImpl")
    protected CmpyDirMtService cmpyDirMtService;
    
    /**
     * 기업디렉토리 승인 팝업
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/approveCmpyDirPopup.do")
    public String approveCmpyDirWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
    	Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + ADMIN_PATH + "cmpyDirApprove";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        } 
        
        return jsp;
    }
    
    /**
     * 기업디렉토리 승인
     *
     * @param ExtHttpRequestParam _req
     * @param ModelAndView
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/approveCmpyDir.do")
    public ModelAndView approveCmpyDir(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {			
			
			result = cmpyDirMtService.approveCmpyDir(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getUpdateedNotFoundMsg(result, _req));
			}			
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 기업디렉토리 반려 팝업
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/rejectCmpyDirPopup.do")
    public String rejectCmpyDirWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
    	Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + ADMIN_PATH + "cmpyDirRjtRsn";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        } 
        
        return jsp;
    }
    
    /**
     * 기업디렉토리 반려
     *
     * @param ExtHttpRequestParam _req
     * @param ModelAndView
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/rejectCmpyDir.do")
    public ModelAndView rejectCmpyDir(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.rejectCmpyDir(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getUpdateedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 기업디렉토리 회원여부 수정
     *
     * @param ExtHttpRequestParam _req
     * @param ModelAndView
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateMember.do")
    public ModelAndView updateMember(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateMember(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getUpdateedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 기업디렉토리 삭제
     *
     * @param ExtHttpRequestParam _req
     * @param ModelAndView
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDir.do")
    public ModelAndView deleteCmpyDir(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.deleteCmpyDir(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getDeteleNotCountMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getDeletedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 기업디렉토리 조회 페이지 이동
     *
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/cmpyDirListPage.do")
	public String cmpyDirListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		return ADMIN_PATH + "cmpyDirListPage";
	}

	/**
     * 기업디렉토리 조회
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/directory/cmpyDirListPageList.do")
	public ModelAndView cmpyDirListPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param = navigator.getParam();
        
        param.put("sidx", "dir_sn");
        param.put("sord", "desc");

		navigator.setList(cmpyDirMtService.searchCmpyDirPageList(param));

		return ViewHelper.getJqGridView(navigator);
	}

	/**
     * 기업디렉토리 조회 (엑셀 다운로드)
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/directory/cmpyDirListPageListExcel.do")
	public ModelAndView cmpyDirListPageListExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        String lang = StringUtil.nvl( param.get("lang"), "kr" );
        
        List<String[]> headerMap = new ArrayList<String[]>();
        String[] columnMap = null;
        
        if("kr".equals(lang)){
        	
    		model.put( "excelName", "기업디렉토리" );
    		model.put( "sheetName" , "기업디렉토리(국문)" ); 
    		
    		headerMap.add( new String[]{ 
    						"기업명(국문)", "사업자번호", "대표자명(국문)", "설립년도", "조직형태", "상장여부", "법인형태", 
    						"물산업 분류(주업종)", "", "", "", "사원수(명)", "홈페이지 주소", "회사 전화번호", "회사 팩스번호", 
    						"회사 주소(국문)", "", "", "회원사 구분", "승인 상태", "공개 여부"} );
    		headerMap.add( new String[]{ 
							"", "", "", "", "", "", "", 
							"구분", "1Depth", "2Depth", "3Depth", "", "", "", "", 
							"우편번호", "기본주소", "상세주소", "", "", ""} );

    		columnMap = new String[]{ 
							"cmpy_nm", "biz_reg_no", "cmpy_nm", "est_yy", "ogn_frm_nm", "lst_yn_nm", "cp_tp_cd_nm", 
							"inds_tp_cd_nm", "wbiz_tp_l_cd_nm", "wbiz_tp_m_cd_nm", "wbiz_tp_s_cd_nm", "empl_cnt", "url", "tel", "fax", 
							"post", "addr1", "addr2", "member_yn_nm", "app_stt_cd_nm", "opn_yn_nm"};
    		
        } else {
        	
    		model.put( "excelName", "기업디렉토리" );
    		model.put( "sheetName" , "기업디렉토리(영문)" );  
    		
    		headerMap.add( new String[]{ 
    						"기업명(국문)", "사업자번호", "대표자명(영문)", "설립년도", "조직형태", "상장여부", "법인형태", 
    						"물산업 분류(주업종)", "", "", "", "사원수(명)", "홈페이지 주소", "회사 전화번호", "회사 팩스번호", 
    						"회사 주소(영문)", "", "", "회원사 구분", "승인 상태", "공개 여부"} );
    		headerMap.add( new String[]{ 
							"", "", "", "", "", "", "", 
							"구분", "1Depth", "2Depth", "3Depth", "", "", "", "", 
							"우편번호", "기본주소", "상세주소", "", "", ""} );

    		columnMap = new String[]{ 
							"cmpy_nm", "biz_reg_no", "cmpy_nm_en", "est_yy", "ogn_frm_nm_en", "lst_yn_nm_en", "cp_tp_cd_nm_en", 
							"inds_tp_cd_nm_en", "wbiz_tp_l_cd_nm_en", "wbiz_tp_m_cd_nm_en", "wbiz_tp_s_cd_nm_en", "empl_cnt", "url", "tel", "fax", 
							"post", "addr1_en", "addr2_en", "member_yn_nm_en", "app_stt_cd_nm_en", "opn_yn_nm_en"};
        	
        }
        
		List<CellRangeAddress> mergeMap = new ArrayList<CellRangeAddress>();

		mergeMap.add( new CellRangeAddress( 0 , 1 , 0 , 0 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 1 , 1 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 2 , 2 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 3 , 3 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 4 , 4 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 5 , 5 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 6 , 6 ) );
		mergeMap.add( new CellRangeAddress( 0 , 0 , 7 , 10 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 11 , 11 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 12 , 12 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 13 , 13 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 14 , 14 ) );
		mergeMap.add( new CellRangeAddress( 0 , 0 , 15 , 17 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 18 , 18 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 19 , 19 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 20 , 20 ) );
		 
		short[] alignMap = new short[]{ 
				HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , 
				HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , 
				HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , 
				HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , 
				HSSFCellStyle.ALIGN_CENTER };
		 
		model.put( "headerMap" , headerMap );
		model.put( "columnMap" , columnMap );
		model.put( "alignMap" , alignMap );		
		model.put( "mergeMap" , mergeMap );
		model.put( "dataMap" , cmpyDirMtService.selectCmpyDirListExcel(param) );		 
		 
		return new ModelAndView( "excelDownView" , "model" , model );
	}
       
    /**
     * 기업디렉토리 상세조회 이동
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/cmpyDirView.do")
    public String cmpyDirView(HttpServletRequest request, ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	
    	String dir_sn = StringUtil.nvl(param.get("dir_sn"));
    	
    	if("".equals(dir_sn)) {
    		dir_sn = StringUtil.nvl(request.getSession().getAttribute("dir_sn"));
    		param.put("dir_sn", dir_sn);
    	}
    	
		model.addAttribute("param", param);  
		model.addAttribute("homepage_tp", ADMIN_PATH);
		
		HttpSession session = request.getSession();
		session.setAttribute("dir_sn",  StringUtil.nvl(param.get("dir_sn")));
		
        
        return ADMIN_PATH + "cmpyDirView";
    }
    
    /**
     * 기업정보 조회
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/searchCmpyDir.do")
    public String searchCmpyDir(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
    	Map<String, Object> param = _req.getParameterMap();

    	Map<String, Object> cmpyDir = cmpyDirMtService.searchCmpyDir(param);
    	List<Map<String, Object>> cmpyDirCslfList = cmpyDirMtService.selectCmpyDirCslfList(param);
        model.addAttribute("cmpyDir", cmpyDir);
        model.addAttribute("cmpyDirCslfList", cmpyDirCslfList);
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + ADMIN_PATH + "cmpyDir";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        } 
        
        return jsp;       
    }
    
    /**
     * 기업정보 수정
     *
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDir.do")
    public ModelAndView updateCmpyDir(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("directory/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                                        
                    // 로고 파일
                    if ("file_id".equals(file.getFieldName()) || 
                    		"file_id_en".equals(file.getFieldName())) {
                        
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("directory/");
                        commonFileVO.setS_user_no((String) param.get("reg_userno"));
                        commonFileService.insertCommonFile(commonFileVO);

                        param.put("logo_" + file.getFieldName(), commonFileVO.getFile_id());
                    } 
                }
            }
			
			result = cmpyDirMtService.updateCmpyDir(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 담당자 조회
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirManager.do")
    public String selectCmpyDirManager(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();    	
    	Map<String, Object> cmpyDir = cmpyDirMtService.selectCmpyDirManager(param);
        model.addAttribute("cmpyDir", cmpyDir);
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + ADMIN_PATH + "cmpyDirManager";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        }        
        
        return jsp;
    }
    
    /**
     * 담당자 저장
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirManager.do")
    public ModelAndView updateCmpyDirManager(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirManager(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 찾아오시는길 조회
     *
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirMap.do")
    public String selectCmpyDirMap(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> cmpyDir = cmpyDirMtService.selectCmpyDirMap(param);
        model.addAttribute("cmpyDir", cmpyDir);
        
        String jsp = "/sub" + ADMIN_PATH + "cmpyDirMap";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        }        
        
        return jsp;
    }
    
    /**
     * 찾아오시는길 저장
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirMap.do")
    public ModelAndView updateCmpyDirMap(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirMap(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 실적 조회
     *
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirBrec.do")
    public String selectCmpyDirBrec(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	
    	Map<String, Object> cmpyDir = cmpyDirMtService.selectCmpyDirBrec(param);
        model.addAttribute("cmpyDir", cmpyDir);
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + ADMIN_PATH + "cmpyDirBrec";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        }        
        
        return jsp;
    }
    
    
    /**
     * 실적 수정
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirBrec.do")
    public ModelAndView updateCmpyDirBrec(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirBrec(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
        
    /**
     * 물산업분류 등록
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/insertCmpyDirCslf.do")
    public ModelAndView insertCmpyDirCslf(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.insertCmpyDirCslf(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }

    
    /**
     * 물산업분류 수정
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirCslf.do")
    public ModelAndView updateCmpyDirCslf(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirCslf(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 물산업분류 삭제
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDirCslf.do")
    public ModelAndView deleteCmpyDirCslf(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.deleteCmpyDirCslf(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
        
    /**
     * 재무 조회
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirFnc.do")
    public String selectCmpyDirFnc(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirFncList = cmpyDirMtService.selectCmpyDirFncList(param);
        model.addAttribute("cmpyDirFncList", cmpyDirFncList);
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + ADMIN_PATH + "cmpyDirFnc";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        }        
        
        return jsp;
    }
        
    /**
     * 재무 등록
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/insertCmpyDirFnc.do")
    public ModelAndView insertCmpyDirFnc(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.insertCmpyDirFnc(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }

    
    /**
     * 재무 수정
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirFnc.do")
    public ModelAndView updateCmpyDirFnc(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirFnc(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 재무 삭제
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDirFnc.do")
    public ModelAndView deleteCmpyDirFnc(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.deleteCmpyDirFnc(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 수출 조회
     *
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirExp.do")
    public String selectCmpyDirExp(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirExpList = cmpyDirMtService.selectCmpyDirExpList(param);
        model.addAttribute("cmpyDirExpList", cmpyDirExpList);
        
    	Map<String, Object> cmpyDirExpCountry = cmpyDirMtService.searchCmpyDirExpCountry(param);
    	model.addAttribute("cmpyDirExpCountry", cmpyDirExpCountry);
    	
    	model.addAttribute("param", param);  
                
        String jsp = "/sub" + ADMIN_PATH + "cmpyDirExp";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        }        
        
        return jsp;
    }
    
	
    /**
     * 수출 등록
     *
     * @param CmpyDirExpVo[] cmpyDirExpArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/insertCmpyDirExp.do")
    public ModelAndView insertCmpyDirExp(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.insertCmpyDirExp(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
	
    /**
     * 수출 수정
     *
     * @param CmpyDirExpVo[] cmpyDirExpArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirExp.do")
    public ModelAndView updateCmpyDirExp(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirExp(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
	
    /**
     * 수출 삭제
     *
     * @param CmpyDirExpVo[] cmpyDirExpArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDirExp.do")
    public ModelAndView deleteCmpyDirExp(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.deleteCmpyDirExp(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 인증 조회
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirCert.do")
    public String selectCmpyDirCert(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirCertList = cmpyDirMtService.selectCmpyDirCertList(param);
        model.addAttribute("cmpyDirCertList", cmpyDirCertList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + ADMIN_PATH + "cmpyDirCert";        
		if("Y".equals(param.get("popup"))){
			jsp += "Popup";
		}        
		
		return jsp;
    }
	
    /**
     * 인증 등록
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/insertCmpyDirCert.do")
    public ModelAndView insertCmpyDirCert(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.insertCmpyDirCert(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
	
    /**
     * 인증 수정
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirCert.do")
    public ModelAndView updateCmpyDirCert(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirCert(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
	
    /**
     * 인증 삭제
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDirCert.do")
    public ModelAndView deleteCmpyDirCert(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.deleteCmpyDirCert(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getDeletedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
	
    /**
     * 연혁 상세조회
     *
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirHstr.do")
    public String selectCmpyDirHstr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> cmpyDirHstrList = cmpyDirMtService.selectCmpyDirHstrList(param);
        model.addAttribute("cmpyDirHstrList", cmpyDirHstrList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + ADMIN_PATH + "cmpyDirHstr";        
		if("Y".equals(param.get("popup"))){
			jsp += "Popup";
		}        
		
		return jsp;
    }
        
    /**
     * 연혁 등록
     *
     * @param CmpyDirHstrVo[] cmpyDirHstrArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/insertCmpyDirHstr.do")
    public ModelAndView insertCmpyDirHstr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.insertCmpyDirHstr(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }

    
    /**
     * 연혁 수정
     *
     * @param CmpyDirHstrVo[] cmpyDirHstrArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirHstr.do")
    public ModelAndView updateCmpyDirHstr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirHstr(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 연혁 삭제
     *
     * @param CmpyDirHstrVo[] cmpyDirHstrArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDirHstr.do")
    public ModelAndView deleteCmpyDirHstr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.deleteCmpyDirHstr(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getDeletedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 제품 조회
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirPrdt.do")
    public String selectCmpyDirPrdt(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
    	Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirPrdtList = cmpyDirMtService.selectCmpyDirPrdtList(param);
        model.addAttribute("cmpyDirPrdtList", cmpyDirPrdtList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + ADMIN_PATH + "cmpyDirPrdt";        
		if("Y".equals(param.get("popup"))){
			jsp += "Popup";
		}        
		
		return jsp;
    }
    
    /**
     * 제품 등록
     *
     * @param CmpyDirPrdtVo[] cmpyDirPrdtArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/insertCmpyDirPrdt.do")
    public ModelAndView insertCmpyDirPrdt(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.insertCmpyDirPrdt(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 제품 수정
     *
     * @param CmpyDirPrdtVo[] cmpyDirPrdtArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirPrdt.do")
    public ModelAndView updateCmpyDirPrdt(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirPrdt(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 제품 삭제
     *
     * @param CmpyDirPrdtVo[] cmpyDirPrdtArr
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDirPrdt.do")
    public ModelAndView deleteCmpyDirPrdt(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.deleteCmpyDirPrdt(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getDeletedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }    
    
    /**
     * 제품사진 조회
     *
     * @param ExtHttpRequestParam _req
     * @param List<Map<String, Object>>
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirPrdtPctr.do")
    public String selectCmpyDirPrdtPctr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirPrdtPctrList = cmpyDirMtService.selectCmpyDirPrdtPctrList(param);
        model.addAttribute("cmpyDirPrdtPctrList", cmpyDirPrdtPctrList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + ADMIN_PATH + "cmpyDirPrdtPctr";        
		if("Y".equals(param.get("popup"))){
			jsp += "Popup";
		}        
		
		return jsp;
    }
    
    
    /**
     * 제품사진 등록
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/insertCmpyDirPrdtPctr.do")
    public ModelAndView insertCmpyDirPrdtPctr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("directory/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                                        
                    // 로고 파일
                    if ("file_id".equals(file.getFieldName())) {
                        
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("directory/");
                        commonFileVO.setS_user_no((String) param.get("reg_userno"));
                        commonFileService.insertCommonFile(commonFileVO);

                        param.put("prdt_file_id", commonFileVO.getFile_id());
                        param.put("prdt_file_id_nm", commonFileVO.getFile_nm());
                    } 
                }
            }
			
			result = cmpyDirMtService.insertCmpyDirPrdtPctr(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }

    
    /**
     * 제품사진 수정
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirPrdtPctr.do")
    public ModelAndView updateCmpyDirPrdtPctr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("directory/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                                        
                    // 로고 파일
                    if ("file_id".equals(file.getFieldName())) {
                        
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("directory/");
                        commonFileVO.setS_user_no((String) param.get("reg_userno"));
                        commonFileService.insertCommonFile(commonFileVO);
                        
                        String pre_prdt_file_id = StringUtil.nvl(param.get("pre_prdt_file_id"), null);
                        if(pre_prdt_file_id != null){
                            commonFileService.deleteCommonFile(pre_prdt_file_id);                        	
                        }
                        
                        param.put("prdt_file_id", commonFileVO.getFile_id());
                        param.put("prdt_file_id_nm", commonFileVO.getFile_nm());
                    } 
                }
            }
			
			result = cmpyDirMtService.updateCmpyDirPrdtPctr(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 제품사진 삭제
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDirPrdtPctr.do")
    public ModelAndView deleteCmpyDirPrdtPctr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try { 
			
	        String pre_prdt_file_id = StringUtil.nvl(param.get("prdt_file_id"), null);
	        if(pre_prdt_file_id != null){
	            commonFileService.deleteCommonFile(pre_prdt_file_id);                        	
	        }
			
			result = cmpyDirMtService.deleteCmpyDirPrdtPctr(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getDeletedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 동영상 조회
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/selectCmpyDirVdo.do")
    public String selectCmpyDirVdo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirVdoList = cmpyDirMtService.selectCmpyDirVdoList(param);
        model.addAttribute("cmpyDirVdoList", cmpyDirVdoList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + ADMIN_PATH + "cmpyDirVdo";        
		if("Y".equals(param.get("popup"))){
			jsp += "Popup";
		}        
		
		return jsp;
    }    
    
    /**
     * 동영상 등록
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/insertCmpyDirVdo.do")
    public ModelAndView insertCmpyDirVdo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.insertCmpyDirVdo(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }    
    
    /**
     * 동영상 수정
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/updateCmpyDirVdo.do")
    public ModelAndView updateCmpyDirVdo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.updateCmpyDirVdo(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getiIsertedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }    
    
    /**
     * 동영상 삭제
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/admin/directory/deleteCmpyDirVdo.do")
    public ModelAndView deleteCmpyDirVdo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirMtService.deleteCmpyDirVdo(param);
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
			} 
			else if (result == 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getDeletedNotFoundMsg(result, _req));
			}	
			else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(result, _req));
			return ViewHelper.getJsonView(param);
		}

		return ViewHelper.getJsonView(param);
    }
}
