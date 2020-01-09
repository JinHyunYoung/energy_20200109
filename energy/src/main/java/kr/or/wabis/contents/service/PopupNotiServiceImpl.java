package kr.or.wabis.contents.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.PopupNotiDao;

@Service("popupNotiService")
public class PopupNotiServiceImpl implements PopupNotiService {
    
    private Logger logger = Logger.getLogger(PopupNotiServiceImpl.class);
    
    @Resource(name = "popupNotiDao")
    protected PopupNotiDao popupNotiDao;
    
    /**
     * 메인페이지 팝업 리스트
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMainPopnotiList(Map<String, Object> param) throws Exception {
        return popupNotiDao.selectMainPopnotiList(param);
    }
}
