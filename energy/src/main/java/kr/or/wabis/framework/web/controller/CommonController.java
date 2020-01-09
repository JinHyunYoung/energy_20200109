package kr.or.wabis.framework.web.controller;

import kr.or.wabis.framework.util.ExtHttpRequestParam;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController extends AbstractController {
    
    /**
     * 에러 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/error.do")
    public String error(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        return "/root/error";
    }
    
    /**
     * 권한없음 페이지로 이동한다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/auth.do")
    public String auth(ExtHttpRequestParam _req, ModelMap model) throws Exception {        
        return "/root/auth";
    }

	/**
	 * 본인인증 폰
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/common/phone.do")
	public String phone(ExtHttpRequestParam _req, ModelMap model) throws Exception {
		                
		return "/sub/web/common/checkplus_main";
	} 
	
	/**
	 * 본인인증 완료
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/common/phone_result.do")
	public String phone_result(ExtHttpRequestParam _req, ModelMap model) throws Exception {
	    	
		return "/sub/web/common/checkplus_success";
	} 

	/**
	 * ipin인증 
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/common/ipin.do")
	public String ipin(ExtHttpRequestParam _req, ModelMap model) throws Exception {

		return "/sub/web/common/ipin_main";
	} 
	
	/** 
	 * ipin인증 완료
	 * @param _req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/web/common/ipin_result.do")
	public String ipin_result(ExtHttpRequestParam _req, ModelMap model) throws Exception {
	    	
		return "/sub/web/common/ipin_result";
	} 
}
