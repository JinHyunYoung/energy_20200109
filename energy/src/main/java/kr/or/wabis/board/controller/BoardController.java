package kr.or.wabis.board.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.board.service.BoardService;
import kr.or.wabis.board.vo.BoardVo;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.framework.web.view.ViewHelper;

@Controller("boardController")
public class BoardController extends AbstractController {
    
    private Logger logger = Logger.getLogger(BoardController.class);
    
    private final static String WEB_PATH = "/web/board/";
    
    @Resource(name = "boardService")
    private BoardService boardService;
    
    /**
     * 게시판 리스트 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/boardContentsListPage.do")
    public String boardContentsListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        List<Map<String, Object>> viewSortList = null;
        
        boardinfo = boardService.selectBoardDetail(param);
        model.addAttribute("boardinfo", boardinfo);
        
        // 게시판 뷰설정목록 리스트
        viewSortList = boardService.selectBoardViewSortList(param);
        model.addAttribute("viewSortList", viewSortList);        
        
        return WEB_PATH + "boardContentsListPage";
    }
    
    /**
     * 게시물 타입별 리스트
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/boardContentsList.do")
    public String boardContentsList(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        
        String jsp = "/sub" + WEB_PATH;
                
        NavigatorInfo navigator = new NavigatorInfo(_req);
        Map<String, Object> param = navigator.getParam();
        Map<String, Object> boardinfo = new HashMap();
        List<Map<String, Object>> viewSortList = null;
        
        param.put("sidx", "reservation_date DESC, ref_seq DESC, restep_seq");
        param.put("sord", "asc");
        
        boardinfo = boardService.selectBoardDetail(param);
        param.put("board_id", StringUtil.nvl(boardinfo.get("board_id")));
        
        // 요약형
        if ("W".equals(boardinfo.get("board_type"))) { 
            jsp += "boardContentsSmyList";
        } 
        
        // 앨범형
        else if ("A".equals(boardinfo.get("board_type")) ) { 
            jsp += "boardContentsImgList";
        }  
        
        // 보고서형
        else if ("R".equals(boardinfo.get("board_type"))) { 
            jsp += "boardContentsReportList";
        } 
        
        // 일반형, QnA형
        else { 
            jsp += "boardContentsList";
        }
        
        
        // 크로스 사이트 스크립트
        if(param.get("searchtxt") != null) {
        	String searchtxt = 	param.get("searchtxt").toString().toLowerCase();
        	if(searchtxt.indexOf("script") > -1) {
        		// 사용자
                param.put("backyn", "F"); 
                
                // 게시판 뷰설정목록 리스트
                viewSortList = boardService.selectBoardViewSortList(param);
                model.addAttribute("viewSortList", viewSortList);
                
                // 카테고리 
                List<Map<String, Object>> category = null;
                if (boardinfo != null && StringUtil.nvl(boardinfo.get("cate_yn")).equals("Y")) {
                    category = boardService.selectBoardCategoryList(param);
                }

                model.addAttribute("category", category);
                
                model.addAttribute("param", param);
                model.addAttribute("boardinfo", boardinfo);
                model.addAttribute("boardList", navigator.getList());
                model.addAttribute("boardPagging", navigator.getPagging());
                model.addAttribute("totalcnt", navigator.getTotalCnt());
                
        		return jsp;
        	}
        }
        
        // 사용자
        param.put("backyn", "F"); 
        navigator.setList(boardService.selectBoardContentsPageList(param));
        
        // 게시판 뷰설정목록 리스트
        viewSortList = boardService.selectBoardViewSortList(param);
        model.addAttribute("viewSortList", viewSortList);
        
        // 카테고리 
        List<Map<String, Object>> category = null;
        if (boardinfo != null && StringUtil.nvl(boardinfo.get("cate_yn")).equals("Y")) {
            category = boardService.selectBoardCategoryList(param);
        }
        model.addAttribute("category", category);
        
        model.addAttribute("param", param);
        model.addAttribute("boardinfo", boardinfo);
        model.addAttribute("boardList", navigator.getList());
        model.addAttribute("boardPagging", navigator.getPagging());
        model.addAttribute("totalcnt", navigator.getTotalCnt());
        
        return jsp;
    }
    
    /**
     * 게시물 등록 페이지 이동
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/boardContentsWrite.do", method = RequestMethod.POST)
    public String boardContentsWrite(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        String jsp = WEB_PATH + "boardContentsWrite";
        
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        Map<String, Object> contentsinfo = new HashMap();
        
        boardinfo = boardService.selectBoardDetail(param);
        
        if (!"W".equals(param.get("mode"))) {
        	
            contentsinfo = boardService.selectContentsDetail(param);
            
            // 패스워드가 있는 경우 패스워드 창으로 호출
            if ("Y".equals(contentsinfo.get("pass_yn")) && 
                    !"Y".equals(param.get("chkpass")) && 
                    !"R".equals(param.get("mode"))) {
                
                jsp = WEB_PATH + "boardContentsPass";
            }
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
        
        // group_id만 넘겨줘야함
        List<CommonFileVO> fileList = commonFileService.getCommonFileList(param); 
        
        // 카테고리
        List<Map<String, Object>> category = null;
        if (StringUtil.nvl(boardinfo.get("cate_yn")).equals("Y")) {    
            category = boardService.selectBoardCategoryList(param);
        }

        model.addAttribute("name", param.get("s_user_name"));
        model.addAttribute("category", category);
        model.addAttribute("boardinfo", boardinfo);
        model.addAttribute("contentsinfo", contentsinfo);
        model.addAttribute("fileList", fileList);
        
        return jsp;
    }
    
    /**
     * 게시판 상세 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/boardContentsView.do")
    public String boardContentsView(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        String jsp = WEB_PATH + "boardContentsView";
        
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> boardinfo = new HashMap();
        Map<String, Object> contentsinfo = new HashMap();
        Map<String, Object> prenext = new HashMap();
                
        contentsinfo = boardService.selectContentsDetail(param);
        param.put("board_id", contentsinfo.get("board_id"));
        
        // 패스워드가 있는 경우 패스워드 창으로 호출
        if ("Y".equals(contentsinfo.get("pass_yn")) && 
                !"Y".equals(param.get("chkpass")) && 
                "Y".equals(contentsinfo.get("secret"))) {
            
            jsp = WEB_PATH + "boardContentsPass";
            model.addAttribute("rt", "V");
            
            return jsp;
        }
        
        boardinfo = boardService.selectBoardDetail(param);
        
        // 이전글 다음글을 가져온다.
        prenext = boardService.selectPreNextContents(param); 
        
        // 조회수를 증가(관리자 페이지에서는 조회수를 증가시키지 않음)
        boardService.updateBoardContentsHits(param);
        
        if (contentsinfo.get("group_id") == null) {
            
            // 그룹아이디가 없는경우 전체를 가져오기 방지
            param.put("group_id", "A"); 
        } else {
            param.put("group_id", contentsinfo.get("group_id"));
        }
        
        // group_id만 넘겨줘야함
        List<CommonFileVO> fileList = commonFileService.getCommonFileList(param); 
        
        model.addAttribute("name", param.get("s_user_name"));
        model.addAttribute("boardinfo", boardinfo);
        model.addAttribute("contentsinfo", contentsinfo);
        model.addAttribute("prenext", prenext);
        model.addAttribute("fileList", fileList);
        model.addAttribute("param", param);
        
        return jsp;
    }
    
    /**
     * 게시물을 등록한다.
     * 
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/insertBoardContents.do")
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
            
            rv = boardService.insertBoardContents(param);
            
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
    @RequestMapping(value = "/web/board/insertBoardContentsReply.do")
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
            boardService.updateBoardContentsReorder(param);
            
            param.put("noti", "N");
            param.put("restep_seq", StringUtil.nvl(param.get("restep_seq"), 0) + 1);
            param.put("relevel_seq", StringUtil.nvl(param.get("relevel_seq"), 0) + 1);
            
            rv = boardService.insertBoardContents(param);
            
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
    @RequestMapping(value = "/web/board/updateBoardContents.do")
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
            rv = boardService.updateBoardContents(param);
            
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
    @RequestMapping(value = "/web/board/deleteBoardContents.do", method = RequestMethod.POST)
    public ModelAndView deleteBoardContents(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            // 삭제하기전 자식글이 있는지 확인
            chk = boardService.chkBoardChildContents(param);
            
            if ( ! (chk > 0) ) {
                rv = boardService.deleteBoardContents(param);
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
     * 게시물을 삭제한다
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/chkBoardPass.do", method = RequestMethod.POST)
    public ModelAndView chkBoardPass(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        String contentsMode = "";
        
        String chk_rt = "";
        if(param.get("chk_rt") != null) {
        	chk_rt = param.get("chk_rt").toString();
        }
        
        String mode = "";
        if(param.get("mode") != null) {
        	mode = param.get("mode").toString();
        }
        
        
        if("V".equals(chk_rt)) {
        	contentsMode = "contentsView";
        }
        else {
        	if("E".equals(mode)) {
            	contentsMode = "contentsEdit";
            }
        	else {
        		contentsMode = "contentsDelete";
        	}
        }
        
        try {
            
            // 삭제하기전 자식글이 있는지 확인
            rv = boardService.chkBoardPass(param);
            
            if (rv > 0) {
                param.put("success", "true");
                param.put("contentsMode", contentsMode);
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
     * 댓글을 저장한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/saveComment.do")
    public ModelAndView saveComment(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            if ("E".equals(param.get("mode"))) {
                rv = boardService.updateComment(param);
            } 
            
            else if ("R".equals(param.get("mode"))) {
                
                param.put("comment_id", CommonUtil.createUUID());
                boardService.updateCommentReorder(param);
                
                param.put("sort", StringUtil.nvl(param.get("sort"), 0) + 1);
                rv = boardService.saveComment(param);
            } 
            
            else {
                param.put("comment_id", CommonUtil.createUUID());
                rv = boardService.saveComment(param);
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
    @RequestMapping(value = "/web/board/deleteComment.do")
    public ModelAndView deleteComment(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            rv = boardService.deleteComment(param);
            
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
     * 댓글의 패스워드를 확인한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/chkComment.do")
    public ModelAndView chkComment(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        try {
            
            rv = boardService.chkComment(param);
            
            if (rv > 0) {
                param.put("success", "true");
            } else {
                param.put("success", "false"); 
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
    @RequestMapping(value = "/web/board/boardCommentList.do")
    public String boardCommentList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = boardService.selectBoardCommentList(param);
        
        model.addAttribute("commentList", list);
        
        return "/sub" + WEB_PATH + "boardCommentList";
    }
    
    /**
     * 만족도를 저장한다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/saveSatisfy.do")
    public ModelAndView saveSatisfy(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        
        try {
            
            param.put("satisfy_id", CommonUtil.createUUID());
            rv = boardService.saveSatisfy(param);
            
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
     * 게시물 추천수를 가져온다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/loadRecommend.do")
    public ModelAndView loadRecommend(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> recommendinfo = new HashMap();
        int total_cnt = 0;
        String recommend_yn = "N";
        
        recommendinfo = boardService.selectRecommend(param);
        
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
    @RequestMapping(value = "/web/board/saveRecommend.do")
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
            
            rv = boardService.saveRecommend(param);
            
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
    
    /**
     * 게시판 메인 출력용 게시물
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/loadMainBoard.do")
    public ModelAndView loadMainBoard(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
                
        List<Map<String, Object>> list = boardService.selectLoadMainBoard(new BoardVo(param));
        param.put("list", list);
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 자동등록방지 문자를 반환해준다.
     * 
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/getCaptcharAnswer.do")
    public ModelAndView getCaptcharAnswer(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest request) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();        
        String answer = StringUtil.nvl(request.getSession().getAttribute("correctAnswer"));
        
        param.put("answer", answer);
        
        return ViewHelper.getJsonView(param);
    }
    
    /**
     * 게시판 댓글 패스워드 팝업
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/board/boardContentsPassPopup.do")
    public String boardContentsPassPopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {                
        return "/sub" + WEB_PATH + "boardContentsPassPopup";
    }
}
