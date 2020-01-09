package kr.or.wabis.framework.web.view;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.framework.vo.BaseVO;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.fileupload.FileDownloadInfo;

public class ViewHelper {       
    
    public static final String JSON_VIEW_NAME = "jsonView";
    public static final String JQGRID_VIEW_NAME = "jqGridView";
    public static final String DOWNLOAD_VIEW_NAME = "downloadView";
    public static final String EXCEL_DOWNLOAD_VIEW_NAME = "excelDownView";
    

    /**
     * JSON View obj 는 Map, List 만 가능
     * 
     * @param navigator
     * @return
     */
    @SuppressWarnings("unchecked")
    public static ModelAndView getJsonView(Map<String, Object> jobj) {
        return new ModelAndView(JSON_VIEW_NAME, jobj);
    }
    
    /**
     * 엑셀 View obj 는 Map, List 만 가능
     * 
     * @param navigator
     * @return
     */
    public static ModelAndView getExcelView(Object object ) {        
    	
        Map<String, Object> map = (Map<String, Object>) object;               
        
        return new ModelAndView(EXCEL_DOWNLOAD_VIEW_NAME, map);
    }
        
    /**
     * download View obj 는 Map, List 만 가능
     * 
     * @param navigator
     * @return
     */
    public static ModelAndView getDownloadView(FileDownloadInfo downLoadInfo) {
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put(ViewerSupport.FILE_SOURCE_KEY, downLoadInfo);
        
        return new ModelAndView(DOWNLOAD_VIEW_NAME, map);
    }
    
    /**
     * JqGrid용 view
     * 
     * @param navigator
     * @return
     */
    public static ModelAndView getJqGridView(NavigatorInfo navigator) {
        
        navigator.sync();
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", navigator.getPageNo());
        map.put("size", navigator.getPageSize());
        map.put("records", navigator.getTotalCnt());
        map.put("total", navigator.getPageCount());
        map.put("rows", navigator.getList());
        map.put("LISTOPVALUE", navigator.getListOpValue());
        map.put("param", navigator.getParam());
        
        return new ModelAndView(JQGRID_VIEW_NAME, map);
    }
    
    /**
     * Datatable용 view
     * 
     * @param navigator
     * @return
     */
    public static ModelAndView getDatatableView(NavigatorInfo navigator) {
        
        // 그리드 데이터 맵핑(json)
        navigator.sync();
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("recordsTotal", navigator.getTotalCnt());
        map.put("recordsFiltered", navigator.getTotalCnt());
        map.put("data", navigator.getList());
        
        return new ModelAndView(JQGRID_VIEW_NAME, map);
    }
    
    /**
     * JqGrid용 view
     * 
     * @param navigator
     * @return
     */
    public static <T> String getJqGridView(ModelMap model, BaseVO paramVO, List<T> gridList) {
        
        Integer currentPage = paramVO.getMiv_pageNo();
        Integer pageSize = paramVO.getMiv_pageSize();
        Integer totalCount = 0;
        Integer maxPage = 0;
        
        if (gridList != null && gridList.size() > 0) {
            totalCount = ((BaseVO) gridList.get(0)).getTotal_cnt();
            maxPage = ((totalCount - 1) / pageSize) + 1;
        }
        
        model.addAttribute("page", currentPage);
        model.addAttribute("size", pageSize);
        model.addAttribute("records", totalCount);
        model.addAttribute("total", maxPage);
        model.addAttribute("rows", gridList);
        
        return JQGRID_VIEW_NAME;
    }
}