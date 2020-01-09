package kr.or.wabis.admin.wbiz.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.integration.service.CodeMtService;
import kr.or.wabis.admin.support.service.ScheduleMtService;
import kr.or.wabis.admin.wbiz.service.CategoryMtService;
import kr.or.wabis.framework.contants.CmsConstant;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.user.vo.UserVO;

@Controller("categoryMtController")
public class CategoryMtController extends AbstractController {
	
	 private Logger logger = Logger.getLogger(this.getClass());
	 
	 private final static String ADMIN_PATH = "/admin/wbiz/";
	 
	 @Resource(name = "categoryMtService")
	 private CategoryMtService categoryMtService;
	 
	 @Resource(name = "codeMtService")
	 private CodeMtService codeMtService;
	
    // 물산업분류관리 조회
    @RequestMapping(value = "/admin/wbiz/selectCategoryList.do")
    public String selectCategoryList( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
        return ADMIN_PATH + "categoryList";
        
    }
    
    // 물산업분류관리 조회
    @RequestMapping(value = "/admin/wbiz/categorySelectList.do")
    public String categorySelectList( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	 Map<String, Object> param = _req.getParameterMap();
    	 List<Map<String, Object>> categoryList = categoryMtService.categorySelectList(param);         
         model.addAttribute( "categoryList" , categoryList );        
         return "/sub" + ADMIN_PATH + "categorySelect";        
    }  
    
    // 물산업분류관리 작성
    @RequestMapping(value = "/admin/wbiz/categoryWrite.do")
    public String categoryWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> category = new HashMap();
        
        param.put( "gubun" , "INDS_TP_CD" );    	
    	model.addAttribute( "indsTypeCodeList" , codeMtService.selectCodeList( param ) );
    	
        if( StringUtil.nvl( param.get( "mode" ) ).equals( "W" ) ){            
 
        }else if( StringUtil.nvl( param.get( "mode" ) ).equals( "E" ) ){
        	
        	if( StringUtil.nvl( param.get( "wbiz_cd_tp" ) ).equals( "L" ) ){
        		 param.put( "wbiz_tp_l_cd" , param.get( "code" ) ); 
        	}else if( StringUtil.nvl( param.get( "wbiz_cd_tp" ) ).equals( "M" ) ){
        		param.put( "wbiz_tp_m_cd" , param.get( "code" ) );
        	}else if( StringUtil.nvl( param.get( "wbiz_cd_tp" ) ).equals( "S" ) ){
        		param.put( "wbiz_tp_s_cd" , param.get( "code" ) );
        	}
        	
        	category = categoryMtService.categorySelect(param);    
        }
        
