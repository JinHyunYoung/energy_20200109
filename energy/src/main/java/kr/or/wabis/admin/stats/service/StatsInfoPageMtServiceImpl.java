package kr.or.wabis.admin.stats.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import kr.or.wabis.dao.stats.StatsInfoPageDao;


@Service("statsInfoPageMtService")
public class StatsInfoPageMtServiceImpl implements StatsInfoPageMtService {
    
    private Logger logger = Logger.getLogger(StatsInfoPageMtServiceImpl.class);
    
    @Resource(name = "statsInfoPageDao")
    protected StatsInfoPageDao statsInfoPageDao;
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectStatsInfopagePageList(Map<String, Object> param) throws Exception {
        return statsInfoPageDao.selectInfopagePageList(param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectStatsInfopage(Map<String, Object> param) throws Exception {
        return statsInfoPageDao.selectInfopage(param);
    }
    
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertStatsInfopage(Map<String, Object> param) throws Exception {
        return statsInfoPageDao.insertInfopage(param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateStatsInfopage(Map<String, Object> param) throws Exception {
        return statsInfoPageDao.updateInfopage(param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteStatsInfopage(Map<String, Object> param) throws Exception {
        return statsInfoPageDao.deleteInfopage(param);
    }
    
    /**
     * 통계 해설 관련 대분류, 중분류 코드 리스트를 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>>  selectStatsInfoCode(Map<String, Object> param) throws Exception {
        return statsInfoPageDao.selectCodeGubunCodeList(param);
    }

    /**
     * 등록된 통계의 연도별 내역을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>>  selectListExcelUpload(Map<String, Object> param) throws Exception {
        return statsInfoPageDao.selectListExcelUpload(param);
    }

}
