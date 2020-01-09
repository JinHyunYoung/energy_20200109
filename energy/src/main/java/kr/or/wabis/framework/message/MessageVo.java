package kr.or.wabis.framework.message;

import java.io.Serializable;

public class MessageVo implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String key = "";
    private String language = "";
    private String messgae = "";
    
    public String getKey() {
        return key;
    }
    
    public void setKey(String key) {
        this.key = key;
    }
    
    public String getLanguage() {
        return language;
    }
    
    public void setLanguage(String language) {
        this.language = language;
    }
    
    public String getMessgae() {
        return messgae;
    }
    
    public void setMessgae(String messgae) {
        this.messgae = messgae;
    }
}
