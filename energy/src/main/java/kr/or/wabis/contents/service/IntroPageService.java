package kr.or.wabis.contents.service;

import java.util.Map;

public interface IntroPageService {
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectIntropage(Map<String, Object> param) throws Exception;
}
