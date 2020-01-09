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
import kr.or.wabis.support.service.OrganService;

@Controller("organController")
public class OrganController extends AbstractController {
    
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/support/";
    
    @Resource(name = "organService")
    private OrganService organService;
    
    // 유관기관 조회
    @RequestMapping(value = "/web/organ/organListPage.do")
    public String organListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
        Map<String, Object> param = _req.getParameterMap();  
        model.addAttribute("param", param);
        return WEB_PATH + "organListPage";
    }
    
    // 유관기관 조회
    @RequestMapping(value = "/web/organ/organList.do")
    public String organList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        param.put("sidx", "sort");
        param.put("sord", "asc");
        
        // 메인에서 조회 정보를 oragnListPage의 조회값을 가지고 있다가 조회시 처리
        String p_organ_gb = StringUtil.nvl(param.get("p_organ_gb"),null);        
        if( p_organ_gb != null){
            param.put("organ_gb", p_organ_gb);
        }

        navigator.setList(organService.selectOrganPageList(param));
                
        model.addAttribute("param", param);
        model.addAttribute("organList", navigator.getList());
        model.addAttribute("organPagging", navigator.getPagging());
        model.addAttribute("totalcnt", navigator.getTotalCnt());

        return "/sub" + WEB_PATH + "organList";
    }
    
    // 유관기관 상세조회
    @RequestMapping(value = "/web/organ/selectOrgan.do")
    public String selectOrgan(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> organ = organService.selectOrgan(param);
        param.put("organ", organ);
        
        return WEB_PATH + "organView";
    }
    
    // 유관기관 조회 (메인용)
    @RequestMapping(value = "/web/organ/loadMainOrganList.do")
    public ModelAndView loadMainOrganList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = organService.selectMainOrganList(param);
        param.put("list", list);
        
        return ViewHelper.getJsonView(param);
        
    }
    
}
