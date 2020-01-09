package kr.or.wabis.dao.contents;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("bannerDao")
public class BannerDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectBannerPageList(Map<String, Object> param) throws Exception {
        return selectPageList("BannerDao.selectBannerPageList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectBannerList(Map<String, Object> param) throws Exception {
        return selectList("BannerDao.selectBannerList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectBanner(Map<String, Object> param) throws Exception {
        return selectOne("BannerDao.selectBanner", param);
    }
    
    /**
     * 중복검사를 한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectBannerExist(Map<String, Object> param) throws Exception {
        return selectOne("BannerDao.selectBannerExist", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBanner(Map<String, Object> param) throws Exception {
        return update("BannerDao.insertBanner", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBanner(Map<String, Object> param) throws Exception {
        return update("BannerDao.updateBanner", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBanner(Map<String, Object> param) throws Exception {
        update("BannerDao.deleteBannerReorder", param);
        return delete("BannerDao.deleteBanner", param);
    }
    
    /**
     * banner 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBannerReorder(Map<String, Object> param) throws Exception {
        List<Map<String, Object>> list = (List<Map<String, Object>>) param.get("banner_list");
        Map<String, Object> data = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            data.put("banner_id", list.get(i).get("banner_id"));
            data.put("sort", list.get(i).get("sort"));
            update("BannerDao.updateBannerSort", data);
        }
        
        return list.size();
    }
    
    /**
     * banner video 목록 조회
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectBannerVideoList(Map<String, Object> param) throws Exception {
        return selectOne("BannerDao.selectBannerVideoList", param);
    }    
    
}
