package kr.or.wabis.admin.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.user.AuthDao;

@Service("authMtService")
public class AuthMtServiceImpl implements AuthMtService {
    
    private static final Logger logger = Logger.getLogger(AuthMtServiceImpl.class);
    
    @Resource(name = "authDao")
    protected AuthDao authDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthPageList(Map<String, Object> param) throws Exception {
        return authDao.selectAuthPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthList(Map<String, Object> param) throws Exception {
        return authDao.selectAuthList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectAuth(Map<String, Object> param) throws Exception {
        return authDao.selectAuth(param);
    }
    
    /**
     * 중복여부를 검사한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    @Override
    public int selectAuthExist(Map<String, Object> param) throws Exception {
        return authDao.selectAuthExist(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertAuth(Map<String, Object> param) throws Exception {
        return authDao.insertAuth(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateAuth(Map<String, Object> param) throws Exception {
        return authDao.updateAuth(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteAuth(Map<String, Object> param) throws Exception {
        return authDao.deleteAuth(param);
    }
    
    /**
     * 권한별 관리자 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> managerAuthPageList(Map<String, Object> param) throws Exception {
        return authDao.managerAuthPageList(param);
    }
    
    /**
     * 관리자 권한 매핑 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertManagerAuth(Map<String, Object> param) throws Exception {
        
        int rt = 0;
        ArrayList list = (ArrayList) param.get("user_list");
        
        Map<String, Object> data = new HashMap();
        data.put("auth_id", param.get("auth_id"));
        data.put("s_user_no", param.get("s_user_no"));
        
        for (int i = 0; i < list.size(); i++) {
            data.put("user_no", list.get(i));
            authDao.insertManagerAuth(data);
            rt++;
        }
        return rt;
    }
    
    /**
     * 관리자 권한 매핑 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteManagerAuth(Map<String, Object> param) throws Exception {
        
        int rt = 0;
        ArrayList list = (ArrayList) param.get("user_list");
        
        Map<String, Object> data = new HashMap();
        data.put("auth_id", param.get("auth_id"));
        data.put("s_user_no", param.get("s_user_no"));
        
        for (int i = 0; i < list.size(); i++) {
            data.put("user_no", list.get(i));
            authDao.deleteManagerAuth(data);
            rt++;
        }
        
        return rt;
    }
    
}
