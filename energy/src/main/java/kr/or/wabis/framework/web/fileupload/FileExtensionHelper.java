package kr.or.wabis.framework.web.fileupload;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import kr.or.wabis.framework.util.ObjectUtil;
import kr.or.wabis.framework.util.ProjectConfigUtil;

public class FileExtensionHelper {
    
    private Logger logger = LoggerFactory.getLogger(getClass());
        
    private static FileExtensionHelper instance = null;
    
    /**
     * 확장자별 type map
     */
    private Map<String, String> typeMap = new HashMap<String, String>();
    
    /**
     * 타입별 이미지 map
     */
    private Map<String, String> imageMap = new HashMap<String, String>();
    
    public final static String DEFAULT_IMG_KYE = "default";
    public final static String DEFAULT_MOVIE_TYPE = "movie";
    
    private FileExtensionHelper() {
        
        final String base = "fileType.";
        final String typeBase = base + "types.";
        final String imgBase = base + "images.";
        
        imageMap.put(DEFAULT_IMG_KYE, ProjectConfigUtil.getString(imgBase + DEFAULT_IMG_KYE));
        
        String[] names = ProjectConfigUtil.getStringArrayValue(base + "names");
        
        if (names != null) {
            
            logger.debug("Names : " + StringUtils.arrayToCommaDelimitedString(names));
            
            for (String key : names) {
                String img = ProjectConfigUtil.getString(imgBase + key);
                imageMap.put(toLower(key), img);
            }
            
            for (String key : names) {
                
                String[] exts = ProjectConfigUtil.getStringArrayValue(typeBase + key);
                if (exts != null) {
                    
                    for (String ext : exts) {
                        typeMap.put(toLower(ext), toLower(key));
                    }
                }
            }
        }
    }
    
    public static synchronized FileExtensionHelper getInstance() {
        if (instance == null) {
            instance = new FileExtensionHelper();
        }
        return instance;
    }
    
    /**
     * 해당파일의 icon 이미지를 읽어옮 /src/config4j.xml 의 fileType 참조 없으면 "";
     * 
     * @param fileName
     * @return
     */
    public String getIconImage(String fileName) {
        
        String img = null;
        
        img = imageMap.get(getGeneralFileType(fileName));
        
        if (img == null) {
            img = imageMap.get(DEFAULT_IMG_KYE);
        }
        
        return ObjectUtil.nvl(img, "");
    }
    
    /**
     * 파일명의 일반적 타입을 돌려줌 없으면 null;
     * 
     * @param fileName
     * @return
     */
    public String getGeneralFileType(String fileName) {
        return typeMap.get(toLower(FileSupport.getExtension(fileName)));
    }
    
    /**
     * 소문 자로 변경
     * 
     * @param obj
     * @return
     */
    private String toLower(String obj) {
        
        if (obj != null) {
            return obj.toLowerCase();
        } else {
            return "";
        }
    }
    
}
