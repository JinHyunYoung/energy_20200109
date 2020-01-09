package kr.or.wabis.admin.board.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.board.service.BoardServiceImpl;

@Service("boardMtService")
public class BoardMtServiceImpl extends BoardServiceImpl implements BoardMtService {
    
    private Logger logger = Logger.getLogger(BoardMtServiceImpl.class);
        
    /**
     * 게시판 리스트 페이지로딩후 grid 데이터를 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardPageList(Map<String, Object> param) throws Exception {
        return boardDao.selectBoardPageList(param);
    }
    
    /**
     * 게시판 리스트 페이지로딩후 list 데이터를 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBoardList(Map<String, Object> param) throws Exception {
        return boardDao.selectBoardList(param);
    }
    
    /**
     * 게시판 기본정보를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBoard(Map<String, Object> param) throws Exception {
        
        // 게시판 타입에 따라 항목설정, 목록뷰설정 디폴트저장
        String v_type = (String) param.get("board_type");
        String v_item_use = "";
        String v_item_required = "number,title,name,reg_date,ip_addr,hits";
        String v_view_print = "number,title,name,reg_date,hits";
        String v_view_size = "";
        String v_view_sort = "";
        
        // QnA형
        if ("Q".equals(v_type)) {
            v_item_use = "number,title,reply_yn,reply_status,reply_contents,reply_date,name,reg_date,ip_addr,hits";
            v_view_size = "15,30,20,20,15";
            v_view_sort = "1,2,3,4,5";
        } 
        
        // 일반형
        else if ("N".equals(v_type)) {
            v_item_use = "number,title,name,reg_date,ip_addr,hits";
            v_view_size = "15,30,20,20,15";
            v_view_sort = "1,2,3,4,5";
        } 
        
        
        // 앨범형, 보고서형, 요약형
        else {
            v_item_use = "number,title,thumb,name,reg_date,ip_addr,hits";
            v_view_print = "title,thumb,name,reg_date,hits";
        }
        
        param.put("item_use", v_item_use);
        param.put("item_required", v_item_required);
        param.put("view_print", v_view_print);
        param.put("view_size", v_view_size);
        param.put("view_sort", v_view_sort);
        
        return boardDao.insertBoard(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoard(Map<String, Object> param) throws Exception {
        return boardDao.selectBoard(param);
    }
    
    /**
     * 게시판 기본정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoard(Map<String, Object> param) throws Exception {
        return boardDao.updateBoard(param);
    }
    
    /**
     * 게시판 항목설정을 저장한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoardItemSet(Map<String, Object> param) throws Exception {
        return boardDao.updateBoardItemSet(param);
    }
    
    /**
     * 게시판 목록뷰설정을 저장한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoardViewSet(Map<String, Object> param) throws Exception {
        return boardDao.updateBoardViewSet(param);
    }
    
    /**
     * 메뉴 매핑여부 확인
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int chkBoardMapp(Map<String, Object> param) throws Exception {
        return boardDao.chkBoardMapp(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBoard(Map<String, Object> param) throws Exception {
        return boardDao.deleteBoard(param);
    }
    
    /**
     * 게시판 카테고리를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBoardCategory(Map<String, Object> param) throws Exception {
        return boardDao.insertBoardCategory(param);
    }
    
    /**
     * 게시판 카테고리를 수정한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBoardCategory(Map<String, Object> param) throws Exception {
        return boardDao.updateBoardCategory(param);
    }
    
    /**
     * 게시판 카테고리를 삭제한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBoardCategory(Map<String, Object> param) throws Exception {
        return boardDao.deleteBoardCategory(param);
    }
    
    /**
     * 게시판 카테고리 상세내용을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardCategoryDetail(Map<String, Object> param) throws Exception {
        return boardDao.selectBoardCategoryDetail(param);
    }
}
