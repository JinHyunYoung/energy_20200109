package kr.or.wabis.framework.web.vo;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class SessionUserVo implements Serializable {
    
    private static final long serialVersionUID = 2221545928561589683L;
    
    /** != 사용자ID =! */
    private String userId;
    
    /** != 사용자명 =! */
    private String userNm;
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getUserNm() {
        return userNm;
    }
    
    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }
    
}