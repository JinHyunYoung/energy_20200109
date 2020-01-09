package kr.or.wabis.admin.support.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.DictionaryDao;


@Service("dictionaryMtService")
public class DictionaryMtServiceImpl implements DictionaryMtService {
	
    private Logger logger = Logger.getLogger(DictionaryMtServiceImpl.class);
    
    @Resource(name = "dictionaryDao")
    protected DictionaryDao dictionaryDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectDictionaryPageList(Map<String, Object> param) throws Exception {
        return dictionaryDao.selectDictionaryPageList(param);
    }
        
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectDictionary(Map<String, Object> param) throws Exception {
        return dictionaryDao.selectDictionary(param);
    }
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertDictionary(Map<String, Object> param) throws Exception {
        return dictionaryDao.insertDictionary(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateDictionary(Map<String, Object> param) throws Exception {
        return dictionaryDao.updateDictionary(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteDictionary(Map<String, Object> param) throws Exception {
        return dictionaryDao.deleteDictionary(param);
    }
    


}
