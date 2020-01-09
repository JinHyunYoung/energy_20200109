package kr.or.wabis.framework.fileupload.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.fileupload.vo.FileVO;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.ObjectUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileDownloadInfo;
import kr.or.wabis.framework.web.fileupload.FileSupport;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller
public class CommonFileController extends AbstractController {
    
    private static final Logger logger = LoggerFactory.getLogger(CommonFileController.class);
    
    public final static String JSP_PATH = "/commonfile/";
    
    /**
     * 일반 파일업로드 페이지로 이동을 해준다.
     * 
     * @param _req
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/sampleCommonFile.do", method = RequestMethod.GET)
    public String sampleCommonFile(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        
        return JSP_PATH + "sampleCommonFile";
    }
    
    /**
     * 멀티파일업로드 페이지로 이동을 해준다.
     * 
     * @param _req
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/sampleMultiFileUpload.do", method = RequestMethod.GET)
    public String sampleMultiFileUpload(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        
        model.addAttribute("group_id", ObjectUtil.getGUID());
        return JSP_PATH + "sampleMultiFileUpload";
    }
    
    /**
     * 멀티파일업로드에서 올린 파일 리스트를 가져온다.
     * 
     * @param _req
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/getCommonFileList.do", method = RequestMethod.GET)
    public @ResponseBody Map getCommonFileList(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        param.put("group_id", param.get("group_id"));
        List<CommonFileVO> fileList = commonFileService.getCommonFileList(param);
        
        List<FileVO> files = new ArrayList<FileVO>();
        FileVO fileVO = null;
        CommonFileVO file = null;
        if (fileList != null && fileList.size() > 0){
            
            for (int i = 0; i < fileList.size(); i++) {
                
                file = (CommonFileVO) fileList.get(i);
                
                fileVO = new FileVO();
                fileVO.setFileId(file.getFile_id());
                fileVO.setName(file.getOrigin_file_nm());
                fileVO.setNewFilename(file.getFile_nm());
                fileVO.setContentType(file.getFile_type());
                fileVO.setSize(file.getFile_size());
                fileVO.setUrl("/commonFile/downloadCommonFile.do?file_id=" + file.getFile_id());
                fileVO.setDeleteUrl("/commonFile/deleteCommonFile.do?file_id=" + file.getFile_id());
                fileVO.setDeleteType("GET");
                
                files.add(fileVO);
            }
        }
        
        HashMap retMap = new HashMap();
        retMap.put("files", files);
        return retMap;
    }
    
    /**
     * 업로드 서버가 살아있는지 체크 시 사용
     * 
     * @param _req
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/uploadServerCheck.do", method = RequestMethod.GET)
    public @ResponseBody Map uploadServerCheck(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        return new HashMap();
    }
    
    /**
     * 멀티파일 업로드에서 파일 업로드 시 사용, 리턴은 json 형태로 반환해 준다.
     * 
     * @param _req
     * @param model
     * @param request
     * @param commonFileVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/uploadCommonFile.do", method = RequestMethod.POST)
    public @ResponseBody Map uploadCommonFile(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request, CommonFileVO commonFileVO) throws Exception {
        
        List<FileVO> files = new ArrayList<FileVO>();
        FileVO fileVO = null;
        
        // 업로드한 파일들을 지정한 경로에 저장한다
        List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("commonfile\\")); 
        FileUploadModel file = null;
        
        if (fileList != null && fileList.size() > 0){
            
            for (int i = 0; i < fileList.size(); i++) {
                
                file = (FileUploadModel) fileList.get(i);
                
                file.getFieldName();
                file.getFileName();
                file.getOriginalFileName();
                file.getContentType();
                file.getExtension();
                file.getFileSize();
                
                commonFileVO.setFile_id("");
                commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getSize());
                commonFileVO.setFile_path("commonfile\\");
                commonFileVO.setCreated_by("1111");
                commonFileVO.setModify_by("1111");
                
                int retVal = commonFileService.insertCommonFile(commonFileVO);
                
                fileVO = new FileVO();
                fileVO.setFileId(commonFileVO.getFile_id());
                fileVO.setName(file.getOriginalFileName());
                fileVO.setNewFilename(file.getFileName());
                fileVO.setContentType(file.getContentType());
                fileVO.setSize(file.getSize());
                fileVO.setUrl("/commonFile/downloadCommonFile.do?file_id=" + commonFileVO.getFile_id());
                fileVO.setDeleteUrl("/commonFile/deleteCommonFile.do?file_id=" + commonFileVO.getFile_id());
                fileVO.setDeleteType("GET");
                
                files.add(fileVO);
            }
        }
        
        HashMap retMap = new HashMap();
        retMap.put("files", files);
        return retMap;
    }
    
    /**
     * 일반 파일 업로드를 처리해준다.
     * 
     * @param _req
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/uploadSampleFile.do", method = RequestMethod.POST)
    public String uploadSampleFile(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        
        List<FileVO> files = new ArrayList<FileVO>();
        FileVO fileVO = null;
        
        // Temp 디렉토리로 올라간 파일을 실제파일 업로드 위치의 commonfile 디렉토리로 이동시켜주며 파일리스트를 가져온다.
        List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("commonfile\\")); // 업로드한 파일들을 지정한 경로에 저장한다
        FileUploadModel file = null;
        
        // 파일이 있을 경우 파일 정보를 가져와서 사용
        if (fileList != null && fileList.size() > 0) {
            
            for (int i = 0; i < fileList.size(); i++) {
                
                file = (FileUploadModel) fileList.get(i);
                
                fileVO = new FileVO();
                fileVO.setName(file.getOriginalFileName()); // 실파일명
                fileVO.setNewFilename(file.getFileName()); // 업로드 파일명
                fileVO.setContentType(file.getContentType()); // 파일 컨텐츠 타입
                fileVO.setSize(file.getSize()); // 파일 사이즈
                fileVO.setFieldName(file.getFieldName()); // View단 file객체 name
                fileVO.setFilePath("commonfile\\");
                
                files.add(fileVO);
            }
        }
        
        model.addAttribute("files", files);
        
        return JSP_PATH + "sampleCommonFileResult";
    }
    
    /**
     * 일반 파일 업로드를 처리해준다.
     * 
     * @param _req
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/uploadImageFile.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> uploadImageFile(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        
        String imageUploadPath = "commonimage/";
        List<FileVO> files = new ArrayList<FileVO>();
        FileVO fileVO = null;
        
        // Temp 디렉토리로 올라간 파일을 실제파일 업로드 위치의 commonfile 디렉토리로 이동시켜주며 파일리스트를 가져온다.
        List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath(imageUploadPath)); // 업로드한 파일들을 지정한 경로에 저장한다
        FileUploadModel file = null;
        String imgNm = "";
        
        // 파일이 있을 경우 파일 정보를 가져와서 사용
        if (fileList != null && fileList.size() > 0){
            
            for (int i = 0; i < fileList.size(); i++) {
                file = (FileUploadModel) fileList.get(i);
                imgNm = file.getFileName();
            }
            
        }
        
        model.addAttribute("files", files);
        
        String retVal = "/contents/" + imageUploadPath + imgNm;
        Map<String, Object> map = new HashMap();
        map.put("link", retVal);
        
        return map;
    }
    
    
    /**
     * 일반 파일 업로드를 처리해준다.
     * 
     * @param _req
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/uploadEditorFile.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> uploadEditorFile(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        
        String editorUploadPath = "commoneditor/";
        List<FileVO> files = new ArrayList<FileVO>();
        FileVO fileVO = null;
        
        // Temp 디렉토리로 올라간 파일을 실제파일 업로드 위치의 commonfile 디렉토리로 이동시켜주며 파일리스트를 가져온다.
        List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath(editorUploadPath)); // 업로드한 파일들을 지정한 경로에 저장한다
        FileUploadModel file = null;
        
        String imgNm = "";
        
        // 파일이 있을 경우 파일 정보를 가져와서 사용
        if (fileList != null && fileList.size() > 0){
            
            for (int i = 0; i < fileList.size(); i++) {
                file = (FileUploadModel) fileList.get(i);
                imgNm = file.getFileName();
            }
            
        }
        
        model.addAttribute("files", files);
        
        String retVal = "/contents/" + editorUploadPath + imgNm;
        Map<String, Object> map = new HashMap();
        map.put("link", retVal);
        
        return map;
    }
    
    /**
     * 일반 파일 업로드를 처리해준다.
     * 
     * @param _req
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/uploadEditorImageFile.do", method = RequestMethod.POST)
    public String uploadEditorImageFile(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        
        String editorUploadPath = "commoneditor/";
        List<FileVO> files = new ArrayList<FileVO>();
        FileVO fileVO = null;
        
        // Temp 디렉토리로 올라간 파일을 실제파일 업로드 위치의 commonfile 디렉토리로 이동시켜주며 파일리스트를 가져온다.
        List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath(editorUploadPath)); // 업로드한 파일들을 지정한 경로에 저장한다
        
        FileUploadModel file = null;
        String imgNm = "";
        
        // 파일이 있을 경우 파일 정보를 가져와서 사용
        if (fileList != null && fileList.size() > 0){
            
            for (int i = 0; i < fileList.size(); i++) {
                file = (FileUploadModel) fileList.get(i);
                imgNm = file.getFileName();
            }
        }
        
        model.addAttribute("fileName", imgNm);
        
        return "/root/assets/se/imgupload2";
    }
    
    /**
     * 멀티파일에 대한 다운로드를 처리해준다.
     * 
     * @param response
     * @param file_id
     * @throws Exception
     */
    @RequestMapping(value = "/commonFile/downloadCommonFile.do", method = RequestMethod.GET)
    public void downloadCommonFile(HttpServletResponse response, String file_id) throws Exception {
        
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("file_id", file_id);
        
        CommonFileVO fileInfo = commonFileService.getCommonFile(param);
        
        String filePath = getUploadPath(fileInfo.getFile_path());
        File commonFile = new File(filePath + fileInfo.getFile_nm());
        
        response.setContentType(fileInfo.getFile_type());
        response.setContentLength((int) fileInfo.getFile_size());
        
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"", fileInfo.getOrigin_file_nm());
        
