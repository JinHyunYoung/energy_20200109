package kr.or.wabis.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.board.vo.BoardVo;
import kr.or.wabis.dao.board.BoardDao;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.util.email.AnswerEmailService;
import kr.or.wabis.framework.util.email.ReplyEmailService;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
    
    private Logger logger = Logger.getLogger(BoardServiceImpl.class);
    
    @Resource(name = "boardDao")
    protected BoardDao boardDao;
    
    /**
     * 게시판 기본정보를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardDetail(Map<String, Object> param) throws Exception {
        return boardDao.selectBoardDetail(param);
    }
    
    /**
     * 게시판 항목을 정렬순으로 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardViewSortList(Map<String, Object> param) throws Exception {
    	 List<Map<String, Object>> list = boardDao.selectBoardViewSortList(param);
         List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
         
         String[] v_prints = null;
         String[] v_sorts = null;
         String[] v_sizes = null;
         
         if (list != null) {
             //v_print, v_sort, v_size, total_cnt
             for (int i = 0; i < list.size(); i++) {
                
            	 //number,title,attach,reg_date,hits  콤마로 구분된 필드명을 잘라서 변환
                 if (list.get(i).get("v_print") != null) {
                	 v_prints = StringUtil.split((String) list.get(i).get("v_print"), ",");
                	 if (list.get(i).get("v_sort") != null) {
                		 v_sorts = StringUtil.split((String) list.get(i).get("v_sort"), ",");
                	 }
                	 
                	 if (list.get(i).get("v_size") != null) {
                		 v_sizes = StringUtil.split((String) list.get(i).get("v_size"), ",");
                	 }
                	 
                	 // 항목 View 설정 후 목록 View 설정을 안하게 되면 3가지가 불일치. 그중 제일 작은 갯수만 하여야 함 

                	 
                	 for(int j = 0; j < v_prints.length; j++){
                         Map<String, Object> map = new HashMap<String, Object>();
               		 
            			 map.put("v_print", StringUtil.nvl(v_prints[j]));
            			 
            			 
            			 //앨범형, 보고서형 등은 v_sort, v_size가 없음
            			 if (v_sorts == null)   {
            				 map.put("v_sort", "");
            			 }else{
            				 //Q&A 게시판 등은 V_Print와 V_sorts, V_size수가 일치하지 않음
            				 if (j < v_sorts.length) {
            					 map.put("v_sort", StringUtil.nvl(v_sorts[j]));
            				 }else{
                				 map.put("v_sort", "");
            				 }
            			 }
            			 
            			//앨범형, 보고서형 등은 v_sort, v_size가 없음
            			 if (v_sizes == null)  {
            				 map.put("v_size","");
            			 }else{
            				//Q&A 게시판 등은 V_Print와 V_sorts, V_size수가 일치하지 않음
            				 if (j < v_sizes.length) {
            					 map.put("v_size", StringUtil.nvl(v_sizes[j]));
            				 }else{
                				 map.put("v_size","");
            				 }
            			 }
            			 
            			 map.put("total_cnt", v_prints.length);
            			 
                         list2.add(map);
                	 }
                 }
             }
         }

        return list2;
    }
    
    /**
     * 게시판 카테고리 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardCategoryList(Map<String, Object> param) throws Exception {
        return boardDao.selectBoardCategoryList(param);
    }
    
    /**
     * 게시물 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardContentsPageList(Map<String, Object> param) throws Exception {
                
        List<Map<String, Object>> list = boardDao.selectBoardContentsPageList(param);
        
        List<Map<String, Object>> list2 = new ArrayList();
        
        Map<String, Object> map = new HashMap();

        CryptoUtil a256 = CryptoUtil.getInstance();
        if (list != null) {
            
            for (int i = 0; i < list.size(); i++) {
                
                map = null;
                map = list.get(i);
                
                if (map.get("handphone") != null) {
                    map.put("handphone", a256.AES_Decode((String) map.get("handphone")));
                }
                
                if (map.get("email") != null) {
                    map.put("email", a256.AES_Decode((String) map.get("email")));
                }
                
                if (map.get("contents") != null) {
                    map.put("contents", StringUtil.removeTag(StringUtil.nvl(map.get("contents"))));
                }
                
                list2.add(map);
            }
        }
        
        return list2;
    }
    
    /**
     * 게시물 기본정보를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectContentsDetail(Map<String, Object> param) throws Exception {
        
        CryptoUtil a256 = CryptoUtil.getInstance();
        
        Map<String, Object> map = boardDao.selectContentsDetail(param);
        
        if (map.get("handphone") != null) {
            map.put("handphone", CryptoUtil.AES_Decode(StringUtil.nvl(map.get("handphone"))));
        }
        
        if (map.get("email") != null) {
        	
        	String mail = CryptoUtil.AES_Decode(StringUtil.nvl(map.get("email")));
        	
        	if(mail.equals("undefined@undefined")){
                map.put("email", null);        		
        	} else {
                map.put("email", mail);        		
        	}        	
        }
        
        return map;
    }
    
    /**
     * 게시물 이전글, 다음글을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectPreNextContents(Map<String, Object> param) throws Exception {
        return boardDao.selectPreNextContents(param);
    }
    
    /**
     * 조회수를 증가 시킨다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public void updateBoardContentsHits(Map<String, Object> param) throws Exception {
        boardDao.updateBoardContentsHits(param);
    }
        
    /**
     * 게시물을 등록한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBoardContents(Map<String, Object> param) throws Exception {
        
        String v_phone = "";        
        if (param.get("phone2") != null && param.get("phone3") != null) {
            v_phone = param.get("phone1") + "-" + param.get("phone2") + "-" + param.get("phone3");
            param.put("handphone", CryptoUtil.AES_Encode(v_phone));
        }
        
        if (param.get("email") != null && param.get("email_recv_yn") != null && "Y".equals(param.get("email_recv_yn"))) {
            param.put("email", CryptoUtil.AES_Encode(param.get("email").toString()));
        } else {
        	param.put("email", null);
        }
        
        // 답신여부 확인후 처리
        if (param.get("mode") != null && param.get("writer_email") != null && param.get("writer_email_recv_yn") != null) {

        	String mode = StringUtil.nvl(param.get("mode"));
        	String email_recv_yn = StringUtil.nvl(param.get("writer_email_recv_yn"));
        	String email = StringUtil.nvl(param.get("writer_email"));
        	
        	if("R".equals(mode) && "Y".equals(email_recv_yn) && !email.equals("")){
                
                // 이메일을 보낸다.
        		new AnswerEmailService().sendEmail(email, param);
        		
        	}
        }
        
        return boardDao.insertBoardContents(param);
    }
    
    /**
     * 게시물을 재정렬한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public void updateBoardContentsReorder(Map<String, Object> param) throws Exception {
        boardDao.updateBoardContentsReorder(param);
    }
    
    /**
     * 게시물을 수정한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoardContents(Map<String, Object> param) throws Exception {
        
        String v_phone = "";
        if (param.get("phone2") != null && param.get("phone3") != null) {
            v_phone = param.get("phone1") + "-" + param.get("phone2") + "-" + param.get("phone3");
            param.put("handphone", CryptoUtil.AES_Encode(v_phone));
        }
                
        if (param.get("email") != null && param.get("email_recv_yn") != null && "Y".equals(param.get("email_recv_yn"))) {
            param.put("email", CryptoUtil.AES_Encode(param.get("email").toString()));
        } else {
        	param.put("email", null);
        }
        
        return boardDao.updateBoardContents(param);
    }
    
    /**
     * 답변게시물여부를 확인한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int chkBoardChildContents(Map<String, Object> param) throws Exception {
        return boardDao.chkBoardChildContents(param);
    }
    
    /**
     * 게시물을 삭제한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBoardContents(Map<String, Object> param) throws Exception {
        return boardDao.deleteBoardContents(param);
    }
    
    /**
     * 게시물 패스워드를 검증한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int chkBoardPass(Map<String, Object> param) throws Exception {
        return boardDao.chkBoardPass(param);
    }
    
    /**
     * 답변을 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int saveBoardContentsAnswer(Map<String, Object> param) throws Exception {
        
        int rv = boardDao.saveBoardContentsAnswer(param);
                
//        // 답신여부 확인후 처리
//        SmsSend sms = new SmsSend();
//        Map<String, Object> map = boardDao.chkSmsRecv(param);
//        if (map != null) {
//            
//            String v_phone = "";
//            if (map.get("handphone") != null) {
//                
//                v_phone = CryptoUtil.AES_Decode(StringUtil.nvl(map.get("handphone")));
//                v_phone = v_phone.replaceAll("-", "");
//                
//                // SMS를 보낸다.
//                sms.sendMessage(v_phone, "회원님의 게시글에 답변이 기재되었습니다.", "0221336588");
//            }
//        }
                
        // 답신여부 확인후 처리
        Map<String, Object> map = boardDao.chkEmailRecv(param);
                
        if (map != null) {
            
            if (map.get("email") != null && map.get("email_recv_yn") != null) {
            	
            	String email_recv_yn = StringUtil.nvl(map.get("email_recv_yn"));
            	String email = CryptoUtil.AES_Decode(StringUtil.nvl(map.get("email")));
            	
            	if("Y".equals(email_recv_yn) && !email.equals("")){
            		                    
                    // 이메일을 보낸다.
            		new ReplyEmailService().sendEmail(email, param);
            		
            	}
            }
        }
                
        return rv;
    }
    
    /**
     * 댓글을 수정한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateComment(Map<String, Object> param) throws Exception {
        return boardDao.updateComment(param);
    }
    
    /**
     * 댓글을 재정렬한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public void updateCommentReorder(Map<String, Object> param) throws Exception {
        boardDao.updateCommentReorder(param);
    }
    
    /**
     * 댓글을 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int saveComment(Map<String, Object> param) throws Exception {
        return boardDao.saveComment(param);
    }
    
    /**
     * 댓글을 삭제한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteComment(Map<String, Object> param) throws Exception {
        return boardDao.deleteComment(param);
    }
    
    /**
     * 댓글의 패스워드를 확인한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int chkComment(Map<String, Object> param) throws Exception {
        return boardDao.chkComment(param);
    }
    
    /**
     * 댓글 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardCommentList(Map<String, Object> param) throws Exception {
        return boardDao.selectBoardCommentList(param);
    }
    
    /**
     * 만족도를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int saveSatisfy(Map<String, Object> param) throws Exception {
        return boardDao.saveSatisfy(param);
    }
    
    /**
     * 추천 정보를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectRecommend(Map<String, Object> param) throws Exception {
        return boardDao.selectRecommend(param);
    }
    
    /**
     * 추천을 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int saveRecommend(Map<String, Object> param) throws Exception {
        return boardDao.saveRecommend(param);
    }
    
    /**
     * 게시판 메인 출력용 게시물
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectLoadMainBoard(BoardVo boardVo) throws Exception {
        
        List<Map<String, Object>> list = boardDao.selectLoadMainBoard(boardVo);
        List<Map<String, Object>> list2 = new ArrayList();
        Map<String, Object> map = new HashMap();
        
        if (list != null) {
            
            for (int i = 0; i < list.size(); i++) {
                
                map = null;
                map = list.get(i);
                
                if (map.get("contents") != null) {
                    map.put("contents", StringUtil.removeTag(StringUtil.nvl(map.get("contents"))));
                }
                
                list2.add(map);
            }
        }
        
        return list2;
    }
}
