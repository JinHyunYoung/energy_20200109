package kr.or.wabis.admin.board.service;

import java.util.List;
import java.util.Map;

import kr.or.wabis.board.service.BoardService;

public interface BoardMtService extends BoardService {
    
    /**
     * 게시판 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardList(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 기본정보를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBoard(Map<String, Object> param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoard(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 기본정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoard(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 항목설정을 저장한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoardItemSet(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 목록뷰설정을 저장한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoardViewSet(Map<String, Object> param) throws Exception;
    
    /**
     * 메뉴 매핑여부 확인
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int chkBoardMapp(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBoard(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 카테고리를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBoardCategory(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 카테고리를 수정한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoardCategory(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 카테고리를 삭제한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBoardCategory(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 카테고리 상세내용을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardCategoryDetail(Map<String, Object> param) throws Exception;
}
