package kr.or.wabis.framework.web.view;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class ViewerSupport {
    
    public final static String PARAM_KEY = ViewerSupport.class + ".PARAM_KEY";
    public final static String DATA_SOURCE_KEY = ViewerSupport.class + ".DATA_SOURCE_KEY";
    public final static String FILE_SOURCE_KEY = ViewerSupport.class + ".FILE_KEY";
    public final static String XML_DOC_KEY = ViewerSupport.class + ".XML_DOC_KEY";
    public final static String JSON_KEY = ViewerSupport.class + ".JSON_KEY";
    
    /**
     * JaperView에 파라미터 Map을 넘겨준다.
     * 
     * @param request
     * @param param
     */
    public static void setPapameterMap(HttpServletRequest request, Map param) {
        request.setAttribute(ViewerSupport.PARAM_KEY, param);
    }
    
    /**
     * JasperPDFVIewer에 데이타 List를 넘겨준다.
     * 
     * @param request
     * @param data
     */
    public static void setDataSourceList(HttpServletRequest request, List data) {
        request.setAttribute(ViewerSupport.DATA_SOURCE_KEY, data);
    }
}
