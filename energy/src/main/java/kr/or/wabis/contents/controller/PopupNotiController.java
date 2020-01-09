package kr.or.wabis.contents.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.contents.controller.PopupNotiMtController;
import kr.or.wabis.contents.service.PopupNotiService;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("popupNotiController")
public class PopupNotiController extends AbstractController {
    
    private Logger logger = Logger.getLogger(PopupNotiMtController.class);
    
    private final static String WEB_PATH = "/web/contents/";
    
    @Resource(name = "popupNotiService")
    private PopupNotiService popupNotiService;
    
    /**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/popnoti/popnotiList.do")
    public ModelAndView popnotiList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        param.put("use_yn", "Y");
        param.put("today", "Y");
        
        List<Map<String, Object>> list = popupNotiService.selectMainPopnotiList(param);
        param.put("list", list);
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 미리보기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/popnoti/popnotiPreview.do")
    public String popnotiPreview(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute("popnoti", param);
        
        return "/popup" + WEB_PATH + "popnotiPreview";
    }
    
}
