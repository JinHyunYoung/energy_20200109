package kr.or.wabis.contents.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.contents.LogoDao;

@Service("logoService")
public class LogoServiceImpl implements LogoService {
    
    private Logger logger = Logger.getLogger(LogoServiceImpl.class);
    
    @Resource(name = "logoDao")
    protected LogoDao logoDao;
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectLogo(Map<String, Object> param) throws Exception {
        return logoDao.selectLogo(param);
    }
    
}
