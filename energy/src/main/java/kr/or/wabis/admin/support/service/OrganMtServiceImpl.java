package kr.or.wabis.admin.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.OrganDao;

@Service("organMtService")
public class OrganMtServiceImpl implements OrganMtService {
	
    private Logger logger = Logger.getLogger(OrganMtServiceImpl.class);
    
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
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertOrgan(Map<String, Object> param) throws Exception {
        return organDao.insertOrgan(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateOrgan(Map<String, Object> param) throws Exception {
        return organDao.updateOrgan(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteOrgan(Map<String, Object> param) throws Exception {
        return organDao.deleteOrgan(param);
    }
    
    /**
     * 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateOrganReorder(List<Map<String, Object>> list) throws Exception {
        return organDao.updateOrganReorder(list);
    }

}
