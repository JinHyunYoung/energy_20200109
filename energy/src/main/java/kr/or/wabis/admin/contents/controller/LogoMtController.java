package kr.or.wabis.admin.contents.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.contents.service.LogoMtService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("logoMtController")
public class LogoMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(LogoMtController.class);
    
    private final static String ADMIN_PATH = "/admin/contents/";
    
    @Resource(name = "logoMtService")
    private LogoMtService logoMtService;
    
    /**
     * 쓰기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/logo/logoWrite.do")
    public String logoWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> logo = new HashMap();
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // logo 정보를 가져온다.
            logo = logoMtService.selectLogo(param);
        }
        
        model.addAttribute("logo", logo);
        
        return ADMIN_PATH + "logoWrite";
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
    @RequestMapping(value = "/admin/logo/insertLogo.do")
    public ModelAndView insertLogo(ExtHttpRequestParam _req, HttpServletRequest request, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("logo/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            
            String fieldNm = "";
            if (fileList != null && fileList.size() > 0){
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                    
                    commonFileVO.setGroup_id(CommonUtil.createUUID());
                    commonFileVO.setFile_nm(file.getFileName());
                    commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                    commonFileVO.setFile_type(file.getExtension());
                    commonFileVO.setFile_size(file.getFileSize());
                    commonFileVO.setFile_path("logo/");
                    commonFileVO.setS_user_no((String) param.get("s_user_no"));
                    
                    commonFileService.insertCommonFile(commonFileVO);
                    
                    fieldNm = file.getFieldName();
                    if (fieldNm.equals("uploadFile1")) {
                        param.put("front_top", commonFileVO.getFile_id());
                        param.put("front_top_file_nm", commonFileVO.getFile_nm());
                    } 
                    
                    else if (fieldNm.equals("uploadFile2")) {
                        param.put("front_bottom", commonFileVO.getFile_id());
                        param.put("front_bottom_file_nm", commonFileVO.getFile_nm());
                    } 
                    
                    else if (fieldNm.equals("uploadFile3")) {
                        param.put("back_top", commonFileVO.getFile_id());
                        param.put("back_top_file_nm", commonFileVO.getFile_nm());
                    } 
                    
                    else if (fieldNm.equals("uploadFile4")) {
                        param.put("backsub_top", commonFileVO.getFile_id());
                        param.put("backsub_top_file_nm", commonFileVO.getFile_nm());
                    }
                }
            }
            
            rv = logoMtService.insertLogo(param);
            
            if (rv > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("Logo", param);
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
    
}
