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
import kr.or.wabis.support.service.OrganService;

@Controller("dictionaryController")
public class DictionaryController extends AbstractController {
    
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/support/";
    
    @Resource(name = "dictionaryService")
    private DictionaryService dictionaryService;
    
    // 유관기관 조회
    @RequestMapping(value = "/web/dictionary/dictionaryListPage.do")
    public String dictionaryListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();  
        model.addAttribute("param", param);

        return WEB_PATH + "dictionaryListPage";
    }
    
    @RequestMapping(value = "/web/dictionary/dictionaryList.do")
    public String dictionaryList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        param.put("sidx", "term_kr_nm");
        param.put("sord", "asc");
        
        navigator.setList(dictionaryService.selectPortalDictionaryPageList(param));
                
        model.addAttribute("top5", dictionaryService.searchTermHistoryTop5(param));
        model.addAttribute("param", param);
        model.addAttribute("dictionaryList", navigator.getList());
        model.addAttribute("dictionaryPagging", navigator.getPagging());
        model.addAttribute("totalcnt", navigator.getTotalCnt());

        return "/sub" + WEB_PATH + "dictionaryList";
    }
    
}
