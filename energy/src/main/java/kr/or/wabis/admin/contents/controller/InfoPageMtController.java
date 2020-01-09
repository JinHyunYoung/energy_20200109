package kr.or.wabis.admin.contents.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.contents.service.InfoPageMtService;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("infoPageMtController")
public class InfoPageMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(InfoPageMtController.class);
    
    private final static String ADMIN_PATH = "/admin/contents/";
    
    @Resource(name = "infoPageMtService")
    private InfoPageMtService infoPageMtService;
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/infopage/infopageListPage.do")
    public String infopageListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        return ADMIN_PATH + "infopageListPage";
    }
    
    /**
     * 작성 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/infopage/infopageWrite.do")
    public String infopageWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {        
        
        Map<String, Object> param = _req.getParameterMap();                
        model.addAttribute("info_type", param.get("info_type"));
        
        return ADMIN_PATH + "infopageWrite";
    }
    
    /**
     * 작성 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/infopage/privacyWrite.do")
    public String privacyWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {        
                     
        model.addAttribute("info_type", "privacy");
        
        return ADMIN_PATH + "infopageWrite";
    }
    
    /**
     * 작성 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/infopage/clauseWrite.do")
    public String clauseWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {        

        model.addAttribute("info_type", "clause");
        
        return ADMIN_PATH + "infopageWrite";
    }
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/infopage/infopagePageList.do")
    public ModelAndView infopagePageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        navigator.setList(infoPageMtService.selectInfopagePageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
       
    /**
     * 선택된 정보페이지를 가져온다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/infopage/selectInfopage.do")
    public @ResponseBody Map<String, Object> selectInfopage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        Map<String, Object> infopage = infoPageMtService.selectInfopage(param);       
        param.put("infopage", infopage);
        
        return param;
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
    @RequestMapping(value = "/admin/infopage/insertInfopage.do")
    public ModelAndView insertInfopage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = infoPageMtService.insertInfopage(param);
            
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
    @RequestMapping(value = "/admin/infopage/updateInfopage.do")
    public ModelAndView updateInfopage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = infoPageMtService.updateInfopage(param);
            
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
    @RequestMapping(value = "/admin/infopage/deleteInfopage.do")
    public ModelAndView deleteInfopage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = infoPageMtService.deleteInfopage(param);
            
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
     * 미리보기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/infopage/infopagePreview.do")
    public String infopagePreview(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute("infopage", param);
        
        return "/popup" + ADMIN_PATH + "infopagePreview";
    }
}
