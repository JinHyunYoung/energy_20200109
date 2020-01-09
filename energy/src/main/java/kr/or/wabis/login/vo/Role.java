package kr.or.wabis.login.vo;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;

public class Role implements GrantedAuthority {
    
    private static final long serialVersionUID = 1L;
    
    private String name;
    
    private List<Privilege> privileges;
    
    @Override
    public final String getAuthority() {
        return this.name;
    }
    
    public final String getName() {
        return name;
    }
    
    public final void setName(final String value) {
        this.name = value;
    }
    
    public final List<Privilege> getPrivileges() {
        return privileges;
    }
    
    public final void setPrivileges(final List<Privilege> list) {
        this.privileges = list;
    }
    
}
