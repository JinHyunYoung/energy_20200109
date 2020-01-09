package kr.or.wabis.user.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.wabis.contents.service.BannerService;
import kr.or.wabis.contents.service.IntroPageService;
import kr.or.wabis.contents.service.LogoService;
import kr.or.wabis.education.service.EducationService;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.integration.service.MenuService;
import kr.or.wabis.stats.service.StatsService;
import kr.or.wabis.user.service.UserService;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller("userController")
public class UserController extends AbstractController {

    private static final Logger logger = Logger.getLogger(UserController.class);

    public final static String WEB_PATH = "/web/user/";

    @Resource(name = "userService")
    private UserService userService;

    @Resource(name = "menuService")
    private MenuService menuService;

    @Resource(name = "introPageService")
    private IntroPageService introPageService;

    @Resource(name = "bannerService")
    private BannerService bannerService;

    @Resource(name = "logoService")
    private LogoService logoService;

    @Resource(name = "statsService")
    private StatsService statsService;
    
    @Resource(name = "educationService")
    private EducationService educationService;

    /**
     * front Main 페이지로 이동한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/main.do")
    public String frontMain(ExtHttpRequestParam _req, ListOp listOp, HttpServletRequest request, ModelMap model) throws Exception {

        HttpSession session = request.getSession();

        // 로그인을 하지 않을 상태에서 접속 통계를 처리하기 위해서 JSESSIONID를 가져와서 사용자 번호를 대체
        Cookie[] cookies = request.getCookies();
        if(cookies != null && cookies[0] != null){

            String jsessionidName = cookies[0].getName();
            String jsessionid = cookies[0].getValue();

            logger.debug("### jsessionidName : " + jsessionidName + ", jsessionid : " + jsessionid);

            if("JSESSIONID".equals(jsessionidName)){

                String sid = StringUtil.nvl(session.getAttribute("JSESSIONID"), "");

                // 현재 세션과 비교해서 아닐 경우에 통계 데이타 저장
                if( ! sid.equals(jsessionid) ){

                    Map<String, Object> param = new HashMap();
                    param.put("s_user_no", jsessionid);
                    param.put("homepage", "F");
                    param.put("ip", request.getRemoteAddr());

                    statsService.insertHomepageconn(param);

                    session.setAttribute("JSESSIONID", jsessionid);
                }
            }
        }


        session.setAttribute("web_g_topmenu_id", "");
        session.setAttribute("web_g_topmenu_nm", "");
        session.setAttribute("web_g_submenu_id", "");
        session.setAttribute("web_g_menu_navi", "");
        session.setAttribute("web_g_up_menu_id", "");

        Map<String, Object> param = _req.getParameterMap();
        param.put("region","1");
        param.put("use_yn", "Y");
        
        List<Map<String, Object>> bannerList = bannerService.selectBannerList(param);
        model.addAttribute("bannerList", bannerList);
        
        Map<String, Object> logo = (Map<String, Object>) session.getAttribute("Logo");

        if (logo == null) {
            logo = logoService.selectLogo(param);
            session.setAttribute("Logo", logo);
        }

        param.put("use_yn", "Y");
        param.put("region", "2");

        List<Map<String, Object>> mainImg = bannerService.selectBannerList(param);
        model.addAttribute("mainImg", mainImg);
        
        // 패밀리 사이트   
        param.put("region", "3");
        List<Map<String, Object>> familySite = bannerService.selectBannerList(param);
        model.addAttribute("familySite", familySite);
        
        // ticker   
        param.put("region", "4");
        List<Map<String, Object>> tickerSite = bannerService.selectBannerList(param);
        model.addAttribute("tickerSite", tickerSite);
        
        // 동영상   
        param.put("region","5");
        param.put("use_yn", "Y");
        
        Map<String, Object> videoList = bannerService.selectBannerVideoList(param);
        model.addAttribute("videoList", videoList);
        
        Map busiMap = educationService.selectYearBusiStat(param);
        model.addAttribute("busiStat", (Map)busiMap.get("busiStat"));
        model.addAttribute("busiAmtTotal", StringUtil.nvl(busiMap.get("busiAmtTotal")));
        model.addAttribute("busiHouseTotal", StringUtil.nvl(busiMap.get("busiHouseTotal")));
        
        List<Map<String, Object>> fundMap = educationService.selectYearFundStat(param);
        model.addAttribute("fundStat", fundMap);
        
        return "/sub" + WEB_PATH + "main";
    }
    /**
     * 슬라이더 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/slider.do")
    public String sliderPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
        param.put("use_yn", "Y");
        
        List<Map<String, Object>> list = bannerService.selectBannerList(param);
        model.addAttribute("list", list);
        
        return WEB_PATH + "slider";
    }
    /**
     * 공통 동적 페이지로 이동한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/dynaPage.do")
    public String dynaPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {
        return WEB_PATH + "dynaPage";
    }

    /**
     * 사용자 로그인 페이지로 이동한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/login.do")
    public String login(ExtHttpRequestParam _req, ListOp listOp, ModelMap model, HttpServletRequest req) throws Exception {
        return WEB_PATH + "login";
    }

    /**
     * 사용자단 메뉴리스트를 가져온다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/homepageMenuList.do")
    public @ResponseBody Map<String, Object> homepageMenuList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        List<Map<String, Object>> topMenuList = menuService.selectHomepageMenuList(param);
        param.put("topMenuList", topMenuList);

        return param;
    }

    /**
     * 회원가입 (가입인증) 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userRegistStep1Page.do")
    public String userRegistStep1Page(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return WEB_PATH + "userRegistStep1Page";
    }

    /**
     * 회원가입 (약관동의) 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userRegistStep2Page.do")
    public String userRegistStep2Page(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        String civil_name = "";
        Map<String, Object> param = _req.getParameterMap();

        // 이용약관 가져오기
        param.put("page_id", "9f603da0fad04dcc861eab7d77b547b7");
        model.addAttribute("agreement", introPageService.selectIntropage(param));

        // 개인정보보호정책 가져오기
        param.put("page_id", "c00759b0f6a34b9caa2065c3c3cab63c");
        model.addAttribute("privacy", introPageService.selectIntropage(param));

        if ("yes".equals(StringUtil.nvl(param.get("realNameChk")))) {
            civil_name = URLDecoder.decode((String) param.get("CIVIL_NAME"), "utf-8");
            model.addAttribute("civil_name", civil_name);
            model.addAttribute("sms_number", (String) param.get("SMS_NUMBER"));
        }

        return WEB_PATH + "userRegistStep2Page";
    }

    /**
     * 회원가입 (회원정보입력) 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userRegistStep3Page.do")
    public String userRegistStep3Page(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        String selYear = StringUtil.nvl(param.get("p_year"), DateUtil.getCurrentYear());
        model.addAttribute("curYear", DateUtil.getCurrentYear());
        model.addAttribute("selYear", selYear);
        param.put("year", selYear);

        return WEB_PATH + "userRegistStep3Page";
    }

    /**
     * 회원가입 (회원가입완료) 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userRegistStep4Page.do")
    public String userRegistStep4Page(ExtHttpRequestParam _req, ModelMap model, HttpServletRequest req) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> user = userService.selectUser(param);
        model.addAttribute("user", user);

        return WEB_PATH + "userRegistStep4Page";
    }

    /**
     * 이용약관 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/agreementPage.do")
    public String agreementPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        // 이용약관 가져오기
        param.put("page_id", "9f603da0fad04dcc861eab7d77b547b7");
        model.addAttribute("agreement", introPageService.selectIntropage(param));

        return WEB_PATH + "agreementPage";
    }

    /**
     * 개인정보정책 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/privacyPage.do")
    public String privacyPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        // 개인정보보호정책 가져오기
        param.put("page_id", "c00759b0f6a34b9caa2065c3c3cab63c");
        model.addAttribute("privacy", introPageService.selectIntropage(param));

        return WEB_PATH + "privacyPage";
    }

    /**
     * 회원정보 재동의 확인팝업으로 이동한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/reAgreementPopup.do")
    public String reAgreementPopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return "/popup" + WEB_PATH + "reAgreementPopup";
    }

    /**
     * 회원정보 재동의 확인
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/reAgreementPage.do")
    public String reAgreementPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
        param.put("user_no", param.get("s_user_no"));

        Map<String, Object> user = userService.selectUser(param);
        model.addAttribute("agree_dt", StringUtil.nvl(user.get("agree_dt")));

        // 이용약관 가져오기
        param.put("page_id", "9f603da0fad04dcc861eab7d77b547b7");
        model.addAttribute("agreement", introPageService.selectIntropage(param));

        // 개인정보보호정책 가져오기
        param.put("page_id", "c00759b0f6a34b9caa2065c3c3cab63c");
        model.addAttribute("privacy", introPageService.selectIntropage(param));

        return WEB_PATH + "reAgreementPage";
    }

    /**
     * 아이디/패스워드 찾기 페이지로 이동한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/findIdPassPage.do")
    public String findIdPassPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        String civil_name = "";
        String civil_mobile = "";
        Map<String, Object> param = _req.getParameterMap();

        if ("yes".equals(StringUtil.nvl(param.get("realNameChk")))) {

            Map<String, Object> map = new HashMap();
            civil_name = URLDecoder.decode(StringUtil.nvl(param.get("CIVIL_NAME")), "utf-8");
            civil_mobile = StringUtil.nvl(param.get("SMS_NUMBER"));

            String mode = StringUtil.nvl(param.get("mode")).substring(0, 1);
            param.put("mode", mode);

            String mobile = "";
            String mobile1 = "";
            String mobile2 = "";
            String mobile3 = "";

            int rv = 0;
            if (civil_mobile.length() == 10) {
                mobile1 = civil_mobile.substring(0, 3);
                mobile2 = civil_mobile.substring(3, 6);
                mobile3 = civil_mobile.substring(6, 10);
            } else {
                mobile1 = civil_mobile.substring(0, 3);
                mobile2 = civil_mobile.substring(3, 7);
                mobile3 = civil_mobile.substring(7, 11);
            }

            mobile = mobile1 + "-" + mobile2 + "-" + mobile3;

            param.put("user_mobile", CryptoUtil.AES_Encode(mobile));
            param.put("user_nm", civil_name);

            if ("I".equals(mode)) {
                map = userService.selectUserPhoneExist(param);
            } else {
                map = userService.selectUserIdPhoneExist(param);
            }

            if (map == null) {
                map = new HashMap();
                mode = "N";
            } else {

                // 아이디 찾기
                if ("I".equals(mode)) {
                    model.addAttribute("user_id", StringUtil.nvl(map.get("user_id")));
                }

                // 패스워드 찾기
                else {

                    param.put("user_no", StringUtil.nvl(map.get("user_no")));

                    String imsiPwd = RandomStringUtils.randomAlphanumeric(10);
                    param.put("user_pw", CryptoUtil.SHA_encrypt(imsiPwd));

                    rv = userService.updatePasswordChange(param);

                    if (rv > 0) {

                        //SmsSend sms = new SmsSend();
                        //sms.sendMessage(civil_mobile, imsiPwd, "0221336588");
                    } else {
                        mode = "E";
                    }
                }

            }

            model.addAttribute("mode2", mode);
        }

        model.addAttribute("realNameChk", (String) param.get("realNameChk"));

        return WEB_PATH + "findIdPassPage";
    }

    /**
     * 회원탈퇴 페이지로 이동한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userDropOutPage.do")
    public String dropOutPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return "/popup" + WEB_PATH + "userDropOutPage";
    }

    /**
     * 가입처리 해준다.
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userRegist.do")
    public ModelAndView userRegist(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        param.put("user_gb", "N"); // 사용자단에서 수정

        try {

            // 이미 등록된 회원 확인
            // rv = userService.selectUserExist(param);

            param.put("user_pw", CryptoUtil.SHA_encrypt(StringUtil.nvl(param.get("user_pw"))));

            if (!StringUtil.nvl(param.get("user_mobile")).equals(""))
                param.put("user_mobile", CryptoUtil.AES_Encode((String) param.get("user_mobile")));

            if (!StringUtil.nvl(param.get("user_email")).equals(""))
                param.put("user_email", CryptoUtil.AES_Encode((String) param.get("user_email")));

            if (!StringUtil.nvl(param.get("user_tel")).equals(""))
                param.put("user_tel", CryptoUtil.AES_Encode((String) param.get("user_tel")));

            param.put("user_no", CommonUtil.createUUID());
            param.put("s_user_no", param.get("user_no"));

            rv = userService.insertUserRegist(param);

            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "가입에 성공하였습니다. 로그인 후 이용해주십시요.");
            } else {
                param.put("success", "false");
                param.put("message", "가입에 실패하였습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }

        return ViewHelper.getJsonView(param);

    }

    /**
     * 회원수정 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userModifyPage.do")
    public String userModifyPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        // 컨텐츠 최상위 분류를 가져온다.
        Map<String, Object> param = _req.getParameterMap();
        param.put("user_no", param.get("s_user_no"));

        Map<String, Object> user = userService.selectUser(param);
        model.addAttribute("user", user);

        return WEB_PATH + "userModifyPage";
    }

    /**
     * 내정보 수정처리를 해준다.
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userModify.do")
    public ModelAndView userModify(HttpServletRequest request, ExtHttpRequestParam _req, ModelMap model, HttpServletRequest req) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        try {

            param.put("user_no", param.get("s_user_no"));
            rv = userService.updateUserModify(param);

            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "내 정보수정에 성공하였습니다.");
            } else {
                param.put("success", "false");
                param.put("message", "내 정보수정에 실패하였습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }

        return ViewHelper.getJsonView(param);
    }

    /**
     * 패스워드 찾기를 처리 해준다.
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/passwordSearch.do")
    public ModelAndView passwordSearch(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        try {

            // 이메일이 이미 있는지를 검색한다.
            rv = userService.selectUserEmailExist(param);
            if (rv > 0) {

                param.put("pwd_confirm_word", CommonUtil.createUUID());
                rv = userService.updatePwdConfirmWord(param);

                if (rv > 0) {

                    // 메일을 전송한다.
                    param.put("success", "true");
                    param.put("message", "암호를 재설정할 수 있는 이메일을 곧 받으실 것입니다. 이메일을 찾을 수 없으면 스팸 편지함 및 휴지통을 확인하십시오.");
                } else {
                    param.put("success", "false");
                    param.put("message", "암호재설정 정보를 전송하는데 실패하였습니다.");
                }

            } else {
                param.put("success", "false");
                param.put("message", "정보와 일치하는 사용자를 찾을 수 없습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }

        return ViewHelper.getJsonView(param);
    }

    /**
     * 패스워드 변경 페이지로 이동한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/pwdChangePage.do")
    public String pwdChangePage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return WEB_PATH + "pwdChangePage";
    }

    /**
     * 메인 패스워드 변경 팝업으로 이동한다.(90일 기준)
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/pwdChangePopup.do")
    public String pwdChangePopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return "/popup" + WEB_PATH + "pwdChangePopup";
    }

    /**
     * 패스워드 변경을 처리 해준다.
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/passwordChange.do")
    public ModelAndView passwordChange(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        int chk = 0;
        Map<String, Object> param = _req.getParameterMap();
        String nowpw = StringUtil.nvl(param.get("now_pw"));

        try {
            param.put("user_no", param.get("s_user_no"));

            // 기존패스워드 확인
            if (!"".equals(nowpw)) {

                param.put("now_pw", CryptoUtil.SHA_encrypt(nowpw));

                chk = userService.selectUserPassExist(param);

                if (chk == 0) {
                    param.put("success", "false");
                    param.put("message", "비밀번호가 맞지 않습니다.");
                    return ViewHelper.getJsonView(param);
                }

            }

            param.put("user_pw", CryptoUtil.SHA_encrypt(StringUtil.nvl(param.get("user_pw"))));

            rv = userService.updatePasswordChange(param);

            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "비밀번호를 변경하였습니다.");
            } else {
                param.put("success", "false");
                param.put("message", "비밀번호 변경에 실패하였습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }

        return ViewHelper.getJsonView(param);
    }

    /**
     * 회원정보재동의 수정
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/updateAgreement.do")
    public ModelAndView updateAgreement(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        try {

            rv = userService.updateAgreement(param);

            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "회원정보 재동의 하였습니다.");
            } else {
                param.put("success", "false");
                param.put("message", "회원정보 재동의에 실패하였습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }

        return ViewHelper.getJsonView(param);
    }

    /**
     * 회원을 탈퇴 시킨다.
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userDropOut.do")
    public ModelAndView userDropOut(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();

        try {

            // 회원을 탈퇴 시킨다.
            param.put("user_no", param.get("s_user_no"));
            rv = userService.userDropOut(param);

            if (rv > 0) {
                param.put("success", "true");
                param.put("message", "탈퇴 하였습니다.");
            } else {
                param.put("success", "false");
                param.put("message", "탈퇴에 실패하였습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }

        return ViewHelper.getJsonView(param);
    }

    /**
     * 중복 아이디 체크
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/userChkId.do")
    public ModelAndView userChkId(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        try {

            rv = userService.selectUserExist(param);

            if (rv > 0) {
                param.put("success", "false");
                param.put("message", "중복된 아이디가 존재합니다.");
            } else {
                param.put("success", "true");
                param.put("message", "사용가능한 아이디입니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            param.put("success", "false");
            param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
            return ViewHelper.getJsonView(param);
        }

        return ViewHelper.getJsonView(param);
    }

    /**
     * 주소팝업 페이지로 이동을 해준다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/jusoSearchPopup.do")
    public String jusoSearchPopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return "/sub" + WEB_PATH + "jusoSearchPopup";
    }

    /**
     * 주소테스트 팝업 페이지로 이동을 해준다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/jusotest.do")
    public String jusoSearchTestPopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return WEB_PATH + "jusoTest";
    }

    /**
     * 주소를 가져온다
     *
     * @param req
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/getAddrApi.do")
    public void getAddrApi(HttpServletRequest req, ModelMap model, HttpServletResponse response) throws Exception {

        String currentPage = req.getParameter("currentPage");
        String countPerPage = req.getParameter("countPerPage");
        String resultType = req.getParameter("resultType");
        String confmKey = req.getParameter("confmKey");
        String keyword = req.getParameter("keyword");

        System.out.println("*** API 시작 ***");
        String apiUrl =
                "http://www.juso.go.kr/addrlink/addrLinkApi.do?"+
                        "currentPage=" + currentPage +
                        "&countPerPage=" + countPerPage +
                        "&keyword=" + URLEncoder.encode(keyword, "UTF-8") +
                        "&confmKey=" + confmKey +
                        "&resultType=" + resultType;

        URL url = new URL(apiUrl);
        BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
        StringBuffer sb = new StringBuffer();
        String tempStr = null;

        while (true) {
            tempStr = br.readLine();
            if (tempStr == null)
                break;
            sb.append(tempStr);
        }
        br.close();

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/xml");
        response.getWriter().write(sb.toString());
    }

    /**
     * 주소2를 가져온다
     *
     * @param req
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/getAddrApi2.do")
    public void getAddrApi2(HttpServletRequest req, ModelMap model, HttpServletResponse response) throws Exception {

        String host = "http://10.182.60.22";
        String currentPage = req.getParameter("currentPage");
        String countPerPage = req.getParameter("countPerPage");
        String resultType = req.getParameter("resultType");
        String confmKey = req.getParameter("confmKey");
        String keyword = req.getParameter("keyword");

        String apiUrl = host + "/addrlink/addrLinkApi.do?"+
                "currentPage=" + currentPage +
                "&countPerPage=" + countPerPage +
                "&keyword=" + URLEncoder.encode(keyword, "UTF-8") +
                "&confmKey=" + confmKey;

        URL url = new URL(apiUrl);
        BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
        StringBuffer sb = new StringBuffer();
        String tempStr = null;

        while (true) {
            tempStr = br.readLine();
            if (tempStr == null)
                break;
            sb.append(tempStr);
        }
        br.close();

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/xml");
        response.getWriter().write(sb.toString());
    }

    /**
     * 세션에 선택메뉴를 저장한다
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/sessionMenu.do")
    public ModelAndView sessionMenu(ExtHttpRequestParam _req, HttpServletRequest req) throws Exception {

        int rv = 0;
        Map<String, Object> param = _req.getParameterMap();
        HttpSession session = req.getSession();

        String topMenu = StringUtil.nvl(param.get("topmenu_id"));
        if (!topMenu.equals("")) {
            session.setAttribute("web_g_topmenu_id", topMenu);
        }

        String topMenuNm = StringUtil.nvl(param.get("topmenu_nm"));
        if (!topMenuNm.equals("")) {
            session.setAttribute("web_g_topmenu_nm", topMenuNm);
        }

        String subMenu = StringUtil.nvl(param.get("submenu_id"));
        if (!subMenu.equals("")) {

            param.put("menu_id", subMenu);
            Map<String, Object> menu = menuService.selectFrontMenu(param);

            session.setAttribute("web_g_topmenu_id", menu.get("topmenu_id"));
            session.setAttribute("web_g_topmenu_nm", menu.get("topmenu_nm"));
            session.setAttribute("web_g_submenu_id", subMenu);
            session.setAttribute("web_g_submenu_nm", menu.get("menu_nm"));
            session.setAttribute("web_g_submenu_desc", menu.get("menu_desc"));
            session.setAttribute("web_g_up_menu_id", menu.get("up_menu_id"));
            String menuNavi = StringUtil.nvl(menu.get("menu_navi"));

            session.setAttribute("web_g_menu_navi", getNavi(menuNavi));
            param.put("login_yn", StringUtil.nvl(menu.get("login_yn"), "N"));

            // 메뉴 접속 통계 저장
            Map<String, Object> statsParam = new HashMap();
            statsParam.put("menu_id", subMenu);
            statsParam.put("homepage", "F");
            statsParam.put("ip", req.getRemoteAddr());

            statsService.insertMenuconn(statsParam);
        }

        param.put("success", "true");

        return ViewHelper.getJsonView(param);
    }

    /**
     * 사용자단 네비게이션을 만들어준다.
     *
     * @param menuNavi
     * @return
     */
    private String getNavi(String menuNavi) {

        StringBuffer retVal = new StringBuffer().append(" <img src=\"/images/icon/icon_home.png\" alt=\"home\" /> &nbsp;&nbsp;");

        if(menuNavi != null && menuNavi.length() > 1) {

            // 쿼리에서 마지막에 토큰(#) 들어가서 그 부분을 삭제하기 위해서 처리
            if(menuNavi.charAt(menuNavi.length()-1) == '#') menuNavi = menuNavi.substring(0, menuNavi.length()-1);

            String[] menuArr = StringUtil.split(menuNavi, "#");

            for (int i = 0; i < menuArr.length; i++) {
                if (i == (menuArr.length - 1)) {
                    retVal
//                    .append("<li class=\"last\">")
                            .append("<a href=\"javascript:showNaviSubmenu()\" >")
//                    .append("<span>")
                            .append(menuArr[i])
//                    .append("</span>")
                            .append("</a>")
//                    .append(" <img src=\"/images/icon/location_dot.png\" alt=\"dot1\" /> ")
                            .append("<div id=\"NaviSubMenu\" class=\"last_sub_menu\" style=\"display:none\"></div></li> ")
//                    .append("</li>")
                            .append("");
                } else {
                    retVal
//                    .append("<li>")
                            .append(menuArr[i])
//                    .append("</li>")
                            .append("&nbsp;&nbsp;")
                            .append(" <img src=\"/images/icon/location_dot.png\" alt=\"dot2\" /> ")
                            .append("");
                }
            }
        }

        return retVal.toString();
    }


