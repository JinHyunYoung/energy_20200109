package kr.or.wabis.contents.controller;

import kr.or.wabis.contents.service.IntroPageService;
import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("introPageController")
public class IntroPageController extends AbstractController {
    
    private Logger logger = Logger.getLogger(IntroPageController.class);
    
    private final static String WEB_PATH = "/web/contents/";
    
    @Resource(name = "introPageService")
    private IntroPageService introPageService;
        
    /**
     * 인트로 보기 페이지로 이동을 한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageShow.do")
    public String intropageShow(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        Map<String, Object> intropage = introPageService.selectIntropage(param); 	
        
        model.addAttribute("intropage", intropage);
        
        return WEB_PATH + "intropageShow";
    } 
    
    /**
     * 인트로 보기 페이지 첨부파일 목록을 조회한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageFileList.do")
    public ModelAndView intropageFileList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	   
    	Map<String, Object> param = _req.getParameterMap();
    	
    	param.put("use_yn", "Y");//사용자화면에서는 사용여부 Y인거만 가져온다.
    	String group_id = (String) param.get("group_id");
    	  if (group_id == null) {
              // 그룹아이디가 없는경우 전체를 가져오기 방지
              param.put("group_id", "A"); 
          }
       
        List list = null;
		try {
			
			List<CommonFileVO> fileList = commonFileService.getCommonFileList(param);
			
			list = new ArrayList();
			for (CommonFileVO file : fileList) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("file_id", file.getFile_id());
				map.put("file_nm", file.getFile_nm());
				map.put("ori_file_nm", file.getOriginFileNm());
				map.put("file_title", file.getFile_title());
				map.put("use_yn", file.getUse_yn());
				map.put("sort", file.getSort());
				list.add(map);
			}
		} catch (Exception e) {
			param.put("success", "false"); 
		}
        
        param.put("files", list);
        param.put("success", "true");
        
        return ViewHelper.getJsonView(param);
    }

    /**
     * 설립목적 보기 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageVision.do")
    public String intropageVision(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> intropage = introPageService.selectIntropage(param);

        model.addAttribute("intropage", intropage);

        return WEB_PATH + "intropageVision";
    }
    /**
     * 연혁 보기 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageHistory.do")
    public String intropageHistory(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> intropage = introPageService.selectIntropage(param);

        model.addAttribute("intropage", intropage);

        return WEB_PATH + "intropageHistory";
    }
    /**
     * 조직도 보기 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageDept.do")
    public String intropageDept(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> intropage = introPageService.selectIntropage(param);

        model.addAttribute("intropage", intropage);

        return WEB_PATH + "intropageDept";
    }

    /**
     * CI 보기 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageCI.do")
    public String intropageCI(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> intropage = introPageService.selectIntropage(param);

        model.addAttribute("intropage", intropage);

        return WEB_PATH + "intropageCI";
    }
    /**
     * 오시는길 보기 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageComing.do")
    public String intropageComing(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> intropage = introPageService.selectIntropage(param);

        model.addAttribute("intropage", intropage);

        return WEB_PATH + "intropageComing";
    }
    /**
     * 윤리경영 보기 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageManagement.do")
    public String intropageManagement(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> intropage = introPageService.selectIntropage(param);

        model.addAttribute("intropage", intropage);

        return WEB_PATH + "intropageManagement";
    }
    /**
     * 윤리경영 보기 페이지로 이동을 한다.
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageManagementSub.do")
    public String intropageManagementSub(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        Map<String, Object> param = _req.getParameterMap();

        Map<String, Object> intropage = introPageService.selectIntropage(param);

        model.addAttribute("intropage", intropage);

        return WEB_PATH + "intropageManagementSub";
    } 
    
    /**
     * 인트로 보기 페이지 첨부파일 목록을 조회한다.
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/web/intropage/intropageInfo.do")
    public ModelAndView intropageInfo(ExtHttpRequestParam _req, ModelMap model) throws Exception {
    	   
    	Map<String, Object> param = _req.getParameterMap();
        Map<String, Object> intropage = introPageService.selectIntropage(param);    	
        param.put("intropage", intropage);
        
        return ViewHelper.getJsonView(param);
    }
}
