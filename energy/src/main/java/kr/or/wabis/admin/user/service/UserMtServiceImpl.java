package kr.or.wabis.admin.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.user.UserDao;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.StringUtil;

@Service("userMtService")
public class UserMtServiceImpl implements UserMtService {
    
    private Logger logger = Logger.getLogger(UserMtServiceImpl.class);
    
    @Resource(name = "userDao")
    protected UserDao userDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserPageList(Map<String, Object> param) throws Exception {
        return userDao.selectUserPageList(param);
    }
    
    /**
     * 권한 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception {
        return userDao.selectAuthList(param);
    }
    
    /**
     * 검색 사용자 페이지리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserSearchPageList(Map<String, Object> param) throws Exception {
        return userDao.selectUserSearchPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserList(Map<String, Object> param) throws Exception {
        return userDao.selectUserList(param);
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
     * 관리자 권한 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectManagerAuthList(Map<String, Object> param) throws Exception {
        return userDao.selectManagerAuthList(param);
    }
    
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
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertUser(Map<String, Object> param) throws Exception {
        
        int rt = userDao.insertUser(param);
        ArrayList authList = (ArrayList) param.get("manager_auth");
        
        Map<String, Object> auth = new HashMap();
        auth.put("user_no", param.get("user_no"));
        auth.put("s_user_no", param.get("s_user_no"));
        
        userDao.deleteAdminAuth(auth);
        
        if (authList != null && authList.size() > 0) {
            for (int i = 0; i < authList.size(); i++) {
                auth.put("auth_id", authList.get(i));
                userDao.insertAdminAuth(auth);
            }
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
        
        // 사용자 등록
        int rt = userDao.updateUser(param);
        ArrayList authList = (ArrayList) param.get("manager_auth");
        
        Map<String, Object> auth = new HashMap();
        auth.put("user_no", param.get("user_no"));
        auth.put("s_user_no", param.get("s_user_no"));
        
        // 사용자 관리자 권한 삭제
        userDao.deleteAdminAuth(auth);
        
        // 사용자 관리자 권한 등록
        if (authList != null && authList.size() > 0)
            for (int i = 0; i < authList.size(); i++) {
                auth.put("auth_id", authList.get(i));
                userDao.insertAdminAuth(auth);
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
        return userDao.deleteUser(param);
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
     * 권한별 관리자 페이지 리스트
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectUserAuthPageList(Map<String, Object> param) throws Exception {
        return userDao.selectUserAuthPageList(param);
    }
}
