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

import kr.or.wabis.admin.integration.service.MenuMtService;
import kr.or.wabis.framework.contants.CmsConstant;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.ProjectConfigUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("menuMtController")
public class MenuMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(MenuMtController.class);
    
    private final static String ADMIN_PATH = "/admin/integration/";
    
    @Resource(name = "menuMtService")
    private MenuMtService menuMtService;
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/menuListPage.do")
    public String menuListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        String jsp = ADMIN_PATH + "menuListPage";
        Map<String, Object> param = _req.getParameterMap();
        
        return jsp;
    }
    
    /**
     * 메뉴 트리 리스트
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/menuTreeList.do")
    public @ResponseBody List<Map<String, Object>> itemTreeList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = menuMtService.selectMenuTreeList(param);
        
        return list;
    }
    
    /**
     * 메뉴 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/menuList.do")
    public @ResponseBody Map<String, Object> menuList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        String jsp = ADMIN_PATH + "menuListPage";
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = menuMtService.selectMenuList(param);
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 메뉴 쓰기 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/menuWrite.do")
    public String menuWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> menu = new HashMap();
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // 메뉴 정보를 가져온다.
            menu = menuMtService.selectMenu(param);
        } 
        
        else {
            menu.put("menu_type", CmsConstant.MENU_TYPE_F);
            menu.put("gnb_use_yn", "N");
            menu.put("footer_use_yn", "N");
            menu.put("sitemap_use_yn", "Y");
            menu.put("https_support_yn", "N");
            menu.put("target_set", "1");
            menu.put("use_yn", "Y");
        }
        model.addAttribute("menu", menu);
        
        return "/sub" + ADMIN_PATH + "menuWrite";
    }
    
    /**
     * 메뉴 데이타를 저장한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/insertMenu.do")
    public ModelAndView insertMenu(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("menu/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                
                file = (FileUploadModel) fileList.get(0);
                
                commonFileVO.setGroup_id(CommonUtil.createUUID());
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("menu/");
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                
                commonFileService.insertCommonFile(commonFileVO);
                param.put("image", commonFileVO.getFile_id());
            }
            
            param.put("menu_id", CommonUtil.createUUID());
            rv = menuMtService.insertMenu(param);
            
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
     * 메뉴 데이타를 수정한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/updateMenu.do")
    public ModelAndView updateMenu(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("menu/"));
            FileUploadModel file = null;
            
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                file = (FileUploadModel) fileList.get(0);
                
                commonFileVO.setGroup_id(CommonUtil.createUUID());
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("menu/");
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                
                commonFileService.insertCommonFile(commonFileVO);
                param.put("image", commonFileVO.getFile_id());
            }
            
            rv = menuMtService.updateMenu(param);
            
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
     * 메뉴 데이타를 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/deleteMenu.do")
    public ModelAndView deleteMenu(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            rv = menuMtService.deleteMenu(param);
            
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
    @RequestMapping(value = "/admin/menu/updateMenuReorder.do")
    public ModelAndView updateMenuReorder(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = 
                (ArrayList<Map<String, Object>>) JsonUtil.fromJsonStr(param.get("menu_list").toString().replace("&quot;", "'"));
        
        param.put("menu_list", list);
        
        try {
            
            rv = menuMtService.updateMenuReorder(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "메뉴 순서를 조정하였습니다.");
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
     * 메뉴 트리 리스트
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/managerMenuTreeList.do")
    public @ResponseBody List<Map<String, Object>> managerMenuTreeList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        String siteName = (String) ProjectConfigUtil.getProperty("project.site.name");
        param.put("site_name", siteName);
        
        List<Map<String, Object>> list = menuMtService.selectManagerMenuTreeList(param);
        
        Map<String, Object> data = null;
        Map<String, Object> normal = new HashMap();
        normal.put("selected", false);
        
        Map<String, Object> checked = new HashMap();
        checked.put("selected", true);
        
        if (list != null && list.size() > 0){
            
            for (int i = 0; i < list.size(); i++) {
                
                data = (Map<String, Object>) list.get(i);
                
                if (data.get("auth_yn").equals("Y"))
                    data.put("state", checked);
                else
                    data.put("state", normal);
            }
        }
        
        return list;
    }
    
    /**
     * 권한에 메뉴를 매핑을 해준다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/insertAuthMenu.do")
    public ModelAndView insertAuthMenu(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = 
                (ArrayList<Map<String, Object>>) JsonUtil.fromJsonStr(param.get("menu_list").toString().replace("&quot;", "'"));
       
        param.put("menu_list", list);
        
        try {
            
            rv = menuMtService.insertAuthMenu(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", "권한에 메뉴를 매핑하는데 성공하였습니다.");
            } else {
                param.put("success", "false"); 
                param.put("message", "권한에 메뉴를 매핑하는데 실패하였습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", "권한에 메뉴를 매핑하는데 실패하였습니다.");
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 관리자 권한별 메뉴리스트를 가져온다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/authMenuList.do")
    public @ResponseBody Map<String, Object> authMenuList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> topMenuList = menuMtService.selectAuthTopMenuList(param);
        param.put("topMenuList", topMenuList);
        
        List<Map<String, Object>> subMenuList = null;
        if (!StringUtil.nvl(param.get("menu_id")).equals(""))
            subMenuList = menuMtService.selectAuthSubMenuList(param);
        else
            subMenuList = new ArrayList();
        
        param.put("subMenuList", subMenuList);
        
        return param;
    }
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/menuSearchPopup.do")
    public String menuSearchPopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        return "/sub" + ADMIN_PATH + "menuListPopup";
    }
    
    /**
     * 메뉴 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/menu/menuSearchList.do")
    public @ResponseBody Map<String, Object> menuSearchList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = menuMtService.selectMenuSearchList(param);
        param.put("rows", list);
        
        return param;
    }
    
}
