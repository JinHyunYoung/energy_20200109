package kr.or.wabis.admin.support.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.support.service.DictionaryMtService;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("dictionaryMtController")
public class DictionaryMtController extends AbstractController {

	private Logger logger = Logger.getLogger(this.getClass());

	private final static String ADMIN_PATH = "/admin/support/";

	@Resource(name = "dictionaryMtService")
	private DictionaryMtService dictionaryMtService;
	

    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/dictionary/dictionaryListPage.do")
    public String dictionaryListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
    	model.addAttribute(ListOp.LIST_OP_NAME, listOp);        
        return ADMIN_PATH + "dictionaryListPage";
    }
    
    /**
     * 작성 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/dictionary/dictionaryWrite.do")
    public String dictionaryWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {  

        
        Map<String, Object> param = _req.getParameterMap();    	

        if ("E".equals(param.get("mode"))) {
            
            Map<String, Object> dictionary = dictionaryMtService.selectDictionary(param);

            model.addAttribute("dictionary", dictionary);
        }
                
        return ADMIN_PATH + "dictionaryWrite";
    }
    
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/dictionary/dictionaryPageList.do")
    public ModelAndView dictionaryPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        navigator.setList(dictionaryMtService.selectDictionaryPageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
    
    /**
     * 데이타를 저장한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/dictionary/insertDictionary.do")
    public ModelAndView insertDictionary(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
        	
            param.put("dictionary_no", CommonUtil.createUUID());
            
            rv = dictionaryMtService.insertDictionary(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", MessageUtil.getInsertMsg(rv, _req));
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
     * 데이타를 수정한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/dictionary/updateDictionary.do")
    public ModelAndView updateDictionary(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        try {         
            
            rv = dictionaryMtService.updateDictionary(param);
            
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
     * 데이타를 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/dictionary/deleteDictionary.do")
    public ModelAndView deleteDictionary(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = dictionaryMtService.deleteDictionary(param);
            
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
    
}
