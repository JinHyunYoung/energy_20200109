package kr.or.wabis.admin.contents.service;

import java.util.Map;

public interface LogoMtService {
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectLogo(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertLogo(Map<String, Object> param) throws Exception;
    
}