    /**
     * 특정 메뉴로 이동한다
     *
     * @param _req
     * @param model
     * @param validator
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/sessionPage.do")
    public ModelAndView sessionPage(ExtHttpRequestParam _req, HttpServletRequest req) throws Exception {

        int rv = 0;

        Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> menu = menuService.selectFrontMenu(param);

        logger.debug("### param : " + param);
        logger.debug("### menu : " + menu);

        HttpSession session = req.getSession();

        String topMenu = StringUtil.nvl(menu.get("topmenu_id"));
        session.setAttribute("web_g_topmenu_id", topMenu);

        String topMenuNm = StringUtil.nvl(menu.get("topmenu_nm"));
        session.setAttribute("web_g_topmenu_nm", topMenuNm);

        String subMenu = StringUtil.nvl(menu.get("menu_id"));
        session.setAttribute("web_g_submenu_id", subMenu);
        session.setAttribute("web_g_submenu_nm", menu.get("menu_nm"));
        session.setAttribute("web_g_submenu_desc", menu.get("menu_desc"));

        session.setAttribute("web_g_up_menu_id", menu.get("up_menu_id"));

        String menuNavi = StringUtil.nvl(menu.get("menu_navi"));
        session.setAttribute("web_g_menu_navi", getNavi(menuNavi));

        param.put("login_yn", StringUtil.nvl(menu.get("login_yn"), "N"));
        param.put("menu", menu);
        param.put("success", "true");

        return ViewHelper.getJsonView(param);
    }

    /**
     * 서브 메뉴 리스트를 가져온다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/user/naviSubmenuList.do")
    public @ResponseBody Map<String, Object> naviSubmenuList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();
        param.put("homepage", "F");

        List<Map<String, Object>> list = menuService.selectNaviMenuList(param);

        param.put("naviSubmenuList", list);

        return param;
    }

}
