package kr.or.wabis.integration.service;

import java.util.List;
import java.util.Map;

public interface MenuService {
    
    /**
     * 홈페이지 메뉴 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageMenuList(Map<String, Object> param) throws Exception;
    
    /**
     * 사용자단 메뉴를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectFrontMenu(Map<String, Object> param) throws Exception;
    
    /**
     * Navi 메뉴 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectNaviMenuList(Map<String, Object> param) throws Exception;
    
    /**
     * 사이트맵 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFrontSitemapList(Map<String, Object> param) throws Exception;
}
