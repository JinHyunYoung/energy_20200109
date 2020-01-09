package kr.or.wabis.admin.contents.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.PopupNotiDao;

@Service("popupNotiMtService")
public class PopupNotiMtServiceImpl implements PopupNotiMtService {
    
    private Logger logger = Logger.getLogger(PopupNotiMtServiceImpl.class);
    
    @Resource(name = "popupNotiDao")
    protected PopupNotiDao popupNotiDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectPopnotiPageList(Map<String, Object> param) throws Exception {
        return popupNotiDao.selectPopnotiPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectPopnotiList(Map<String, Object> param) throws Exception {
        return popupNotiDao.selectPopnotiList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectPopnoti(Map<String, Object> param) throws Exception {
        return popupNotiDao.selectPopnoti(param);
    }
    
    /**
     * 중복여부를 검사한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    @Override
    public int selectPopnotiExist(Map<String, Object> param) throws Exception {
        return popupNotiDao.selectPopnotiExist(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertPopnoti(Map<String, Object> param) throws Exception {
        return popupNotiDao.insertPopnoti(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updatePopnoti(Map<String, Object> param) throws Exception {
        return popupNotiDao.updatePopnoti(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deletePopnoti(Map<String, Object> param) throws Exception {
        return popupNotiDao.deletePopnoti(param);
    }
}
