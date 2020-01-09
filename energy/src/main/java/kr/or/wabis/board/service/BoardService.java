package kr.or.wabis.board.service;

import java.util.List;
import java.util.Map;

import kr.or.wabis.board.vo.BoardVo;

public interface BoardService {
    
    /**
     * 게시판 기본정보를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardDetail(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 항목을 정렬순으로 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardViewSortList(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 카테고리 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardCategoryList(Map<String, Object> param) throws Exception;
    
    /**
     * 게시물 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardContentsPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 게시물 기본정보를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectContentsDetail(Map<String, Object> param) throws Exception;
    
    /**
     * 게시물 이전글, 다음글을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectPreNextContents(Map<String, Object> param) throws Exception;
    
    /**
     * 조회수를 증가 시킨다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public void updateBoardContentsHits(Map<String, Object> param) throws Exception;
    
    /**
     * 게시물를 등록한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBoardContents(Map<String, Object> param) throws Exception;
    
    /**
     * 게시물을 재정렬한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public void updateBoardContentsReorder(Map<String, Object> param) throws Exception;
    
    /**
     * 게시물를 수정한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoardContents(Map<String, Object> param) throws Exception;
    
    /**
     * 답변게시물여부를 확인한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int chkBoardChildContents(Map<String, Object> param) throws Exception;
    
    /**
     * 게시물를 삭제한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBoardContents(Map<String, Object> param) throws Exception;
    
    /**
     * 게시물 패스워드를 검증한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int chkBoardPass(Map<String, Object> param) throws Exception;
    
    /**
     * 답변을 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int saveBoardContentsAnswer(Map<String, Object> param) throws Exception;
    
    /**
     * 댓글을 수정한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateComment(Map<String, Object> param) throws Exception;
    
    /**
     * 댓글을 재정렬한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public void updateCommentReorder(Map<String, Object> param) throws Exception;
    
    /**
     * 댓글을 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int saveComment(Map<String, Object> param) throws Exception;
    
    /**
     * 댓글을 삭제한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteComment(Map<String, Object> param) throws Exception;
    
    /**
     * 댓글의 패스워드를 확인한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int chkComment(Map<String, Object> param) throws Exception;
    
    /**
     * 댓글 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardCommentList(Map<String, Object> param) throws Exception;
    
    /**
     * 만족도를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int saveSatisfy(Map<String, Object> param) throws Exception;
    
    /**
     * 추천 정보를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectRecommend(Map<String, Object> param) throws Exception;
    
    /**
     * 추천을 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int saveRecommend(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 메인 출력용 게시물
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectLoadMainBoard(BoardVo boardVo) throws Exception;
    
}
