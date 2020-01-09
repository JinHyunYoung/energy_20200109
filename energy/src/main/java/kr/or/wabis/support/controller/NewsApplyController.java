package kr.or.wabis.support.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.support.service.DictionaryService;
import kr.or.wabis.support.service.NewsApplyService;
import kr.or.wabis.support.service.OrganService;

@Controller("newsApplyController")
public class NewsApplyController extends AbstractController {
    
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/support/";
    
    @Resource(name = "newsApplyService")
    private NewsApplyService newsApplyService;
    
    // 유관기관 조회
    @RequestMapping(value = "/web/newsApply/newsApply.do")
    public String newsApply(ExtHttpRequestParam _req, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();  
        model.addAttribute("param", param);

        return WEB_PATH + "newsApply";
    }
    
    @RequestMapping(value = "/web/newsApply/newsApplyWrite.do")
    public ModelAndView newsApplyWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();        
       param.put( "result" , newsApplyService.updateNewsApply(param));

        return ViewHelper.getJsonView(param);
    }
    
}
