package kr.or.wabis.framework.util;

import java.util.Iterator;
import java.util.Vector;

import kr.or.wabis.framework.property.PropertyService;

public class PropertyUtil {
    
    private static PropertyService propertyService;
    
    public void setPropertyService(PropertyService propertyService) {
        PropertyUtil.propertyService = propertyService;
    }
    
    public static boolean getBoolean(String name) {
        return propertyService.getBoolean(name);
    }
    
    public static boolean getBoolean(String name, boolean def) {
        return propertyService.getBoolean(name, def);
    }
    
    public static double getDouble(String name) {
        return propertyService.getDouble(name);
    }
    
    public static double getDouble(String name, double def) {
        return propertyService.getDouble(name, def);
    }
    
    public static float getFloat(String name) {
        return propertyService.getFloat(name);
    }
    
    public static float getFloat(String name, float def) {
        return propertyService.getFloat(name, def);
    }
    
    public static int getInt(String name) {
        return propertyService.getInt(name);
    }
    
    public static int getInt(String name, int def) {
        return propertyService.getInt(name, def);
    }
    
    public static Iterator<?> getKeys() {
        return propertyService.getKeys();
    }
    
    public static Iterator<?> getKeys(String prefix) {
        return propertyService.getKeys(prefix);
    }
    
    public static long getLong(String name) {
        return propertyService.getLong(name);
    }
    
    public static long getLong(String name, long def) {
        return propertyService.getLong(name, def);
    }
    
    public static String getString(String name) {
        return propertyService.getString(name);
    }
    
    public static String getString(String name, String def) {
        return propertyService.getString(name, def);
    }
    
    public static String[] getStringArray(String name) {
        return propertyService.getStringArray(name);
    }
    
    public static Vector<?> getVector(String name) {
        return propertyService.getVector(name);
    }
    
    public static Vector<?> getVector(String name, Vector<?> def) {
        return propertyService.getVector(name, def);
    }
    
}