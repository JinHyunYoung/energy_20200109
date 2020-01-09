package kr.or.wabis.board.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.board.service.FaqService;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("faqController")
public class FaqController extends AbstractController {
    
    private Logger logger = Logger.getLogger(FaqController.class);
    
    private final static String WEB_PATH = "/web/board/";
    
    @Resource(name = "faqService")
    private FaqService faqService;
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/faq/faqListPage.do")
    public String faqListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        param.put("use_yn", "Y");
        List<Map<String, Object>> faqList = faqService.selectFaqList(param);
        
        model.addAttribute("faqList", faqList);
        
        return WEB_PATH + "faqListPage";
    }
    
    /**
     * 게시판 메인 출력용 Faq
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/loadMainFaq.do")
    public ModelAndView loadMainBoard(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = faqService.selectLoadMainFaq(param);
        
        param.put("list", list);
        
        return ViewHelper.getJsonView(param);
    }
    
}
