package kr.or.wabis.framework.util;

import java.util.HashMap;
import java.util.Map;

public class GlobalVariable {
    
    private static volatile GlobalVariable INSTANCE;
    
    private Map<String, Object> data;
    
    public static GlobalVariable getInstance() {
        if (INSTANCE == null) {
            synchronized (CryptoUtil.class) {
                if (INSTANCE == null)
                    INSTANCE = new GlobalVariable();
            }
        }
        return INSTANCE;
    }
    
    private GlobalVariable() {
        data = new HashMap();
    }
    
    public void setKeyValue(String key, Object value) {
        data.put(key, value);
    }
    
    public Object getKeyValue(String key) {
        return data.get(key);
    }
    
}
