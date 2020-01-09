package kr.or.wabis.framework.util;

import java.io.File;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileUtil {
    
    private static Logger log = LoggerFactory.getLogger(FileUtil.class);
    
    /**
     * Get Download file name != 파일 명을 웹 브라우저 특성에 맞게 변경한다. =!
     * 
     * @param request
     * @param fileName
     * @return
     * @throws Exception
     */
    public static String getWebFileName(HttpServletRequest request, String fileName) throws Exception {
        
        String header = request.getHeader("User-Agent");
        
        String browserType = "MSIE";
        if (header.contains("Firefox")) {
            browserType = "Firefox";
        } else if (header.contains("Chrome")) {
            browserType = "Chrome";
        } else if (header.contains("Opera")) {
            browserType = "Opera";
        }
        
        String newFileName = fileName;
        
        if (browserType.contains("MSIE")) {
            newFileName = URLEncoder.encode(newFileName, "UTF-8").replaceAll("\\+", "%20");
        } else if (browserType.contains("Firefox")) {
            newFileName = new String(newFileName.getBytes("UTF-8"), "ISO-8859-1");
        } else if (browserType.contains("Opera")) {
            newFileName = new String(newFileName.getBytes("UTF-8"), "ISO-8859-1");
        } else if (browserType.contains("Chrome")) {
            newFileName = new String(newFileName.getBytes("UTF-8"), "ISO-8859-1");
        }
        
        return newFileName;
    }
    
    /**
     * Get Electronic Document's Attach File Path
     * 
     * @return
     */
    public static String getElecDocAttchFilePath() {
        String today = DateUtil.getTodayISOStr("yyyyMMddHH");
        return PropertyUtil.getString("ATTCH_FILE_PATH") + today.substring(0, 4) + File.separator + today.substring(4, 6) + File.separator + today.substring(6, 8) + File.separator + today.substring(8);
    }
    
    /**
     * Get Electronic Document's Attach File's Name for Saving
     * 
     * @return
     */
    public static String getElecDocAttchFileSaveFileNm(String msgId, String fileSn, String fileNm) {
        String saveFileExt = StringUtil.substringAfterLast(fileNm, ".");
        return msgId + "_attach_" + fileSn + (StringUtil.isEmpty(saveFileExt) ? "" : "." + saveFileExt);
    }
    
    /**
     * Get Electronic Document's Attach File Path
     * 
     * @return
     */
    public static String getNewAttchFileMtNo() {
        return DateUtil.getTodayISOStr("yyyyMMddHHmmssSSS");
    }
}
