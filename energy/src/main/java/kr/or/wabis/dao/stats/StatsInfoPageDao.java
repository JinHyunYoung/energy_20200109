package kr.or.wabis.dao.stats;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;
import kr.or.wabis.framework.util.StringUtil;

@Repository("statsInfoPageDao")
public class StatsInfoPageDao extends AbstractDao {
    
    /**
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectInfopagePageList(Map<String, Object> param) throws Exception {
        return selectPageList("StatsInfoPageDao.selectStatsInfopagePageList", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectInfopage(Map<String, Object> param) throws Exception {
        return selectOne("StatsInfoPageDao.selectStatsInfopage", param);
    }
    
    /**
     * 선택된 행의 값을 가지고 온다
     * 
     * @param param
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectInfopageShow(Map<String, Object> param) throws Exception {
        return selectOne("StatsInfoPageDao.selectStatsInfopageShow", param);
    }
            
    
    /**
     * 값을 입력한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int insertInfopage(Map<String, Object> param) throws Exception {
        return update("StatsInfoPageDao.insertStatsInfopage", param);
    }
    
    /**
     * 값을 수정한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int updateInfopage(Map<String, Object> param) throws Exception {
        return update("StatsInfoPageDao.updateStatsInfopage", param);
    }
    
    /**
     * 값을 삭제한다
     * 
     * @param param
     * @return int
     * @throws Exception
     */
    public int deleteInfopage(Map<String, Object> param) throws Exception {
        return delete("StatsInfoPageDao.deleteStatsInfopage", param);
    }

    /**
     * 코드 테이블을 조회한다. 
     * @param param
     * @return
     * @throws Exception
     */
    public  List<Map<String, Object>> selectCodeGubunCodeList(Map<String, Object> param) throws Exception {
    	String codeType=StringUtil.nvl(param.get("type"));
    	
    	if (codeType.equals("STATS_INFO_M_CD_MINUS")) { //
            return selectList("StatsInfoPageDao.selectStatsInfoMCodes", param);
    		
    	} else {
            return selectList("StatsInfoPageDao.selectCodeGubunCodeList", param);
    	}
    }
    
    /**
     * 통계 데이터 업로드 이력을 조회한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public List<Map<String, Object>> selectListExcelUpload(Map<String, Object> param) throws Exception {
        return selectList("StatsReportDao.selectListExcelUpload", param);
    }
 
}
