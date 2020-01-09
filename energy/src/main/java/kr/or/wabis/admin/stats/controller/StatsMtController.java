package kr.or.wabis.admin.stats.controller;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.wabis.admin.stats.service.StatsMtService;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.controller.AbstractController;

@Controller("statsMtController")
public class StatsMtController extends AbstractController {
    
    private Logger logger = Logger.getLogger(StatsMtController.class);
    
    private final static String ADMIN_PATH = "/admin/stats/";
    
    @Resource(name = "statsMtService")
    private StatsMtService statsMtService;
        
    /**
     * 시간대별 접속 통계 리스트 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/homepageconnHour.do")
    public String homepageconnHour(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        String curdate = DateUtil.getCurrentDateTimeFormat("yyyy-MM-dd");
        model.addAttribute("curdate", curdate);
        
        Map<String, Object> param = _req.getParameterMap();
        model.addAttribute("conntot", statsMtService.selectHomepageconnTotal(param));
        
        return ADMIN_PATH + "homepageconnHour";
    }
    
    /**
     * 시간대별 접속 통계 리스트 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/homepageconnHourTable.do")
    public String homepageconnHourTable(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        
        Map<String, Object> connhour = statsMtService.selectHomepageconnHour(param);
        if (connhour == null) {
            connhour = new HashMap();
            
        }
        model.addAttribute("connhour", connhour);
        
        return "/sub" + ADMIN_PATH + "homepageconnHourTable";
    }
    
    /**
     * 일자별 접속 통계 리스트 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/homepageconnDay.do")
    public String homepageconnDay(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        String curdate = DateUtil.getCurrentDateTimeFormat("yyyy-MM-dd");
        model.addAttribute("curdate", curdate);
        
        Map<String, Object> param = _req.getParameterMap();
        model.addAttribute("conntot", statsMtService.selectHomepageconnTotal(param));
        
        return ADMIN_PATH + "homepageconnDay";
    }
    
    /**
     * 일자별 접속 통계 리스트 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/homepageconnDayList.do")
    public @ResponseBody Map<String, Object> homepageconnDayList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsMtService.selectHomepageconnDay(param);        
        param.put("rows", list);
        
        return param;
    }
    
    /**
     * 연별 접속 통계 리스트 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/homepageconnYear.do")
    public String homepageconnYear(ExtHttpRequestParam _req, ModelMap model) throws Exception {
                
        Map<String, Object> param = _req.getParameterMap();
        model.addAttribute("conntot", statsMtService.selectHomepageconnTotal(param));
        
        return ADMIN_PATH + "homepageconnYear";
    }
    
    /**
     * 년별 접속 통계 리스트 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/homepageconnYearList.do")
    public @ResponseBody Map<String, Object> homepageconnYearList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsMtService.selectHomepageconnYear(param);        
        param.put("rows", list);
        
        return param;
    }
    

    
    /**
     * 메뉴 기간별 접속 현황 통계 리스트 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/menuconnPeriod.do")
    public String menuconnPeriod(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        String curdate = DateUtil.getCurrentDateTimeFormat("yyyy-MM-dd");
        model.addAttribute("curdate", curdate);
        
        return ADMIN_PATH + "menuconnPeriod";
    }
    
    /**
     * 메뉴 기간별 접속 현황 통계 리스트 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/menuconnPeriodList.do")
    public @ResponseBody Map<String, Object> menuconnPeriodList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsMtService.selectMenuconnPeriod(param);        
        param.put("dataList", list);
        
        return param;
    }
    

    
    /**
     * 메뉴 월별 접속 현황 통계 리스트 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/menuconnMonth.do")
    public String menuconnMonth(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        String curYear = DateUtil.getCurrentDateTimeFormat("yyyy");
        model.addAttribute("curYear", curYear);
        
        return ADMIN_PATH + "menuconnMonth";
    }
    
    /**
     * 메뉴 월별 접속 현황 통계 리스트 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/menuconnMonthList.do")
    public @ResponseBody Map<String, Object> menuconnMonthList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsMtService.selectMenuconnMonth(param);      
        
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        Map<String, Object> pre_map = null;
        String menu_id = "", pre_menu_id = "";
        int mm = 0, conn_cnt = 0;
        
        // 테이블에서 조회시 결과 값을 맵에 일별로 다시 데이타를 변환한다.
        for(Map<String, Object> map : list){
            
            menu_id = map.get("menu_id").toString();            
            mm = Integer.parseInt(StringUtil.nvl(map.get("mm"), "0"));
            conn_cnt = Integer.parseInt(StringUtil.nvl(map.get("conn_cnt"), "0"));
            
            if(pre_menu_id.equals(menu_id)){
                
                if(pre_map != null) {
                    pre_map.put("conn_cnt_" + mm, conn_cnt);                    
                }
                
            } else {
                
                dataList.add(map);
                
                // 일별로 카운트를 0 으로 생성한다.
                for(int i = 1; i <= 12; i++){
                    map.put("conn_cnt_" + i, "0");
                }
                
                map.put("conn_cnt_" + mm, conn_cnt);
                
                pre_map = map;
                
            }
            
            pre_menu_id = menu_id;
        }
        
        param.put("dataList", dataList);
        
        return param;
    }
    

    
    /**
     * 메뉴 일자별  접속 통계 리스트 페이지로 이동한다.
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/menuconnDay.do")
    public String menuconnDay(ExtHttpRequestParam _req, ModelMap model) throws Exception {

        String curYear = DateUtil.getCurrentDateTimeFormat("yyyy");
        model.addAttribute("curYear", curYear);        

        String curMonth = "" + (new GregorianCalendar().get(GregorianCalendar.MONTH) + 1);
        model.addAttribute("curMonth", curMonth);
                      
        return ADMIN_PATH + "menuconnDay";
    }
    
    /**
     * 메뉴 일자별 접속 통계 리스트 데이터를 가지고 온다
     * 
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/stats/menuconnDayList.do")
    public @ResponseBody Map<String, Object> menuconnDayList(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        
        Map<String, Object> param = _req.getParameterMap();
        
        List<Map<String, Object>> list = statsMtService.selectMenuconnDay(param);
        
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        Map<String, Object> pre_map = null;
        String menu_id = "", pre_menu_id = "";
        int dd = 0, conn_cnt = 0;
        
        // 테이블에서 조회시 결과 값을 맵에 일별로 다시 데이타를 변환한다.
        for(Map<String, Object> map : list){
            
            menu_id = map.get("menu_id").toString();            
            dd = Integer.parseInt(StringUtil.nvl(map.get("dd"), "0"));
            conn_cnt = Integer.parseInt(StringUtil.nvl(map.get("conn_cnt"), "0"));
            
            if(pre_menu_id.equals(menu_id)){
                
                if(pre_map != null) {
                    pre_map.put("conn_cnt_" + dd, conn_cnt);                    
                }
                
            } else {
                
                dataList.add(map);
                
                // 일별로 카운트를 0 으로 생성한다.
                for(int i = 1; i <= 31; i++){
                    map.put("conn_cnt_" + i, "0");
                }
                
                map.put("conn_cnt_" + dd, conn_cnt);
                
                pre_map = map;
                
            }
            
            pre_menu_id = menu_id;
        }
        
        param.put("dataList", dataList);
        
        return param;
    }
}
