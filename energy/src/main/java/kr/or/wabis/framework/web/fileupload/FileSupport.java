package kr.or.wabis.framework.web.fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.ibm.icu.text.CharsetDetector;

import kr.or.wabis.framework.util.ObjectUtil;
import kr.or.wabis.framework.util.ProjectConfigUtil;

public class FileSupport {
    
    private final static Logger logger = LoggerFactory.getLogger(FileSupport.class);
    
    private final static String[] MMS_FILE_EXTS = ProjectConfigUtil.getStringArrayValue("fileType.mms");    
    private final static int BYTE_NUM = 1024;
    
    /**
     * 해당파일의 icon 이미지를 읽어옮 /src/config4j.xml 의 fileType 참조
     * 
     * @param fileName
     * @return
     */
    public static String getIconImage(String fileName) {
        return FileExtensionHelper.getInstance().getIconImage(fileName);
    }
    
    /**
     * 파일명의 일반적 타입을 돌려줌 없으면 null;
     * 
     * @param fileName
     * @return
     */
    public static String getGeneralFileType(String fileName) {
        return FileExtensionHelper.getInstance().getGeneralFileType(fileName);
    }
    
    /**
     * 스트리밍파일 여부 확인
     * 
     * @param fileName
     * @return
     */
    public static boolean isMmsFile(String fileName) {
        
        String fileExt = getExtension(fileName);
        
        for (String ext : MMS_FILE_EXTS) {
            if (ext.equals(fileExt)) {
                return true;
            }
        }
        
        return false;
        
    }
    
    /**
     * 스트리밍파일 여부 확인
     * 
     * @param fileName
     * @return
     */
    public static boolean isMmsFile(File file) {
        
        if (file != null) {
            return isMmsFile(file.getName());
        }
        
        return false;
        
    }
    
    /**
     * 파일의 확장자를 구분하여 파일구분을 한다 0:일반 1:동영상
     * 
     * @param fileName
     *            : 파일이름
     * @return 0:일반 1:동영상
     */
    public static int getFileTypeGubun(String fileName) {
        
        if (FileExtensionHelper.DEFAULT_MOVIE_TYPE.equals(getGeneralFileType(fileName))) {
            return 1;
        }
        
        else {
            return 0;
        }
    }
    
    /**
     * 파일을 삭제 한다.
     * 
     * @param folder
     *            폴더명
     * @param fileName
     *            파일명
     * @return 삭제 여부
     */
    public static boolean deleteFile(String folder, String fileName) {
        
        boolean res = true;
        
        File file = new File(folder, fileName);
        res = file.delete();
        
        return res;
    }
    
    /**
     * List<Map<String, Object>> 형식에서 파일명에 대해 파일타입을 map에 추가한다.
     * 
     * @param list
     *            데이터
     * @param column
     *            파일명이 들어있는 Map 키값
     * @return 추가된 데이터
     */
    public static List<Map<String, Object>> addFileType(List<Map<String, Object>> list, String column) {
        return addFileType(list, column, "file_type");
    }
    
    /**
     * List<Map<String, Object>> 형식에서 파일명에 대해 파일타입을 map에 추가한다.
     * 
     * @param list
     *            데이터
     * @param column
     *            파일명이 들어있는 Map 키값
     * @param fileType
     *            추가시킬 컬럼명
     * @return 추가된 데이터
     */
    public static List<Map<String, Object>> addFileType(List<Map<String, Object>> list, String column, String fileType) {
        
        for (Map<String, Object> map : list) {
            map.put(fileType, getIconImage(ObjectUtil.getSafeString(map.get(column))));
        }
        
        return list;
    }
    
    /**
     * 첨부파일의 갯수를 넘겨주어 2개 이상이면 외 [파일갯수-1]로 표현
     * 
     * @param fileCount
     * @return
     */
    public static String getFileExtCount(int fileCount) {
        
        if (fileCount > 1) {
            return "&nbsp;외[" + (fileCount - 1) + "]";
        }
        
        return "";
    }
    
    /**
     * 
     * @param fi
     * @param DestFile
     * @return
     */
    public static boolean streamToFile(InputStream fi, File DestFile) {
        
        boolean chk = false;
        FileOutputStream fo = null;
        
        try {
            
            fo = new FileOutputStream(DestFile);
            
            if (fi != null && fo != null) {
                
                byte[] b = new byte[1024];
                int numRead = fi.read(b);
                
                while (numRead != -1) {
                    fo.write(b, 0, numRead);
                    numRead = fi.read(b);
                }
                
                fo.flush();
                chk = true;
                
            }
            
            else {
                if (DestFile != null) {
                    DestFile.delete();
                }
            }
            
        } catch (Throwable e) {
            try {
                if (DestFile != null) {
                    DestFile.delete();
                }
            } catch (Throwable ex) {
                logger.error(e.getMessage());
            }
            
        } finally {
            
            if (fi != null){
                try {
                    fi.close();
                    fi = null;
                } catch (Exception _ignored) {
                }
            }
            
            if (fo != null){
                try {
                    fo.close();
                    fo = null;
                } catch (Exception _ignored) {
                }
            }
            
        }
        
        return chk;
    }
    
