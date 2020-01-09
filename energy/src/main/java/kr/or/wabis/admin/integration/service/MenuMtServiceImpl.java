package kr.or.wabis.admin.integration.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.integration.MenuDao;

@Service("menuMtService")
public class MenuMtServiceImpl implements MenuMtService {
    
    private Logger logger = Logger.getLogger(MenuMtServiceImpl.class);
    
    @Resource(name = "menuDao")
    protected MenuDao menuDao;
    
    /**
     * 메뉴리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuList(Map<String, Object> param) throws Exception {
        return menuDao.selectMenuList(param);
    }
    
    /**
     * 메뉴 트리리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuTreeList(Map<String, Object> param) throws Exception {
        return menuDao.selectMenuTreeList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectMenu(Map<String, Object> param) throws Exception {
        return menuDao.selectMenu(param);
    }
    
    /**
     * 중복여부를 검사한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    @Override
    public int selectMenuExist(Map<String, Object> param) throws Exception {
        return menuDao.selectMenuExist(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertMenu(Map<String, Object> param) throws Exception {
        return menuDao.insertMenu(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateMenu(Map<String, Object> param) throws Exception {
        return menuDao.updateMenu(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteMenu(Map<String, Object> param) throws Exception {
        return menuDao.deleteMenu(param);
    }
    
    /**
     * 메뉴 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateMenuReorder(Map<String, Object> param) throws Exception {
        return menuDao.updateMenuReorder(param);
    }
    
    /**
     * 관리자 메뉴 트리리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectManagerMenuTreeList(Map<String, Object> param) throws Exception {
        return menuDao.selectManagerMenuTreeList(param);
    }
    
    /**
     * 권한에 메뉴를 매핑한다.
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertAuthMenu(Map<String, Object> param) throws Exception {
        int rt = 0;
        menuDao.deleteAuthMenu(param);
        ArrayList list = (ArrayList) param.get("menu_list");
        Map<String, Object> data = new HashMap();
        data.put("auth_id", param.get("auth_id"));
        data.put("s_user_no", param.get("s_user_no"));
        for (int i = 0; i < list.size(); i++) {
            data.put("menu_id", list.get(i));
            menuDao.insertAuthMenu(data);
            rt++;
        }
        return rt;
    }
    
    /**
     * 권한별 최상위 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthTopMenuList(Map<String, Object> param) throws Exception {
        return menuDao.selectAuthTopMenuList(param);
    }
    
    /**
     * 권한별 서브 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectAuthSubMenuList(Map<String, Object> param) throws Exception {
        return menuDao.selectAuthSubMenuList(param);
    }
    
    /**
     * 메뉴 검색 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMenuSearchList(Map<String, Object> param) throws Exception {
        return menuDao.selectMenuSearchList(param);
    }
    
    /**
     * 사이트맵 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectSitemapList(Map<String, Object> param) throws Exception {
    	ArrayList<Map<String, Object>> mapList = (ArrayList<Map<String, Object>>)menuDao.selectSitemapList(param);
//    	Collections.sort(mapList, new Comparator<Map<String, Object>>() {
//			@Override
//    	    public int compare(Map<String, Object> m1, Map<String, Object> m2) {
//				System.out.println(m2.get("lvl").toString() + " : " + m1.get("lvl").toString());
//    	    	if(!m1.get("lvl").toString().equals(m2.get("lvl").toString())) {
//    	    		return Integer.valueOf(m1.get("lvl").toString()).compareTo(Integer.valueOf(m2.get("lvl").toString()));
//    	    	}
//				System.out.println(m2.get("sort").toString() + " : " + m1.get("sort").toString());
//    	        return Integer.valueOf(m2.get("sort").toString()).compareTo(Integer.valueOf(m1.get("sort").toString()));
//    	     }
//    	});
    	
        return mapList;
    }
}
