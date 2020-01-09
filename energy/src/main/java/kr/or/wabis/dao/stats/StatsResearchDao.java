package kr.or.wabis.dao.stats;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;
import kr.or.wabis.framework.util.StringUtil;

@Repository("statsResearchDao")
public class StatsResearchDao extends AbstractDao {
    

 
    public List<Map<String, Object>> selectResearchCodeList(Map<String, Object> param) throws Exception {
        return selectList("StatsResearchDao.selectResearchCodeList", param);
    }

    public List<Map<String, Object>> selectResearchItemTreeList(Map<String, Object> param) throws Exception {
        return selectList("StatsResearchDao.selectResearchBizTypeItemTree", param);
    }

    public List<Map<String, Object>> selectResearchTableList(Map<String, Object> param) throws Exception {
        return selectList("StatsResearchDao.selectResearchTableList", param);
    }

    public List<Map<String, Object>> selectResearchTableHeader(Map<String, Object> param) throws Exception {
        return selectList("StatsResearchDao.selectResearchTableHeader", param);
    }
}