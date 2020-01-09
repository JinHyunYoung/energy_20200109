package kr.or.wabis.board.service;

import java.util.List;
import java.util.Map;

public interface FaqService {
    
    /**
     * FAQ를 조회한다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFaqList(Map<String, Object> param) throws Exception;
    
    /**
     * 게시판 메인 출력용 게시물
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectLoadMainFaq(Map<String, Object> param) throws Exception;
}
