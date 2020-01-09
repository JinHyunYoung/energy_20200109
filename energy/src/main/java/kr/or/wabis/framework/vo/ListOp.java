package kr.or.wabis.framework.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import kr.or.wabis.framework.util.ExtHttpRequestParam;
import kr.or.wabis.framework.util.JsonUtil;
import kr.or.wabis.framework.util.ObjectUtil;
import kr.or.wabis.framework.util.StringUtil;

public class ListOp {
    
    private static final long serialVersionUID = 5504682103224072216L;
    
    private Log logger = LogFactory.getLog(ListOp.class);
    
    private static final boolean USE_JSON = false;
    
    public static final String SERIALISVALID = "_SERIALISVALID";
        
    public final static String LIST_OP_NAME = "LISTOP";
    
    private Map<String, Object> ht = null;
    private boolean isValid = false;
    
    public ListOp() {
        isValid = true;
        init(null);
    }
    
    public ListOp(String str) {
        init(str);
    }
    
    public ListOp(HttpServletRequest request) {
        String str = request.getParameter(ListOp.LIST_OP_NAME);
        init(str);
    }
    
    public boolean isValid() {
        return this.isValid;
    }
    
    public void clearMap() {
        ht.clear();
    }
    
    private void init(String str) {
        
        if (str != null) {
            
            try {
                
                str = URLDecoder.decode(str, "UTF-8");
                if (USE_JSON) {
                    this.ht = (Map<String, Object>) JsonUtil.fromJsonStr(str);
                } else {
                    this.ht = ListOpUtil.str2hashtable(str);
                }
                
                if (ht != null && "T".equals(ht.get(SERIALISVALID))) {
                    isValid = true;                    
                }
                
            } catch (UnsupportedEncodingException e) {
                logger.error("Err _UnSerialUrl :" + e.getMessage());
            }
            
        } else {
            this.ht = new HashMap<String, Object>();
        }
        
        this.setDef(NavigatorInfo.MIV_PAGESIZE, NavigatorInfo.DEFAULT_PAGE_SIZE + "");
        this.setDef(NavigatorInfo.MIV_PAGE, 1 + "");
    }
    
    /**
     * 파라미터를 문자열로 돌려 준다.
     * 
     * @return
     */
    public String getValue() {
        
        try {
            
            if (USE_JSON) {
                return URLEncoder.encode(JsonUtil.toJsonStr(this.ht), "UTF-8");
            } else {
                return URLEncoder.encode(ListOpUtil.hashtable2str(this.ht), "UTF-8");
            }
            
        } catch (UnsupportedEncodingException e) {
            logger.error("Err _UnSerialUrl :" + e.getMessage());
            return null;
        }
    }
    
    /**
     * 파라미터를 문자열로 돌려 준다.
     * 
     * @return
     */
    public String getDecodedValue() throws Exception {
        return URLDecoder.decode(getValue(), "UTF-8");
    }
    
    /**
     * 
     * @param key
     */
    public void remove(String key) {
        ht.remove(key);
    }
    
    /**
     * 
     * @param key
     * @param def
     * @return
     */
    public String get(String key, String def) {
        
        String sT = null;
        if (ht != null && ht.containsKey(key)) {
            
            Object obj = ht.get(key);
            if (obj instanceof String) {
                sT = (String) ht.get(key);
            } 
            
            else {
                if (obj != null) {
                    logger.error("\n==================================================\n\n" + key + "=\n" + obj.getClass());
                } 
            }
            
            if (sT != null && !"".equals(sT.trim())) {
                return sT;
            }
        }
        
        return def;
    }
    
    /**
     * 
     * @param key
     * @return
     */
    public String[] getValues(String key) {
        
        Object obj = ht.get(key);
        if (obj == null) {
            return (String[]) ArrayUtils.EMPTY_OBJECT_ARRAY;
        } 
        
        else if (obj instanceof String[]) {
            return (String[]) obj;
        } 
        
        else if (obj instanceof Collection) {
            return (String[]) ((Collection) obj).toArray(new String[0]);
        } 
        
        else {
            logger.debug(" >>>>> " + obj.getClass());
            return (String[]) ArrayUtils.add((String[]) ArrayUtils.EMPTY_OBJECT_ARRAY, obj.toString());
        }
    }
    
    /**
     * 
     * @param Key
     * @return
     */
    public String get(String Key) {
        return get(Key, "");
    }
    
