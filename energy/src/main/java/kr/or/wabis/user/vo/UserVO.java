package kr.or.wabis.user.vo;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

import kr.or.wabis.login.vo.Role;

public class UserVO implements UserDetails {
    
    private static final long serialVersionUID = 1L;
    
    /**
     * 사용자NO
     */
    private String userNo;
    
    /**
     * 사용자ID
     */
    private String userId;
    
    /**
     * 사용자명
     */
    private String userName;
    
    /**
     * 비밀번호
     */
    private String userPw;
    
    /**
     * 삭제여부
     */
    private String delYn;
    
    /**
     * 권한
     */
    private String auth;
    
    /**
     * 권한
     */
    private String authNm;
    
    /**
     * 소개
     */
    private String intro;
    
    /**
     * Email
     */
    private String userEmail;
    
    /**
     * Mobile
     */
    private String userMobile;
    
    /**
     * 자택/내선번호
     */
    private String userTel;
    
    /**
     * 사용자 구분
     */
    private String userGb;
    
    /**
     * 부서
     */
    private String dept;
    
    /**
     * 등록자ID
     */
    private String regUserNo;
    
    /**
     * 등록일자
     */
    private String regDate;
    
    /**
     * 수정자ID
     */
    private String updUserNo;
    
    /**
     * 수정일자
     */
    private String updDate;
    
    /**
     * 오늘 접속 횟수
     */
    private String todayconnCnt;
    
    /**
     * 나이
     */
    private int age;
    
    /**
     * 비밀번호-변경일자
     */
    private String pwdModDt;
    
    /**
     * 비밀번호-변경여부
     */
    private String pwdChgYn;
    
    /**
     * 로그인 실패 COUNT
     */
    private int errCnt;
    
    
    /**
     * 마지막 로그인 실패 일시
     */
    private String lastErrDt;
  
    // --------------------------------------
    // Spring Security 관련 메소드 (UserDetails 인터페이스)

    private List<Role> authorities;
    
    public final List<Role> getAuthorities() {
        return authorities;
    }
    
    public final void setAuthorities(final List<Role> list) {
        this.authorities = list;
    }
    
    public final String getPassword() {
        return userPw;
    }
    
    public final String getUsername() {
        return userId;
    }
    
    public boolean isAccountNonExpired(){
        return true;
    }
    
    public boolean isAccountNonLocked(){
        return true;        
    }
    
    public boolean isCredentialsNonExpired(){
        return true;        
    }
    
    public boolean isEnabled(){
        return true;        
    }
    // --------------------------------------
    
    @Override
    public final String toString() {
        return "UserVO [userId=" + userId + ", userName=" + userName + ", userPw=" + userPw + ", delYn=" + delYn + ", auth=" + auth + ", pwdModDt=" + pwdModDt + ", regUserId=" + regUserNo + ", regDate=" + regDate + ", updUserId=" + updUserNo + ", updDate=" + updDate + ", userEmail=" + userEmail + ", authorities=" + authorities + "]";
    }
    
    
    public String getUserNo() {
        return userNo;
    }
    
    public void setUserNo(String userNo) {
        this.userNo = userNo;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getUserName() {
        return userName;
    }    
   
    public void setUserName(String userName) {
        this.userName = userName;
    }
   
    public String getUserPw() {
        return userPw;
    }
   
    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    public String getUserMobile() {
        return userMobile;
    }
    
    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }
    
    public String getDelYn() {
        return delYn;
    }
    
    public void setDelYn(String delYn) {
        this.delYn = delYn;
    }
    
    public String getAuth() {
        return auth;
    }
    
    public void setAuth(String auth) {
        this.auth = auth;
    }
    
    public String getAuthNm() {
        return authNm;
    }
    
    public void setAuthNm(String authNm) {
        this.authNm = authNm;
    }
    
    public String getIntro() {
        return intro;
    }
    
    public void setIntro(String intro) {
        this.intro = intro;
    }
    
    public String getUserGb() {
        return userGb;
    }
    
    public void setUserGb(String userGb) {
        this.userGb = userGb;
    }
    
    public String getRegUserNo() {
        return regUserNo;
    }
    
    public void setRegUserNo(String regUserNo) {
        this.regUserNo = regUserNo;
    }
    
    public String getRegDate() {
        return regDate;
    }
    
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }
    
    public String getUpdUserNo() {
        return updUserNo;
    }
    
    public void setUpdUserNo(String updUserId) {
        this.updUserNo = updUserId;
    }
    
    public String getUpdDate() {
        return updDate;
    }
       
    public void setUpdDate(String updDate) {
        this.updDate = updDate;
    }
    
    public String getPwdModDt() {
        return pwdModDt;
    }
    
    public void setPwdModDt(String pwdModDt) {
        this.pwdModDt = pwdModDt;
    }
    
    public String getPwdChgYn() {
        return pwdChgYn;
    }
    
    public void setPwdChgYn(String pwdChgYn) {
        this.pwdChgYn = pwdChgYn;
    }
    
    public String getTodayconnCnt() {
        return todayconnCnt;
    }
    
    public void setTodayconnCnt(String todayconnCnt) {
        this.todayconnCnt = todayconnCnt;
    }
    
    public int getAge() {
        return age;
    }
    
    public void setAge(int age) {
        this.age = age;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getUserTel() {
        return userTel;
    }

    public void setUserTel(String userTel) {
        this.userTel = userTel;
    }   
    
    // 로그인 실패 횟수 COUNT
    public int getErrCnt() {
    	return errCnt;
    }
    
    public void setErrCnt(int errCnt) {
    	this.errCnt = errCnt;
    }
    
    public String getLastErrDt() {
    	return lastErrDt;
    }
    
    public void setLastErrDt(String lastErrDt) {
    	this.lastErrDt = lastErrDt;
    }
}