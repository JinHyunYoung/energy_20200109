package kr.or.wabis.admin.contents.controller;

import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.web.controller.AbstractController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by my on 2017-11-05.
 */
@Controller("SponsorStaController")
public class SponsorStaController extends AbstractController {

    private Logger logger = Logger.getLogger(SponsorStaController.class);

    private final static String ADMIN_PATH = "/admin/contents/";
    /**
     * 리스트 페이지로 이동한다
     *
     * @param _req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/sponsor/sponsorStaListPage.do")
    public String sponsorStaListPage(ExtHttpRequestParam _req, ModelMap model) throws Exception {
        return ADMIN_PATH + "sponsorStaListPage";
    }

}
