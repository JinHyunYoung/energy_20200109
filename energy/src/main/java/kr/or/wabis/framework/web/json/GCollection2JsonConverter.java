package kr.or.wabis.framework.web.json;

import java.lang.reflect.Type;
import java.util.Collection;
import java.util.Map;

import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

/**
 * Map의 value가 null인 경우 empty string 으로 처리 하게
 *
 */
@SuppressWarnings({ "unchecked", "rawtypes" })
public class GCollection2JsonConverter implements JsonSerializer<Collection>, JsonDeserializer<Map> {
    
    public Map deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
        return null;
    }
    
    public JsonElement serialize(Collection src, Type typeOfSrc, JsonSerializationContext context) {
        
        JsonArray array = new JsonArray();
        Type childGenericType = null;
        
        for (Object item : src) {
            
            JsonElement valueElement;
            if (item == null) {
                valueElement = new JsonPrimitive("");
            } else {
                Type childType = (childGenericType == null) ? item.getClass() : childGenericType;
                valueElement = context.serialize(item, childType);
            }
            
            array.add(valueElement);
        }
        
        return array;
    }
    
}