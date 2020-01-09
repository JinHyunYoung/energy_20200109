package kr.or.wabis.admin.board.controller;

import java.math.BigDecimal;
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

import kr.or.wabis.admin.board.service.BoardMtService;
import kr.or.wabis.framework.contants.CmsConstant;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.user.vo.UserVO;

@Controller("boardMtController")
public class BoardMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(BoardMtController.class);
    
    private final static String ADMIN_PATH = "/admin/board/";
    
    @Resource(name = "boardMtService")
    private BoardMtService boardMtService;
    
    /***************** 게시판 관리 *****************/
    
    /**
     * 게시판 리스트 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardListPage.do")
    public String boardListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
                
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        return ADMIN_PATH + "boardListPage";
    }
    
    /**
     * 게시판 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardPageList.do")
    public ModelAndView boardPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        navigator.setList(boardMtService.selectBoardPageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
    
    /**
     * 게시판 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardList.do")
    public String boardList(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
                
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = boardMtService.selectBoardList(param);
        model.addAttribute("boardList", list);
        
        return ADMIN_PATH + "boardListPage";
    }
    
    /**
     * 게시판 등록, 기본정보 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardWrite.do")
    public String boardWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
        
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        
        if (StringUtil.nvl(param.get("mode")).equals("E")) {
            boardinfo = boardMtService.selectBoardDetail(param);
        }
        
        model.addAttribute("boardinfo", boardinfo);
        
        return ADMIN_PATH + "boardWrite";
    }
    
    /**
     * 게시판 기본 정보를 저장한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/insertBoard.do")
    public ModelAndView insertBoard(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = boardMtService.insertBoard(param);
            
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
     * 항목설정 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardItemSet.do")
    public String boardItemSet(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        
        if (StringUtil.nvl(param.get("mode")).equals("E")) {
            boardinfo = boardMtService.selectBoardDetail(param);
        }
        
        model.addAttribute("boardinfo", boardinfo);
        
        return ADMIN_PATH + "boardItemSet";
    }
    
    /**
     * 목록 뷰설정 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardViewSet.do")
    public String boardViewSet(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        
        if (StringUtil.nvl(param.get("mode")).equals("E")) {
            boardinfo = boardMtService.selectBoardDetail(param);
        }
        
        model.addAttribute("boardinfo", boardinfo);
        
        return ADMIN_PATH + "boardViewSet";
    }
    
    /**
     * 선택된 항목의 detail 값을 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/Board.do")
    public String getBoard(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        model.addAttribute("item", boardMtService.selectBoard(param));
        
        return ADMIN_PATH + "boardEdit";
    }
    
    /**
     * 게시판 기본정보를 수정한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/updateBoard.do")
    public ModelAndView updateBoard(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = boardMtService.updateBoard(param);
            
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
     * 게시판 항목설정를 저장한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/updateBoardItemSet.do")
    public ModelAndView updateBoardItemSet(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        try {
            
            rv = boardMtService.updateBoardItemSet(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getSavedMsg(rv, _req));
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
     * 게시판 목록뷰설정를 저장한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/updateBoardViewSet.do")
    public ModelAndView updateBoardViewSet(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = boardMtService.updateBoardViewSet(param);
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", MessageUtil.getSavedMsg(rv, _req));
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
     * 게시판을 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/deleteBoard.do")
    public ModelAndView deleteBoard(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            // 삭제하기전 매핑 확인
            chk = boardMtService.chkBoardMapp(param);
            
            if ( ! (chk > 0) ) {
                rv = boardMtService.deleteBoard(param);
            }
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getDeteleMsg(rv, _req));
            } else {
                param.put("success", "false"); 
                if (chk > 0) {
                    param.put("message", "메뉴에 매핑된 게시판입니다."); 
                } else {
                    param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false"); 
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }
        
        return ViewHelper.getJsonView(param);
    }
    
    /***************** 게시판 관리 end *****************/
    
    /***************** 게시판 카테고리 관리 *****************/
    
    /**
     * 게시판 카테고리 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardCategoryListPage.do")
    public String faqWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        Map<String, Object> category = new HashMap();        
        model.addAttribute("category", category);
        
        return "/sub" + ADMIN_PATH + "boardCategoryListPage";
    }
    
    /**
     * 게시판 카테고리 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardCategoryList.do")
    public @ResponseBody Map<String, Object> boardCategoryList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();        
        List<Map<String, Object>> list = boardMtService.selectBoardCategoryList(param);
        
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 게시판 카테고리를 저장한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/insertBoardCategory.do")
    public ModelAndView insertBoardCategory(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            param.put("cate_id", CommonUtil.createUUID());
            rv = boardMtService.insertBoardCategory(param);
            
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
     * 게시판 카테고리를 수정한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/updateBoardCategory.do")
    public ModelAndView updateBoardCategory(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = boardMtService.updateBoardCategory(param);
            
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
     * 게시판 카테고리를 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/deleteBoardCategory.do")
    public ModelAndView deleteBoardCategory(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = boardMtService.deleteBoardCategory(param);
            
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
     * 게시판 카테고리 상세정보를 가져온다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/selectBoardCategoryDetail.do")
    public ModelAndView selectBoardCategoryDetail(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();        
        param.put("data", boardMtService.selectBoardCategoryDetail(param));
        
        return ViewHelper.getJsonView(param);
    }
    
    /***************** 게시판 카테고리 관리 end *****************/
    
    /***************** 게시물 관리 *****************/
    
    /**
     * 게시물 관리 페이지 이동
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardContentsListPage.do")
    public String boardContentsListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
                
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = boardMtService.selectBoardList(param);
        model.addAttribute("boardList", list);

        Map<String, Object> boardinfo = new HashMap();
        if (!StringUtil.nvl(param.get("board_id")).equals("")) {
            
            boardinfo = boardMtService.selectBoardDetail(param);
            model.addAttribute("boardinfo", boardinfo);
            
            // 카테고리
            List<Map<String, Object>> category = null;
            if (StringUtil.nvl(boardinfo.get("cate_yn")).equals("Y")) {
                category = boardMtService.selectBoardCategoryList(param);
            }
            model.addAttribute("category", category);
        }
        
        model.addAttribute("gubun", param.get("gubun"));
        
        return ADMIN_PATH + "boardContentsListPage";
    }
    
    /**
     * 게시물 리스트
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/selectBoardContentsPageList.do")
    public ModelAndView selectBoardContentsPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        
        // 관리자 셋팅
        param.put("backyn", "B"); 
        
        navigator.setList(boardMtService.selectBoardContentsPageList(param));
        
        return ViewHelper.getJqGridView(navigator);
    }
    
    /**
     * 게시물 등록 페이지 이동
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardContentsWrite.do")
    public String boardContentsWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        Map<String, Object> contentsinfo = new HashMap();
        
        boardinfo = boardMtService.selectBoardDetail(param);
        
        if ("W".equals(param.get("mode"))) {

            UserVO userVo =  _req.getSessionUser();
            
            // 담당정보 셋팅
            if(userVo != null){
                
                String charge_info = "담당자 : " + userVo.getUserName();                
                if(!StringUtil.isEmpty(userVo.getDept())) charge_info += " | 담당부서 : " + userVo.getDept();
                if(!StringUtil.isEmpty(userVo.getUserTel())) charge_info += " | 전화번호 : " + CryptoUtil.AES_Decode(userVo.getUserTel());
                if(!StringUtil.isEmpty(userVo.getUserEmail())) charge_info += " | 이메일 : " + CryptoUtil.AES_Decode(userVo.getUserEmail());
                
                contentsinfo.put("charge_info", charge_info);
            }
            
        } else {
            contentsinfo = boardMtService.selectContentsDetail(param);            
        }
        
        // 그룹아이디가 없는경우 전체를 가져오기 방지
        if (contentsinfo.get("group_id") == null) {  
            param.put("group_id", "A"); 
        } else {
            param.put("group_id", contentsinfo.get("group_id"));
        }      
        
        // 이메일 셋팅
        String email = StringUtil.nvl(contentsinfo.get("email"));
        if (!email.equals("")) {
            String[] emailStr = StringUtil.split(email, "@");
            contentsinfo.put("email_1", emailStr[0]);
            contentsinfo.put("email_2", emailStr[1]);
        }
        
        // group_id만  넘겨줘야함
        List<CommonFileVO> fileList = commonFileService.getCommonFileList(param); 
        model.addAttribute("fileList", fileList);
        
        // 카테고리
        List<Map<String, Object>> category = null;
        if (StringUtil.nvl(boardinfo.get("cate_yn")).equals("Y")) {     
            category = boardMtService.selectBoardCategoryList(param);
        }
        model.addAttribute("category", category);
                
        model.addAttribute("name", param.get("s_user_name"));
        model.addAttribute("boardinfo", boardinfo);
        model.addAttribute("contentsinfo", contentsinfo);
        
        return ADMIN_PATH + "boardContentsWrite";
    }
    
    /**
     * 게시물 등록한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/insertBoardContents.do")
    public ModelAndView insertBoardContents(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("board/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                    
                    // 썸네일
                    if ("thumb".equals(file.getFieldName())) { 
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("board/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        param.put("image_file_id", commonFileVO.getFile_id());
                    } 
                    
                    // 첨부파일
                    else {
                        if (acnt == 0) {
                            commonFileVO.setGroup_id(CommonUtil.createUUID());
                            param.put("group_id", commonFileVO.getGroup_id());
                        } else {
                            commonFileVO.setGroup_id((String) param.get("group_id"));
                        }
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("board/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        acnt++;
                    }
                }
            }
            param.put("contents_id", CommonUtil.createUUID());
            param.put("restep_seq", 0);
            param.put("relevel_seq", 0);
            
            rv = boardMtService.insertBoardContents(param);
            
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
     * 답글을 등록한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/insertBoardContentsReply.do")
    public ModelAndView insertBoardContentsReply(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int acnt = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("board/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                    
                    // 썸네일
                    if ("thumb".equals(file.getFieldName())) {
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("board/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        param.put("image_file_id", commonFileVO.getFile_id());
                    } 
                    
                    // 첨부파일
                    else { 
                        if (acnt == 0) {
                            commonFileVO.setGroup_id(CommonUtil.createUUID());
                            param.put("group_id", commonFileVO.getGroup_id());
                        } else {
                            commonFileVO.setGroup_id((String) param.get("group_id"));
                        }
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("board/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        acnt++;
                    }
                }
            }
            
            param.put("contents_id", CommonUtil.createUUID());
            boardMtService.updateBoardContentsReorder(param);
            
            param.put("noti", "N");
            param.put("restep_seq", StringUtil.nvl(param.get("restep_seq"), 0) + 1);
            param.put("relevel_seq", StringUtil.nvl(param.get("relevel_seq"), 0) + 1);
            
            rv = boardMtService.insertBoardContents(param);
            
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
     * 게시물 수정한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/updateBoardContents.do")
    public ModelAndView updateBoardContents(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            List<FileUploadModel> fileList = _req.saveAllFilesTo(getUploadPath("board/"));
            FileUploadModel file = null;
            CommonFileVO commonFileVO = new CommonFileVO();
            
            if (fileList != null && fileList.size() > 0) {
                
                for (int i = 0; i < fileList.size(); i++) {
                    
                    file = (FileUploadModel) fileList.get(i);
                    
                    // 썸네일
                    if ("thumb".equals(file.getFieldName())) { 
                        commonFileVO.setGroup_id(CommonUtil.createUUID());
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("board/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                        param.put("image_file_id", commonFileVO.getFile_id());
                    } 
                    
                    // 첨부파일
                    else {
                        if ("".equals(param.get("group_id")) || param.get("group_id") == null) {
                            commonFileVO.setGroup_id(CommonUtil.createUUID());
                            param.put("group_id", commonFileVO.getGroup_id());
                        } else {
                            commonFileVO.setGroup_id((String) param.get("group_id"));
                        }
                        commonFileVO.setFile_nm(file.getFileName());
                        commonFileVO.setOrigin_file_nm(file.getOriginalFileName());
                        commonFileVO.setFile_type(file.getExtension());
                        commonFileVO.setFile_size(file.getFileSize());
                        commonFileVO.setFile_path("board/");
                        commonFileVO.setS_user_no((String) param.get("s_user_no"));
                        commonFileService.insertCommonFile(commonFileVO);
                    }
                }
            }
            
            rv = boardMtService.updateBoardContents(param);
            
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
     * 게시물을 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/deleteBoardContents.do")
    public ModelAndView deleteBoardContents(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            // 삭제하기전 자식글이 있는지 확인
            chk = boardMtService.chkBoardChildContents(param);
            
            if ( ! (chk > 0) ) {
                rv = boardMtService.deleteBoardContents(param);
            }
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getDeteleMsg(rv, _req));
            } else {
                param.put("success", "false");
                if (chk > 0) {
                    param.put("message", "답글이 있으면 삭제할 수 없습니다."); 
                } else {
                    param.put("message", MessageUtil.getProcessFaildMsg(rv, _req)); 
                }
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
     * 게시물 타입별 리스트
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardContentsList.do")
    public String boardContentsList(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        String jsp = "/sub" + ADMIN_PATH;
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        Map<String, Object> boardinfo = new HashMap();
        List<Map<String, Object>> viewSortList = null;
        List<Map<String, Object>> boardlist = null;
        
        boardinfo = boardMtService.selectBoardDetail(param);
        
        // 요약형
        if ("W".equals(boardinfo.get("board_type"))) { 
            jsp += "boardContentsSmyList";
            param.put("sidx", "noti DESC, ref_seq DESC, restep_seq");
            param.put("sord", "asc");
            navigator.setList(boardMtService.selectBoardContentsPageList(param));
            model.addAttribute("boardList", navigator.getList());
            model.addAttribute("boardPagging", navigator.getPagging());
            model.addAttribute("totalcnt", navigator.getTotalCnt());
        } 
        
        // 앨범형
        else if ("A".equals(boardinfo.get("board_type"))) { 
            jsp += "boardContentsImgList";
            param.put("sidx", "noti DESC, ref_seq DESC, restep_seq");
            param.put("sord", "asc");
            navigator.setList(boardMtService.selectBoardContentsPageList(param));
            model.addAttribute("boardList", navigator.getList());
            model.addAttribute("boardPagging", navigator.getPagging());
            model.addAttribute("totalcnt", navigator.getTotalCnt());
        } 
        
        // 보고서형
        else if ("R".equals(boardinfo.get("board_type"))) { 
            jsp += "boardContentsReportList";
            param.put("sidx", "noti DESC, ref_seq DESC, restep_seq");
            param.put("sord", "asc");
            navigator.setList(boardMtService.selectBoardContentsPageList(param));
            model.addAttribute("boardList", navigator.getList());
            model.addAttribute("boardPagging", navigator.getPagging());
            model.addAttribute("totalcnt", navigator.getTotalCnt());
        } 
        
        // 일반형, QnA형
        else { 
            jsp += "boardContentsList"; 
            model.addAttribute(ListOp.LIST_OP_NAME, listOp);
            model.addAttribute("boardlist", boardlist);
        }
        
        // 게시판 뷰설정목록 리스트
        viewSortList = boardMtService.selectBoardViewSortList(param);

        model.addAttribute("param", param);
        model.addAttribute("viewSortList", viewSortList);
        model.addAttribute("boardinfo", boardinfo);
        
        return jsp;
    }
    
    /**
     * 게시물 뷰 페이지로 이동
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardContentsView.do")
    public String boardContentsView(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        model.addAttribute(ListOp.LIST_OP_NAME, listOp);
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        Map<String, Object> contentsinfo = new HashMap();
        Map<String, Object> prenext = new HashMap();
        
        boardinfo = boardMtService.selectBoardDetail(param);
        contentsinfo = boardMtService.selectContentsDetail(param);
        
        // 이전글 다음글을 가져온다.
        prenext = boardMtService.selectPreNextContents(param); 
                
        if (contentsinfo.get("group_id") == null) {
            
         // 그룹아이디가 없는경우 전체를 가져오기 방지
            param.put("group_id", "A"); 
        } else {
            param.put("group_id", contentsinfo.get("group_id"));
        }
        
        // group_id만  넘겨줘야함
        List<CommonFileVO> fileList = commonFileService.getCommonFileList(param); 
        
        model.addAttribute("name", param.get("s_user_name"));
        model.addAttribute("boardinfo", boardinfo);
        model.addAttribute("contentsinfo", contentsinfo);
        model.addAttribute("prenext", prenext);
        model.addAttribute("fileList", fileList);
        
        return ADMIN_PATH + "boardContentsView";
    }
    
    /**
     * 답변을 저장한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/saveBoardContentsAnswer.do")
    public ModelAndView saveBoardContentsAnswer(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = boardMtService.saveBoardContentsAnswer(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getSavedMsg(rv, _req));
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
    
    /***************** 게시물 관리 end *****************/
    
    /***************** 댓글 *****************/
    
    /**
     * 댓글을 저장한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/saveComment.do")
    public ModelAndView saveComment(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            if ("E".equals(param.get("mode"))) {
                rv = boardMtService.updateComment(param);
            } 
            
            else if ("R".equals(param.get("mode"))) {
            	
                param.put("comment_id", CommonUtil.createUUID());
                boardMtService.updateCommentReorder(param);
                
                param.put("sort", StringUtil.nvl(param.get("sort"), 0) + 1);
                rv = boardMtService.saveComment(param);
            } 
            
            else {
                param.put("comment_id", CommonUtil.createUUID());
                rv = boardMtService.saveComment(param);
            }
            
            if (rv > 0) { 
                param.put("success", "true");
                param.put("message", MessageUtil.getSavedMsg(rv, _req));
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
     * 댓글을 삭제한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/deleteComment.do")
    public ModelAndView deleteComment(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = boardMtService.deleteComment(param);
            
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
     * 댓글 리스트 페이지
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardCommentList.do")
    public String boardCommentList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = boardMtService.selectBoardCommentList(param);
        
        model.addAttribute("commentList", list);
        
        return "/sub" + ADMIN_PATH + "boardCommentList";
    }
    
    /***************** 댓글 end *****************/
    
    /***************** 만족도 *****************/
    
    /**
     * 만족도를 저장한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/saveSatisfy.do")
    public ModelAndView saveSatisfy(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            param.put("satisfy_id", CommonUtil.createUUID());
            rv = boardMtService.saveSatisfy(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("message", MessageUtil.getSavedMsg(rv, _req));
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
    
    /***************** 만족도 end *****************/
    
    /***************** 추천 *****************/
    
    /**
     * 게시물 추천수를 가져온다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/loadRecommend.do")
    public ModelAndView loadRecommend(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> recommendinfo = new HashMap();
        int total_cnt = 0;
        String recommend_yn = "N";
        
        recommendinfo = boardMtService.selectRecommend(param);
        if (recommendinfo != null) {
            total_cnt = ((BigDecimal) recommendinfo.get("total_cnt")).intValue();
            recommend_yn = (String) recommendinfo.get("recommend_yn");
        }
        
        param.put("recommend_cnt", total_cnt);
        param.put("recommend_yn", recommend_yn);
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 추천하기, 추천취소하기
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/saveRecommend.do")
    public ModelAndView saveRecommend(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
        	
            if ("Y".equals(param.get("recommend_yn"))) {
                param.put("recommend_yn", "N");
                param.put("message", "취소하였습니다.");
            } else {
                param.put("recommend_yn", "Y");
                param.put("message", "추천하였습니다.");
            }
            
            rv = boardMtService.saveRecommend(param);
            
            if (rv > 0) { 
                param.put("success", "true");
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
    
    /***************** 추천 end *****************/
    
    /**
     * 게시판 팝업 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardSearchPopup.do")
    public String boardSearchPopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        return "/sub" + ADMIN_PATH + "boardListPopup";
    }
    
    /**
     * 게시판 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/board/boardSearchList.do")
    public @ResponseBody Map<String, Object> boardSearchList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = boardMtService.selectBoardList(param);
        param.put("rows", list);
        
        return param;
    }
}
