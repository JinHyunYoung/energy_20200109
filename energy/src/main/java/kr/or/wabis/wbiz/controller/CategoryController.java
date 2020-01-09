package kr.or.wabis.wbiz.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.wbiz.service.CategoryMtService;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.support.service.OrganService;
import kr.or.wabis.wbiz.service.CategoryService;

@Controller("categoryController")
public class CategoryController extends AbstractController {
    
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/wbiz/";
    
    @Resource(name = "categoryService")
    private CategoryService categoryService;
    
    @Resource(name = "categoryMtService")
	 private CategoryMtService categoryMtService;
    
    // 유관기관 조회
    @RequestMapping(value = "/web/wbiz/categoryList.do")
    public String categoryListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {      
    	
        Map<String, Object> param = _req.getParameterMap();  
        
        List<Map<String, Object>> categoryList = categoryService.selectCategoryList(param);
        model.addAttribute( "categoryList" , categoryList );        
        
        return WEB_PATH + "categoryList";
    }
    
    // 물산업분류관리 로드
    @RequestMapping(value = "/web/wbiz/categoryLoad.do")
    public ModelAndView categoryLoad( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	param.put( "list" , categoryMtService.categoryLoad( param ) );
    	
        return ViewHelper.getJsonView(param);
    }
    
    
}
