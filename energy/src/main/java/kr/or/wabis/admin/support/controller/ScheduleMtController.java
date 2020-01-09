package kr.or.wabis.admin.support.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.NumberUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.support.service.ScheduleMtService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileSupport;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.user.vo.UserVO;

@Controller("scheduleMtController")
public class ScheduleMtController extends AbstractController {
	
	 private Logger logger = Logger.getLogger(this.getClass());
	 
	 private final static String ADMIN_PATH = "/admin/support/";
	 
	 @Resource(name = "scheduleMtService")
	 private ScheduleMtService scheduleMtService;
	
    // 행사일정관리 조회
    @RequestMapping(value = "/admin/support/selectScheduleList.do")
    public String scheduleList(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        return ADMIN_PATH + "scheduleList";
    }
    
    // 행사일정관리 조회
    @RequestMapping(value = "/admin/support/loadScheduleList.do")
    public ModelAndView loadScheduleList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	List<Map<String, Object>> list = scheduleMtService.selectScheduleList( param );
        
        for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Map<String, Object> map = (Map<String, Object>) iterator.next();

			String group_id = StringUtil.nvl(map.get("group_id"));
			if (!group_id.equals("")) {
				param.put("group_id", group_id);
		        List<CommonFileVO> attach = commonFileService.getCommonFileList(param);
		        map.put("attach", attach);
			}
		}
        
        param.put("list", list);
        return ViewHelper.getJsonView(param);
	    		
    }
    
    // 행사일정관리 수정 팝업
    @RequestMapping(value = "/admin/support/selectSchedule.do")
    public String scheduleModifyPop(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	
    	Map<String, Object> param = _req.getParameterMap();
    	
    	if( ! StringUtil.isEmpty( StringUtil.nvl( param.get( "evt_sn" ) ) ) ){
    		 model.addAttribute( "schedule" , scheduleMtService.selectSchedule( param ) );
    	}
    	
        return "/sub" + ADMIN_PATH + "scheduleModifyPopup";
    }
    
    // 행사일정관리 등록
    @RequestMapping(value = "/admin/support/insertSchedule.do")
    public ModelAndView scheduleInsert(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
    	
    	Map<String, Object> param = _req.getParameterMap();    
    	UserVO userVo =  _req.getSessionUser();
    	int result = 0;
    	
    	try{
    			param.put( "s_user_no" , userVo.getUserNo() );	    		
	    		result = scheduleMtService.insertSchedule( param );
        
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
    
    
    // 행사일정관리 수정
    @RequestMapping(value = "/admin/support/updateSchedule.do")
    public ModelAndView scheduleUpdate(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
    	
    	Map<String, Object> param = _req.getParameterMap();    
    	UserVO userVo =  _req.getSessionUser();
    	int result = 0;
    	
    	try{
    		
    		param.put( "s_user_no" , userVo.getUserNo() );	
	    	result = scheduleMtService.updateSchedule( param );
        
	        if( result > 0 ){ 
	            param.put( "success" , "true" );
	            param.put( "message" , MessageUtil.getUpdatedMsg( result , _req ) );
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
    
    // 행사일정관리 수정
    @RequestMapping(value = "/admin/support/deleteSchedule.do")
    public ModelAndView scheduleDelete(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
    	
    	Map<String, Object> param = _req.getParameterMap();
    	int result = 0;
    	
    	try{
    		
	    	result = scheduleMtService.deleteSchedule( param );
        
	        if( result > 0 ){ 
	            param.put( "success" , "true" );
	            param.put( "message" , MessageUtil.getDeteleMsg( result , _req ) );
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

    /**
     * 소개페이지 페이지로딩후 file list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/scheduleFileList.do")
    public @ResponseBody Map<String, Object> fileList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
    	Map<String, Object> param = _req.getParameterMap();
    	
    	String group_id = (String) param.get("group_id");
    	  if (group_id == null) {
              
              // 그룹아이디가 없는경우 전체를 가져오기 방지
              param.put("group_id", "A"); 
          }
       
        List<CommonFileVO> fileList = commonFileService.getCommonFileList(param);
        
        List list = new ArrayList();
        for (CommonFileVO file : fileList) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("file_id", file.getFile_id());
			map.put("file_nm", file.getFile_nm());
			map.put("ori_file_nm", file.getOriginFileNm());
			map.put("file_title", file.getFile_title());
			map.put("file_size", file.getFile_size()/1024);
			map.put("file_type", file.getFile_type());
			map.put("sort", file.getSort());
			list.add(map);
		}
        
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 소개페이지 파일 등록
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/insertScheduleFile.do", method = RequestMethod.POST)
    public ModelAndView insertScheduleFile(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        String group_id = (String)param.get("file_group_id");

        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("schedule/"));
            FileUploadModel file = null;
            boolean isUpdate_groupid = false;

            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() == 1) {

            	file = (FileUploadModel) fileList.get(0);
            	 
            	if(acnt == 0 && group_id == null){
            		commonFileVO.setGroup_id(CommonUtil.createUUID());
            		group_id = commonFileVO.getGroup_id();

            		isUpdate_groupid = true;
            	}else{
            		commonFileVO.setGroup_id(group_id);
            	}
            	commonFileVO.setFile_nm(file.getFileName());
                commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                commonFileVO.setFile_type(file.getExtension());
                commonFileVO.setFile_size(file.getFileSize());
                commonFileVO.setFile_path("schedule/");
//                commonFileVO.setFile_title(input_file_title);
//                commonFileVO.setSort(Long.parseLong(input_file_sort));
                commonFileVO.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(commonFileVO);
                acnt++;
                
            }
            
            if(isUpdate_groupid){
                // schedule group id 정보를 수정한다.
                param.put("group_id", group_id);
                scheduleMtService.updateGroupId(param);
            }
            
            param.put("group_id", group_id);
            param.put("success", "true");
            param.put("message", MessageUtil.getInsertMsg(rv, _req));
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 
            return ViewHelper.getJsonView(param);
        }
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 소개페이지 파일 수정
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/updateScheduleFile.do", method = RequestMethod.POST)
    public ModelAndView updateScheduleFile(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        String group_id = (String)param.get("file_group_id");
        String input_file_id = (String)param.get("input_file_id");
        
        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("schedule/"));
            FileUploadModel file = null;
            
        	// 기존 file VO get
            Map<String, Object> del_param = new HashMap<String, Object>();
            del_param.put("file_id", input_file_id);
            
            CommonFileVO fileInfo = commonFileService.getCommonFile(del_param);

        	if(group_id == null){
        		fileInfo.setGroup_id(CommonUtil.createUUID());
        		group_id = fileInfo.getGroup_id();
        	}else{
        		fileInfo.setGroup_id(group_id);
        	}
        	
            //파일 첨부 된 경우, 파일 정보 변경.
            if (fileList != null && fileList.size() == 1) {
            	
            	//기존 파일 삭제.
                String path = fileInfo.getFile_path();
                String filename = fileInfo.getFile_nm();
                
                FileSupport.deleteFile(path, filename);
                int retVal = commonFileService.deleteCommonFile(input_file_id);
            	
            	file = (FileUploadModel) fileList.get(0);

            	fileInfo.setFile_nm(file.getFileName());
            	
            	fileInfo.setOrigin_file_nm(file.getOriginalFileName());
            	fileInfo.setFile_type(file.getExtension());
            	fileInfo.setFile_size(file.getFileSize());
            	fileInfo.setFile_path("schedule/");
            	fileInfo.setS_user_no((String) param.get("s_user_no"));
                commonFileService.insertCommonFile(fileInfo);
                
            }else{
                int retVal = commonFileService.deleteCommonFile(input_file_id);
                
                commonFileService.insertCommonFile(fileInfo);            	
            }
            param.put("group_id", group_id);
            param.put("success", "true");
            param.put("message", MessageUtil.getInsertMsg(rv, _req));
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 
            return ViewHelper.getJsonView(param);
        }
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 소개페이지 파일 삭제
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/support/deleteScheduleFile.do", method = RequestMethod.POST)
    public ModelAndView deleteScheduleFile(ExtHttpRequestParam _req, ModelMap model) throws Exception {
		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		String file_id = (String) param.get("file_id");
		try {
			// 기존 file VO get
			Map<String, Object> del_param = new HashMap<String, Object>();
			del_param.put("file_id", file_id);

			CommonFileVO fileInfo = commonFileService.getCommonFile(del_param);
			// 기존 파일 삭제.
			String path = fileInfo.getFile_path();
			String filename = fileInfo.getFile_nm();

			FileSupport.deleteFile(path, filename);

			int retVal = commonFileService.deleteCommonFile(file_id);

			param.put("success", "true");
			param.put("message", MessageUtil.getInsertMsg(rv, _req));
		} catch (Exception e) {
			e.printStackTrace();
			param.put("success", "false");
			param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
			return ViewHelper.getJsonView(param);
		}
		return ViewHelper.getJsonView(param);
    }
        
    
}
