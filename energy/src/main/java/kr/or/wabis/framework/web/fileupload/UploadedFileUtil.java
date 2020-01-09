package kr.or.wabis.framework.web.fileupload;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UploadedFileUtil {
    
    private static final Logger logger = LoggerFactory.getLogger(UploadedFileUtil.class);
    
    /**
     * Create new File
     * 
     * @param f
     * @return [true] if the named file does not exist and was successfully created; [false] if the named file already exists
     */
    protected static boolean createNewFile(File f) {
        
        try {
            return f.createNewFile();
        } catch (IOException ignored) {
            return false;
        }
        
    }
    
    public static File uniqueFile(File f) {
        
        if (createNewFile(f)) {
            return f;
        }
        
        String name = f.getName();
        String body = null;
        String ext = null;
        
        int dot = name.lastIndexOf(".");
        if (dot != -1) {
            body = name.substring(0, dot) + "_(";
            ext = ")" + name.substring(dot); // includes "."
        } else {
            body = name + "_(";
            ext = ")";
        }
        
        int count = 0;
        while (!createNewFile(f) && count < 9999) {
            count++;
            String newName = body + count + ext;
            f = new File(f.getParent(), newName);
        }
        
        return f;
    }
    
    protected static void _deleteFile(String tempFilename) {
        
        try {
            
            java.io.File f = new java.io.File(tempFilename);
            
            if (f != null) {
                f.delete();
            }
            
        } catch (Throwable e) {            
        }
    }
    
    /**
     * 파일을 filePath경로에 newFileName으로 저장 한다. canOverwrite이 true 이면 기존 파일을 덮어 쓰며 false이면 새로운 파일명을 만들어 저장 한다.
     * 
     * @param dto
     * @param filePath
     * @param newFileName
     * @param canOverwrite
     * @return
     * @throws Exception
     */
    public static String saveAs(FileUploadModel dto, String filePath, String newFileName, boolean canOverwrite) throws Exception {
        
        File newFile = null;
        
        if (dto.getSize() > 0) {
            
            try {
                
                FileSupport.checkAndMakeDir(filePath);
                newFile = new File(filePath, newFileName);
                
                if (!canOverwrite) {
                    newFile = uniqueFile(newFile);
                }
                
                InputStream fis = dto.getInputStream();
                
                if (FileSupport.streamToFile(fis, newFile)) {
                    
                    dto.setNewFileName(newFile.getName());
                    dto.setFileStreCours(filePath);
                    
                    return newFile.getName();
                    
                } else {
                    throw new Exception("Can't make " + newFileName + "," + newFile);
                }
                
            } catch (Throwable e) {
                
                if (newFile != null) {
                    newFile.delete();
                }
                
                logger.error("UploadedFile.SaveAS()  : " + filePath + ", " + newFileName + " :" + e.getMessage());
                
                throw new Exception(e.getMessage(), e);
            }
            
        } else {
            return null;
        }
        
    }
    
    public static boolean isMultiPart(HttpServletRequest hRequest) {
        return (hRequest.getHeader("content-type") != null && hRequest.getHeader("content-type").indexOf("multipart/form-data") != -1);
    }
}