        response.setHeader(headerKey, headerValue);
        
        try {
            
            InputStream is = new FileInputStream(commonFile);
            IOUtils.copy(is, response.getOutputStream());
            
        } catch (IOException e) {
            logger.error("Could not download File " + file_id, e);
        }
    }
    
    /**
     * 멀티파일업로드에서 파일 삭제 시 처리를 해준다.
     * 
     * @param file_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonFile/deleteCommonFile.do", method = RequestMethod.GET)
    public @ResponseBody List deleteCommonFile(String file_id) throws Exception {
        
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("file_id", file_id);
        
        CommonFileVO fileInfo = commonFileService.getCommonFile(param);
        
        String path = fileInfo.getFile_path();
        String filename = fileInfo.getFile_nm();
        
        FileSupport.deleteFile(path, filename);
        
        int retVal = commonFileService.deleteCommonFile(file_id);
        
        List<Map<String, Object>> results = new ArrayList<>();
        
        Map<String, Object> success = new HashMap<>();
        success.put("success", true);
        results.add(success);
        
        return results;
    }
    
    /**
     * 일반 파일업로드에 대한 파일 다운로드를 처리해준다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/fileDownLoad.do")
    public ModelAndView fileDownLoad(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap(); // param값의 맵을 만듬
        
        String path = ""; // 파일경로
        String filename = ""; // 파일이름
        String orignl_file_nm = ""; // 파일이름
        String down_type = StringUtil.nvl(param.get("down_type").toString());
        
        path = getUploadPath(param.get("file_path").toString());
        if ("sample".equals(down_type)) {
            path = getDocRootPath((param.get("file_path").toString()));
        }
        
        filename = param.get("orignl_file_nm").toString();
        orignl_file_nm = param.get("file_nm").toString();
        
        // 다운로드 받을 파일 정보를 만듬
        FileDownloadInfo file = new FileDownloadInfo(path, filename, orignl_file_nm); 

        return ViewHelper.getDownloadView(file);
    }
    
    /**
     * file_id를 받아 파일 다운로드를 처리해준다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/commonfile/fileidDownLoad.do")
    public ModelAndView fileidDownLoad(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap(); // param값의 맵을 만듬
        
        String path = ""; // 파일경로
        String filename = ""; // 파일이름
        String orignl_file_nm = ""; // 파일이름
        
        CommonFileVO fileInfo = commonFileService.getCommonFile(param);
        
        path = getUploadPath(fileInfo.getFile_path());
        
        filename = fileInfo.getFile_nm();
        orignl_file_nm = fileInfo.getOrigin_file_nm();

        logger.debug("path : " + path);
        logger.debug("filename : " + filename);
        logger.debug("orignl_file_nm : " + orignl_file_nm);

        // 다운로드 받을 파일 정보를 만듬
        FileDownloadInfo file = new FileDownloadInfo(path, filename, orignl_file_nm); 
               
        return ViewHelper.getDownloadView(file);
    }
    
    /**
     * 파일 삭제
     * 
     * @param file_id
     * @return json
     * @throws Exception
     */
    @RequestMapping(value = "/commonFile/deleteOneCommonFile.do")
    public ModelAndView deleteCommonFile(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            CommonFileVO fileInfo = commonFileService.getCommonFile(param);
            
            String path = fileInfo.getFile_path();
            String filename = fileInfo.getFile_nm();
            
            FileSupport.deleteFile(path, filename);
            
            rv = commonFileService.deleteCommonFile((String) param.get("file_id"));
            
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
