package kr.or.wabis.wbiz.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.support.OrganDao;
import kr.or.wabis.dao.wbiz.CategoryDao;

@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {
	
    private Logger logger = Logger.getLogger(CategoryServiceImpl.class);
    
    @Resource(name = "categoryDao")
    protected CategoryDao categoryDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectCategoryList(Map<String, Object> param) throws Exception {
        return categoryDao.categorySelectList(param);
    }    
    
    

}
