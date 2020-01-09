package kr.or.wabis.admin.integration.controller;

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

import kr.or.wabis.admin.integration.service.CodeMtService;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("codeMtController")
public class CodeMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(CodeMtController.class);
    
    private final static String ADMIN_PATH = "/admin/integration/";
    
    @Resource(name = "codeMtService")
    private CodeMtService codeMtService;
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/code/codegubunListPage.do")
    public String codegubunListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
                
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        return ADMIN_PATH + "codegubunListPage";
    }
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/code/codegubunPageList.do")
    public ModelAndView codegubunPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        navigator.setList(codeMtService.selectCodegubunPageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
    
    /**
     * 쓰기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/code/codegubunWrite.do")
    public String codegubunWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> codegubun = new HashMap();
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // 코드 정보를 가져온다.
            codegubun = codeMtService.selectCodegubun(param);
            
        } else {
            codegubun.put("use_yn", "Y");
        }
        
        model.addAttribute("codegubun", codegubun);
        
        return "/sub" + ADMIN_PATH + "codegubunWrite";
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
    @RequestMapping(value = "/admin/code/insertCodegubun.do")
    public ModelAndView insertCodegubun(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            // 중복 코드가 있는지를 체크한다.
            rv = codeMtService.selectCodegubunExist(param);
            
            if (rv < 1) {
                
                // 등록 처리를 해준다.
                rv = codeMtService.insertCodegubun(param);
                
                if (rv > 0) { 
                    param.put("success", "true");
                    param.put("message", MessageUtil.getInsertMsg(rv, _req));
                } else {
                    param.put("success", "false"); 
                    param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 
                }
                
            } else {
                param.put("success", "false");
                param.put("message", "대코드가 이미 존재합니다.");
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
    @RequestMapping(value = "/admin/code/updateCodegubun.do")
    public ModelAndView updateCodegubun(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = codeMtService.updateCodegubun(param);
            
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
    @RequestMapping(value = "/admin/code/deleteCodegubun.do")
    public ModelAndView deleteCodegubun(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = codeMtService.deleteCodegubun(param);
            
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
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/code/codeListPage.do")
    public String codeListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> codegubun = codeMtService.selectCodegubun(param);
        model.addAttribute("codegubun", codegubun);
        
        return ADMIN_PATH + "codeListPage";
    }
    
    /**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/code/codeList.do")
    public @ResponseBody Map<String, Object> codeList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = codeMtService.selectCodeList(param);        
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 공통 코드 리스트를 돌려준다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/code/commonCodeList.do")
    public ModelAndView commonCodeList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List list = codeMtService.selectCodeGubunCodeList(StringUtil.nvl(param.get("gubun")));
        HashMap retMap = new HashMap();
        retMap.put("list", list);
        
        return ViewHelper.getJsonView(retMap);
    }
    
    /**
     * 쓰기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/code/codeWrite.do")
    public String codeWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> code = new HashMap();
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // 코드 정보를 가져온다.
            code = codeMtService.selectCode(param);
        }
        
        code.put("use_yn", "Y");
        
        code.put("gubun", param.get("gubun"));
        code.put("gubun_nm", param.get("gubun_nm"));
        model.addAttribute("code", code);
        
        return "/sub" + ADMIN_PATH + "codeWrite";
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
    @RequestMapping(value = "/admin/code/insertCode.do")
    public ModelAndView insertCode(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            // 중복 코드가 있는지를 체크한다.
            rv = codeMtService.selectCodeExist(param);
            
            if (rv < 1) {
                
                rv = codeMtService.insertCode(param);
                
                if (rv > 0) {
                    param.put("success", "true");
                    param.put("message", MessageUtil.getInsertMsg(rv, _req));
                } else {
                    param.put("success", "false"); 
                    param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 
                }
                
            } else {
                param.put("success", "false");
                param.put("message", "코드가 이미 존재합니다.");
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
    @RequestMapping(value = "/admin/code/updateCode.do")
    public ModelAndView updateCode(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            // 중복 코드가 있는지를 체크한다.
            rv = codeMtService.updateCode(param);
            
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
    @RequestMapping(value = "/admin/code/deleteCode.do")
    public ModelAndView deleteCode(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = codeMtService.deleteCode(param);
            
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
     * 코드 순서를 재조정해준다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/code/updateCodeReorder.do")
    public ModelAndView updateCodeReorder(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = 
                (ArrayList<Map<String, Object>>) JsonUtil.fromJsonStr(param.get("code_list").toString().replace("&quot;", "'"));
        
        param.put("code_list", list);
        
        try {
            
            rv = codeMtService.updateCodeReorder(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "코드 순서를 조정하였습니다.");
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
