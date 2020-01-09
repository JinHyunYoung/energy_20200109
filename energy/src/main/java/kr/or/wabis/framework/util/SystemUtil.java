package kr.or.wabis.framework.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SystemUtil {
    
    private static Logger log = LoggerFactory.getLogger(SystemUtil.class);
    
    /*------------------------------------------------------------
     * ENVIRONMENT
     *----------------------------------------------------------*/
    public final static String DB_TYPE = "DB_TYPE";
    public final static String EXEC_ENVIRONMENT = "EXEC_ENVIRONMENT";
    public final static String PROJECT_CONFIG_FILE = "PROJECT_CONFIG_FILE";
    
    public static String getExecutionEnvironment() {
        return PropertyUtil.getString(EXEC_ENVIRONMENT);
    }
    
    public static String getProperty(String key) {
        return PropertyUtil.getString(key);
    }
    
    public static String getDBType() {
        return PropertyUtil.getString(DB_TYPE);
    }
    
}
