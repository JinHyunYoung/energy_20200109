package kr.or.wabis.directory.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.wbiz.service.CategoryMtService;
import kr.or.wabis.directory.service.CmpyDirService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.ProjectConfigUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.util.email.DirectoryAppService;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

/**
 * <PRE>
 * !=
 * 기업디렉토리 정보를 조회하는 기능
 *
 * </PRE>
 *
 * @author Generated
 * @version 1.0
 * @since 01-01-2016
 *
 */
@Controller("cmpyDirController")
public class CmpyDirController extends AbstractController {
    
    private static final Logger logger = Logger.getLogger(CmpyDirController.class);
    
    public final static String WEB_PATH = "/web/directory/";
    
    @Resource(name="cmpyDirServiceImpl")
    protected CmpyDirService cmpyDirService;
    
	 @Resource(name = "categoryMtService")
	 private CategoryMtService categoryMtService;
    
    /**
     * 기업디렉토리 만들기
     *
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/cmpyDirMake.do")
    public String cmpyDirMake1(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();   
		model.addAttribute("param", param);  
		
		String inds_tp_cd = StringUtil.nvl(param.get("inds_tp_cd"), null);

        model.addAttribute("inds_tp_cd", inds_tp_cd);
    	
        return WEB_PATH + "cmpyDirMake1";
    }
    
    /**
     * 기업디렉토리 만들기 2
     *
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/cmpyDirMake2.do")
    public String cmpyDirMake2(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
        Map<String, Object> param = _req.getParameterMap();   
		model.addAttribute("param", param);  
		
		String dir_sn = StringUtil.nvl(param.get("dir_sn"), null);

		if(dir_sn != null){
	    	Map<String, Object> cmpyDir = cmpyDirService.searchCmpyDir(param);
	        model.addAttribute("cmpyDir", cmpyDir);
		}
		
        return WEB_PATH + "cmpyDirMake2";
    }
    
    /**
     * 기업디렉토리 만들기 3
     *
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/cmpyDirMake3.do")
    public String cmpyDirMake3(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("param", param);
        return WEB_PATH + "cmpyDirMake3";
    }
    
    /**
     * 기업디렉토리 관리
     *
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/cmpyDirControl.do")
    public String cmpyDirControl(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("param", param);
        return WEB_PATH + "cmpyDirControl";
    }
    
    /**
     * 기업디렉토리 승인결과
     *
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/cmpyDirApproval.do")
    public String cmpyDirApproval(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("param", param);
        return WEB_PATH + "cmpyDirApproval";
    }
    
    /**
     * 중복확인[중복확인]
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/checkCmpyDir.do")
    public ModelAndView checkCmpyDir(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
        	Map<String, Object> cmpyDir = cmpyDirService.checkCmpyDir(param);
        	
        	if(cmpyDir == null ) {
				param.put("result", "none");
			} else {
				param.put("cmpyDir", cmpyDir);
			}
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", MessageUtil.getProcessFaildMsg(0 , _req));
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 기업디렉토리 관리 (인증)
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/controlCmpyDir.do")
    public ModelAndView controlCmpyDir(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        String auth_no = StringUtil.nvl(param.get("auth_no"), null); 
        
        try {
            
        	Map<String, Object> cmpyDir = cmpyDirService.checkCmpyDir(param);
        	
        	if(cmpyDir == null ) {
				param.put("result", "none");
			} else {
	        	
	            String app_stt_cd = StringUtil.nvl(cmpyDir.get("app_stt_cd"), null); 
	        	
	            // 상태가 승인일 경우 입력한 인증번호와 조회결과의 인증번호가 다를 경우 인증 실패로 처리
				if("2".equals(app_stt_cd) && auth_no != null && !auth_no.equals(StringUtil.nvl(cmpyDir.get("auth_no"), null))) {
					param.put("result", "auth_fail");
				}

				param.put("app_stt_cd", "Y");
				param.put("cmpyDir", cmpyDir);
				param.put("myDirectory", "Y");
			}
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", MessageUtil.getProcessFaildMsg(0 , _req));
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
	
	 /**
     * 기업디렉토리 등록
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/insertCmpyDir.do")
    public ModelAndView insertCmpyDir(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
    	
    	Integer result = 0;

        Map<String, Object> param = _req.getParameterMap();   
		model.addAttribute("param", param);  

		try {			
			
//			String dir_sn = StringUtil.nvl(param.get("dir_sn"), null);
//
//			if(dir_sn != null){
//				result = cmpyDirService.updateCmpyDirForMake(param);
//			} else {
			result = cmpyDirService.insertCmpyDir(param);				
//			}			
			
			if (result > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getInsertMsg(result, _req));
				
		        String adminemail = (String) ProjectConfigUtil.getProperty("project.mail.adminemail");
				
				new DirectoryAppService().sendEmail(adminemail, param);
				
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
     * 기업디렉토리 조회 페이지 이동
     *
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/cmpyDirListPage.do")
	public String cmpyDirListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
        
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		model.addAttribute("param", param);

		return WEB_PATH + "cmpyDirListPage";
	}

	/**
     * 기업디렉토리 조회
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/directory/searchCmpyDirPageList.do")
	public String searchCmpyDirPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        param.put("sidx", "dir_sn");
        param.put("sord", "desc");
        
        // 승인, 공개여부 Y 인 목록만 보여야 하기 때문에 추가
        param.put("app_stt_cd", "2");
        param.put("opn_yn", "Y");

		navigator.setList(cmpyDirService.searchCmpyDirPageList(param));
                
        model.addAttribute("param", param);
        model.addAttribute("cmpyDirList", navigator.getList());
        model.addAttribute("cmpyDirPagging", navigator.getPagging());
        model.addAttribute("totalcnt", navigator.getTotalCnt());

        Map<String, Object> categoryParam = new HashMap<String, Object>();
        categoryParam.put("inds_tp_cd" , StringUtil.nvl(param.get("inds_tp_cd")) ); 
        
        categoryParam.put("wbiz_cd_tp", "L");
		List<Map<String, Object>> wbiz_tp_l_category = categoryMtService.categoryLoad(categoryParam);
		model.addAttribute("wbiz_tp_l_category", wbiz_tp_l_category);

		categoryParam.put("wbiz_tp_l_cd" , StringUtil.nvl(param.get("wbiz_tp_l_cd")) ); 
		if (!StringUtil.nvl(param.get("wbiz_tp_m_cd")).equals("")) {
			categoryParam.put("wbiz_cd_tp", "M");
			List<Map<String, Object>> wbiz_tp_m_category = categoryMtService.categoryLoad(categoryParam);    
	        model.addAttribute("wbiz_tp_m_category", wbiz_tp_m_category);
	        
		}
		
		categoryParam.put("wbiz_tp_m_cd" , StringUtil.nvl(param.get("wbiz_tp_m_cd")) );
		if (!StringUtil.nvl(param.get("wbiz_tp_s_cd")).equals("")) {
			param.put("wbiz_cd_tp", "S");
			List<Map<String, Object>> wbiz_tp_s_category = categoryMtService.categoryLoad(categoryParam);    
	        model.addAttribute("wbiz_tp_s_category", wbiz_tp_s_category);
		}

        return "/sub" + WEB_PATH + "cmpyDirList";
	}
       
    /**
     * 기업디렉토리 상세조회 이동
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/cmpyDirView.do")
    public String cmpyDirView(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("param", param);  
		model.addAttribute("homepage_tp", WEB_PATH);   
        
        return "/sub" + WEB_PATH + "cmpyDirView";
    }
    
    /**
     * 기업정보 조회
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/searchCmpyDir.do")
    public String searchCmpyDir(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
    	Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("param", param);      	

		String dir_sn = StringUtil.nvl(param.get("dir_sn"), null);

		if(dir_sn != null){

	    	Map<String, Object> cmpyDir = cmpyDirService.searchCmpyDir(param);
	    	List<Map<String, Object>> cmpyDirCslfList = cmpyDirService.selectCmpyDirCslfList(param);
	        model.addAttribute("cmpyDir", cmpyDir);
	        model.addAttribute("cmpyDirCslfList", cmpyDirCslfList);
		}
        
        String jsp = "/sub" + WEB_PATH + "cmpyDir";        
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
    @RequestMapping(value = "/web/directory/updateCmpyDir.do")
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
            
			result = cmpyDirService.updateCmpyDir(param);
			
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
     * 기업정보 조회
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/searchCmpyDirAuth.do")
    public String searchCmpyDirAuth(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
    	Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + WEB_PATH + "cmpyDirAuth";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        } 
        
        return jsp;
    }
    
    
	/**
	 * 기업정보 인증번호 확인
	 *
	 * @param CmpyDirVo cmpyDirVo
	 * @param ModelMap model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/directory/checkCmpyDirAuth.do")
	public ModelAndView checkCmpyDirAuth(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
        	Map<String, Object> cmpyDir = cmpyDirService.checkCmpyDirAuth(param);
        	
        	if(cmpyDir == null ) {
				param.put("result", "none");
			} else {
				param.put("result", "ok");
			}
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", MessageUtil.getProcessFaildMsg(0 , _req));
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
    @RequestMapping(value = "/web/directory/selectCmpyDirManager.do")
    public String selectCmpyDirManager(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> cmpyDir = cmpyDirService.selectCmpyDirManager(param);
        model.addAttribute("cmpyDir", cmpyDir);
		model.addAttribute("param", param);  

        String jsp = "/sub" + WEB_PATH + "cmpyDirManager";        
        if("Y".equals(param.get("popup"))){
        	jsp += "Popup";
        }        
        
        return jsp;
    }
    
    /**
     * 담당자 수정
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/updateCmpyDirManager.do")
    public ModelAndView updateCmpyDirManager(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.updateCmpyDirManager(param);
			
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
    @RequestMapping(value = "/web/directory/selectCmpyDirMap.do")
    public String selectCmpyDirMap(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	Map<String, Object> param = _req.getParameterMap();
    	Map<String, Object> cmpyDir = cmpyDirService.selectCmpyDirMap(param);
        model.addAttribute("cmpyDir", cmpyDir);
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + WEB_PATH + "cmpyDirMap";        
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
    @RequestMapping(value = "/web/directory/updateCmpyDirMap.do")
    public ModelAndView updateCmpyDirMap(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			result = cmpyDirService.updateCmpyDirMap(param);
			
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
    @RequestMapping(value = "/web/directory/selectCmpyDirBrec.do")
    public String selectCmpyDirBrec(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	
    	Map<String, Object> cmpyDir = cmpyDirService.selectCmpyDirBrec(param);
        model.addAttribute("cmpyDir", cmpyDir);
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + WEB_PATH + "cmpyDirBrec";        
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
    @RequestMapping(value = "/web/directory/updateCmpyDirBrec.do")
    public ModelAndView updateCmpyDirBrec(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			result = cmpyDirService.updateCmpyDirBrec(param);
			
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
    @RequestMapping(value = "/web/directory/insertCmpyDirCslf.do")
    public ModelAndView insertCmpyDirCslf(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			result = cmpyDirService.insertCmpyDirCslf(param);
			
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
    @RequestMapping(value = "/web/directory/updateCmpyDirCslf.do")
    public ModelAndView updateCmpyDirCslf(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.updateCmpyDirCslf(param);
			
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
    @RequestMapping(value = "/web/directory/deleteCmpyDirCslf.do")
    public ModelAndView deleteCmpyDirCslf(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.deleteCmpyDirCslf(param);
			
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
     * 재무 조회
     *
     * @param ExtHttpRequestParam _req
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/selectCmpyDirFnc.do")
    public String selectCmpyDirFnc(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirFncList = cmpyDirService.selectCmpyDirFncList(param);
        model.addAttribute("cmpyDirFncList", cmpyDirFncList);
		model.addAttribute("param", param);  
        
        String jsp = "/sub" + WEB_PATH + "cmpyDirFnc";        
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
    @RequestMapping(value = "/web/directory/insertCmpyDirFnc.do")
    public ModelAndView insertCmpyDirFnc(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.insertCmpyDirFnc(param);
			
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
    @RequestMapping(value = "/web/directory/updateCmpyDirFnc.do")
    public ModelAndView updateCmpyDirFnc(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.updateCmpyDirFnc(param);
			
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
    @RequestMapping(value = "/web/directory/deleteCmpyDirFnc.do")
    public ModelAndView deleteCmpyDirFnc(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.deleteCmpyDirFnc(param);
			
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
     * 수출 조회
     *
     * @param CmpyDirVo cmpyDirVo
     * @param ModelMap model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/web/directory/selectCmpyDirExp.do")
    public String selectCmpyDirExp(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirExpList = cmpyDirService.selectCmpyDirExpList(param);
        model.addAttribute("cmpyDirExpList", cmpyDirExpList);
        
        Map<String, Object> cmpyDirExpCountry = cmpyDirService.searchCmpyDirExpCountry(param);
    	model.addAttribute("cmpyDirExpCountry", cmpyDirExpCountry);
    	
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + WEB_PATH + "cmpyDirExp";        
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
    @RequestMapping(value = "/web/directory/insertCmpyDirExp.do")
    public ModelAndView insertCmpyDirExp(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.insertCmpyDirExp(param);
			
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
    @RequestMapping(value = "/web/directory/updateCmpyDirExp.do")
    public ModelAndView updateCmpyDirExp(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.updateCmpyDirExp(param);
			
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
    @RequestMapping(value = "/web/directory/deleteCmpyDirExp.do")
    public ModelAndView modifyExpStus(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.deleteCmpyDirExp(param);
			
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
    @RequestMapping(value = "/web/directory/selectCmpyDirCert.do")
    public String selectCmpyDirCertList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirCertList = cmpyDirService.selectCmpyDirCertList(param);
        model.addAttribute("cmpyDirCertList", cmpyDirCertList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + WEB_PATH + "cmpyDirCert";        
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
    @RequestMapping(value = "/web/directory/insertCmpyDirCert.do")
    public ModelAndView insertCmpyDirCert(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.insertCmpyDirCert(param);
			
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
    @RequestMapping(value = "/web/directory/updateCmpyDirCert.do")
    public ModelAndView updateCmpyDirCert(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.updateCmpyDirCert(param);
			
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
    @RequestMapping(value = "/web/directory/deleteCmpyDirCert.do")
    public ModelAndView deleteCmpyDirCert(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.deleteCmpyDirCert(param);
			
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
    @RequestMapping(value = "/web/directory/selectCmpyDirHstr.do")
    public String selectCmpyDirHstr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> cmpyDirHstrList = cmpyDirService.selectCmpyDirHstrList(param);
        model.addAttribute("cmpyDirHstrList", cmpyDirHstrList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + WEB_PATH + "cmpyDirHstr";        
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
    @RequestMapping(value = "/web/directory/insertCmpyDirHstr.do")
    public ModelAndView insertCmpyDirHstr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.insertCmpyDirHstr(param);
			
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
    @RequestMapping(value = "/web/directory/updateCmpyDirHstr.do")
    public ModelAndView updateCmpyDirHstr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.updateCmpyDirHstr(param);
			
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
    @RequestMapping(value = "/web/directory/deleteCmpyDirHstr.do")
    public ModelAndView deleteCmpyDirHstr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.deleteCmpyDirHstr(param);
			
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
    @RequestMapping(value = "/web/directory/selectCmpyDirPrdt.do")
    public String selectCmpyDirPrdt(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
    	Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirPrdtList = cmpyDirService.selectCmpyDirPrdtList(param);
        model.addAttribute("cmpyDirPrdtList", cmpyDirPrdtList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + WEB_PATH + "cmpyDirPrdt";        
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
    @RequestMapping(value = "/web/directory/insertCmpyDirPrdt.do")
    public ModelAndView insertCmpyDirPrdt(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.insertCmpyDirPrdt(param);
			
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
    @RequestMapping(value = "/web/directory/updateCmpyDirPrdt.do")
    public ModelAndView updateCmpyDirPrdt(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.updateCmpyDirPrdt(param);
			
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
    @RequestMapping(value = "/web/directory/deleteCmpyDirPrdt.do")
    public ModelAndView deleteCmpyDirPrdt(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.deleteCmpyDirPrdt(param);
			
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
    @RequestMapping(value = "/web/directory/selectCmpyDirPrdtPctr.do")
    public String selectCmpyDirPrdtPctr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirPrdtPctrList = cmpyDirService.selectCmpyDirPrdtPctrList(param);
        model.addAttribute("cmpyDirPrdtPctrList", cmpyDirPrdtPctrList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + WEB_PATH + "cmpyDirPrdtPctr";        
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
    @RequestMapping(value = "/web/directory/insertCmpyDirPrdtPctr.do")
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
			
			result = cmpyDirService.insertCmpyDirPrdtPctr(param);
			
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
    @RequestMapping(value = "/web/directory/updateCmpyDirPrdtPctr.do")
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
			
			result = cmpyDirService.updateCmpyDirPrdtPctr(param);
			
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
    @RequestMapping(value = "/web/directory/deleteCmpyDirPrdtPctr.do")
    public ModelAndView deleteCmpyDirPrdtPctr(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
            String pre_prdt_file_id = StringUtil.nvl(param.get("prdt_file_id"), null);
            if(pre_prdt_file_id != null){
                commonFileService.deleteCommonFile(pre_prdt_file_id);                        	
            }
			
			result = cmpyDirService.deleteCmpyDirPrdtPctr(param);
			
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
    @RequestMapping(value = "/web/directory/selectCmpyDirVdo.do")
    public String selectCmpyDirVdo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
    	
    	List<Map<String, Object>> cmpyDirVdoList = cmpyDirService.selectCmpyDirVdoList(param);
        model.addAttribute("cmpyDirVdoList", cmpyDirVdoList);
		model.addAttribute("param", param);  
        
		String jsp = "/sub" + WEB_PATH + "cmpyDirVdo";        
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
    @RequestMapping(value = "/web/directory/insertCmpyDirVdo.do")
    public ModelAndView insertCmpyDirVdo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.insertCmpyDirVdo(param);
			
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
    @RequestMapping(value = "/web/directory/updateCmpyDirVdo.do")
    public ModelAndView updateCmpyDirVdo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.updateCmpyDirVdo(param);
			
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
    @RequestMapping(value = "/web/directory/deleteCmpyDirVdo.do")
    public ModelAndView deleteCmpyDirVdo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Integer result = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			result = cmpyDirService.deleteCmpyDirVdo(param);
			
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
