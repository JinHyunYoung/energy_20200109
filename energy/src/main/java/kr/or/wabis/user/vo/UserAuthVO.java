package kr.or.wabis.user.vo;

import java.io.Serializable;

public class UserAuthVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String userId = null;
    private String auth = "";
    private String authName = null;
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getAuth() {
        return auth;
    }
    
    public void setAuth(String auth) {
        this.auth = auth;
    }
    
    public String getAuthName() {
        return authName;
    }
    
    public void setAuthName(String authName) {
        this.authName = authName;
    }
    
}
