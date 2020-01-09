package kr.or.wabis.admin.support.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.support.service.DictionaryMtService;
import kr.or.wabis.admin.support.service.NewsApplyMtService;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("newsApplyMtController")
public class NewsApplyMtController extends AbstractController {

	private Logger logger = Logger.getLogger(this.getClass());

	private final static String ADMIN_PATH = "/admin/support/";

	@Resource(name = "newsApplyMtService")
	private NewsApplyMtService newsApplyMtService;
	

    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/newsApply/newsApplyListPage.do")
    public String newsApplyListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);        
        return ADMIN_PATH + "newsApplyListPage";
    }  
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/newsApply/newsApplyPageList.do")
    public ModelAndView newsApplyPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        navigator.setList(newsApplyMtService.selectNewsApplyPageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
        
    /**
     * 데이타를 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/newsApply/newsApplyDelete.do")
    public ModelAndView deleteNewsApply(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        String list_app_sn = (String)param.get( "list_app_sn" );
        String[] array_app_sn = list_app_sn.split( "," );        
        
        try {
                   	
        	rv = 0;
        	for( int i = 0 ; i < array_app_sn.length ; ++i ){        		
        		rv += newsApplyMtService.deleteNewApply(array_app_sn[i]);
        	}            
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getDeteleMsg(rv, _req));
            } else {
                param.put("success", "false");
                param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
    
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/newsApply/newsApplyPageListExcel.do")
    public ModelAndView newsApplyPageListExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        navigator.setPageSize( 99999 );
        Map<String, Object> param = navigator.getParam();
        
        param.put("miv_end_index", 9999999);
        logger.debug(param);
        
        model.put( "excelName", "뉴스레터신청자" );
		model.put( "sheetName" , "뉴스레터신청자" );    	 
		 
		List<String[]> headerMap = new ArrayList<String[]>();
		headerMap.add( new String[]{ "신청일" , "이름" , "이메일" } );
		
		 
		String[] columnMap = new String[]{ "reg_date" , "name" , "email" };
		short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT };
		 
		model.put( "headerMap" , headerMap );
		model.put( "columnMap" , columnMap );
		model.put( "alignMap" , alignMap );		
		model.put( "dataMap" , newsApplyMtService.selectNewsApplyPageList(param) );
		 
		 
		return new ModelAndView( "excelDownView" , "model" , model );        
       
    }
    
}
