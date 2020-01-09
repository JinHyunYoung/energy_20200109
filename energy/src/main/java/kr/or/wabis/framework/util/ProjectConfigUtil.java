package kr.or.wabis.framework.util;

import java.util.NoSuchElementException;

import org.apache.commons.configuration.AbstractConfiguration;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.ConversionException;
import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.configuration.reloading.FileChangedReloadingStrategy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProjectConfigUtil {
    
    private final static Logger log = LoggerFactory.getLogger(ProjectConfigUtil.class);

    private final static char DEFAULT_DELIMITER = ',';
    
    private static CompositeConfiguration config;
    private static String config_file;
    
    static {
        
        try {            
            
            config_file = "properties/" + SystemUtil.getProperty(SystemUtil.PROJECT_CONFIG_FILE);
            
            // default delimiter(,)를 DEFAULT_DELIMITER 으로 변경 함
            AbstractConfiguration.setDefaultListDelimiter(DEFAULT_DELIMITER);
            
            config = new CompositeConfiguration();
            
            XMLConfiguration xmlConfig = new XMLConfiguration(config_file);
            
            // 바뀌었는지 확인하여 다시 읽어오는 기능
            xmlConfig.setReloadingStrategy(new FileChangedReloadingStrategy());
            config.addConfiguration(xmlConfig);
            
        } catch (ConfigurationException e) {
            e.printStackTrace();
            log.error("Configuration Error from : " + config_file + "/n" + e.getMessages());
        }
    }
    
    /**
     * <pre>
     * 
     * </pre>
     * 
     * @param key
     * @return
     */
    public static Object getProperty(String key) {
        return config.getProperty(key);
    }
    
    /**
     * <pre>
     * property value를 String 타입으로 획득.
     * 매칭되는 property 부재 시 null 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @return String config4j.propertiest 파일의 해당 property value
     */
    public static String getString(String prop) {
        String value = null;
        try {
            value = config.getString(prop);
        } catch (ConversionException convException) {
            log.error("ConversionException :{}", convException);
        }
        return value;
    }
    
    /**
     * <pre>
     * property value를 String 타입으로 획득.
     * 매칭되는 property 부재 경우 대비 디폴트 value 지정 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @param String
     *            (defaultValue) 해당 property value 부재 시 획득할 디폴트 value
     * @return String config4j.propertiest 파일의 해당 property value
     */
    public static String getString(String prop, String defaultValue) {
        String value = null;
        try {
            value = config.getString(prop, defaultValue);
        } catch (ConversionException convException) {
            log.error("ConversionException :{}", convException);
        }
        return value;
    }
    
    /**
     * <pre>
     * 1개의 property에 여러 value들이  쉼표로 구분되어 존재 시, 
     * 모든 value들을 String 배열로 획득.
     * 매칭되는 property 부재 시 빈 String array 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @return String[] config4j.propertiest 파일의 해당 property value들
     */
    public static String[] getStringArrayValue(String prop) {
        String[] value = null;
        try {
            value = config.getStringArray(prop);
        } catch (ConversionException convException) {
            log.error("ConversionException :{}", convException);
        }
        return (value == null) ? new String[0] : value;
    }
    
    /**
     * <pre>
     * </pre>
     * 
     * @param prop
     * @param deli
     * @return
     */
    public static String[] getStringArrayValue(String prop, char deli) {
        String[] value = null;
        try {
            config.setListDelimiter(deli);
            value = config.getStringArray(prop);
        } catch (ConversionException convException) {
            log.error("ConversionException :{}", convException);
        }
        return (value == null) ? new String[0] : value;
    }
    
    /**
     * <pre>
     * property value를 int 타입으로 획득.
     * 매칭되는 property 부재 혹은 value 타입오류 발생 시 -987654321 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @return int config4j.propertiest 파일의 해당 property value
     */
    public static int getIntValue(String prop) {
        int value;
        try {
            value = config.getInt(prop);
        } catch (NoSuchElementException nseException) {
            log.error("NoSuchElementException :{}", nseException);
            value = -987654321;
        } catch (ConversionException convException) {
            log.error("ConversionException :{}", convException);
            value = -987654321;
        }
        return value;
    }
    
    /**
     * <pre>
     * property value를 int 타입으로 획득.
     * 매칭되는 property 부재 경우 대비 디폴트 value 지정 획득.
     * property value 타입오류 발생 시 -987654321 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @param int
     *            (defaultValue) 해당 property value 부재 시 획득할 디폴트 value
     * @return int config4j.propertiest 파일의 해당 property value
     */
    public static int getIntValue(String prop, int defaultValue) {
        int value;
        try {
            value = config.getInt(prop, defaultValue);
        } catch (ConversionException convException) {
            log.error("ConversionException :{}", convException);
            value = -987654321;
        }
        return value;
    }
    
    /**
     * <pre>
     * property value를 float 타입으로 획득.
     * 매칭되는 property 부재 혹은 value 타입오류 발생 시 -987654321f 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @return float config4j.propertiest 파일의 해당 property value
     */
    public static float getFloatValue(String prop) {
        float value;
        try {
            value = config.getFloat(prop);
        } catch (NoSuchElementException nseException) {
            log.error("NoSuchElementException :{}", nseException);
            value = -987654321f;
        } catch (ConversionException convException) {
            log.error("ConversionException :{}", convException);
            value = -987654321f;
        }
        return value;
    }
    
    /**
     * <pre>
     * property value를 float 타입으로 획득.
     * 매칭되는 property 부재 경우 대비 디폴트 value 지정 획득.
     * property value 타입오류 발생 시 -987654321f 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @param float
     *            (defaultValue) 해당 property value 부재 시 획득할 디폴트 value
     * @return float config4j.propertiest 파일의 해당 property value
     */
    public static float getFloatValue(String prop, float defaultValue) {
        float value;
        try {
            value = config.getFloat(prop, defaultValue);
        } catch (ConversionException convException) {
            log.error("ConversionException :{}", convException);
            value = -987654321f;
        }
        return value;
    }
    
    /**
     * <pre>
     * property value를 boolean 타입으로 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @return boolean config4j.propertiest 파일의 해당 property value
     */
    public static boolean getBooleanValue(String prop) {
        return config.getBoolean(prop);
    }
    
    /**
     * <pre>
     * property value를 boolean 타입으로 획득.
     * 매칭되는 property 부재 경우 대비 디폴트 value 지정 획득.
     * </pre>
     * 
     * @param String
     *            (prop) config4j.properties 파일의 property
     * @param boolean
     *            (defaultValue) 해당 property value 부재 시 획득할 디폴트 value
     * @return boolean config4j.propertiest 파일의 해당 property value
     */
    public static boolean getBooleanValue(String prop, boolean defaultValue) {
        try {
            return config.getBoolean(prop, defaultValue);
        } catch (Exception e) {
            log.error("Exception :{}", e);
            return defaultValue;
        }
    }
}