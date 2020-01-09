package kr.or.wabis.admin.integration.service;

import java.util.List;
import java.util.Map;

public interface CodeMtService {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectCodegubunPageList(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectCodegubunList(Map<String, Object> param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCodegubun(Map<String, Object> param) throws Exception;
    
    /**
     * 중복 여부를 체크한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int selectCodegubunExist(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertCodegubun(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCodegubun(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteCodegubun(Map<String, Object> param) throws Exception;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectCodeList(Map<String, Object> param) throws Exception;
    
    /**
     * 코드구분의 코드 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCodeGubunCodeList(String param) throws Exception;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCode(Map<String, Object> param) throws Exception;
    
    /**
     * 중복 여부를 체크한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public int selectCodeExist(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertCode(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCode(Map<String, Object> param) throws Exception;
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteCode(Map<String, Object> param) throws Exception;
    
    /**
     * 코드 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCodeReorder(Map<String, Object> param) throws Exception;
}
