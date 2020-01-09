package kr.or.wabis.contents.service;

import java.util.List;
import java.util.Map;

public interface PopupNotiService {
    
    /**
     * 메인페이지 팝업 리스트
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMainPopnotiList(Map<String, Object> param) throws Exception;
    
}
