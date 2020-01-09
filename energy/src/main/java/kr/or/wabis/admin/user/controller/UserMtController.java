package kr.or.wabis.admin.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.admin.integration.service.MenuMtService;
import kr.or.wabis.admin.user.service.UserMtService;
import kr.or.wabis.framework.util.CommonUtil;
import kr.or.wabis.framework.util.CryptoUtil;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.vo.ListOp;
import kr.or.wabis.framework.vo.NavigatorInfo;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.user.service.UserService;
import kr.or.wabis.user.vo.UserVO;

@Controller("userMtController")
public class UserMtController extends AbstractController {

	private Logger logger = Logger.getLogger(UserMtController.class);

	private final static String ADMIN_PATH = "/admin/user/";

	@Resource(name = "userMtService")
	private UserMtService userMtService;

	@Resource(name = "menuMtService")
	private MenuMtService menuMtService;
	
	@Resource(name = "userService")
	private UserService userService;
	

	/**
	 * 메인 페이지로 이동한다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/main.do")
	public String adminMain(HttpServletRequest request, ExtHttpRequestParam _req, ModelMap model) throws Exception {

		HttpSession session = request.getSession();
		session.setAttribute("admin_g_topmenu_id", "");
		session.setAttribute("admin_g_topmenu_nm", "");
		session.setAttribute("admin_g_submenu_id", "");
		session.setAttribute("admin_g_up_menu_id", "");
		session.setAttribute("admin_g_menu_navi", "");

		Map<String, Object> param = _req.getParameterMap();
		param.put("homepage", "B");

		List<Map<String, Object>> sitemapList = menuMtService.selectSitemapList(param);
		model.addAttribute("sitemapList", sitemapList);

		return ADMIN_PATH + "main";
	}

	/**
	 * 회원 리스트 페이지로 이동한다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/userListPage.do")
	public String userListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		return ADMIN_PATH + "userListPage";
	}

	/**
	 * 회원 리스트 페이지로딩후 grid 데이터를 가지고 온다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/userPageList.do")
	public ModelAndView userPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param = navigator.getParam();
		String searchKey = StringUtil.nvl(param.get("searchkey"));
		String searchTxt = StringUtil.nvl(param.get("searchtxt"));

		if ((searchKey.equals("user_mobile") || searchKey.equals("user_email")) && !searchTxt.equals("")) {
			param.put("searchtxt", CryptoUtil.AES_Encode(searchTxt));
		}

		List<Map<String, Object>> list = userMtService.selectUserPageList(param);
		Map<String, Object> user = null;
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				user = list.get(i);
				user.put("user_mobile", CryptoUtil.AES_Decode(StringUtil.nvl(user.get("user_mobile"))));
				user.put("user_email", CryptoUtil.AES_Decode(StringUtil.nvl(user.get("user_email"))));
			}
		}
		navigator.setList(list);

		return ViewHelper.getJqGridView(navigator);
	}

	/**
	 * 관리자 리스트 페이지로 이동한다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/managerListPage.do")
	public String managerListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		List<Map<String, Object>> authList = userMtService.selectAuthList(param);

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);
		model.addAttribute("authList", authList);

		return ADMIN_PATH + "managerListPage";
	}

	/**
	 * 관리자 리스트 페이지로딩후 grid 데이터를 가지고 온다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/managerPageList.do")
	public ModelAndView managerPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param = navigator.getParam();

		List<Map<String, Object>> list = userMtService.selectUserPageList(param);

		Map<String, Object> user = null;
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				user = list.get(i);
				user.put("user_mobile", CryptoUtil.AES_Decode(StringUtil.nvl(user.get("user_mobile"))));
				user.put("user_email", CryptoUtil.AES_Decode(StringUtil.nvl(user.get("user_email"))));
			}
		}

		navigator.setList(list);

		return ViewHelper.getJqGridView(navigator);
	}

	/**
	 * 회원 검색리스트 페이지로딩후 grid 데이터를 가지고 온다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/userSearchPageList.do")
	public ModelAndView userSearchPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param = navigator.getParam();

		navigator.setList(userMtService.selectUserSearchPageList(param));

		return ViewHelper.getJqGridView(navigator);
	}

	/**
	 * 리스트 페이지로딩후 list 데이터를 가지고 온다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/userList.do")
	public String userList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();

		List<Map<String, Object>> list = userMtService.selectUserList(param);
		model.addAttribute("itemList", list);

		return ADMIN_PATH + "userListPage";
	}

	/**
	 * 회원 쓰기 페이지로 이동한다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/userWrite.do")
	public String userWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> user = new HashMap();

		if (!StringUtil.nvl(param.get("mode")).equals("W")) {

			// 사용자 정보를 가져온다.
			user = userMtService.selectUser(param);

			String userMobile = StringUtil.nvl(user.get("user_mobile"));
			if (!userMobile.equals("")) {
				String[] mobile = StringUtil.split(userMobile, "-");
				user.put("mobile_1", mobile[0]);
				user.put("mobile_2", mobile[1]);
				user.put("mobile_3", mobile[2]);
			}

			String userTel = StringUtil.nvl(user.get("user_tel"));
			if (!userTel.equals("")) {
				String[] tel = StringUtil.split(userTel, "-");
				user.put("tel_1", tel[0]);
				user.put("tel_2", tel[1]);
				user.put("tel_3", tel[2]);
			}

			String userEmail = StringUtil.nvl(user.get("user_email"));
			if (!userEmail.equals("")) {
				String[] email = StringUtil.split(userEmail, "@");
				user.put("email_1", email[0]);
				user.put("email_2", email[1]);
			}

		}

		model.addAttribute("user", user);

		return ADMIN_PATH + "userWrite";
	}

	/**
	 * 관리자 쓰기 페이지로 이동한다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/managerWrite.do")
	public String managerWrite(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {

		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		Map<String, Object> param = _req.getParameterMap();
		Map<String, Object> user = new HashMap();
		List<Map<String, Object>> managerAuthList = null;

		List<Map<String, Object>> authList = userMtService.selectAuthList(param);

		if (!StringUtil.nvl(param.get("mode")).equals("W")) {

			// 사용자 정보를 가져온다.
			user = userMtService.selectUser(param);
			String userMobile = StringUtil.nvl(user.get("user_mobile"));
			if (!userMobile.equals("")) {
				String[] mobile = StringUtil.split(userMobile, "-");
				user.put("mobile_1", mobile[0]);
				user.put("mobile_2", mobile[1]);
				user.put("mobile_3", mobile[2]);
			}

			String userTel = StringUtil.nvl(user.get("user_tel"));
			if (!userTel.equals("")) {
				String[] tel = StringUtil.split(userTel, "-");
				user.put("tel_1", tel[0]);
				user.put("tel_2", tel[1]);
				user.put("tel_3", tel[2]);
			}

			String userEmail = StringUtil.nvl(user.get("user_email"));
			if (!userEmail.equals("")) {
				String[] email = StringUtil.split(userEmail, "@");
				user.put("email_1", email[0]);
				user.put("email_2", email[1]);
			}

			managerAuthList = userMtService.selectManagerAuthList(param);
		} else {
			managerAuthList = new ArrayList<Map<String, Object>>();
		}

		model.addAttribute("user", user);
		model.addAttribute("authList", authList);
		model.addAttribute("managerAuthList", managerAuthList);

		return ADMIN_PATH + "managerWrite";
	}

	/**
	 * 데이타를 저장한다
	 * 
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/insertUser.do")
	public ModelAndView insertUser(HttpServletRequest request, ExtHttpRequestParam _req, ModelMap model)
			throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {

			List<Map<String, Object>> list = null;
			if (StringUtil.nvl(param.get("user_gb")).equals("M"))
				list = (ArrayList<Map<String, Object>>) JsonUtil
						.fromJsonStr(param.get("manager_auth").toString().replace("&quot;", "'"));

			param.put("manager_auth", list);

			if (!StringUtil.nvl(param.get("user_pw")).equals(""))
				param.put("user_pw", CryptoUtil.SHA_encrypt((String) param.get("user_pw")));

			if (!StringUtil.nvl(param.get("user_mobile")).equals(""))
				param.put("user_mobile", CryptoUtil.AES_Encode((String) param.get("user_mobile")));

			if (!StringUtil.nvl(param.get("user_email")).equals(""))
				param.put("user_email", CryptoUtil.AES_Encode((String) param.get("user_email")));

			if (!StringUtil.nvl(param.get("user_tel")).equals(""))
				param.put("user_tel", CryptoUtil.AES_Encode((String) param.get("user_tel")));

			rv = userMtService.selectUserExist(param);

			if (rv < 1) {

				param.put("user_no", CommonUtil.createUUID());
				rv = userMtService.insertUser(param);

				if (rv > 0) {
					param.put("success", "true");
					param.put("message", MessageUtil.getInsertMsg(rv, _req));
				} else {
					param.put("success", "false");
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
				}
			} else {
				param.put("success", "false");
				param.put("message", "이미 등록된 사용자입니다.");
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
	 * 선택된 항목의 detail 값을 가지고 온다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/User.do")
	public String getUser(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		Map<String, Object> param = _req.getParameterMap();
		model.addAttribute("item", userMtService.selectUser(param));

		return ADMIN_PATH + "userEdit";
	}

	/**
	 * 데이타를 수정한다
	 * 
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/updateUser.do")
	public ModelAndView updateUser(HttpServletRequest request, ExtHttpRequestParam _req, ModelMap model)
			throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			List<Map<String, Object>> list = null;
			if (StringUtil.nvl(param.get("user_gb")).equals("M"))
				list = (ArrayList<Map<String, Object>>) JsonUtil
						.fromJsonStr(param.get("manager_auth").toString().replace("&quot;", "'"));

			param.put("manager_auth", list);

			if (!StringUtil.nvl(param.get("user_pw")).equals(""))
				param.put("user_pw", CryptoUtil.SHA_encrypt((String) param.get("user_pw")));

			if (!StringUtil.nvl(param.get("user_mobile")).equals(""))
				param.put("user_mobile", CryptoUtil.AES_Encode((String) param.get("user_mobile")));

			if (!StringUtil.nvl(param.get("user_email")).equals(""))
				param.put("user_email", CryptoUtil.AES_Encode((String) param.get("user_email")));

			if (!StringUtil.nvl(param.get("user_tel")).equals(""))
				param.put("user_tel", CryptoUtil.AES_Encode((String) param.get("user_tel")));

			rv = userMtService.updateUser(param);

			if (rv > 0) {
				param.put("success", "true");
				param.put("message", MessageUtil.getUpdatedMsg(rv, _req));
			} else {
				param.put("success", "false");
				param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
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
	 * 사용자를 삭제한다
	 * 
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/deleteUser.do")
	public ModelAndView deleteUser(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {

			UserVO userVo = _req.getSessionUser();
			String s_user_no = userVo.getUserNo();

			String user_no = StringUtil.nvl(param.get("user_no"));

			if (user_no.equals(s_user_no)) {

				param.put("success", "false");
				param.put("message", "본인은 삭제할 수 없습니다.");

			} else {

				rv = userMtService.deleteUser(param);

				if (rv > 0) {
					param.put("success", "true");
					param.put("message", MessageUtil.getDeteleMsg(rv, _req));
				} else {
					param.put("success", "false");
					param.put("message", MessageUtil.getProcessFaildMsg(rv, _req));
				}

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
	 * 비밀번호 초기화
	 * 
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/updatePasswordChange.do")
	public ModelAndView updatePasswordChange(HttpServletRequest request, ExtHttpRequestParam _req, ModelMap model)
			throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {

			String imsiPwd = RandomStringUtils.randomAlphanumeric(10);
			param.put("user_pw", CryptoUtil.SHA_encrypt(imsiPwd));

			rv = userMtService.updatePasswordChange(param);

			if (rv > 0) {

				// SMS를 전송
				// SmsSend sms = new SmsSend();
				// Map<String, Object> user = userMtService.selectUser(param);
				// sms.sendMessage(StringUtil.replace(StringUtil.nvl(user.get("user_mobile")),
				// "-", ""), imsiPwd, "0221336588");
				// param.put("success", "true");
				// param.put("message", "회원의 비밀번호 초기화에 성공하였으며 사용자에게 문자를
				// 발송하였습니다.");

				param.put("success", "true");
				param.put("message", "회원의 비밀번호 초기화에 성공하였습니다.");

			} else {
				param.put("success", "false");
				param.put("message", "회원의 비밀번호 초기화에 실패하였습니다.");
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
	 * 아이디 중복체크
	 * 
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/userIdCheck.do")
	public ModelAndView userIdCheck(HttpServletRequest request, ExtHttpRequestParam _req, ModelMap model)
			throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {

			rv = userMtService.selectUserExist(param);

			if (rv > 0) {
				param.put("success", "false");
				param.put("message", "중복 아이디가 존재합니다. 다른 아이디를 입력해주십시요.");
			} else {
				param.put("success", "true");
				param.put("message", "사용할 수 있는 아이디입니다.");
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
	 * 메인 패스워드 변경 팝업으로 이동한다.(90일 기준)
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/pwdChangePopup.do")
	public String pwdChangePopup(ExtHttpRequestParam _req, ModelMap model) throws Exception {
	    
		return "/popup"+ADMIN_PATH + "pwdChangePopup";
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
	@RequestMapping(value = "/admin/user/passwordChange.do")
	public ModelAndView passwordChange(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		int rv = 0;
		int chk = 0;
		Map<String, Object> param = _req.getParameterMap();

		try {
			
			param.put("user_pw", CryptoUtil.SHA_encrypt(StringUtil.nvl(param.get("user_pw"))));
			rv = userMtService.updatePasswordChange(param);

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
	 * 권한별 관리자 리스트 페이지로딩후 grid 데이터를 가지고 온다
	 * 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/authUserPageList.do")
	public ModelAndView selectUserAuthPageList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param = navigator.getParam();
		navigator.setList(userMtService.selectUserAuthPageList(param));

		return ViewHelper.getJqGridView(navigator);
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
	@RequestMapping(value = "/admin/user/sessionMenu.do")
	public ModelAndView sessionMenu(ExtHttpRequestParam _req, HttpServletRequest req) throws Exception {

		int rv = 0;
		Map<String, Object> param = _req.getParameterMap();
		HttpSession session = req.getSession();

		String topMenu = StringUtil.nvl(param.get("topmenu_id"));
		if (!topMenu.equals("")) {
			session.setAttribute("admin_g_topmenu_id", topMenu);
		}

		String topMenuNm = StringUtil.nvl(param.get("topmenu_nm"));
		if (!topMenuNm.equals("")) {
			session.setAttribute("admin_g_topmenu_nm", topMenuNm);
		}

		String subMenu = StringUtil.nvl(param.get("submenu_id"));
		if (!subMenu.equals("")) {

			param.put("menu_id", subMenu);
			param.put("homepage", "B");

			Map<String, Object> menu = menuMtService.selectMenu(param);

			session.setAttribute("admin_g_submenu_id", subMenu);
			session.setAttribute("admin_g_submenu_nm", menu.get("menu_nm"));
			session.setAttribute("admin_g_submenu_desc", menu.get("menu_desc"));
			session.setAttribute("admin_g_up_menu_id", menu.get("up_menu_id"));

			String menuNavi = StringUtil.nvl(menu.get("menu_navi"));
			session.setAttribute("admin_g_menu_navi", getNavi(menuNavi));
		}

		param.put("success", "true");

		return ViewHelper.getJsonView(param);
	}

	/**
	 * 관리자단 네비게이션을 만들어준다.
	 * 
	 * @param menuNavi
	 * @return
	 */
	private String getNavi(String menuNavi) {

		StringBuffer retVal = new StringBuffer().append("<li>HOME</li>");

		if (menuNavi != null && menuNavi.length() > 1) {

			// 쿼리에서 마지막에 토큰(#) 들어가서 그 부분을 삭제하기 위해서 처리
			if (menuNavi.charAt(menuNavi.length() - 1) == '#')
				menuNavi = menuNavi.substring(0, menuNavi.length() - 1);

			String[] menuArr = StringUtil.split(menuNavi, "#");

			for (int i = 0; i < menuArr.length; i++) {
				if (i == (menuArr.length - 1)) {
					retVal.append("<li><strong>").append(menuArr[i]).append("</strong></li>");
				} else {
					retVal.append("<li>").append(menuArr[i]).append("</li>");
				}
			}
		}

		return retVal.toString();
	}

