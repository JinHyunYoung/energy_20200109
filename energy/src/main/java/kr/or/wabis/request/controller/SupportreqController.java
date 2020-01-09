package kr.or.wabis.request.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.request.service.SupportreqService;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by my on 2017-11-01.
 */
@Controller("supportreqController")
public class SupportreqController  extends AbstractController {
	
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/support/";
    
    @Resource(name = "supportreqService")
    private SupportreqService supportreqService;

    /**
     * 지원신청 인증 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/support/supportreqCerti.do")
    public String supportreqCerti(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
         
        return WEB_PATH + "supportreqCerti";
    }

    /**
     * 지원신청 등록 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/support/supportreqWrite.do")
    public String supportreqWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
        String birth = StringUtil.nvl(param.get("birth"));
        if(!birth.equals("")) param.put("birth",DateUtil.getConvertDate(birth,"1"));
        model.addAttribute("supportreq", param);
        
        return WEB_PATH + "supportreqWrite";
    }
    
    /**
     * 지원신청을 등록한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/support/insertSupportreq.do")
    public ModelAndView insertSupportreq(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("supportreq/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                    
                    // 대상가구증명서류
                    if ("uploadFile1".equals(file.getFieldName())) { 
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("supportreq/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        param.put("obj_prof_doc", commonFileVO.getFile_id());
                    } 
                }
            }
            
            rv = supportreqService.insertSupportreq(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "지원서가 등록되었습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "지원서 등록에 실패하였습니다."); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "지원서 등록 시  오류가  발생하였습니다."); 
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
    @RequestMapping(value = "/web/support/supportreqComplete.do")
    public String supportreqComplete(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        return WEB_PATH + "supportreqComplete";
    }
}
