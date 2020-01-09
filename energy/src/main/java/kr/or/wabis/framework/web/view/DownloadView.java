package kr.or.wabis.framework.web.view;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.wabis.framework.util.ObjectUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.fileupload.FileDownloadInfo;
import kr.or.wabis.framework.web.fileupload.FileSupport;

public class DownloadView extends AbstractView {
    
    private final int DEFAULT_BUF_SIZE = 65536;
    
    private Logger logger = LoggerFactory.getLogger(DownloadView.class);
    
    public void Download() {
        setContentType("application/download; utf-8");
    }
    
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        FileDownloadInfo downloadInfo = (FileDownloadInfo) model.get(ViewerSupport.FILE_SOURCE_KEY);
        
        File file = downloadInfo.getFile();
        
        logger.debug(downloadInfo.toString());
        
        if (file == null || !file.canRead()) {
            throw new FileNotFoundException("File not found!");
        } 
        
        else {
            
            long seek_start = 0L;
            byte abyte0[] = null;
            
            String seek_range = request.getHeader("Range");
            String sendFileName = ObjectUtil.nvl(StringUtil.getUrlDecode(downloadInfo.getOriginalFileName()), file.getName());
                        
            String ext = FileSupport.getExtension(sendFileName);
            String mimeType = downloadInfo.getContentType();
            if (mimeType == null) {
                
                if ("xlsx".equalsIgnoreCase(ext) || "xls".equalsIgnoreCase(ext)) {
                    mimeType = "application/vnd.ms-excel;charset=UTF-8";
                }
                
                else if ("docx".equalsIgnoreCase(ext) || "doc".equalsIgnoreCase(ext)) {
                    mimeType = "application/vnd.ms-word;charset=UTF-8";
                }
                
                else if ("pptx".equalsIgnoreCase(ext) || "ppt".equalsIgnoreCase(ext)) {
                    mimeType = "application/vnd.ms-powerpoint;charset=UTF-8";
                }
                
                else {
                    mimeType = "application/octet-stream;";
                }
            }
            
            response.setContentType(mimeType);
                        
            setDisposition(sendFileName, request, response);
            
            // 전송되는 데이터의 인코딩이 바이너리 타입이라는 것을 명시.
            response.setHeader("Content-Transfer-Encoding", "binary");
            
            if (seek_range != null) {
                
                long l1 = 0L;
                int i1 = seek_range.indexOf('=') + 1;
                int j1 = seek_range.indexOf('-');
                String s8 = seek_range.substring(i1, j1);
                seek_start = Long.parseLong(s8);
                l1 = file.length() - seek_start;
                
                if (l1 < 0L) {
                    l1 = 0L;
                }
                
                response.setHeader("Content-Range", Long.toString(seek_start) + "-" + (l1 - 1L) + "/" + file.length());
                response.setContentLength((int) l1);
                
            } else {
                response.setContentLength((int) file.length());
            }
            
            response.setHeader("Cache-Control", "no-cache, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            
            abyte0 = new byte[DEFAULT_BUF_SIZE];
            RandomAccessFile randomAccessFile = new RandomAccessFile(file, "r");
            if (seek_range != null) {
                randomAccessFile.seek(seek_start);
            }
            
            ServletOutputStream servletUutputStream = response.getOutputStream();
            
            int j = 0;
            try {
                
                int i = 0;
                while ((i = randomAccessFile.read(abyte0, 0, DEFAULT_BUF_SIZE)) != -1) {
                    servletUutputStream.write(abyte0, 0, i);
                    servletUutputStream.flush();
                    j += i;
                }
                
            } finally {
                
                if (randomAccessFile != null) {
                    try {
                        randomAccessFile.close();
                    } catch (Exception ignore) {
                    }
                }
                
                if (servletUutputStream != null) {
                    try {
                        servletUutputStream.close();
                    } catch (Exception ignore) {
                    }
                }
                
                randomAccessFile = null;
                servletUutputStream = null;
                HttpSession session = request.getSession();
                session.setAttribute("processSimulator", "end_process");
            }
        }
    }
    
    
    /**
     * 
     * @param request
     * @return
     */
    private String getBrowser(HttpServletRequest request) {
        
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } 
        
        else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
            return "Trident";
        } 
        
        else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } 
        
        else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        
        return "Firefox";
    }
    
    /**
     * 
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String browser = getBrowser(request);
        
        String dispositionPrefix = "attachment; filename=";
        String encodedFilename = null;
        
        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } 
        
        else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } 
        
        else if (browser.equals("Firefox")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        }
        
        else if (browser.equals("Opera")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } 
        
        else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        }
        
        else {
            throw new IOException("Not supported browser");
        }
        
        response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
        
        if ("Opera".equals(browser)) {
            response.setContentType("application/octet-stream;charset=UTF-8");
        }
        
        logger.debug("{}, {}, Content-Disposition:{}", new String[] { request.getRemoteAddr(), browser, dispositionPrefix + encodedFilename });
    }
}
