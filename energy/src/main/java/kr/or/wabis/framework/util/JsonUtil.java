package kr.or.wabis.framework.util;

import java.lang.reflect.Type;
import java.util.Collection;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.or.wabis.framework.web.json.GCollection2JsonConverter;
import kr.or.wabis.framework.web.json.GMap2JsonConverter;
import kr.or.wabis.framework.web.json.NaturalDeserializer;

public class JsonUtil {
    
    private static final Logger logger = LoggerFactory.getLogger(JsonUtil.class);
    
    /**
     * Convert a Object into Json String
     * 
     * @param obj
     * @return
     */
    public static String toJsonStr(Object obj) {
        String rv = null;
        try {
            if (obj != null) {
                
                GsonBuilder gb = new GsonBuilder();
                gb.serializeNulls();
                // gb.registerTypeAdapter(CaseInsensitiveMap.class, new
                // GMap2JsonConverter());
                // gb.registerTypeAdapter(HashMap.class, new
                // GMap2JsonConverter());
                gb.registerTypeAdapter(Map.class, new GMap2JsonConverter());
                gb.registerTypeAdapter(Collection.class, new GCollection2JsonConverter());
                // gb.registerTypeAdapter(String.class, new
                // GString2JsonConverter());
                Gson gson = gb.create();
                rv = gson.toJson(obj);
            } else {
                rv = "{}";
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            rv = "{}";
        }
        return rv;
    }
    
    /**
     * Convert Json String into Object
     * 
     * @param obj
     * @return
     */
    public static Object fromJsonStr(String jsonStr) {
        Object natural = null;
        
        try {
            // logger.debug("from JSON String: {} " + jsonStr);
            
            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.registerTypeAdapter(Object.class, new NaturalDeserializer());
            Gson gson = gsonBuilder.create();
            natural = gson.fromJson(jsonStr, Object.class);
        } catch (Exception e) {
            logger.error("Error : {} \n {} ", new String[] { e.getMessage(), jsonStr });
        }
        return natural;
    }
    
    /**
     * Gson을 이용한 String -> Class<T>.
     * 
     * @param <T>
     * @param jsonString
     * @param classOfT
     * @return T
     */
    public static <T> T fromJsonGson(final String jsonString, final Class<T> classOfT) {
        Gson gson = new Gson();
        return gson.fromJson(jsonString, classOfT);
    }
    
    /**
     * Gson을 이용한 jsonElement -> Class<T>.
     * 
     * @param <T>
     * @param jsonElement
     * @param type
     * @return T
     */
    public static <T> T fromJsonGson(final JsonElement jsonElement, final Type type) {
        Gson gson = new Gson();
        return gson.fromJson(jsonElement, type);
    }
    
    /**
     * Gson을 이용한 String -> Class<T>.
     * 
     * @param <T>
     * @param jsonString
     * @param typeOfT
     * @return T
     */
    public static <T> T fromJsonGson(final String jsonString, final Type typeOfT) {
        Gson gson = new Gson();
        return gson.fromJson(jsonString, typeOfT);
    }
    
    /**
     * String으로 넘어온 JSON 텍스트를 JsonArray 변환.
     * 
     * @param jsonString
     * @return JsonArray
     * @throws Exception
     */
    public static final JsonArray fromJsonArrayGson(final String jsonString) {
        JsonArray arr = null;
        JsonElement el = new JsonParser().parse(jsonString);
        
        if (jsonString != null) {
            arr = el.getAsJsonArray();
        }
        return arr;
    }
    
    /**
     * jackson 라이브러리도 변환
     * 
     * @param obj
     * @return
     */
    public static String objectToJackson(Object obj) {
        String rv = null;
        try {
            if (obj != null) {
                
                ObjectMapper om = new ObjectMapper();
                rv = om.writeValueAsString(obj);
                
            } else {
                rv = "{}";
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            rv = "{}";
        }
        return rv;
    }
    
    /**
     * jackson 라이브러리 사용
     * 
     * @param jsonStr
     * @return
     */
    public static Map<String, Object> jacksonToObj(String jsonStr) {
        Map<String, Object> natural = null;
        
        try {
            ObjectMapper om = new ObjectMapper();
            natural = om.readValue(jsonStr, new TypeReference<Map<String, Object>>() {
            });
            
        } catch (Exception e) {
            logger.error("Error : {} \n {} ", new String[] { e.getMessage(), jsonStr });
        }
        return natural;
    }
    
}
