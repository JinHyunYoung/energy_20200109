package kr.or.wabis.framework.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.or.wabis.framework.fileupload.service.CommonFileService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ProjectConfigUtil;
import kr.or.wabis.framework.web.fileupload.FileSupport;

public class AbstractController {
    
    @Autowired
    protected CommonFileService commonFileService;
    
    /**
     * context 정보를 불러온다
     * 
     * @return
     */
    protected final WebApplicationContext getContext() {
        return ContextLoader.getCurrentWebApplicationContext();
    }
    
    /**
     * 세션정보를 가지고 온다
     * 
     * @param key
     * @return
     */
    public static final Object getSessionAttribute(String key) {
        
        try {
            
            ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();            
            HttpSession session = servletRequestAttribute.getRequest().getSession(true);            
            return session.getAttribute(key);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * 세션정보를 저장한다
     * 
     * @param key
     * @param value
     */
    public static final void setSessionAttribute(String key, Object value) {
        
        try {
            
            ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpSession session = servletRequestAttribute.getRequest().getSession(true);          
            session.setAttribute(key, value);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 로컬 세션을 제거 한다
     */
    public static final void removeLocalSession(String key) {
        
        try {
            
            ServletRequestAttributes servletRequestAttribute =  (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpSession session = servletRequestAttribute.getRequest().getSession(true);           
            session.removeAttribute(key);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 업로드 디렉토리 정보를 가지고 온다
     * 
     * @return
     */
    public String getUploadPath(String subDir) throws Exception {
        
        String baseUploadPath = (String) ProjectConfigUtil.getProperty("contents.upload.basePath");
        if ("".equals(subDir)) {
            subDir = "etc/";
        }
        
        FileSupport.checkAndMakeDir(baseUploadPath + subDir);
        
        return baseUploadPath + subDir;
    }
    
    /**
     * 
     * @param subDir
     * @return
     */
    public String getTempUploadPath() throws Exception {
        
        String toDay = DateUtil.getCurrentYyyymmdd();
        String baseUploadPath = (String) ProjectConfigUtil.getProperty("contents.upload.temp") + toDay;
        FileSupport.checkAndMakeDir(baseUploadPath);
        
        return baseUploadPath;
    }
    
    /**
     * documentRoot 디렉토리 정보를 가지고 온다
     * 
     * @return
     */
    public String getDocRootPath(String subDir) throws Exception {
        
        String docRootPath = (String) ProjectConfigUtil.getProperty("project.server.docroot.path");
        
        if ("".equals(subDir)) {
            subDir = "files/";
        }
        
        FileSupport.checkAndMakeDir(docRootPath + subDir);
        
        return docRootPath + subDir;
    }
    
    /**
     * 그룹에 속한 모든 파일정보를 삭제합니다
     * 
     * @param attachFileId
     */
    public void deleteFileInfo(String groupId) {
        
        try {
            
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("group_id", groupId);
            
            // group_id만 넘겨줘야함
            List<CommonFileVO> infolist = commonFileService.getCommonFileList(param);
            String path = "";
            String filename = "";
            
            for (int i = 0; infolist.size() > i; i++) {
                
                CommonFileVO fileInfo = infolist.get(i);
                
                path = fileInfo.getFile_path();
                filename = fileInfo.getFile_nm();
                
                FileSupport.deleteFile(path, filename);
            }
            
            commonFileService.deleteCommonFileAll(param);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 물리적 파일을 삭제해준다
     * 
     * @param path
     * @param filename
     */
    public void deleteFile(String path, String filename) {
        
        try {
            
            FileSupport.deleteFile(path, filename);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
}
