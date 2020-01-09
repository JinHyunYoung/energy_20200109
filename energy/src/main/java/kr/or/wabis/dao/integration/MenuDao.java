package kr.or.wabis.dao.integration;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("menuDao")
public class MenuDao extends AbstractDao {
    
    /**
     * 메뉴 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectMenuList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectMenuList", param);
    }
    
    /**
     * 메뉴 트리 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectMenuTreeList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectMenuTreeList", param);
    }
    
    /**
     * 홈페이지 메뉴 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectHomepageMenuList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectHomepageMenuList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectMenu(Map<String, Object> param) throws Exception {
        return selectOne("MenuDao.selectMenu", param);
    }
    
    /**
     * 사용자단 메뉴를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectFrontMenu(Map<String, Object> param) throws Exception {
        return selectOne("MenuDao.selectFrontMenu", param);
    }
    
    /**
     * 중복검사를 한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectMenuExist(Map<String, Object> param) throws Exception {
        return selectOne("MenuDao.selectMenuExist", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertMenu(Map<String, Object> param) throws Exception {
        return update("MenuDao.insertMenu", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateMenu(Map<String, Object> param) throws Exception {
        return update("MenuDao.updateMenu", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteMenu(Map<String, Object> param) throws Exception {
        update("MenuDao.deleteMenuReorder", param);
        return delete("MenuDao.deleteMenu", param);
    }
    
    /**
     * 메뉴 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateMenuReorder(Map<String, Object> param) throws Exception {
        List<Map<String, Object>> list = (List<Map<String, Object>>) param.get("menu_list");
        Map<String, Object> data = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            data.put("menu_id", list.get(i).get("menu_id"));
            data.put("sort", list.get(i).get("sort"));
            update("MenuDao.updateMenuSort", data);
        }
        
        return list.size();
    }
    
    /**
     * 관리자 메뉴 트리리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectManagerMenuTreeList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectManagerMenuTreeList", param);
    }
    
    /**
     * 권한에 메뉴를 매핑한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertAuthMenu(Map<String, Object> param) throws Exception {
        return update("MenuDao.insertAuthMenu", param);
    }
    
    /**
     * 권한의 메뉴를 삭제한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteAuthMenu(Map<String, Object> param) throws Exception {
        return update("MenuDao.deleteAuthMenu", param);
    }
    
    /**
     * 권한별 최상위 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthTopMenuList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectAuthTopMenuList", param);
    }
    
    /**
     * 권한별 서브 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthSubMenuList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectAuthSubMenuList", param);
    }
    
    /**
     * 메뉴 검색 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuSearchList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectMenuSearchList", param);
    }
    
    /**
     * 사이트맵 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectSitemapList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectSitemapList", param);
    }    
    
    /**
     * 사이트맵 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectFrontSitemapList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectFrontSitemapList", param);
    }
    
    /**
     * Navi 메뉴 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectNaviMenuList(Map<String, Object> param) throws Exception {
        return selectList("MenuDao.selectNaviMenuList", param);
    }
}
