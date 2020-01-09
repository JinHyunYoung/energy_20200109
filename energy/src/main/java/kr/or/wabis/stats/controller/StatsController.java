package kr.or.wabis.stats.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;

import kr.or.wabis.framework.web.controller.AbstractController;
import kr.or.wabis.stats.service.StatsService;

@Controller("statsController")
public class StatsController extends AbstractController {
    
    private Logger logger = Logger.getLogger(StatsController.class);
    
    private final static String WEB_PATH = "/web/stats/";
    
    @Resource(name = "statsService")
    private StatsService statsService;
}
