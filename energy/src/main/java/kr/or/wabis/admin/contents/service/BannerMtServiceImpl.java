package kr.or.wabis.admin.contents.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.BannerDao;

@Service("bannerMtService")
public class BannerMtServiceImpl implements BannerMtService {
    
    private Logger logger = Logger.getLogger(BannerMtServiceImpl.class);
    
    @Resource(name = "bannerDao")
    protected BannerDao bannerDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBannerPageList(Map<String, Object> param) throws Exception {
        return bannerDao.selectBannerPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBannerList(Map<String, Object> param) throws Exception {
        return bannerDao.selectBannerList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBanner(Map<String, Object> param) throws Exception {
        return bannerDao.selectBanner(param);
    }
    
    /**
     * 중복여부를 검사한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    @Override
    public int selectBannerExist(Map<String, Object> param) throws Exception {
        return bannerDao.selectBannerExist(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBanner(Map<String, Object> param) throws Exception {
        return bannerDao.insertBanner(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBanner(Map<String, Object> param) throws Exception {
        return bannerDao.updateBanner(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBanner(Map<String, Object> param) throws Exception {
        return bannerDao.deleteBanner(param);
    }
    
    /**
     * banner 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBannerReorder(Map<String, Object> param) throws Exception {
        return bannerDao.updateBannerReorder(param);
    }
}
