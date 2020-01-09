package kr.or.wabis.contents.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.contents.controller.BannerMtController;
import kr.or.wabis.contents.service.BannerService;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("bannerController")
public class BannerController extends AbstractController {
    
    private Logger logger = Logger.getLogger(BannerMtController.class);
    
    private final static String WEB_PATH = "/web/contents/";
    
    @Resource(name = "bannerService")
    private BannerService bannerService;
    
    /**
     * 게시판 메인 출력용 게시물
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/banner/loadMainBanner.do")
    public ModelAndView loadMainBoard(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        param.put("use_yn", "Y");
        
        List<Map<String, Object>> list = bannerService.selectBannerList(param);
        param.put("list", list);
        
        return ViewHelper.getJsonView(param);
    }
    
}
