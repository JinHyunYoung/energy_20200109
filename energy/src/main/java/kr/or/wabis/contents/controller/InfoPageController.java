package kr.or.wabis.contents.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.contents.service.InfoPageService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("infoPageController")
public class InfoPageController extends AbstractController {
    
    private Logger logger = Logger.getLogger(InfoPageController.class);
    
    private final static String WEB_PATH = "/web/contents/";
    
    @Resource(name = "infoPageService")
    private InfoPageService infoPageService;
    
    /**
     * 이용약관 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/infopage/clauseShow.do")
    public String clauseShow(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
        model.put("info_type", "clause");
        return WEB_PATH + "infopageShow";
    }
    
    /**
     * 개인정보 보호정책 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/infopage/privacyShow.do")
    public String privacyShow(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        model.put("info_type", "privacy");
        return WEB_PATH + "infopageShow";
    }
    
	/**
	 * 정보 보기 페이지로 이동을 한다.
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/infopage/selectInfopageShow.do")
    public ModelAndView selectInfopageShow(ExtHttpRequestParam _req, ModelMap model) throws Exception {
	
	    Map<String, Object> param = _req.getParameterMap();  
	    
	    String version = param.get("version").toString();
	    
	    Map<String, Object> infopage;
	    if(version.equals("none")){
	    	infopage = infoPageService.selectInfopageShow(param);  	    	
	    } else {
	    	infopage = infoPageService.selectInfopage(param);  	  	    	
	    }
	                         
	    param.put("infopage", infopage);
        
        return ViewHelper.getJsonView(param);        
    }    
}
