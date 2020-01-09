package kr.or.wabis.framework.util;

import java.io.Serializable;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.or.wabis.framework.web.fileupload.FileUploadModel;
import kr.or.wabis.user.vo.UserVO;

public class ExtHttpRequestParam implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private static final Log logger = LogFactory.getLog(ExtHttpRequestParam.class);
    
    private Map<String, Object> paramMap = null;;
    private Map<String, Object> simpleMap = null;
    private Locale locale = null;
    
    private Map<String, List<FileUploadModel>> filesMap;
    
    private boolean multiPart = false;
    
    private UserVO sessionUser = null;
    
    // // 임시 데이타 저장소
    private Map<String, Object> param = null;
    
    public ExtHttpRequestParam() {
        this.param = new HashMap<String, Object>();
        this.paramMap = new HashMap<String, Object>();
    }
    
    public void setLocale(Locale locale) {
        this.locale = locale;
    }
    
    public Locale getLocale() {
        return this.locale;
    }
    
    public UserVO getSessionUser() {
        return sessionUser;
    }
    
    public void setSessionUser(UserVO sessionUser) {
        this.sessionUser = sessionUser;
    }
    
    public boolean isMultiPart() {
        return multiPart;
    }
    
    public void setMultiPart(boolean multiPart) {
        this.multiPart = multiPart;
    }
    
    public boolean containsKey(String key) {
        return this.paramMap.containsKey(key);
    }
    
    public void setUploadedFiles(Map<String, List<FileUploadModel>> uploadedFiles) throws Exception {
        assertMulti();
        this.filesMap = uploadedFiles;
    }
    
    public void setParam(Map<String, Object> hParam) {
        this.paramMap = hParam;
        simpleMap = null;
    }
    
    public String getP(String key) {
        return getParameter(key, null);
    }
        
    public Object getObject(String key) {
        return paramMap.get(key);
    }
    
    public String getParameter(String key) {
        return getParameter(key, null);
    }
    
    public void put(String key, String value) {
        if (paramMap == null) {
            paramMap = new HashMap<String, Object>();
        }
        
        paramMap.put(key, (String[]) ArrayUtils.add(ArrayUtils.EMPTY_STRING_ARRAY, value));
        simpleMap = null;
    }
    
    public String getParameter(String key, String def) {
        
        String rv = null;
        if (paramMap != null) {
            
            Object t = this.paramMap.get(key);
            if (t != null) {
                if (t instanceof Object[]) {
                    rv = ObjectUtil.getSafeString(((Object[]) t)[0]);
                }
            }
        }
        
        return ObjectUtil.nvl(rv, def);
    }
    
    /**
     * null 없음 !!
     * 
     * @param key
     * @return
     */
    public String[] getParameterValues(String key) {
        
        String[] rv = null;
        if (paramMap != null) {
            Object o = this.paramMap.get(key);
            if (o != null) {
                if (o instanceof Object[]) {
                    rv = (String[]) o;
                }
            }
        }
        return (rv == null) ? new String[0] : rv;
    }
    
    /**
     * Parameter로 넘어온 정보를 Map에 담아 넘겨줌 여러개의 값의 경우 첫번째 값을 너어줌(list나 collection아님)
     * 
     * @return
     */
    public Map<String, Object> getParameterMap() {
        
        if (simpleMap == null) {
            
            simpleMap = new HashMap<String, Object>();
            Set<String> keySet = paramMap.keySet();
            
            String[] values = null;
            for (String key : keySet) {
                values = (String[]) this.paramMap.get(key);
                
                if (values.length < 2)
                    simpleMap.put(key, this.getParameter(key));
                else
                    simpleMap.put(key, this.getParameterValues(key));
            }
        }
        return simpleMap;
    }
    
    /**
     * View Object ID가 같은 대상에 대한 값을 ArrayList로 반환해준다.
     * 
     * @param key
     * @return
     */
    public ArrayList<String> getParameterList(String key) {
        
        ArrayList<String> paramList = new ArrayList<String>();
        
        try {
            
            Object o = (Object) paramMap.get(key);
            
            Class<? extends Object> c = o.getClass();
            if (o != null) {
                
                if (c.isArray()) {
                    
                    int length = Array.getLength(o);
                    if (length != 0) {
                        
                        for (int i = 0; i < length; i++) {
                            
                            Object tiem = Array.get(o, i);
                            if (tiem == null) {
                                paramList.add("");
                            } else {
                                paramList.add(tiem.toString());
                            }
                        }
                    }
                    
                } else {
                    paramList.add(o.toString());
                }
            }
        } catch (Exception e) {
        }
        
        return paramList;
    }
    
    public Set<String> getKeySet() {
        return this.paramMap.keySet();
    }
    
    /**
     * key와 맞는 upload된 파일들을 저장 하고 저장된 파일명을 돌려 준다. (해당 오브젝트에서도 getRealFileName()을 이용해 저장된 파일명을 가져올 수 있음.
     * 
     * @param key
     * @param path
     * @return
     */
    public List<FileUploadModel> saveFilesTo(String key, String path) throws Exception {
        
        assertMulti();
        List<FileUploadModel> fileNameList = new ArrayList<FileUploadModel>();
        
        if (filesMap != null) {
            
            List<FileUploadModel> files = filesMap.get(key);
            
            for (FileUploadModel file : files) {
                // fileNameList.add(file.saveTo(path));
                file.saveTo(path);
                fileNameList.add(file);
            }
        }
        
        return (fileNameList == null) ? Collections.EMPTY_LIST : fileNameList;
    }
    
    /**
     * upload된 모든 파일을 path에 저장 하고 저장된 파일명을 돌려 준다. (file명이 변경됨)
     * 
     * @param path
     * @return
     */
    public List<FileUploadModel> saveAllFilesTo(String path) throws Exception {
        assertMulti();
        
        List<FileUploadModel> fileNameList = new ArrayList<FileUploadModel>();
        if (filesMap != null) {
            Iterator<String> i = filesMap.keySet().iterator();
            while (i.hasNext()) {
                String key = (String) i.next();
                fileNameList.addAll(saveFilesTo(key, path));
            }
        }
        return fileNameList;
        
    }
    
    /**
     * key와 맞는 upload된 파일들을 저장 하고 저장된 파일명을 돌려 준다. (null 걱정 없음 )
     * 
     * @param key
     * @return List<FileUploadModel>
     */
    public List<FileUploadModel> getFiles(String key) throws Exception {
        
        assertMulti();
        List<FileUploadModel> fileList = new ArrayList<FileUploadModel>();
        
        if (filesMap != null) {
            
            List<FileUploadModel> files = filesMap.get(key);
            if (files != null) {
                for (FileUploadModel file : files) {
                    fileList.add(file);
                }
            }
        }
        
        return fileList;
    }
    
    public List<FileUploadModel> getAllFiles() throws Exception {
        
        assertMulti();
        List<FileUploadModel> fileList = new ArrayList<FileUploadModel>();
        
        if (filesMap != null) {
            Iterator<String> i = filesMap.keySet().iterator();
            while (i.hasNext()) {
                String key = (String) i.next();
                fileList.addAll(getFiles(key));
            }
        }
        return fileList;
    }
    
    public String toString() {
        StringBuffer msg = new StringBuffer();
        
        msg.append("  paramMap={");
        if (paramMap != null) {
            Set<String> keySet = paramMap.keySet();
            for (String key : keySet) {
                msg.append(key + "=" + ToStringBuilder.reflectionToString(paramMap.get(key), ToStringStyle.SIMPLE_STYLE));
            }
        } else {
            msg.append("null");
        }
        
        msg.append("}\n");
        return msg.toString();
    }
    
    /**
     * mutilpart form이 아니면 exception 발생
     * 
     * @throws Exception
     */
    private void assertMulti() throws Exception {
        if (!this.multiPart) {
            throw new Exception("form type이 파일을 전송할수 없습니다. FORM tag에 type=\"POST\" +" + " enctype=\"multipart/form-data\" 를 추가해 주십시요 .");
        }
    }
    
    public boolean setDefaultParam(String key, Object value) {
        
        boolean changed = false;
        if (paramMap != null) {
            
            if (paramMap.containsKey(key)) {
                
                if (ObjectUtil.isEmpty(paramMap.get(key))) {
                    paramMap.put(key, value);
                    changed = true;
                }
                
            } else {
                paramMap.put(key, value);
                changed = true;
            }
        }
        return changed;
    }
}