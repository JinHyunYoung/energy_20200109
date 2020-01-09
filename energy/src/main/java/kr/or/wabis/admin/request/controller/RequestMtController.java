package kr.or.wabis.admin.request.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.or.wabis.admin.request.service.RequestMtService;
import kr.or.wabis.framework.email.MailManageServiceImpl;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.ProjectConfigUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by my on 2017-11-01.
 */
@Controller("requestMtController")
public class RequestMtController  extends AbstractController {
	
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String ADMIN_PATH = "/admin/request/";
    
    @Resource(name = "requestMtService")
    private RequestMtService requestMtService;
	
	@Autowired
    private MailManageServiceImpl mailManagerService;
    
    /**
     * 신문고 리스트 페이지
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/request/requestListPage.do")
    public String requestListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception { 

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		
        return ADMIN_PATH + "requestListPage";
    }
 
    /**
     * 신문고 페이지리스트
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/request/requestPageList.do")
    public ModelAndView requestPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
    	NavigatorInfo navigator = new NavigatorInfo(_req);	
        Map<String, Object> param  = navigator.getParam();
		navigator.setList(requestMtService.selectRequestPageList(param));		
        
        return ViewHelper.getJqGridView(navigator);	
    }

    /**
     * 신문고 리스트를 엑셀 다운로드 해준다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/request/requestPageListExcel.do")
    public ModelAndView requestPageListExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        navigator.setPageSize( 99999 );
        Map<String, Object> param = navigator.getParam();
        
        param.put("miv_end_index", 9999999);
        logger.debug(param);
        
        model.put( "excelName", "신문고신청" );
		model.put( "sheetName" , "신문고신청" );    	 
		 
		List<String[]> headerMap = new ArrayList<String[]>();
		headerMap.add( new String[]{ "구분","신청일시","이름","이메일","연락처","답변상태","제목","첨부파일존재여부","내용","답변자","답변내용"} );
		String[] columnMap = new String[]{"req_gb_nm","reg_date","user_nm","email","handphone","answer_yn","title","attach_file_yn","contents","answer_nm","answer" };
		short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT,
				                        HSSFCellStyle.ALIGN_LEFT 
		                              };
		 
		model.put( "headerMap" , headerMap );
		model.put( "columnMap" , columnMap );
		model.put( "alignMap" , alignMap );		
		model.put( "dataMap" , requestMtService.selectRequestPageList(param) );
		 
		return new ModelAndView( "excelDownView" , "model" , model );        
    }
    /**
     * 운영관리 등록 페이지로 이동한다
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/request/requestWrite.do")
    public String eduseqWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> request = new HashMap();
             
        request = requestMtService.selectRequest(param);
        
        model.addAttribute("request", request);
        model.addAttribute("param", param);
        
        return ADMIN_PATH + "requestWrite";
    }
    
    /**
     * 신문고를 등록한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/request/updateRequestAnswer.do")
    public ModelAndView updateRequestAnswer(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
            
            rv = requestMtService.updateRequestAnswer(param);
            
            if (rv > 0) { 
            	if(!StringUtil.nvl(param.get("email")).equals("")){ 
	            	String adminEmail = (String) ProjectConfigUtil.getProperty("project.mail.adminemail");
	            	param.put("contents",StringUtil.convertTextAreaToStringCRLF(StringUtil.nvl(param.get("contents"))));
	            	param.put("answer",StringUtil.convertTextAreaToStringCRLF(StringUtil.nvl(param.get("answer"))));
	            	mailManagerService.sendEmail(StringUtil.nvl(param.get("email")), adminEmail, StringUtil.nvl(param.get("title")), param, "/email/requestAnswerMailForm.vm");
            	}
                param.put("success", "true");
                param.put("message", "신문고가 답변이 되었습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "신문고 답변에 실패하였습니다."); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "신문고 답변 시  오류가  발생하였습니다."); 
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);        
    }

    
    /**
     * 신문고를 삭제한다.
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/request/deleteRequest.do")
    public ModelAndView deleteRequest(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
    
        try {
            
            rv = requestMtService.deleteRequest(param);
            
            if (rv > 0) { 
              	
                param.put("success", "true");
                param.put("message", "신문고가 삭제 되었습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "신문고 삭제에 실패하였습니다."); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "신문고 삭제 시  오류가  발생하였습니다."); 
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);        
    }
    
}