	/**
	 * 관리자단 권한을 수정해준다.
	 * 
	 * @param _req
	 * @param model
	 * @param validator
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/user/sessionChangeAuthId.do")
	public ModelAndView sessionChangeAuthId(ExtHttpRequestParam _req, HttpServletRequest req) throws Exception {

		int rv = 0;

		Map<String, Object> param = _req.getParameterMap();
		HttpSession session = req.getSession();

		String authId = StringUtil.nvl(param.get("auth_id"));

		session.setAttribute("s_auth_id", authId);
		session.setAttribute("admin_g_topmenu_id", "");
		session.setAttribute("admin_g_topmenu_nm", "");
		session.setAttribute("admin_g_submenu_id", "");
		session.setAttribute("admin_g_submenu_nm", "");
		session.setAttribute("admin_g_submenu_desc", "");
		session.setAttribute("admin_g_up_menu_id", "");
		session.setAttribute("admin_g_menu_navi", "");

		return ViewHelper.getJsonView(param);
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
	@RequestMapping(value = "/admin/user/sessionPage.do")
	public ModelAndView sessionPage(ExtHttpRequestParam _req, HttpServletRequest req) throws Exception {

		int rv = 0;

		Map<String, Object> param = _req.getParameterMap();
		param.put("homepage", "B");

		Map<String, Object> menu = menuMtService.selectMenu(param);
		HttpSession session = req.getSession();

		String topMenu = StringUtil.nvl(menu.get("topmenu_id"));
		session.setAttribute("admin_g_topmenu_id", topMenu);

		String topMenuNm = StringUtil.nvl(menu.get("topmenu_nm"));
		session.setAttribute("admin_g_topmenu_nm", topMenuNm);

		String subMenu = StringUtil.nvl(menu.get("menu_id"));
		session.setAttribute("admin_g_submenu_id", subMenu);
		session.setAttribute("admin_g_submenu_nm", menu.get("menu_nm"));
		session.setAttribute("admin_g_submenu_desc", menu.get("menu_desc"));
		session.setAttribute("admin_g_up_menu_id", menu.get("up_menu_id"));

		String menuNavi = StringUtil.nvl(menu.get("menu_navi"));
		session.setAttribute("admin_g_menu_navi", getNavi(menuNavi));

		param.put("menu", menu);
		param.put("success", "true");

		return ViewHelper.getJsonView(param);
	}
	
	
	
	@RequestMapping(value = "/admin/user/loginHistoryListPage.do")
	public String loginHistoryListPage(ExtHttpRequestParam _req, ListOp listOp, ModelMap model) throws Exception {

        String curdate = DateUtil.getCurrentDateTimeFormat("yyyy-MM-dd");
        model.addAttribute("curdate", curdate);		
		
		model.addAttribute(ListOp.LIST_OP_NAME, listOp);

		return ADMIN_PATH + "loginHistoryListPage";
	}
	
	
	@RequestMapping(value = "/admin/user/loginHistoryList.do")
	public ModelAndView loginHistoryList(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		NavigatorInfo navigator = new NavigatorInfo(_req);
		Map<String, Object> param = navigator.getParam();
		String startDate = StringUtil.nvl(param.get("p_conn_stadt"));
		String endDate = StringUtil.nvl(param.get("p_conn_enddt"));
		String userId = StringUtil.nvl(param.get("p_user_id"));
		
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		param.put("userId", userId);

		List<Map<String, Object>> list = userService.selectLoginHistoryList(param);

		navigator.setList(list);

		return ViewHelper.getJqGridView(navigator);
	}	
	
	
    @RequestMapping(value = "/admin/user/loginHistoryListExcel.do")
    public ModelAndView loginHistoryListExcel(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        NavigatorInfo navigator = new NavigatorInfo(_req);
        navigator.setPageSize( 99999 );
        Map<String, Object> param = navigator.getParam();
        
		String startDate = StringUtil.nvl(param.get("p_conn_stadt"));
		String endDate = StringUtil.nvl(param.get("p_conn_enddt"));
		String userId = StringUtil.nvl(param.get("p_user_id"));
		
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		param.put("userId", userId);
        
        param.put("miv_end_index", 9999999);
        logger.debug(param);
        
        model.put( "excelName", "로그인 이력" );
		model.put( "sheetName" , "로그인 이력" );    	 
		 
		List<String[]> headerMap = new ArrayList<String[]>();
		headerMap.add( new String[]{ "아이디","이름","아이피","로그인여부","시스템","로그인일시" } );
		String[] columnMap = new String[]{ "user_id","user_nm","ip","access_yn","system","login_date" };
		short[] alignMap = new short[]{ HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.ALIGN_LEFT , HSSFCellStyle.ALIGN_LEFT };
		 
		model.put( "headerMap" , headerMap );
		model.put( "columnMap" , columnMap );
		model.put( "alignMap" , alignMap );	
		model.put("userId", userId);
		model.put( "dataMap" , userService.selectLoginHistoryList(param) );
		 
		 
		return new ModelAndView( "excelDownView" , "model" , model );        
    }	

}
