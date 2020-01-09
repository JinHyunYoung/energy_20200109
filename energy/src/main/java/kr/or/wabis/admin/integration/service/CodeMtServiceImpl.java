package kr.or.wabis.admin.integration.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.integration.CodeDao;

@Service("codeMtService")
public class CodeMtServiceImpl implements CodeMtService {
    
    private Logger logger = Logger.getLogger(CodeMtServiceImpl.class);
    
    @Resource(name = "codeDao")
    protected CodeDao codeDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectCodegubunPageList(Map<String, Object> param) throws Exception {
        return codeDao.selectCodegubunPageList(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectCodegubunList(Map<String, Object> param) throws Exception {
        return codeDao.selectCodegubunList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCodegubun(Map<String, Object> param) throws Exception {
        return codeDao.selectCodegubun(param);
    }
    
    /**
     * 중복여부를 검사한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    @Override
    public int selectCodegubunExist(Map<String, Object> param) throws Exception {
        return codeDao.selectCodegubunExist(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertCodegubun(Map<String, Object> param) throws Exception {
        return codeDao.insertCodegubun(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCodegubun(Map<String, Object> param) throws Exception {
        return codeDao.updateCodegubun(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteCodegubun(Map<String, Object> param) throws Exception {
        return codeDao.deleteCodegubun(param);
    }
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectCodeList(Map<String, Object> param) throws Exception {
        return codeDao.selectCodeList(param);
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
        return codeDao.selectCodeGubunCodeList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCode(Map<String, Object> param) throws Exception {
        return codeDao.selectCode(param);
    }
    
    /**
     * 중복여부를 검사한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    @Override
    public int selectCodeExist(Map<String, Object> param) throws Exception {
        return codeDao.selectCodeExist(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertCode(Map<String, Object> param) throws Exception {
        return codeDao.insertCode(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCode(Map<String, Object> param) throws Exception {
        return codeDao.updateCode(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteCode(Map<String, Object> param) throws Exception {
        return codeDao.deleteCode(param);
    }
    
    /**
     * 코드 순서조정 정보를 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateCodeReorder(Map<String, Object> param) throws Exception {
        return codeDao.updateCodeReorder(param);
    }
}
