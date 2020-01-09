package kr.or.wabis.contents.service;

import java.util.List;
import java.util.Map;

public interface BannerService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBannerList(Map<String, Object> param) throws Exception;
    
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBannerVideoList(Map<String, Object> param) throws Exception;
    
}