    /**
     * 대상폴더의 존재여부 확인 후 없으면 폴더를 생성 한다.
     * 
     * @param FilePath
     * @throws FileUtilsException
     */
    public static void checkAndMakeDir(String FilePath) throws Exception {
        
        // 파일패스 뒤에 separator가 있는지 확인한다.
        FilePath = chkSeparator(FilePath);
        
        // 복사할 곳에 디렉토리가 있는지 확인한다.
        if (!existDirectory(FilePath)) {
            
            // 디렉토리가 없으면 만든다.
            createDirectory(FilePath);
        }
    }
    
    /*******************************************************************************************************************************
     * 파일 패스 뒤에 \ 혹은 / 이 없으면 붙여주는 메서드
     * <p>
     * @ param path 파일패스
     * <p>
     * @ param
     * <p>
     * @ return tempp 고쳐진 파일 패스
     * <p>
     ******************************************************************************************************************************/
    public static String chkSeparator(String path) {
        String tempp = "";
        try {
            tempp = path;
            if (!tempp.substring(tempp.length() - 1, tempp.length()).equals(File.separator)) {
                tempp = tempp + File.separator;
            }
        } catch (Exception e) {
        }
        return tempp;
    }
    
    /*******************************************************************************************************************************
     * 디렉토리가 있는지 확인한다.
     * <p>
     * @ param path 파일패스
     * <p>
     * @ return true:디렉토리 있음, false:디렉토리없음
     * <p>
     ******************************************************************************************************************************/
    public static boolean existDirectory(String path) {
        boolean i = false;
        try {
            File f = new File(path);
            i = f.exists();
        } catch (Exception e) {
            i = false;
        }
        return i;
    }
    
    /*******************************************************************************************************************************
     * 디렉토리를 생성한다.
     * <p>
     * @ param path 파일패스
     * <p>
     * @ return true:성공,false:실패
     * <p>
     ******************************************************************************************************************************/
    public static void createDirectory(String path) throws Exception {
        
        boolean flag = false;
        try {
            File f = new File(path);
            File fp = f.getParentFile();
            if (!fp.exists()) {
                createDirectory(fp.getPath());
            }
            if (!f.exists()) {
                flag = f.mkdir();
                logger.info("Created Directory: {}", f.getPath());
                if (!flag) {
                    throw new Exception("Can't make dir : " + path);
                }
            }
        } catch (Exception e) {
            throw new Exception(e.getMessage(), e);
        }
    }
    
    /**
     * 
     * @param file
     * @return
     */
    public static String getExtension(File file) {
        
        if (file != null) {
            return getExtension(file.getName());
        }
        
        return "";
    }
    
    /**
     * 파일명의 확장자를 가져옮
     * 
     * @param fileName
     * @return
     */
    public static String getExtension(String fileName) {
        
        if (fileName.startsWith(".")) {
            return fileName.substring(1);
        }
        
        String[] tokens = fileName.split("\\.");
        
        if (tokens.length == 1)
            return "";
        
        return tokens[(tokens.length - 1)];
        
    }
    
    
    /**
     * 파일 확장자 체크.
     *
     * @param filename the filename
     * @param chExt the ch ext
     * @return true, if successful
     * @throws Exception the exception
     */
    public static boolean filenmCheck(final String filename, final String chExt) throws Exception {
        
        String ext = "";
        boolean result = false;
        
        try {
            
            int dot = filename.lastIndexOf(".");
            if (dot != -1) {
                ext = filename.substring(dot + 1); // 확장자
            }
            
            if (!ext.equals("")) {
                if (ext.equalsIgnoreCase(chExt)) {
                    result = true;
                } else {
                    result = false;
                }
            }
            
        } catch (Exception e) {
            throw e;
        }
        return result;
    }
    
    /**
     * 파일 확장자 체크.
     *
     * @param filename the filename
     * @param chExt the ch ext
     * @return true, if successful
     * @throws Exception  the exception
     */
    public static boolean filenmCheck(final String filename, final String[] chExt) throws Exception {
        
        String ext = "";
        boolean result = false;
        
        try {
            
            int dot = filename.lastIndexOf(".");
            if (dot != -1) {
                ext = filename.substring(dot + 1); // 확장자
            }
            
            if (!ext.equals("")) {
                
                for (int i = 0; i < chExt.length; i++) {
                    if (chExt[i].equalsIgnoreCase(ext)) {
                        result = true;
                        break;
                    } else {
                        result = false;
                    }
                }
            }
            
        } catch (Exception e) {
            throw e;
        }
        
        return result;
    }
    
