package kr.or.wabis.admin.contents.service;

import java.util.List;
import java.util.Map;

public interface BannerMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBannerPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectBannerList(Map<String, Object> param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBanner(Map<String, Object> param) throws Exception;
    
    /**
     * 중복 여부를 체크한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int selectBannerExist(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertBanner(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBanner(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteBanner(Map<String, Object> param) throws Exception;
    
    /**
     * banner 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateBannerReorder(Map<String, Object> param) throws Exception;
    
}
