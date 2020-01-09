package kr.or.wabis.admin.user.service;

import java.util.List;
import java.util.Map;

public interface UserMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 권한 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception;
    
    /**
     * 검색 사용자 페이지리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserSearchPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserList(Map<String, Object> param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectUser(Map<String, Object> param) throws Exception;
    
    /**
     * 관리자 권한 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectManagerAuthList(Map<String, Object> param) throws Exception;
    
    /**
     * 중복 여부를 체크한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int selectUserExist(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertUser(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateUser(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteUser(Map<String, Object> param) throws Exception;
    
    /**
     * 비밀번호 변경 설정 문자를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePasswordChange(Map<String, Object> param) throws Exception;
    
    /**
     * 권한별 관리자 페이지 리스트
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserAuthPageList(Map<String, Object> param) throws Exception;
}
