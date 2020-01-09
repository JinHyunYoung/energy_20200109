package kr.or.wabis.request.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.framework.email.MailManageServiceImpl;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.ProjectConfigUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.request.service.RequestService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by my on 2017-11-01.
 */
@Controller("requestController")
public class RequestController  extends AbstractController {
	
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/request/";
    
    @Resource(name = "requestService")
    private RequestService requestService;
	
	@Autowired
    private MailManageServiceImpl mailManagerService;
	
    /**
     * 신문고 안내 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/request/requestInfo.do")
    public String requestInfo(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
    	
        return WEB_PATH + "requestInfo";
    }
    
    /**
     * 신문고 인증 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/request/requestCerti.do")
    public String requestCerti(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
        model.addAttribute("param", param);
        
      	// 관리자에게 메일을 전송해준다. admin@test.com을 관리자 메일로 대체
    /*	String adminEmail = "wabis.email@koref.or.kr";
    	param.put("user_nm", "홍길동");
    	param.put("email", "chorongjjang@gmail.com");
    	param.put("handphone", "010-111-2222");
    	param.put("title", "테스트 메일입니다.");
    	param.put("mailSendDate", "2017-11-11");
    	param.put("contents", "테스트 메일 내용 입니다.");
    	mailManagerService.sendEmail("chorongjjang@gmail.com", adminEmail, "테스트 메일입니다.", param, "/email/requestMailForm.vm");*/
        
        return WEB_PATH + "requestCerti";
    } 

    /**
     * 신문고 등록 페이지로 이동을 한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/request/requestWrite.do")
    public String requestWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
        model.addAttribute("param", param);
        
        return WEB_PATH + "requestWrite";
    }
    
    /**
     * 신문고를 등록한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/request/insertRequest.do")
    public ModelAndView insertRequest(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("request/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                    
                    // 첨부파일
                    if ("uploadFile1".equals(file.getFieldName())) { 
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("request/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        param.put("file_name", file.getOriginalFileName());
                        param.put("file_path", getUploadPath("request/")+file.getFileName());
                        param.put("attach_file", commonFileVO.getFile_id());
                    } 
                }
            }
            
            String email = param.get("email_1") + "@" + param.get("email_2");
            param.put("email", email);
            rv = requestService.insertRequest(param);
            
            if (rv > 0) { 
              	// 관리자에게 메일을 전송해준다.
            	try{
	            	String adminEmail = (String) ProjectConfigUtil.getProperty("project.mail.adminemail");
	            	param.put("mailSendDate", DateUtil.getTodayStr("yyyy-MM-dd"));
	            	mailManagerService.sendEmail(adminEmail, adminEmail, StringUtil.nvl(param.get("title")), param, "/email/requestMailForm.vm");
            	}catch(Exception e ){
            		e.printStackTrace();
            	}
                param.put("success", "true");
                param.put("message", "신문고가 등록되었습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "신문고 등록에 실패하였습니다."); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "신문고 등록 시  오류가  발생하였습니다."); 
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);        
    }
    
    /**
     * 신문고 접수 완료 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/request/requestComplete.do")
    public String requestComplete(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
         
        return WEB_PATH + "requestComplete";
    }
}
