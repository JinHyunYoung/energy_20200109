package kr.or.wabis.framework.web.controller;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.wabis.framework.code.CommCdCondVo;
import kr.or.wabis.framework.code.CommCdVo;
import kr.or.wabis.framework.exception.BizException;
import kr.or.wabis.framework.util.CodeUtil;
import kr.or.wabis.framework.util.LocaleUtil;
import kr.or.wabis.framework.util.MessageUtil;
import kr.or.wabis.framework.web.service.FileMtService;
import kr.or.wabis.framework.web.vo.AttchFileInfoVo;
import kr.or.wabis.framework.web.vo.ElecDocAttchFileInfoVo;

@Controller("frameworkController")
public class FrameworkController {
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    @Resource(name = "fileMtService")
    private FileMtService fileMtService;
    
    /**
     * searchCode != 특정 Code 조회 =!
     * 
     * @param CommCdCondVo- vo
     * @return List<CommCdVo>
     * @throws Exception
     */
    @RequestMapping(value = "/comm/searchCode.do")
    @ResponseBody
    public List<CommCdVo> searchCode(ModelMap model, CommCdCondVo vo) throws Exception {
        vo.setLngaCd(LocaleUtil.getLanguage());
        return CodeUtil.getCode(vo);
    }
    
    /**
     * Reload Codes != Code 재조회 =!
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/comm/reloadCodeAll.do")
    public String reloadCodeAll(ModelMap model) throws Exception {
        return "jsonView";
    }
    
    /**
     * call validation result page != 밸리데이션 검증결과 페이지로 이동 =!
     *
     * @param PstatVo - pstatVo
     * @param ModelMap - model
     * @param HttpServletRequest- request
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/comm/moveValidationResult.do")
    public String moveValidationResult(@RequestParam(value = "excelYn", defaultValue = "N") String excelYn, ModelMap model) throws Exception {      
        // return pure jsp, NOT Tiles
        return "N".equals(excelYn) ? "/comm/validationResult" : "/comm/validationResultExcel";
    }
    
    /**
     * Download Attachment in the Normal Screen, not Electronic Document != 첨부파일 다운로드 =!
     *
     * @param ElecDocAttchFileInfoVo - iElecDocAttchFileInfoVo
     * @param ModelMap - model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/comm/downloadNormalAttchFile.do")
    public String downloadNormalAttchFile(AttchFileInfoVo iAttchFileInfoVo, ModelMap model) throws Exception {
        AttchFileInfoVo retVo = fileMtService.searchNormalAttchFile(iAttchFileInfoVo);
        
        // physical save path
        String attchFilePathNm = retVo.getAttchFilePathNm(); 
        
        // physical save filename
        String attchFileStrgNm = retVo.getAttchFileStrgNm();
        
        // original filename
        String attchFileOgnlFileNm = retVo.getAttchFileOgnlFileNm(); 
        
        File file = new File(attchFilePathNm, attchFileStrgNm);
        if (!file.exists()) {
            
            // File
            String str = "File"; 
            
            // {0} not exists != 해당 {0}는(은) 존재하지 않습니다 =!
            String msg = "해당" + attchFileStrgNm + "는(은) 존재하지 않습니다.";
            log.error("### file not found : {}", file.getAbsolutePath());
            
            throw new BizException(msg);
        }
        
        model.addAttribute("downloadFile", file);
        model.addAttribute("downloadFileName", attchFileOgnlFileNm);
        
        return "fileDownloadView";
    }
    
    /**
     * Get Base64 Binaray for Image Preview != 이미지 미리보기를 위해 Base64로 리턴 =!
     *
     * @param ElecDocAttchFileInfoVo - iElecDocAttchFileInfoVo
     * @param ModelMap - model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/comm/previewImage.do")
    @ResponseBody
    public String previewImage(ElecDocAttchFileInfoVo iElecDocAttchFileInfoVo, ModelMap model) throws Exception {
        
        ElecDocAttchFileInfoVo retVo = fileMtService.searchElecDocAttchFile(iElecDocAttchFileInfoVo);
        
        // physical save path
        String attchFilePathNm = retVo.getAttchFilePathNm(); 
        
        // physical save filename
        String attchFileStrgNm = retVo.getAttchFileStrgNm();         
        
        File file = new File(attchFilePathNm, attchFileStrgNm);
        if (!file.exists()) {
            
            // File
            String str = MessageUtil.getMessage("system.00037"); 

            // {0} not exists != 해당 {0}는(은) 존재하지 않습니다 =!
            String msg = MessageUtil.getMessage("system.20012", new String[] { str }); 
            log.error("### file not found : {}", file.getAbsolutePath());
            throw new BizException(msg);
        }
        
        byte[] filebyte = FileUtils.readFileToByteArray(file);
        String base64 = org.apache.commons.codec.binary.Base64.encodeBase64String(filebyte);
        
        return base64;
    }
    
}
