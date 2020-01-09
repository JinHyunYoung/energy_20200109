package kr.or.wabis.user.service;

import java.util.List;
import java.util.Map;

import kr.or.wabis.user.vo.UserVO;

public interface UserService {
    
    /**
     * 중복 여부를 체크한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int selectUserExist(Map<String, Object> param) throws Exception;
    
    /**
     * 사용자 가입을 처리해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertUserRegist(Map<String, Object> param) throws Exception;
    
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
     * 성명과 핸드폰이 맞는지를 확인해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectUserPhoneExist(Map<String, Object> param) throws Exception;
    
    /**
     * 아아디, 성명과 핸드폰이 맞는지를 확인해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectUserIdPhoneExist(Map<String, Object> param) throws Exception;    
    
    /**
     * 비밀번호 변경 설정 문자를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePasswordChange(Map<String, Object> param) throws Exception;
    
    /**
     * 내 정보를 수정해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateUserModify(Map<String, Object> param) throws Exception;
    
    /**
     * 성명과 이메일이 맞는지를 확인해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectUserEmailExist(Map<String, Object> param) throws Exception;
    
    /**
     * 비밀번호 변경 설정 문자를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePwdConfirmWord(Map<String, Object> param) throws Exception;
    
    /**
     * 패스워드가 맞는지를 확인해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectUserPassExist(Map<String, Object> param) throws Exception;
    
    /**
     * 회원정보재동의 수정
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateAgreement(Map<String, Object> param) throws Exception;
    
    /**
     * 회원 탈퇴
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int userDropOut(Map<String, Object> param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public UserVO selectUserId(String param) throws Exception;
    
    
    /**
     * 로그인 이력 적재
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int insertLoginHistory(Map<String, Object> param) throws Exception;
    
    
    /**
     * 로그인 이력 조회
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectLoginHistoryList(Map<String, Object> param) throws Exception;
    
}
