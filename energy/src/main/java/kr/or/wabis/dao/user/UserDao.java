package kr.or.wabis.dao.user;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.user.vo.UserVO;

@Repository("userDao")
public class UserDao extends AbstractDao {
        
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectUserPageList(Map<String, Object> param) throws Exception {
        return selectPageList("UserDao.selectUserPageList", param);
    }
    
    /**
     * 검색 사용자 페이지리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserSearchPageList(Map<String, Object> param) throws Exception {
        return selectPageList("UserDao.selectUserSearchPageList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectUserList(Map<String, Object> param) throws Exception {
        return selectList("UserDao.selectUserList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public UserVO selectUserLogin(String param) throws Exception {
        return selectOne("UserDao.selectUserLogin", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public UserVO selectUserId(String param) throws Exception {
        return selectOne("UserDao.selectUserId", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectUser(Map<String, Object> param) throws Exception {
        return selectOne("UserDao.selectUser", param);
    }
    
    /**
     * 중복검사를 한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectUserExist(Map<String, Object> param) throws Exception {
        return selectOne("UserDao.selectUserExist", param);
    }
    
    /**
     * 사용자 가입을 처리해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertUserRegist(Map<String, Object> param) throws Exception {
        int rt = update("UserDao.insertUser", param);
        if (rt > 0) {
            if (StringUtil.nvl(param.get("user_gb"), "N").equals("N"))
                param.put("hist_msg", "사용자를 등록하였습니다.");
            else
                param.put("hist_msg", "관리자를 등록하였습니다.");
            
            // insert("UserDao.insertUserModHistory", param);
        }
        return rt;
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertUser(Map<String, Object> param) throws Exception {
        int rt = update("UserDao.insertUser", param);
        if (rt > 0) {
            if (StringUtil.nvl(param.get("user_gb"), "N").equals("N"))
                param.put("hist_msg", "사용자를 등록하였습니다.");
            else
                param.put("hist_msg", "관리자를 등록하였습니다.");
            
            // insert("UserDao.insertUserModHistory", param);
        }
        return rt;
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateUser(Map<String, Object> param) throws Exception {
        int rt = update("UserDao.updateUser", param);
        if (rt > 0) {
            if (StringUtil.nvl(param.get("user_gb"), "N").equals("N"))
                param.put("hist_msg", "사용자를 수정 하였습니다.");
            else
                param.put("hist_msg", "관리자를 수정 하였습니다.");
            
            // insert("UserDao.insertUserModHistory", param);
        }
        return rt;
    }
    
    /**
     * 내 정보를 수정해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateUserModify(Map<String, Object> param) throws Exception {
        int rt = update("UserDao.updateUser", param);
        if (rt > 0) {
            if (StringUtil.nvl(param.get("user_gb"), "N").equals("N"))
                param.put("hist_msg", "사용자를 수정 하였습니다.");
            else
                param.put("hist_msg", "관리자를 수정 하였습니다.");
            
            // insert("UserDao.insertUserModHistory", param);
        }
        return rt;
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteUser(Map<String, Object> param) throws Exception {
        return delete("UserDao.deleteUser", param);
    }
    
    /**
     * 성명과 이메일이 맞는지를 확인해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectUserEmailExist(Map<String, Object> param) throws Exception {
        return selectOne("UserDao.selectUserEmailExist", param);
    }
    
    /**
     * 패스워드가 맞는지를 확인해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectUserPassExist(Map<String, Object> param) throws Exception {
        return selectOne("UserDao.selectUserPassExist", param);
    }
    
    /**
     * 비밀번호 변경 설정 문자를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePwdConfirmWord(Map<String, Object> param) throws Exception {
        return update("UserDao.updatePwdConfirmWord", param);
    }
    
    /**
     * 비밀번호 변경 설정 문자를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePasswordChange(Map<String, Object> param) throws Exception {
        return update("UserDao.updatePasswordChange", param);
    }
    
    /**
     * 권한 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception {
        return selectList("UserDao.selectAuthList", param);
    }
    
    /**
     * 관리자 권한 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectManagerAuthList(Map<String, Object> param) throws Exception {
        return selectList("UserDao.selectManagerAuthList", param);
    }
    
    /**
     * 매니저 권한을 등록해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertAdminAuth(Map<String, Object> param) throws Exception {
        return update("UserDao.insertAdminAuth", param);
    }
    
    /**
     * 매너지 권한을 삭제해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteAdminAuth(Map<String, Object> param) throws Exception {
        return update("UserDao.deleteAdminAuth", param);
    }
    
    /**
     * 권한별 관리자 페이지 리스트
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserAuthPageList(Map<String, Object> param) throws Exception {
        return selectPageList("UserDao.selectUserAuthPageList", param);
    }
    
    /**
     * 회원정보재동의 수정
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateAgreement(Map<String, Object> param) throws Exception {
        return update("UserDao.updateAgreement", param);
    }
    
    /**
     * 회원 탈퇴
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int userDropOut(Map<String, Object> param) throws Exception {
        return update("UserDao.userDropOut", param);
    }
        
    /**
     * 재 동의 및 탈퇴 사용자 목록
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectReAgreeUserList(Map<String, Object> param) throws Exception {
        return selectPageList("UserDao.selectReAgreeUserList", param);
    }
    
    /**
     * 성명과 핸드폰이 맞는지를 확인해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectUserPhoneExist(Map<String, Object> param) throws Exception {
        return selectOne("UserDao.selectUserPhoneExist", param);
    }
    
    /**
     * 아아디, 성명과 핸드폰이 맞는지를 확인해준다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectUserIdPhoneExist(Map<String, Object> param) throws Exception {
        return selectOne("UserDao.selectUserIdPhoneExist", param);
    }
        
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectUserAgreeList(Map<String, Object> param) throws Exception {
        return selectList("UserDao.selectReAgreeUserList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectUserLoginList(Map<String, Object> param) throws Exception {
        return selectList("UserDao.selectUserLoginList", param);
    }
    
    /**
     * 
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void userAutoDropOut() throws Exception {
        update("UserDao.userAutoDropOut");
    }
    
    /**
     * 
     * @param param
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void userAutoDropOut2(Map<String, Object> param) throws Exception {
        update("UserDao.userDropOut", param);
    }

	public void initErrorLoginCount(String userId)  throws Exception {
		update("UserDao.initErrorLoginCount", userId);
	}

	public void updateErrorLoginCount(String userId) throws Exception {
		update("UserDao.updateErrorLoginCount", userId);
	}
	
	/**
	 * 로그인 이력 적재
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertLoginHistory(Map<String, Object> param) throws Exception {
		return insert("UserDao.insertLoginHistory", param);
	}
	
	/**
	 * 로그인 이력 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectLoginHistoryList(Map<String, Object> param) throws Exception {
        return selectList("UserDao.selectLoginHistoryList", param);
    }
}