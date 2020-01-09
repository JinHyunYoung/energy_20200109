package kr.or.wabis.admin.contents.service;

import java.util.List;
import java.util.Map;

public interface PopupNotiMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectPopnotiPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectPopnotiList(Map<String, Object> param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectPopnoti(Map<String, Object> param) throws Exception;
    
    /**
     * 중복 여부를 체크한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int selectPopnotiExist(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertPopnoti(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePopnoti(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deletePopnoti(Map<String, Object> param) throws Exception;
    
}
