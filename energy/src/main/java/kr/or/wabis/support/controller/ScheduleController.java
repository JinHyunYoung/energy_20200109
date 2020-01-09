package kr.or.wabis.support.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.wabis.framework.fileupload.vo.CommonFileVO;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.framework.web.view.ViewHelper;
import kr.or.wabis.support.service.ScheduleService;
import kr.or.wabis.user.vo.UserVO;

@Controller("scheduleController")
public class ScheduleController extends AbstractController {
    
    private Logger logger = Logger.getLogger(this.getClass());
    
    private final static String WEB_PATH = "/web/support/";
    
    @Resource(name = "scheduleService")
    private ScheduleService scheduleService;
    
    // 행사일정관리 조회
    @RequestMapping(value = "/web/support/selectScheduleList.do")
    public String scheduleList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return WEB_PATH + "schedule";
    }
    
    // 행사일정관리 조회
    @RequestMapping(value = "/web/support/loadScheduleList.do")
    public ModelAndView loadScheduleList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = scheduleService.selectScheduleList(param);
        
        for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Map<String, Object> map = (Map<String, Object>) iterator.next();

			String group_id = StringUtil.nvl(map.get("group_id"));
			if (!group_id.equals("")) {
				param.put("group_id", group_id);
		        List<CommonFileVO> attach = commonFileService.getCommonFileList(param);
		        map.put("attach", attach);
			}
		}
        
        param.put("list", list);
        
        return ViewHelper.getJsonView(param);
        
    }
    
    // 행사일정관리 조회 (메인용)
    @RequestMapping(value = "/web/support/loadMainScheduleList.do")
    public ModelAndView loadMainScheduleList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        List<Map<String, Object>> list = scheduleService.selectScheduleListMain(param);
        param.put("list", list);
        
        return ViewHelper.getJsonView(param);
        
    }
    
}
