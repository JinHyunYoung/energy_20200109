package kr.or.wabis.admin.user.service;

import java.util.List;
import java.util.Map;

public interface AuthMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectAuth(Map<String, Object> param) throws Exception;
    
    /**
     * 중복 여부를 체크한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int selectAuthExist(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertAuth(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateAuth(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteAuth(Map<String, Object> param) throws Exception;
    
    /**
     * 권한별 관리자 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> managerAuthPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 관리자 권한 매핑 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertManagerAuth(Map<String, Object> param) throws Exception;
    
    /**
     * 관리자 권한 매핑 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteManagerAuth(Map<String, Object> param) throws Exception;
    
}
