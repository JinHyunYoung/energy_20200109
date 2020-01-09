package kr.or.wabis.dao.stats;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.wabis.framework.dao.AbstractDao;
import kr.or.wabis.framework.util.StringUtil;

@Repository("statsReportDao")
public class StatsReportDao extends AbstractDao {
    

    public List<Map<String, Object>> statisticsReportData(Map<String, Object> param) throws Exception {
        return selectList("StatsReportDao.statisticsReportData", param);
    }

    /**
     * 업종별 통계
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectIndustryGraph(Map<String, Object> param) throws Exception {
    	String type = StringUtil.nvl(param.get("type"));
    	
    	List<Map<String, Object>> list=null;
    	if (type=="industry"){
    		list =selectList("StatsReportDao.selectIndustryGraph", param); 
    	} else if (type=="industry_year"){
    		list =selectList("StatsReportDao.selectIndustryGraphYear", param); 
    	} else if (type=="job_year"){
    		list =selectList("StatsReportDao.selectJobGraphYear", param); 
    	} else if (type=="industry_scale"){
    		list =selectList("StatsReportDao.selectIndustryScaleGraph", param); 
    	} else if (type=="industry_scale_year"){
    		list =selectList("StatsReportDao.selectIndustryScaleGraphYear", param); 
    	}
    	
        return list;
    }
    
    /**
     * 사업체현황 규모
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectScaleGraph(Map<String, Object> param) throws Exception {
    	String type = StringUtil.nvl(param.get("type"));
    	
    	List<Map<String, Object>> list=null;
    	if (type=="scale"){
    		list =selectList("StatsReportDao.selectScaleGraph", param); 
    	} else if (type=="scale_year"){
    		list =selectList("StatsReportDao.selectScaleGraphYear", param); 
    	}
        return list;
    }

    /**
     * 통계 해설서 내용을 가져온다.
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectStatsInfoMValues(Map<String, Object> param) throws Exception {
    	return selectList("StatsInfoPageDao.selectStatsInfoMValues", param); 
    }

    /**
     * 3년간 주요 지표 규모
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectMajorIndices(Map<String, Object> param) throws Exception {
    	return selectList("StatsReportDao.selectMajorIndices", param); 
    }
    
    /**
     * 물산업분류체계 테이블에서 대분류, 중분류, 세분류 코드가 있으면 데이터를 가져온다. 
     * @param param
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCategory(Map<String, Object> param) throws Exception {
        return selectOne("StatsReportDao.selectCategory", param);
    }

    /**
     * 코드 테이블에서 산업구분을 조회한다. 
     * @param param
     * @return
     * @throws Exception
     */
    public  Map<String, Object> selectCode(Map<String, Object> param) throws Exception {
        return selectOne("StatsReportDao.selectCode", param);
    }
    
    /**
     * 통계 데이터 업로드 이력을 조회한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public List<Map<String, Object>> selectExcelUploadList(Map<String, Object> param) throws Exception {
        return selectList("StatsReportDao.selectExcelUploadList", param);
    }
    
    /**
     * 통계 데이터 엑셀 업로드 이력을 등록한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public int insertExcelUploadList(Map<String, Object> param) throws Exception {
        return insert("StatsReportDao.insertExcelUploadList", param);
    }
    
    /**
     * 통계 데이터 엑셀 업로드 이력을 삭제한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public int deleteExcelUploadList(Map<String, Object> param) throws Exception {
        return insert("StatsReportDao.deleteExcelUploadList", param);
    }
    /**
     * 통계 데이터를 엑셀로 업로드 받아 데이터를 DB에 저장한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public int insertResearchScale(Map<String, Object> param) throws Exception {
        return insert("StatsReportDao.insertScaleExcelUpload", param);
    }

    /**
     * 통계 데이터를 삭제한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public int deleteResearchScale(Map<String, Object> param) throws Exception {
        return delete("StatsReportDao.deleteScaleExcelUpload", param);
    }

    /**
     * 통계 데이터를 엑셀로 업로드 받아 데이터를 DB에 저장한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public int insertResearchIndustry(Map<String, Object> param) throws Exception {
        return insert("StatsReportDao.insertIndustryExcelUpload", param);
    }

    /**
     * 통계 데이터를 엑셀로 업로드 받아 엑셀에 등록된 연도의 데이터가 있으면 기존 데이터를 삭제한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public int deleteResearchIndustry(Map<String, Object> param) throws Exception {
        return delete("StatsReportDao.deleteIndustryExcelUpload", param);
    }

    /**
     * 통계 모집단 명부 이력을 조회한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public List<Map<String, Object>> selectPersonList(Map<String, Object> param) throws Exception {
        return selectList("StatsReportDao.selectStatsPerson", param);
    }


    /**
     * 통계 모집단 이력을 엑셀로 업로드 받아 데이터를 DB에 저장한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public int insertPersonList(Map<String, Object> param) throws Exception {
        return insert("StatsReportDao.insertStatsPerson", param);
    }

    /**
     * 통계 모집단 데이터를 삭제한다.
     * 
     * @param param
     * @return 저장 시 성공/실패 여부
     * @throws Exception
     */
    public int deletePersonList(Map<String, Object> param) throws Exception {
        return delete("StatsReportDao.deleteStatsPerson", param);
    }
   
}