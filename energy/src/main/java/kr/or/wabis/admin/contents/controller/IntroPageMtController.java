package kr.or.wabis.admin.contents.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.contents.service.IntroPageMtService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileSupport;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("introPageMtController")
public class IntroPageMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(IntroPageMtController.class);
    
    private final static String ADMIN_PATH = "/admin/contents/";
    
    @Resource(name = "introPageMtService")
    private IntroPageMtService introPageMtService;
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/intropageListPage.do")
    public String intropageListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
                
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        return ADMIN_PATH + "intropageListPage";
    }
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/intropagePageList.do")
    public ModelAndView intropagePageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        navigator.setList(introPageMtService.selectIntropagePageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
    
    /**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/intropageList.do")
    public @ResponseBody Map<String, Object> intropageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = introPageMtService.selectIntropageList(param);
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 쓰기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/intropageWrite.do")
    public String intropageWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> intropage = new HashMap();
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // intropage 정보를 가져온다.
            intropage = introPageMtService.selectIntropage(param);
        } else {
            intropage.put("satis_yn", "Y");
        }
                
        model.addAttribute("intropage", intropage);
        
        return ADMIN_PATH + "intropageWrite";
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
    @RequestMapping(value = "/admin/intropage/insertIntropage.do")
    public ModelAndView insertIntropage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            param.put("page_id", CommonUtil.createUUID());
            rv = introPageMtService.insertIntropage(param);
            
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
    @RequestMapping(value = "/admin/intropage/updateIntropage.do")
    public ModelAndView updateIntropage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = introPageMtService.updateIntropage(param);
            
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
    @RequestMapping(value = "/admin/intropage/deleteIntropage.do")
    public ModelAndView deleteIntropage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = introPageMtService.deleteIntropage(param);
            
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
    @RequestMapping(value = "/admin/intropage/intropagePreview.do")
    public String intropagePreview(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute("intropage", param);
        
        return "/popup" + ADMIN_PATH + "intropagePreview";
    }
    
    /**
     * 소개페이지 팝업 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/intropageSearchPopup.do")
    public String intropageSearchPopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        
        return "/sub" + ADMIN_PATH + "intropageListPopup";
    }
    
    /**
     * 소개페이지 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/intropageSearchList.do")
    public @ResponseBody Map<String, Object> intropageSearchList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = introPageMtService.selectIntropageList(param);
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 소개페이지 페이지로딩후 file list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/fileList.do")
    public @ResponseBody Map<String, Object> fileList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
    	Map<String, Object> param = _req.getParameterMap();
    	
    	String group_id = (String) param.get("group_id");
    	  if (group_id == null) {
              
              // 그룹아이디가 없는경우 전체를 가져오기 방지
              param.put("group_id", "A"); 
          }
       
        List<CommonFileVO> fileList = commonFileService.getCommonFileList(param);
        List list = new ArrayList();
        for (CommonFileVO file : fileList) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("file_id", file.getFile_id());
			map.put("file_nm", file.getFile_nm());
			map.put("use_yn", file.getUse_yn());
			map.put("ori_file_nm", file.getOriginFileNm());
			map.put("file_title", file.getFile_title());
			map.put("sort", file.getSort());
			list.add(map);
		}
        
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 소개페이지 파일 등록
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/insertIntropageFile.do", method = RequestMethod.POST)
    public ModelAndView insertIntropageFile(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        String group_id = (String)param.get("file_group_id");
        String page_id = (String)param.get("file_page_id");
        String input_file_title = (String)param.get("input_file_title");
        String input_file_sort = (String)param.get("input_file_sort");

        logger.debug(param);
        
        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("intro/"));
            FileUploadModel file = null;
            boolean isUpdate_groupid = false;

            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() == 1) {

            	file = (FileUploadModel) fileList.get(0);
            	 
            	if(acnt == 0 && group_id == null){
            		commonFileVO.setGroup_id(CommonUtil.createUUID());
            		group_id = commonFileVO.getGroup_id();

            		isUpdate_groupid = true;
            	}else{
            		commonFileVO.setGroup_id(group_id);
            	}
            	commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setUse_yn((String) param.get("use_yn"));
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("intro/");
                commonFileVO.setFile_title(input_file_title);
                commonFileVO.setSort(Long.parseLong(input_file_sort));
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(commonFileVO);
                acnt++;
                
            }
            
            if(isUpdate_groupid){
                // intropage group id 정보를 수정한다.
                param.put("group_id", group_id);
                param.put("page_id", page_id);
                introPageMtService.updateGroupId(param);
            }
            
            param.put("group_id", group_id);
            param.put("success", "true");
            param.put("message", MessageUtil.getInsertMsg(rv, _req));
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 
            return ViewHelper.getJsonView(param);
        }
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 소개페이지 파일 수정
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/updateIntropageFile.do", method = RequestMethod.POST)
    public ModelAndView updateIntropageFile(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        String group_id = (String)param.get("file_group_id");
        String input_file_id = (String)param.get("input_file_id");
        String input_file_title = (String)param.get("input_file_title");
        
        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("intro/"));
            FileUploadModel file = null;
            
        	// 기존 file VO get
            Map<String, Object> del_param = new HashMap<String, Object>();
            del_param.put("file_id", input_file_id);
            
            CommonFileVO fileInfo = commonFileService.getCommonFile(del_param);

        	if(group_id == null){
        		fileInfo.setGroup_id(CommonUtil.createUUID());
        		group_id = fileInfo.getGroup_id();
        	}else{
        		fileInfo.setGroup_id(group_id);
        	}
        	fileInfo.setFile_title(input_file_title);
        	
            //파일 첨부 된 경우, 파일 정보 변경.
            if (fileList != null && fileList.size() == 1) {
            	
            	//기존 파일 삭제.
                String path = fileInfo.getFile_path();
                String filename = fileInfo.getFile_nm();
                
                FileSupport.deleteFile(path, filename);
                int retVal = commonFileService.deleteCommonFile(input_file_id);
            	
            	file = (FileUploadModel) fileList.get(0);

            	fileInfo.setFile_nm(file.getFileName());
            	fileInfo.setUse_yn((String) param.get("use_yn"));
            	
            	fileInfo.setOrigin_file_nm(file.getOriginalFileName());
            	fileInfo.setFile_type(file.getExtension());
            	fileInfo.setFile_size(file.getFileSize());
            	fileInfo.setFile_path("intro/");
            	fileInfo.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(fileInfo);
                
            }else{
                int retVal = commonFileService.deleteCommonFile(input_file_id);
                
            	fileInfo.setUse_yn((String) param.get("use_yn"));
            	
                commonFileService.insertCommonFile(fileInfo);            	
            }
            param.put("group_id", group_id);
            param.put("success", "true");
            param.put("message", MessageUtil.getInsertMsg(rv, _req));
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 
            return ViewHelper.getJsonView(param);
        }
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 소개페이지 파일 삭제
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/deleteIntropageFile.do", method = RequestMethod.POST)
    public ModelAndView deleteIntropageFile(ExtHttpRequestParam _req, ModelMap model) throws Exception {
		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		String file_id = (String) param.get("file_id");
		try {
			// 기존 file VO get
			Map<String, Object> del_param = new HashMap<String, Object>();
			del_param.put("file_id", file_id);

			CommonFileVO fileInfo = commonFileService.getCommonFile(del_param);
			// 기존 파일 삭제.
			String path = fileInfo.getFile_path();
			String filename = fileInfo.getFile_nm();

			FileSupport.deleteFile(path, filename);

			int retVal = commonFileService.deleteCommonFile(file_id);

			param.put("success", "true");
			param.put("message", MessageUtil.getInsertMsg(rv, _req));
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
			return ViewHelper.getJsonView(param);
		}
		return ViewHelper.getJsonView(param);
    }
    
    /**
     * 소개페이지 파일 순서 조정 정보를 저장한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/intropage/updateFileListReorder.do")
    public ModelAndView updateFileListReorder(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        List<Map<String, Object>> list = (ArrayList<Map<String, Object>>) JsonUtil.fromJsonStr(param.get("file_list").toString().replace("&quot;", "'"));
        param.put("file_list", list);
        
        try {
        	rv = commonFileService.updateFileListReorder(param);
        	
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "파일 순서를 저장하였습니다.");
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
}
