package kr.or.wabis.framework.property;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;

import org.apache.commons.collections.ExtendedProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanDefinitionStoreException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.util.Assert;

public class PropertyService implements ResourceLoaderAware, InitializingBean, DisposableBean {
    
    private final Logger log = LoggerFactory.getLogger(PropertyService.class);
    
    private ResourceLoader resourceLoader;
    
    private Set<?> propFileName;
    
    private ExtendedProperties extendedProp;
    
    public PropertyService() throws Exception {
        this.resourceLoader = null;
    }
        
    /**
     * 
     * @throws Exception
     */
    public void refreshPropertyFiles() throws Exception {
        
        String fileName = null;
        try {
            
            Iterator it = this.propFileName.iterator();
            
            while ((it != null) && (it.hasNext())) {
                Object element = it.next();
                String enc = null;
                
                if (element instanceof Map) {
                    Map ele = (Map) element;
                    enc = (String) ele.get("encoding");
                    fileName = (String) ele.get("filename");
                } 
                
                else {
                    fileName = (String) element;
                }
                
                loadPropertyResources(fileName, enc);
            }
            
        } catch (Exception e) {
            throw new Exception("error refreshing property file:" + fileName);
        }
    }
    
    /**
     * 
     * @param location
     * @param encoding
     * @throws Exception
     */
    private void loadPropertyResources(String location, String encoding) throws Exception {

        log.info("############################################################");
        log.info("loading location :{}, encoding : {}", location, encoding);       
                
        if (this.resourceLoader instanceof ResourcePatternResolver) {
            
            try {
                
                Resource[] resources = ((ResourcePatternResolver) this.resourceLoader).getResources(location);
                
                loadPropertyLoop(resources, encoding);
                
            } catch (IOException ex) {
                throw new BeanDefinitionStoreException("Could not resolve Properties resource pattern [" + location + "]", ex);
            }
            
        } else {
            Resource resource = this.resourceLoader.getResource(location);
            loadPropertyRes(resource, encoding);
        }
        
        log.info("############################################################");
    }
    
    /**
     * 
     * @param resources
     * @param encoding
     * @throws Exception
     */
    private void loadPropertyLoop(Resource[] resources, String encoding) throws Exception {
        
        Assert.notNull(resources, "Resource array must not be null");
        
        for (int i = 0; i < resources.length; ++i) {
            loadPropertyRes(resources[i], encoding);
        }
    }
    
    /**
     * 
     * @param resource
     * @param encoding
     * @throws Exception
     */
    private void loadPropertyRes(Resource resource, String encoding) throws Exception {

        log.info("loading resource : {}, encoding : {}", resource.getFilename(), encoding);
        
        Properties prop = new Properties();
        if (resource.getFilename().endsWith(".xml")) {
            prop.loadFromXML(resource.getInputStream());
        } 
        
        else {
            prop.load(resource.getInputStream());
        }
        
        log.info("loading properties : {}", prop);
        
        this.extendedProp.putAll(prop);
    }
    
    public void destroy() throws Exception {
        extendedProp.clear();
        extendedProp = null;
    }
    
    public void afterPropertiesSet() throws Exception {
        this.extendedProp = new ExtendedProperties();
        
        if (this.propFileName != null) {
            refreshPropertyFiles();
        }
    }
    
    public void setResourceLoader(ResourceLoader resourceLoader) {
        this.resourceLoader = resourceLoader;
    }
    
    public void setPropFileName(Set<?> propFileName) {
        this.propFileName = propFileName;
    }
    
    public boolean getBoolean(String name) {
        return getConfiguration().getBoolean(name);
    }
    
    public boolean getBoolean(String name, boolean def) {
        return getConfiguration().getBoolean(name, def);
    }
    
    public double getDouble(String name) {
        return getConfiguration().getDouble(name);
    }
    
    public double getDouble(String name, double def) {
        return getConfiguration().getDouble(name, def);
    }
    
    public float getFloat(String name) {
        return getConfiguration().getFloat(name);
    }
    
    public float getFloat(String name, float def) {
        return getConfiguration().getFloat(name, def);
    }
    
    public int getInt(String name) {
        return getConfiguration().getInt(name);
    }
    
    public int getInt(String name, int def) {
        return getConfiguration().getInt(name, def);
    }
    
    public Iterator<?> getKeys() {
        return getConfiguration().getKeys();
    }
    
    public Iterator<?> getKeys(String prefix) {
        return getConfiguration().getKeys(prefix);
    }
    
    public long getLong(String name) {
        return getConfiguration().getLong(name);
    }
    
    public long getLong(String name, long def) {
        return getConfiguration().getLong(name, def);
    }
    
    public String getString(String name) {
        return getConfiguration().getString(name);
    }
    
    public String getString(String name, String def) {
        return getConfiguration().getString(name, def);
    }
    
    public String[] getStringArray(String name) {
        return getConfiguration().getStringArray(name);
    }
    
    public Vector<?> getVector(String name) {
        return getConfiguration().getVector(name);
    }
    
    public Vector<?> getVector(String name, Vector<?> def) {
        return getConfiguration().getVector(name, def);
    }
    
    private ExtendedProperties getConfiguration() {
        return this.extendedProp;
    }
}