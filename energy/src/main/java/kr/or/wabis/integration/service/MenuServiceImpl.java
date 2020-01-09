package kr.or.wabis.integration.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.integration.MenuDao;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
    
    private Logger logger = Logger.getLogger(MenuServiceImpl.class);
    
    @Resource(name = "menuDao")
    protected MenuDao menuDao;
        
    /**
     * 홈페이지 메뉴 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageMenuList(Map<String, Object> param) throws Exception {
        return menuDao.selectHomepageMenuList(param);
    }
    
    /**
     * 사용자단 메뉴를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectFrontMenu(Map<String, Object> param) throws Exception {
        return menuDao.selectFrontMenu(param);
    }
    
    /**
     * Navi 메뉴 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectNaviMenuList(Map<String, Object> param) throws Exception {
        return menuDao.selectNaviMenuList(param);
    }    
    

    /**
     * 사이트맵 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFrontSitemapList(Map<String, Object> param) throws Exception {
        return menuDao.selectFrontSitemapList(param);
    }
}
