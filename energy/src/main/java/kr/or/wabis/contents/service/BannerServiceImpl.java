package kr.or.wabis.contents.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.BannerDao;

@Service("bannerService")
public class BannerServiceImpl implements BannerService {
    
    private Logger logger = Logger.getLogger(BannerServiceImpl.class);
    
    @Resource(name = "bannerDao")
    protected BannerDao bannerDao;

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
     * 
     * @param param
     * @return
     * @throws Exception
     */
	@Override
	public Map<String, Object> selectBannerVideoList(Map<String, Object> param)
			throws Exception {
		 return bannerDao.selectBannerVideoList(param);
	}
}
