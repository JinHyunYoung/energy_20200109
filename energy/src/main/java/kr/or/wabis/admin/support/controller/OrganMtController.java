package kr.or.wabis.admin.support.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.support.service.OrganMtService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.user.vo.UserVO;

@Controller("organMtController")
public class OrganMtController extends AbstractController {

	private Logger logger = Logger.getLogger(this.getClass());

	private final static String ADMIN_PATH = "/admin/support/";

	@Resource(name = "organMtService")
	private OrganMtService organMtService;
	

    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/organ/organListPage.do")
    public String organListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);        
        return ADMIN_PATH + "organListPage";
    }
    
    /**
     * 작성 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/organ/organWrite.do")
    public String organWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {  

        
        Map<String, Object> param = _req.getParameterMap();    	

        if ("E".equals(param.get("mode"))) {
            
            Map<String, Object> organ = organMtService.selectOrgan(param);
            
            String organTel = StringUtil.nvl(organ.get("organ_tel"));
            if (!organTel.equals("")) {
                String[] tel = StringUtil.split(organTel, "-");
                organ.put("tel_1", tel[0]);
                organ.put("tel_2", tel[1]);
                organ.put("tel_3", tel[2]);
            }

            model.addAttribute("organ", organ);
        }
                
        return ADMIN_PATH + "organWrite";
    }
    
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/organ/organPageList.do")
    public ModelAndView organPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        navigator.setList(organMtService.selectOrganPageList(param));
        
        return ViewHelper.getJqGridView(navigator);
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
    @RequestMapping(value = "/admin/organ/insertOrgan.do")
    public ModelAndView insertOrgan(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("organ/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                    
                    // 썸네일
                    if ("thumb".equals(file.getFieldName())) { 
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("organ/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        param.put("image_file_id", commonFileVO.getFile_id());
                    } 
                }
            }
            param.put("organ_no", CommonUtil.createUUID());
            
            rv = organMtService.insertOrgan(param);
            
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
    @RequestMapping(value = "/admin/organ/updateOrgan.do")
    public ModelAndView updateOrgan(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("organ/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                    
                    // 썸네일
                    if ("thumb".equals(file.getFieldName())) { 
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("organ/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        param.put("image_file_id", commonFileVO.getFile_id());
                    } 
                }
            }
            
            rv = organMtService.updateOrgan(param);
            
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
    @RequestMapping(value = "/admin/organ/deleteOrgan.do")
    public ModelAndView deleteOrgan(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = organMtService.deleteOrgan(param);
            
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
     * faq 순서를 재조정해준다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/organ/updateOrganReorder.do")
    public ModelAndView updateOrganReorder(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = 
                (ArrayList<Map<String, Object>>) JsonUtil.fromJsonStr(param.get("organ_list").toString().replace("&quot;", "'"));
                
        try {
            
            rv = organMtService.updateOrganReorder(list);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "순서를 저장하였습니다.");
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
