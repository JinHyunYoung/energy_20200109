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
import kr.or.wabis.support.service.IntgSchService;
import kr.or.wabis.support.service.OrganService;

@Controller("intgSchController")
public class IntgSchController extends AbstractController {
    
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/support/";
    
    @Resource(name = "intgSchService")
    private IntgSchService intgSchService;
    
    // 유관기관 조회
    @RequestMapping(value = "/web/intgSch/intgSchListPage.do")
    public String intgSchListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {

    	Map<String, Object> param = _req.getParameterMap();  
        model.addAttribute("param", param);

        return WEB_PATH + "intgSchListPage";
    }
    
    @RequestMapping(value = "/web/intgSch/intgSchList.do")
    public String intgSchList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        param.put("sidx", "reg_date");
        param.put("sord", "desc");
        
        String keyword = StringUtil.nvl( (String)param.get( "keyword" ) );
        
        if( ! "".equals( keyword ) ){
        
        	List<Map<String,Object>> list = intgSchService.selectIntgSchPageList(param);
        
	        if( list != null && ! list.isEmpty() ){
	        	String from = "";
	        	String to = "";
	        	
	        	for( int i = 0 ; i < list.size() ; i++ ){
	        		if( (String)list.get(i).get( "contents" ) != null ){
	        			from = (String)list.get(i).get( "contents" );
	        			from = StringUtil.removeTag( from );
	        			if( from != null ){
	        				to = from.replaceAll( keyword , "<span class=\"search_keyword\">" + keyword + "</span>" );  
	        			}else{
	        				to = from;
	        			}
	        			list.get(i).put( "contents" , to );
	        		}
	        	}
	        }
	        navigator.setList(list);
        }
        
        
                
        model.addAttribute("top5", intgSchService.searchIntgSchTop5(param));
        
        model.addAttribute("param", param);
        model.addAttribute("intgSchList", navigator.getList());
        model.addAttribute("intgSchPagging", navigator.getPagging());
        model.addAttribute("totalcnt", navigator.getTotalCnt());
        model.addAttribute("pageSize", navigator.getPageSize());
        

        return "/sub" + WEB_PATH + "intgSchList";
    }
    
    
    @RequestMapping(value = "/web/intgSch/intgSchTop5.do")
    public ModelAndView intgSchTop5(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();        
                
        param.put("top5", intgSchService.searchIntgSchTop5(param));        
        return ViewHelper.getJsonView( param );
        
    }
    
}
