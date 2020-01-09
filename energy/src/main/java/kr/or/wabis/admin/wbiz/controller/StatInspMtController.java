package kr.or.wabis.admin.wbiz.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.integration.service.CodeMtService;
import kr.or.wabis.admin.support.service.ScheduleMtService;
import kr.or.wabis.admin.wbiz.service.CategoryMtService;
import kr.or.wabis.admin.wbiz.service.StatInspMtService;
import kr.or.wabis.framework.contants.CmsConstant;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.user.vo.UserVO;

@Controller("statInspMtController")
public class StatInspMtController extends AbstractController {
	
	 private Logger logger = Logger.getLogger(this.getClass());
	 
	 private final static String ADMIN_PATH = "/admin/wbiz/";
	 
	 @Resource(name = "categoryMtService")
	 private CategoryMtService categoryMtService;
	 
	 @Resource(name = "codeMtService")
	 private CodeMtService codeMtService;
	 
	 @Resource(name = "statInspMtService")
	 private StatInspMtService statInspMtService;
	
    // 물산업분류관리 조회
    @RequestMapping(value = "/admin/wbiz/statInspApplyListPage.do")
    public String statInspApplyListPage( ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);        
        return ADMIN_PATH + "statInspApplyListPage";
        
    }
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/wbiz/statInspApplyPageList.do")
    public ModelAndView statInspApplyPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        navigator.setList(statInspMtService.selectStatInspApplyPageList(param));
        
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
    @RequestMapping(value = "/admin/wbiz/statInspApplyDelete.do")
    public ModelAndView statInspApplyDelete(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        String list_app_sn = (String)param.get( "list_app_sn" );
        String[] array_app_sn = list_app_sn.split( "," );        
        
        try {
                   	
        	rv = 0;
        	for( int i = 0 ; i < array_app_sn.length ; ++i ){        		
        		param.put( "stats_app_sn" , array_app_sn[i]);
        		rv += statInspMtService.deleteStatInspApply(param);
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
     * 작성 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/wbiz/statInspApplyWrite.do")
    public String statInspApplyWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {  

        
        Map<String, Object> param = _req.getParameterMap();    	

        if ("E".equals(param.get("mode"))) {
           
        	param.put( "gubun" , "INDS_TP_CD" );
            model.addAttribute( "indsTypeCodeList" , codeMtService.selectCodeList( param ) );            
            Map<String, Object> statInspApply = statInspMtService.selectStatInspApply(param);
            model.addAttribute("statInspApply", statInspApply);
            
            String inds_tp_cd = StringUtil.nvl( statInspApply.get("inds_tp_cd" ) );
            String wbiz_tp_l_cd = StringUtil.nvl( statInspApply.get("wbiz_tp_l_cd" ) );
            String wbiz_tp_m_cd = StringUtil.nvl( statInspApply.get("wbiz_tp_m_cd" ) );
            String wbiz_tp_s_cd = StringUtil.nvl( statInspApply.get("wbiz_tp_s_cd" ) );
            
            Map<String, Object> _param = new HashMap<>();
            
            if( ! "".equals( wbiz_tp_l_cd ) ){            	
            	_param.put( "inds_tp_cd" , inds_tp_cd );
            	_param.put( "wbiz_cd_tp" , "L" );
            	model.addAttribute( "list_wbiz_tp_l_cd" ,  	categoryMtService.categoryLoad( _param ) );            	
            }
            
            _param.clear();
            if( ! "".equals( wbiz_tp_m_cd ) ){            	
            	_param.put( "wbiz_tp_l_cd" , wbiz_tp_l_cd );
            	_param.put( "wbiz_cd_tp" , "M" );
            	model.addAttribute( "list_wbiz_tp_m_cd" ,  	categoryMtService.categoryLoad( _param ) );            	
            }
            
            _param.clear();
            if( ! "".equals( wbiz_tp_s_cd ) ){            	
            	_param.put( "wbiz_tp_m_cd" , wbiz_tp_m_cd );
            	_param.put( "wbiz_cd_tp" , "S" );
            	model.addAttribute( "list_wbiz_tp_s_cd" ,  	categoryMtService.categoryLoad( _param ) );            	
            }
            
            
        }
                
        return "/popup" + ADMIN_PATH + "statInspApplyModifyPop";
    }
    
    /**
     * 데이타를 수정한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/wbiz/statInspApplyUpdate.do")
    public ModelAndView statInspApplyUpdate(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        try {         
            
            rv = statInspMtService.updateStatInspApply(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
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
    @RequestMapping(value = "/admin/wbiz/statInspApplySelectListExcel.do")
    public ModelAndView statInspApplySelectListExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        navigator.setPageSize( 99999 );
        Map<String, Object> param = navigator.getParam();
        
        
		model.put( "excelName", "통계조사신청자" );
		model.put( "sheetName" , "통계조사신청자" );    	 
		 
		List<String[]> headerMap = new ArrayList<String[]>();
		headerMap.add( new String[]{ "신청일" , "소속 기업명" , "사업자번호" , "물산업 분류(주업종)" , "" , "" , "" , "종사자수(사원수)" , "주소" , "" , "" , "이름" , "전화번호" , "휴대전화" , "이메일" , "소속부서" , "직위" } );
		headerMap.add( new String[]{ "" , "" , "" , "구분" , "1Depth" , "2Depth" , "3Depth" , "" , "우편번호" , "기본주소" , "상세주소" , "" , "" , "" , "" , "" , "" } );
		List<CellRangeAddress> mergeMap = new ArrayList<CellRangeAddress>();
		
		mergeMap.add( new CellRangeAddress( 0 , 1 , 0 , 0 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 1 , 1 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 2 , 2 ) );
		mergeMap.add( new CellRangeAddress( 0 , 0 , 3 , 6 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 7 , 7 ) );
		mergeMap.add( new CellRangeAddress( 0 , 0 , 8 , 10 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 11 , 11 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 12 , 12 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 13 , 13 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 14 , 14 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 15 , 15 ) );
		mergeMap.add( new CellRangeAddress( 0 , 1 , 16 , 16 ) );
		 
		String[] columnMap = new String[]{ "reg_date" , "cmpy_nm" , "biz_reg_no" , "inds_tp_cd" , "wbiz_tp_l_cd" , "wbiz_tp_m_cd" , "wbiz_tp_s_cd" , 
				"empl_cnt" , "post" , "addr1" , "addr2" , "pic_nm" , "telno" , "pic_clph_no" , "pic_email" , "pic_dept" , "pstn_nm" };
		short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , 
				 HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_RIGHT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , 
				 HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT};
		 
		model.put( "headerMap" , headerMap );
		model.put( "columnMap" , columnMap );
		model.put( "alignMap" , alignMap );		
		model.put( "mergeMap" , mergeMap );
		model.put( "dataMap" , statInspMtService.selectStatInspApplyPageListExcel( param ) );
		 
		 
		return new ModelAndView( "excelDownView" , "model" , model );
		
    }
    
  
	
}
