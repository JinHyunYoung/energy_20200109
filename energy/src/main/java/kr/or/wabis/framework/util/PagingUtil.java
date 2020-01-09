package kr.or.wabis.framework.util;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.wabis.framework.web.vo.DefaultVo;
import kr.or.wabis.framework.web.vo.PaginationInfo;

public class PagingUtil {
    
    private static Logger log = LoggerFactory.getLogger(PagingUtil.class);
    
    /**
     * Paging Setting != Paging 세팅 =!
     * 
     * @param DefaultVo
     * @return String
     * @throws Exception
     */
    public static void preHandle(DefaultVo vo) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(vo.getPageIndex());
        paginationInfo.setRecordCountPerPage(vo.getRecordCountPerPage());
        paginationInfo.setPageSize(vo.getPageSize());
        
        vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        vo.setLastIndex(paginationInfo.getLastRecordIndex());
        
        log.debug("### PageIndex:{}, RecordCountPerPage:{}", vo.getPageIndex(), vo.getRecordCountPerPage());
        log.debug("### FirstRecordIndex:{}, LastRecordIndex:{}", vo.getFirstIndex(), vo.getLastIndex());
        
        HttpServletRequest request = SpringUtil.getServletRequest();
        request.setAttribute("paginationInfo", paginationInfo);
    }
    
    public static void postHandle(List<?> list) {
        
        HttpServletRequest request = SpringUtil.getServletRequest();
        
        int totCnt = 0;
        if (list != null && list.size() > 0) {
            totCnt = ((DefaultVo) list.get(0)).getTotalRecordCount();
        }
        
        PaginationInfo paginationInfo = (PaginationInfo) request.getAttribute("paginationInfo");
        if (paginationInfo == null) {
            paginationInfo = new PaginationInfo();
        }
        
        paginationInfo.setTotalRecordCount(totCnt);
        
        request.setAttribute("paginationInfo", paginationInfo);
    }
    
}