        model.addAttribute( "category" , category );        
        return "/sub" + ADMIN_PATH + "categoryWrite";
    }
    
    // 물산업분류관리 로드
    @RequestMapping(value = "/admin/wbiz/categoryLoad.do")
    public ModelAndView categoryLoad( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	param.put( "list" , categoryMtService.categoryLoad( param ) );
    	
        return ViewHelper.getJsonView(param);
    }
    
    // 물산업 분류관리 조회
    @RequestMapping(value = "/admin/wbiz/categoryInsert.do")
    public ModelAndView categoryInsert( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();    
    	UserVO userVo =  _req.getSessionUser();
    	int result = 0;
    	
    	try{
    			param.put( "s_user_no" , userVo.getUserNo() );	    		
    			
    			if( "L".equals( param.get( "wbiz_cd_tp" ) ) ){
    				param.put("wbiz_tp_l_cd" , param.get( "wbiz_tp_cd" ) );
    				param.put("wbiz_tp_m_cd" , "" );
    				param.put("wbiz_tp_s_cd" , "" );
    			} else if( "M".equals( param.get( "wbiz_cd_tp" ) ) ){
    				param.put("wbiz_tp_m_cd" , param.get( "wbiz_tp_cd" ) );
    				param.put("wbiz_tp_s_cd" , "" );
    			} else if( "S".equals( param.get( "wbiz_cd_tp" ) ) ){
    				param.put("wbiz_tp_s_cd" , param.get( "wbiz_tp_cd" ) );
    			}  
    			
	    		result = categoryMtService.categoryInsert( param );
        
	        if( result > 0 ){ 
	            param.put( "success" , "true" );
	            param.put( "message" , MessageUtil.getInsertMsg( result , _req ) );
	        }else{
	            param.put( "success" , "false" ); 
	            param.put( "message" , MessageUtil.getProcessFaildMsg( result , _req ) ); 
	        }
        
    	}catch( Exception e ){
	        e.printStackTrace();
	        param.put( "success" , "false" ); 
	        param.put( "message" , MessageUtil.getProcessFaildMsg( result , _req ) ); 
	        return ViewHelper.getJsonView( param );
    	}    	
    	
        return ViewHelper.getJsonView( param );
        
    }
    
    
 // 물산업 분류관리 조회
    @RequestMapping(value = "/admin/wbiz/categoryUpdate.do")
    public ModelAndView categoryUpdate( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();    
    	UserVO userVo =  _req.getSessionUser();
    	int result = 0;
    	
    	try{
    			param.put( "s_user_no" , userVo.getUserNo() );	    		
	    		result = categoryMtService.categoryUpdate( param );
        
	        if( result > 0 ){ 
	            param.put( "success" , "true" );
	            param.put( "message" , MessageUtil.getInsertMsg( result , _req ) );
	        }else{
	            param.put( "success" , "false" ); 
	            param.put( "message" , MessageUtil.getProcessFaildMsg( result , _req ) ); 
	        }
        
    	}catch( Exception e ){
	        e.printStackTrace();
	        param.put( "success" , "false" ); 
	        param.put( "message" , MessageUtil.getProcessFaildMsg( result , _req ) ); 
	        return ViewHelper.getJsonView( param );
    	}    	
    	
        return ViewHelper.getJsonView( param );
        
    }
    
    // 물산업 분류관리 조회
    @RequestMapping(value = "/admin/wbiz/categoryDelete.do")
    public ModelAndView categoryDelete( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();    
    	UserVO userVo =  _req.getSessionUser();
    	int result = 0;
    	
    	try{
    			param.put( "s_user_no" , userVo.getUserNo() );	    		
	    		result = categoryMtService.categoryDelete( param );
        
	        if( result > 0 ){ 
	            param.put( "success" , "true" );
	            param.put( "message" , MessageUtil.getInsertMsg( result , _req ) );
	        }else{
	            param.put( "success" , "false" ); 
	            param.put( "message" , MessageUtil.getProcessFaildMsg( result , _req ) ); 
	        }
        
    	}catch( Exception e ){
	        e.printStackTrace();
	        param.put( "success" , "false" ); 
	        param.put( "message" , MessageUtil.getProcessFaildMsg( result , _req ) ); 
	        return ViewHelper.getJsonView( param );
    	}    	
    	
        return ViewHelper.getJsonView( param );
        
    }
    
    // 물산업분류관리 조회
    @RequestMapping(value = "/admin/wbiz/categorySelectListExcel.do")
    public ModelAndView categorySelectListExcel( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	 Map<String, Object> param = _req.getParameterMap();    
    	
    	 model.put( "excelName", "물산업분류(국문)" );
    	 model.put( "sheetName" , "물산업분류" );    	 
    	 
    	 List<String[]> headerMap = new ArrayList<String[]>();
    	 headerMap.add( new String[]{ "산업구분" , "코드" , "대분류명" , "코드" , "중분류명" , "코드" , "세분류명" } );
    	 
    	 String[] columnMap = new String[]{ "code_nm" , "wbiz_tp_l_cd" , "wbiz_tp_l_nm" , "wbiz_tp_m_cd" , "wbiz_tp_m_nm" , "wbiz_tp_s_cd" , "wbiz_tp_s_nm" };
    	 short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , 
    			 HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER };
    	 
    	 model.put( "headerMap" , headerMap );
    	 model.put( "columnMap" , columnMap );
    	 model.put( "alignMap" , alignMap );
    	 model.put( "dataMap" , categoryMtService.categorySelectList( param ) );
    	 
    	 
    	 return new ModelAndView( "excelDownView" , "model" , model );
        
    }
    
 // 물산업분류관리 조회
    @RequestMapping(value = "/admin/wbiz/categorySelectListExcelEn.do")
    public ModelAndView categorySelectListExcelEn( ExtHttpRequestParam _req , ModelMap model ) throws Exception {
    	
    	 Map<String, Object> param = _req.getParameterMap();   
    	
    	 model.put( "excelName", "물산업분류(영문)" );
    	 model.put( "sheetName" , "물산업분류" );    	 
    	 
    	 List<String[]> headerMap = new ArrayList<String[]>();
    	 headerMap.add( new String[]{ "산업구분" , "코드" , "대분류명" , "코드" , "중분류명" , "코드" , "세분류명" } );
    	 
    	 String[] columnMap = new String[]{ "code_nm" , "wbiz_tp_l_cd" , "wbiz_tp_l_nm" , "wbiz_tp_m_cd" , "wbiz_tp_m_nm" , "wbiz_tp_s_cd" , "wbiz_tp_s_nm" };
    	 short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , 
    			 HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER , HSSFCellStyle.ALIGN_CENTER };
    	 
    	 model.put( "headerMap" , headerMap );
    	 model.put( "columnMap" , columnMap );
    	 model.put( "alignMap" , alignMap );
    	 param.put( "language" , "en" );
    	 model.put( "dataMap" , categoryMtService.categorySelectList( param ) );
    	 
    	 
    	 return new ModelAndView( "excelDownView" , "model" , model );
        
    }
    
 
	
}
