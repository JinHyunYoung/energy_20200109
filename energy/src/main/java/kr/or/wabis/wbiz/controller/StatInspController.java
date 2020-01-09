package kr.or.wabis.wbiz.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.integration.service.CodeMtService;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.support.service.OrganService;
import kr.or.wabis.wbiz.service.CategoryService;
import kr.or.wabis.wbiz.service.StatInspService;

@Controller("statInspController")
public class StatInspController extends AbstractController {
    
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/wbiz/";
    
    @Resource(name = "statInspService")
    private StatInspService statInspService;
    
    @Resource(name = "codeMtService")
	 private CodeMtService codeMtService;
    
    // 유관기관 조회
    @RequestMapping(value = "/web/wbiz/statInspApply.do")
    public String categoryListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
        Map<String, Object> param = _req.getParameterMap();
        
        param.put( "gubun" , "INDS_TP_CD" );
        model.addAttribute( "indsTypeCodeList" , codeMtService.selectCodeList( param ) ); 
       
        return WEB_PATH + "statInspApply";
    }
    
    
 // 유관기관 조회
    @RequestMapping(value = "/web/wbiz/statInspApplyWrite.do")
    public ModelAndView statInspApplyWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();        
       param.put( "result" , statInspService.insertStatInspApply(param));

        return ViewHelper.getJsonView(param);
    }    
    
    
}
