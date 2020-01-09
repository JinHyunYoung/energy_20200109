package kr.or.wabis.admin.user.controller;

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

import kr.or.wabis.admin.user.service.AuthMtService;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("authMtController")
public class AuthMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(AuthMtController.class);
    
    public final static String ADMIN_PATH = "/admin/user/";
    
    @Resource(name = "authMtService")
    private AuthMtService authMtService;
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/authListPage.do")
    public String authListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
                
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        return ADMIN_PATH + "authListPage";
    }
    
    /**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/authPageList.do")
    public ModelAndView authPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        navigator.setList(authMtService.selectAuthPageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
    
    /**
     * 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/authList.do")
    public @ResponseBody Map<String, Object> authList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = authMtService.selectAuthList(param);
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 쓰기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/authWrite.do")
    public String authWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> auth = new HashMap();
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // 권한 정보를 가져온다.
            auth = authMtService.selectAuth(param);
        }
        
        auth.put("use_yn", "Y");
        
        model.addAttribute("auth", auth);
        
        return "/sub" + ADMIN_PATH + "authWrite";
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
    @RequestMapping(value = "/admin/auth/insertAuth.do")
    public ModelAndView insertAuth(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            param.put("auth_id", CommonUtil.createUUID());
            rv = authMtService.insertAuth(param);
            
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
     * 선택된 항목의 detail 값을 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/Auth.do")
    public String getAuth(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute("item", authMtService.selectAuth(param));
        
        return ADMIN_PATH + "authEdit";
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
    @RequestMapping(value = "/admin/auth/updateAuth.do")
    public ModelAndView updateAuth(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = authMtService.updateAuth(param);
            
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
    @RequestMapping(value = "/admin/auth/deleteAuth.do")
    public ModelAndView deleteAuth(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = authMtService.deleteAuth(param);
            
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
     * 권한 메뉴 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/authMenuListPage.do")
    public String authMenuListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        return ADMIN_PATH + "authMenuListPage";
    }
    
    /**
     * 메니저 권한 사용자 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/managerAuthListPage.do")
    public String managerAuthListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        return ADMIN_PATH + "managerAuthListPage";
    }
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/managerAuthPageList.do")
    public ModelAndView managerAuthPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        navigator.setList(authMtService.managerAuthPageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
    
    /**
     * 관리자 권한 매핑을 해준다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/insertManagerAuth.do")
    public ModelAndView insertManagerAuth(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = 
                (ArrayList<Map<String, Object>>) JsonUtil.fromJsonStr(param.get("user_list").toString().replace("&quot;", "'"));
        
        param.put("user_list", list);
        
        try {
            
            rv = authMtService.insertManagerAuth(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "권한 매핑에 성공하였습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "권한 매핑에 실패하였습니다."); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "권한 매핑에 실패하였습니다."); 
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 관리자 권한 매핑을 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/auth/deleteManagerAuth.do")
    public ModelAndView deleteManagerAuth(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = 
                (ArrayList<Map<String, Object>>) JsonUtil.fromJsonStr(param.get("user_list").toString().replace("&quot;", "'"));
        
        param.put("user_list", list);
        
        try {
            
            rv = authMtService.deleteManagerAuth(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "권한 매핑 삭제에 성공하였습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "권한 매핑 삭제에 실패하였습니다."); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "권한 매핑 삭제에 실패하였습니다."); 
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
}
