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

import kr.or.wabis.admin.contents.service.BannerMtService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("bannerMtController")
public class BannerMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(BannerMtController.class);
    
    private final static String ADMIN_PATH = "/admin/contents/";
    
    @Resource(name = "bannerMtService")
    private BannerMtService bannerMtService;
    
    /**
     * 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/banner/bannerListPage.do")
    public String bannerListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        return ADMIN_PATH + "bannerListPage";
    }
    
    /**
     * 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/banner/bannerPageList.do")
    public ModelAndView bannerPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        navigator.setList(bannerMtService.selectBannerPageList(param));
        
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
    @RequestMapping(value = "/admin/banner/bannerList.do")
    public @ResponseBody Map<String, Object> bannerList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = bannerMtService.selectBannerList(param);
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
    @RequestMapping(value = "/admin/banner/bannerWrite.do")
    public String bannerWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> banner = new HashMap();
        
        if (!StringUtil.nvl(param.get("mode")).equals("W")) {
            
            // banner 정보를 가져온다.
            banner = bannerMtService.selectBanner(param);
            
        } else {
            
            banner.put("region", param.get("region"));
            banner.put("target", "1");
            banner.put("use_yn", "Y");
            
        }
        
        model.addAttribute("banner", banner);
        
        return "/sub" + ADMIN_PATH + "bannerWrite";
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
    @RequestMapping(value = "/admin/banner/insertBanner.do")
    public ModelAndView insertBanner(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("banner/"));
            FileUploadModel file = null;
            
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                file = (FileUploadModel) fileList.get(0);
                commonFileVO.setGroup_id(CommonUtil.createUUID());
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("banner");
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(commonFileVO);
                param.put("image", commonFileVO.getFile_id());
            }
            
            param.put("banner_id", CommonUtil.createUUID());
            rv = bannerMtService.insertBanner(param);
            
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
    @RequestMapping(value = "/admin/banner/updateBanner.do")
    public ModelAndView updateBanner(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("banner/"));
            FileUploadModel file = null;
            
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                file = (FileUploadModel) fileList.get(0);
                commonFileVO.setGroup_id(CommonUtil.createUUID());
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("banner");
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(commonFileVO);
                param.put("image", commonFileVO.getFile_id());
            }
            
            rv = bannerMtService.updateBanner(param);
            
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
    @RequestMapping(value = "/admin/banner/deleteBanner.do")
    public ModelAndView deleteBanner(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = bannerMtService.deleteBanner(param);
            
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
     * banner 순서를 재조정해준다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/banner/updateBannerReorder.do")
    public ModelAndView updateBannerReorder(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = (ArrayList<Map<String, Object>>) JsonUtil.fromJsonStr(param.get("banner_list").toString().replace("&quot;", "'"));
        param.put("banner_list", list);
        
        try {
            
            rv = bannerMtService.updateBannerReorder(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "배너 순서를 저장하였습니다.");
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
