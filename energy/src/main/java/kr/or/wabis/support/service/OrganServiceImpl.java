package kr.or.wabis.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.OrganDao;

@Service("organService")
public class OrganServiceImpl implements OrganService {
	
    private Logger logger = Logger.getLogger(OrganServiceImpl.class);
    
    @Resource(name = "organDao")
    protected OrganDao organDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectOrganPageList(Map<String, Object> param) throws Exception {
        return organDao.selectOrganPageList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectOrgan(Map<String, Object> param) throws Exception {
        return organDao.selectOrgan(param);
    }    
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMainOrganList(Map<String, Object> param) throws Exception {
        return organDao.selectMainOrganList(param);
    }
    

}
