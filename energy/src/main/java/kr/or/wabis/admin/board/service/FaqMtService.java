package kr.or.wabis.admin.board.service;

import java.util.List;
import java.util.Map;

public interface FaqMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFaqPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFaqList(Map<String, Object> param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectFaq(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertFaq(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateFaq(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteFaq(Map<String, Object> param) throws Exception;
    
    /**
     * faq 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateFaqReorder(Map<String, Object> param) throws Exception;
}
