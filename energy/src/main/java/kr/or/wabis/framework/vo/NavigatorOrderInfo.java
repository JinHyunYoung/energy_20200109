package kr.or.wabis.framework.vo;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.ObjectUtil;

public class NavigatorOrderInfo {
    
    private final static long serialVersionUID = 1L;
    
    public final static String ORD_ASC = "ASC";
    public final static String ORD_DESC = "DESC";
    
    private Log logger = LogFactory.getLog(NavigatorOrderInfo.class);
    private String order = ORD_ASC;
    private String orderParam = "";
    private String key = null;
    private boolean ordSpecified = false;
    
    /**
     * 
     * @param param "(A|D):FieldName"
     */
    public NavigatorOrderInfo(String param) {
        
        try {
            Map[] sortList = (Map[]) JsonUtil.fromJsonStr(param);
            
            this.orderParam = param;
            if (sortList != null && sortList.length > 0) {
                
                Map sortInfo = (Map) sortList[0];
                this.key = ObjectUtil.getSafeString(sortInfo.get("property"));
                this.order = ObjectUtil.getSafeString(sortInfo.get("direction"));
                this.ordSpecified = true;
                
            }
            
        } catch (Exception e) {
            logger.error("param = [" + orderParam + "]" + e.getMessage(), e);
        }
    }
    
    /**
     * 
     * @param fieldname
     * @param isdescending
     */
    public NavigatorOrderInfo(String fieldname, boolean isdescending) {
        this.key = fieldname;
        this.order = (isdescending) ? ORD_DESC : ORD_ASC;
    }
    
    /**
     * @return Returns the key.
     */
    public String getKey() {
        return key;
    }
    
    /**
     * @param key - The key to set.
     */
    public void setKey(String key) {
        this.key = key;
    }
    
    /**
     * @return Returns the ord.
     */
    public String getOrder() {
        return order;
    }
    
    /**
     * @param ord - The ord to set.
     */
    public void setOrder(String ord) {
        this.order = ord;
    }
    
    /**
     * order option을 String으로 전환
     * 
     * @return
     */
    public String getParam() {
        return this.orderParam;
    }
    
    /**
     * @return the ordSpecified
     */
    public boolean isOrdSpecified() {
        return ordSpecified;
    }
    
}