    /**
     * 
     * @param key
     * @param def
     * @return
     */
    public int getInt(String key, int def) {
        
        if (ht.containsKey(key)) {
            return ObjectUtil.parseInt((String) ht.get(key), def);
        } else {
            return def;
        }
    }
    
    /**
     * 
     * @param key
     * @return
     */
    public int getInt(String key) {
        return getInt(key, 0);
    }
    
    /**
     * 
     * @param key
     * @param value
     */
    public void put(String key, Object value) {
        
        if (ht == null) {
            ht = new HashMap<String, Object>();
        }
        
        if (key != null) {
            ht.put(key, value);
        }
    }
    
    /**
     * 해당 key 값이 없으면 파라미터 값을 넣음
     * 
     * @param key
     * @param value
     */
    public void setDef(String key, Object value) {
        if (ht == null) {
            ht = new HashMap<String, Object>();
        }
        if (!ht.containsKey(key)) {
            ht.put(key, value);
        }
    }
    
    /**
     * 
     * @return
     */
    public int size() {
        return ht.size();
        
    }
    
    /**
     * 
     * @param Key
     * @return
     */
    public boolean containsKey(String Key) {
        return ht.containsKey(Key);
    }
    
    /**
     * 
     * @return
     */
    public boolean isEmpty() {
        return ht.isEmpty();
    }
    
    /**
     * 
     */
    public void clear() {
        this.ht.clear();
    }
    
    /**
     * 저장소 정보를 돌려준다. JSTL에서 값을 바로 접근 가능 하게
     * 
     * @return
     */
    public final Map<String, Object> getHt() {
        return this.ht;
    }
    
    /**
     * 새로 넘오온 값과 나중에 온값을 merge 한다.
     * 
     * @param _req
     * @param searchFields - "field_nm:def value" 형태로 넣어줌
     * @return
     */    
    public Map<String, Object> getMergedParam(ExtHttpRequestParam _req, String[] searchFields) {
        
        Map<String, Object> param = _req.getParameterMap();
        String srch_frms = StringUtil.nvl((String) param.get("srch_frm"));
        HashMap<String, Object> srch_frm = new HashMap<String, Object>();
        
        if (!"".equals(srch_frms)) {
            srch_frm = convertToMap((String) param.get("srch_frm"));
        }
        
        String key = null;
        String tempKey = null;
        Object def = null;
        boolean isArray = false;
        String[] sprited = null;
        if (searchFields != null) {
            
            for (int i = 0; i < searchFields.length; i++) {
                
                tempKey = searchFields[i];
                sprited = tempKey.split(":");
                tempKey = sprited[0];
                
                if (tempKey.endsWith("[]")) {
                    isArray = true;
                    key = tempKey.substring(0, tempKey.length() - 2);
                } else {
                    isArray = false;
                    key = tempKey;
                }
                
                if (sprited.length > 1) {
                    if (sprited[1].startsWith("$d{")) {
                        def = dateDef(sprited[1]);
                    } else {
                        def = JsonUtil.fromJsonStr(sprited[1]);
                    }
                } else {
                    def = null;
                }
                
                // request에 해당키의 값이 있는지 확인
                if (_req.containsKey(key)) {
                    
                    String[] va = _req.getParameterValues(key);
                    if (va != null) {
                        
                        if (isArray) {
                            param.put(key, va);
                            this.put(key, va);
                        } else {
                            param.put(key, va[0]);
                            this.put(key, va[0]);
                        }                        
                    }
                    
                } 
                
                else if (srch_frm.containsKey(key)) {
                    param.put(key, srch_frm.get(key));
                }
                
                else {
                    
                    if (ht.containsKey(key)) {
                        param.put(key, this.get(key));
                    } else {
                        param.put(key, def);
                        this.put(key, def);
                    }
                }
            }
        }
        
        Set<String> keySet = ht.keySet();
        for (String k : keySet) {
            param.put(k, ht.get(k));
        }
        
        logger.debug("OPPARAM : " + param);
        return param;
    }
    
    /**
     * 
     * @param def
     * @return
     */
    private String dateDef(String def) {
        return "";
    }
    
    /**
     * 
     * @param str
     * @return
     */
    public static HashMap<String, Object> convertToMap(String str) {
        
        String[] tokens = str.split("&amp;");
        HashMap<String, Object> map = new HashMap<String, Object>();
        for (int i = 0; i < tokens.length; i++) {
            String[] strings = tokens[i].split("=");
            if (strings.length == 2)
                map.put(strings[0], StringUtil.getUrlDecode(strings[1].replaceAll("%2C", ",")));
        }
        
        return map;
    }    
}
