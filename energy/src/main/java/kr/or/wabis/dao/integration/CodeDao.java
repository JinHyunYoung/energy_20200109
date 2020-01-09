package kr.or.wabis.dao.integration;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;

@Repository("codeDao")
public class CodeDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCodegubunPageList(Map<String, Object> param) throws Exception {
        return selectPageList("CodeDao.selectCodegubunPageList", param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCodegubunList(Map<String, Object> param) throws Exception {
        return selectList("CodeDao.selectCodegubunList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectCodegubun(Map<String, Object> param) throws Exception {
        return selectOne("CodeDao.selectCodegubun", param);
    }
    
    /**
     * 중복검사를 한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectCodegubunExist(Map<String, Object> param) throws Exception {
        return selectOne("CodeDao.selectCodegubunExist", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertCodegubun(Map<String, Object> param) throws Exception {
        return update("CodeDao.insertCodegubun", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCodegubun(Map<String, Object> param) throws Exception {
        return update("CodeDao.updateCodegubun", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteCodegubun(Map<String, Object> param) throws Exception {
        delete("CodeDao.deleteCodeAll", param);
        int retVal = delete("CodeDao.deleteCodegubun", param);
        return retVal;
    }
    
    /**
     * 코드리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCodeList(Map<String, Object> param) throws Exception {
        return selectList("CodeDao.selectCodeList", param);
    }
    
    /**
     * 코드구분의 코드 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCodeGubunCodeList(String param) throws Exception {
        return selectList("CodeDao.selectCodeGubunCodeList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectCode(Map<String, Object> param) throws Exception {
        return selectOne("CodeDao.selectCode", param);
    }
    
    /**
     * 중복검사를 한다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int selectCodeExist(Map<String, Object> param) throws Exception {
        return selectOne("CodeDao.selectCodeExist", param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertCode(Map<String, Object> param) throws Exception {
        return update("CodeDao.insertCode", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCode(Map<String, Object> param) throws Exception {
        return update("CodeDao.updateCode", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteCode(Map<String, Object> param) throws Exception {
        update("CodeDao.deleteCodeReorder", param);
        delete("CodeDao.deleteCode", param);
        return 1;
    }
    
    /**
     * 코드 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCodeReorder(Map<String, Object> param) throws Exception {
        List<Map<String, Object>> list = (List<Map<String, Object>>) param.get("code_list");
        Map<String, Object> data = new HashMap();
        data.put("gubun", param.get("gubun"));
        for (int i = 0; i < list.size(); i++) {
            data.put("code", list.get(i).get("code"));
            data.put("sort", list.get(i).get("sort"));
            update("CodeDao.updateCodeSeq", data);
        }
        
        return list.size();
    }
}
