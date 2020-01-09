package kr.or.wabis.integration.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.integration.service.MenuService;

@Controller("menuController")
public class MenuController extends AbstractController {
    
    private Logger logger = Logger.getLogger(MenuController.class);
    
    private final static String WEB_PATH = "/web/integration/";
    
    @Resource(name = "menuService")
    private MenuService menuService;
    
    /**
     * 사이트맵 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/integration/siteMapShow.do")
    public String siteMapShow(ExtHttpRequestParam _req, ModelMap model) throws Exception {    

        Map<String, Object> param = _req.getParameterMap();  
                
        List<Map<String, Object>> sitemapList = menuService.selectFrontSitemapList(param);
        model.addAttribute("sitemapList", sitemapList);

        return WEB_PATH + "siteMapShow";
    }
    
}
