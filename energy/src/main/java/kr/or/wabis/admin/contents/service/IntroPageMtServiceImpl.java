package kr.or.wabis.admin.contents.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.IntroPageDao;

@Service("introPageMtService")
public class IntroPageMtServiceImpl implements IntroPageMtService {
    
    private Logger logger = Logger.getLogger(IntroPageMtServiceImpl.class);
    
    @Resource(name = "introPageDao")
    protected IntroPageDao introPageDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectIntropagePageList(Map<String, Object> param) throws Exception {
        return introPageDao.selectIntropagePageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectIntropageList(Map<String, Object> param) throws Exception {
        return introPageDao.selectIntropageList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectIntropage(Map<String, Object> param) throws Exception {
        return introPageDao.selectIntropage(param);
    }
    
    /**
     * 중복여부를 검사한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    @Override
    public int selectIntropageExist(Map<String, Object> param) throws Exception {
        return introPageDao.selectIntropageExist(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertIntropage(Map<String, Object> param) throws Exception {
        return introPageDao.insertIntropage(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateIntropage(Map<String, Object> param) throws Exception {
        return introPageDao.updateIntropage(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteIntropage(Map<String, Object> param) throws Exception {
        return introPageDao.deleteIntropage(param);
    }
    
    /**
     * group id 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateGroupId(Map<String, Object> param) throws Exception {
        return introPageDao.updateGroupId(param);
    }
}