    /**
     * 파일 사이즈 체크.
     *
     * @param file the file
     * @param chSize the ch size
     * @param bt  the bt
     * @return true, if successful
     * @throws Exception the exception
     */
    public static boolean fileSizeCheck(final File file, final float chSize, final String bt) throws Exception {
        
        boolean result = false;
        
        try {
            
            if (file != null) {
                float filelen = file.length();
                float fileSize = 0.0F;
                
                if (bt.equals("K")) {
                    fileSize = filelen / BYTE_NUM;
                } else if (bt.equals("M")) {
                    fileSize = filelen / (BYTE_NUM * BYTE_NUM);
                }
                
                if (fileSize < chSize) {
                    result = true;
                } else {
                    result = false;
                }
            }
            
        } catch (Exception e) {
            throw e;
        }
        return result;
    }
    
    /**
     * Gets the file extension.
     *
     * @param filename the filename
     * @return the file extension
     */
    public static String getFileExtension(final String filename) {
        
        int index = filename.lastIndexOf(".");
        String fileExtension = filename.substring(index + 1);
        
        return fileExtension;
    }
    
    /**
     * 업로드한 파일의 인코딩 타입을 구해온다.
     *
     * @param file the file
     * @return String file encoding type
     * @throws Exception the exception
     */
    public static String getReadFileEncoding(final File file) throws Exception {
        
        FileInputStream fin = null;
        String encoding = "";
        
        try {
            
            long length = file.length();
            byte[] strByte = new byte[(int) length];
            
            fin = new FileInputStream(file);
            fin.read(strByte);
            
            // ICU 라이브러리 사용 - 리눅스, 유닉스 서버일 경우 UTF-8 BOM 타입 구분
            CharsetDetector detector = new CharsetDetector();
            detector.setText(strByte);
            
            encoding = detector.detect().getName();
            
            if (encoding.equalsIgnoreCase("IBM420_ltr") || 
                    encoding.equalsIgnoreCase("ISO-8859-1") || 
                    encoding.equalsIgnoreCase("Big5") || 
                    encoding.equalsIgnoreCase("ISO-8859-9")) {
                
                encoding = "EUC-KR";
            }
            
            fin.close();
            
        } catch (IOException e) {
            throw new Exception(e);
        } finally {
            if (fin != null) {
                try {
                    fin.close();
                } catch (Exception e) {
                }
            }
        }
        
        return encoding;
    }
    
    /**
     * 업로드한 파일의 인코딩 타입을 구해온다.
     *
     * @param multipartFile the multipart file
     * @return String file encoding type
     * @throws Exception  the exception
     */
    public static String getReadFileEncoding(final MultipartFile multipartFile) throws Exception {
        
        InputStream fin = null;
        String encoding = "";
        
        try {
            
            long length = multipartFile.getSize();
            byte[] strByte = new byte[(int) length];
            
            fin = (InputStream) multipartFile.getInputStream();
            fin.read(strByte);
            
            // ICU 라이브러리 사용 - 리눅스, 유닉스 서버일 경우 UTF-8 BOM 타입 구분
            CharsetDetector detector = new CharsetDetector();
            detector.setText(strByte);
            
            encoding = detector.detect().getName();
            
            if (encoding.equalsIgnoreCase("IBM420_ltr") || 
                    encoding.equalsIgnoreCase("ISO-8859-1") ||
                    encoding.equalsIgnoreCase("Big5") ||
                    encoding.equalsIgnoreCase("ISO-8859-9")) {
                encoding = "EUC-KR";
            }
            
            fin.close();
            
        } catch (IOException e) {
            throw new Exception(e);
        } finally {
            if (fin != null) {
                try {
                    fin.close();
                } catch (Exception e) {
                }
            }
        }
        
        return encoding;
    }
    
    /**
     * 파일의 확장자를 체크하여 필터링된 확장자를 포함한 파일인 경우에 true를 리턴한다.
     * 
     * @param file
     */
    public static boolean fileExtIsReturnBoolean(String fileName, String checkExt) {
        
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
        String[] CHECK_EXTENSION = checkExt.split(",");
        
        int len = CHECK_EXTENSION.length;
        for (int i = 0; i < len; i++) {
            if (ext.equalsIgnoreCase(CHECK_EXTENSION[i])) {
                return true;
            }
        }
        
        return false;
    }
    
    /*
     * 업로드 제한 확장자를 체크해준다.
     */
    public static boolean badFileExtIsReturn(String fileName) {
        
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
        final String[] BAD_EXTENSION = { "jsp", "php", "asp", "html", "perl", "exe", "war" };
        int len = BAD_EXTENSION.length;
        
        for (int i = 0; i < len; i++) {
            
            if (ext.equalsIgnoreCase(BAD_EXTENSION[i])) {
                
                // 불량 확장자가 존재할떄 IOExepction 발생
                return true;
            }
        }
        
        return false;
    }
}