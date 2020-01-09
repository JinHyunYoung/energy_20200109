package kr.or.wabis.admin.contents.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.InfoPageDao;

@Service("infoPageMtService")
public class InfoPageMtServiceImpl implements InfoPageMtService {
    
    private Logger logger = Logger.getLogger(InfoPageMtServiceImpl.class);
    
    @Resource(name = "infoPageDao")
    protected InfoPageDao infoPageDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectInfopagePageList(Map<String, Object> param) throws Exception {
        return infoPageDao.selectInfopagePageList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectInfopage(Map<String, Object> param) throws Exception {
        return infoPageDao.selectInfopage(param);
    }
    
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertInfopage(Map<String, Object> param) throws Exception {
        return infoPageDao.insertInfopage(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateInfopage(Map<String, Object> param) throws Exception {
        return infoPageDao.updateInfopage(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteInfopage(Map<String, Object> param) throws Exception {
        return infoPageDao.deleteInfopage(param);
    }
}
