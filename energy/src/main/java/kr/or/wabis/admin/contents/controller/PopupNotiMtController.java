package kr.or.wabis.admin.contents.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.contents.service.PopupNotiMtService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("popupNotiMtController")
public class PopupNotiMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(PopupNotiMtController.class);
    
    private final static String ADMIN_PATH = "/admin/contents/";
    
    @Resource(name = "popupNotiMtService")
    private PopupNotiMtService popupNotiMtService;
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/popnoti/popnotiListPage.do")
    public String popnotiListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
                
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        return ADMIN_PATH + "popnotiListPage";
    }
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/popnoti/popnotiPageList.do")
    public ModelAndView popnotiPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        navigator.setList(popupNotiMtService.selectPopnotiPageList(param));
        
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
    @RequestMapping(value = "/admin/popnoti/popnotiList.do")
    public @ResponseBody Map<String, Object> popnotiList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = popupNotiMtService.selectPopnotiList(param);
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
    @RequestMapping(value = "/admin/popnoti/popnotiWrite.do")
    public String popnotiWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> popnoti = new HashMap();
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // popnoti 정보를 가져온다.
            popnoti = popupNotiMtService.selectPopnoti(param);
            
        } else {
            popnoti.put("satisfy_yn", "Y");
            popnoti.put("use_yn", "Y");
        }
        
        model.addAttribute("popnoti", popnoti);
        
        return ADMIN_PATH + "popnotiWrite";
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
    @RequestMapping(value = "/admin/popnoti/insertPopnoti.do")
    public ModelAndView insertPopnoti(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("menu/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                
                file = (FileUploadModel) fileList.get(0);
                commonFileVO.setGroup_id(CommonUtil.createUUID());
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("menu/");
                
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(commonFileVO);
                
                param.put("file_id", commonFileVO.getFile_id());
                
            }
            
            param.put("noti_id", CommonUtil.createUUID());
            rv = popupNotiMtService.insertPopnoti(param);
            
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
    @RequestMapping(value = "/admin/popnoti/updatePopnoti.do")
    public ModelAndView updatePopnoti(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("menu/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                
                file = (FileUploadModel) fileList.get(0);
                commonFileVO.setGroup_id(CommonUtil.createUUID());
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("menu/");
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                
                commonFileService.insertCommonFile(commonFileVO);
                param.put("file_id", commonFileVO.getFile_id());
            }
            
            rv = popupNotiMtService.updatePopnoti(param);
            
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
    @RequestMapping(value = "/admin/popnoti/deletePopnoti.do")
    public ModelAndView deletePopnoti(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = popupNotiMtService.deletePopnoti(param);
            
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
    @RequestMapping(value = "/admin/popnoti/popnotiPreview.do")
    public String popnotiPreview(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute("popnoti", param);
        
        return "/popup" + ADMIN_PATH + "popnotiPreview";
    }
    
}
