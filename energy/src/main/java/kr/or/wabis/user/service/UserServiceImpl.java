package kr.or.wabis.user.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.stats.StatsDao;
import kr.or.wabis.dao.user.UserDao;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.user.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {
    
    private Logger logger = Logger.getLogger(UserServiceImpl.class);
    
    @Resource(name = "userDao")
    protected UserDao userDao;
    
    @Resource(name = "statsDao")
    protected StatsDao statsDao;
    
    /**
     * 중복여부를 검사한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    @Override
    public int selectUserExist(Map<String, Object> param) throws Exception {
        return userDao.selectUserExist(param);
    }
    
    /**
     * 사용자 가입을 처리해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertUserRegist(Map<String, Object> param) throws Exception {
        return userDao.insertUserRegist(param);
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
        
        Map<String, Object> map = userDao.selectUser(param);
        
        if (map.get("user_mobile") != null) {
            map.put("user_mobile", CryptoUtil.AES_Decode(StringUtil.nvl(map.get("user_mobile"))));
        }
        
        if (map.get("user_email") != null) {
            map.put("user_email", CryptoUtil.AES_Decode(StringUtil.nvl(map.get("user_email"))));
        }
        
        if (map.get("user_tel") != null) {
            map.put("user_tel", CryptoUtil.AES_Decode(StringUtil.nvl(map.get("user_tel"))));
        }
        
        return map;
    }
    
    /**
     * 성명과 핸드폰이 맞는지를 확인해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public Map<String, Object> selectUserPhoneExist(Map<String, Object> param) throws Exception {
        return userDao.selectUserPhoneExist(param);
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
        return userDao.selectUserIdPhoneExist(param);
    }
    
    /**
     * 비밀번호 변경 설정 문자를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePasswordChange(Map<String, Object> param) throws Exception {
        return userDao.updatePasswordChange(param);
    }
    
    /**
     * 내 정보를 수정해준다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateUserModify(Map<String, Object> param) throws Exception {
        if (!StringUtil.nvl(param.get("user_mobile")).equals("")) {
            param.put("user_mobile", CryptoUtil.AES_Encode(StringUtil.nvl(param.get("user_mobile"))));
        }
        if (!StringUtil.nvl(param.get("user_email")).equals("")) {
            param.put("user_email", CryptoUtil.AES_Encode(StringUtil.nvl(param.get("user_email"))));
        }
        if (!StringUtil.nvl(param.get("user_tel")).equals("")) {
            param.put("user_tel", CryptoUtil.AES_Encode((String) param.get("user_tel")));
        }
        
        return userDao.updateUserModify(param);
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
        return userDao.selectUserEmailExist(param);
    }
    
    /**
     * 비밀번호 변경 설정 문자를 저장한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePwdConfirmWord(Map<String, Object> param) throws Exception {
        return userDao.updatePwdConfirmWord(param);
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
        return userDao.selectUserPassExist(param);
    }
    
    /**
     * 회원정보재동의 수정
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateAgreement(Map<String, Object> param) throws Exception {
        return userDao.updateAgreement(param);
    }
    
    /**
     * 회원 탈퇴
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int userDropOut(Map<String, Object> param) throws Exception {
        return userDao.userDropOut(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public UserVO selectUserId(String param) throws Exception {
        return userDao.selectUserId(param);
    }   
    
    /**
     * 로그인 이력 적재
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertLoginHistory(Map<String, Object> param) throws Exception {
    	return userDao.insertLoginHistory(param);
    }
    
    /**
     * 로그인 이력 조회
     * 
     * @param param
     * @return 
     * @throws Exception
     */
    public List<Map<String, Object>> selectLoginHistoryList(Map<String, Object> param) throws Exception {
    	return userDao.selectLoginHistoryList(param);
    }
    
}
