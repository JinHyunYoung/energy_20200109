package kr.or.wabis.framework.web.tld;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.service.FileMtService;
import kr.or.wabis.framework.web.vo.AttchFileInfoVo;

public class FileNormal extends ExtendedTagSupport {
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    // 첨부파일관리번호
    private String attchFileMtNo;
    
    private String readonly;
    
    private boolean showElecDocTrgtYn = false;
    
    public String getAttchFileMtNo() {
        return attchFileMtNo;
    }
    
    public void setAttchFileMtNo(String attchFileMtNo) {
        this.attchFileMtNo = attchFileMtNo;
    }
    
    public String getReadonly() {
        return readonly;
    }
    
    public void setReadonly(String readonly) {
        this.readonly = readonly;
    }
    
    public boolean isShowElecDocTrgtYn() {
        return showElecDocTrgtYn;
    }
    
    public void setShowElecDocTrgtYn(boolean showElecDocTrgtYn) {
        this.showElecDocTrgtYn = showElecDocTrgtYn;
    }
    
    @Override
    public void doTag() throws JspException, IOException {
        
        StringBuffer tagBuffer = new StringBuffer();
        
        tagBuffer.append(startTag());
        tagBuffer.append(generatorTheadTable());
        tagBuffer.append(generatorTbodyTable());
        tagBuffer.append(endTag());
        
        getJspContext().getOut().print(tagBuffer.toString());
    }
    
    /**
     * 
     * @return
     */
    private String startTag() {
        return "<div class=\"table-grid table-responsive\">\n<table class=\"table\" id=\"attchFileTable\">";
    }
    
    /**
     * 
     * @return
     */
    private String endTag() {
        return "</table>\n</div>";
    }
    
    /**
     * 
     * @return
     */
    private String generatorTheadTable() {
        
        boolean isReadOnly = "readonly".equals(readonly);
        
        String contextRoot = getRequest().getContextPath();
        StringBuffer buffer = new StringBuffer();
        
        buffer.append("<colgroup>");
        buffer.append("  <col width=`80px` />"); // No, Choice
        buffer.append("  <col width=`*` />"); // attach !=첨부=!
        
        if (showElecDocTrgtYn) {
            buffer.append("  <col width=`120px` />"); // send target !=전송대상=!
        }
        
        buffer.append("</colgroup>");
        buffer.append("<thead>");
        
        if (!isReadOnly) {
            buffer.append("<tr>");
            buffer.append("    <th colspan=`" + (showElecDocTrgtYn ? 3 : 2) + "` class=`text-right`>");
            buffer.append("        <a href=`#` style=`text-decoration: none;` onclick=`cf_addAttchFile();return false;`>" + getMessage("system.00038") + " <img src=`" + contextRoot + "/images/common/btn_plus.png` /></a>"); // 파일추가
            buffer.append("        &nbsp;&nbsp;");
            buffer.append("        <a href=`#` style=`text-decoration: none;` onclick=`cf_delAttchFile();return false;`>" + getMessage("system.00039") + " <img src=`" + contextRoot + "/images/common/btn_minus.png` /></a>"); // 파일삭제
            buffer.append("    </th>");
            buffer.append("</tr>");
        }
        
        buffer.append("<tr>");
        buffer.append("    <th class=`text-center`>" + getMessage(isReadOnly ? "system.00024" : "system.00022") + "</th>"); // No, Choice
        buffer.append("    <th class=`text-center`>" + getMessage("system.00027") + "</th>"); // 첨부
        
        if (showElecDocTrgtYn) {
            buffer.append("    <th class=`text-center`>" + getMessage("system.00042") + "</th>"); // 전송대상
        }
        
        buffer.append("</tr>");
        buffer.append("</thead>");
        
        String ret = StringUtil.replace(buffer.toString(), "`", "\"");
        
        return ret;
    }
    
    /**
     * 
     * @return
     */
    private String generatorTbodyTable() {
        
        String contextRoot = getRequest().getContextPath();
        StringBuffer buffer = new StringBuffer();
        
        List<AttchFileInfoVo> docAttchList = null;
        try {
            FileMtService service = (FileMtService) getServiceBean("fileMtService");
            
            if (StringUtil.isEmpty(attchFileMtNo)) {
                docAttchList = new ArrayList<>();
            } else {
                docAttchList = service.searchNormalAttchFileList(attchFileMtNo);
            }
            
        } catch (Exception e) {
            log.error("{}", e.getMessage());
        }
        
        boolean isReadOnly = "readonly".equals(readonly);
        
        buffer.append("<tbody>");
        
        int index = 0;
        for (AttchFileInfoVo fileVo : docAttchList) {
            
            // for link
            String attchFileMtNo = fileVo.getAttchFileMtNo(); // pk.
            String attchFileSn = fileVo.getAttchFileSn() + ""; // pk. Attach File Sn.
            String attchFileOgnlFileNm = fileVo.getAttchFileOgnlFileNm(); // 첨부파일원본파일
            String elecDocTrgtYn = fileVo.getElecDocTrgtYn(); // 전자문서대상여부
            
            buffer.append("<tr>");
            if (isReadOnly) {
                buffer.append("    <td class=`text-center`>" + (index + 1) + "</td>");
            } else {
                buffer.append("    <td class=`text-center`><input type=`checkbox` id=`choiceCheckbox` /></td>\n");
            }
            
            buffer.append("    <td>");
            buffer.append("        <a href=`#` onclick=`cf_downloadNormalAttchFile('" + attchFileMtNo + "','" + attchFileSn + "');return false;` id=`linkDownloadFile`>" + attchFileOgnlFileNm + "</a>");
            
            buffer.append("        <input type=`file`   name=`attchFileList[" + index + "].attchFile` style=`display:none;` />");
            
            buffer.append("        <input type=`hidden` name=`attchFileList[" + index + "].attchFileMtNo` value=`" + attchFileMtNo + "` />");
            
            buffer.append("        <input type=`hidden` name=`attchFileList[" + index + "].attchFileSn`   value=`" + attchFileSn + "` />");
            
            buffer.append("    </td>");
            
            if (showElecDocTrgtYn) {
                String checked = "Y".equals(elecDocTrgtYn) ? "checked=`checked`" : "";
                buffer.append("    <td class=`text-center`><input type=`checkbox` id=`elecDocTrgtYn` name=`attchFileList[" + index + "].elecDocTrgtYn` value=`Y` " + checked + " /></td>");
            }
            
            buffer.append("</tr>");
            
            index++;
        }
        
        if (isReadOnly) {
            
            if (docAttchList.isEmpty()) {
                buffer.append("<tr>");
                buffer.append("    <td colspan=`2` class=`text-center`>" + getMessage("system.20002") + "</td>"); // search result not exists
                buffer.append("</tr>");
            }
            
        } else {
            
            buffer.append("<tr>");
            buffer.append("    <td class=`text-center`><input type=`checkbox` id=`choiceCheckbox` /></td>\n");
            buffer.append("    <td><input type=`file` style=`width:99%;` id=`attchFile` name=`attchFileList[" + index + "].attchFile` /></td>\n");
            if (showElecDocTrgtYn) {
                buffer.append("    <td class=`text-center`><input type=`checkbox` id=`elecDocTrgtYn` name=`attchFileList[" + index + "].elecDocTrgtYn` value=`Y` checked=`checked`></td>\n");
            }
            buffer.append("</tr>");
        }
        
        buffer.append("</tbody>");
        
        String ret = StringUtil.replace(buffer.toString(), "`", "\"");
        
        return ret;
    }
    
}
