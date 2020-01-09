package kr.or.wabis.framework.message;

import java.io.IOException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.io.Resource;
import org.springframework.util.Assert;

import kr.or.wabis.framework.util.LocaleUtil;

public class PropertyResourceBundleMessageSource extends ReloadableResourceBundleMessageSource {
    
    private Logger log = LoggerFactory.getLogger(PropertyResourceBundleMessageSource.class);
    
    private final String defaultLanguages = "EN";
    private String[] languages;
    
    public PropertyResourceBundleMessageSource() {
        super();
    }
    
    public void setLanguages(String[] languages) {
        
        if (languages != null) {
            
            this.languages = new String[languages.length];
            for (int idx = 0; idx < languages.length; ++idx) {
                String language = languages[idx];
                Assert.hasText(language, "language must not be empty");
                this.languages[idx] = language.trim().toUpperCase();
            }
            
        } else {
            this.languages = new String[] { defaultLanguages };
        }
    }
    
    @Override
    protected Properties loadProperties(Resource resource, String fileName) throws IOException {
        
        log.info("### loadProperties:{}", fileName);
        Properties prop = super.loadProperties(resource, fileName);        
        return prop;
    }
    
    public Properties searchMessageByLanguage() {
        Properties prop = super.getMergedProperties(LocaleUtil.getLocale()).getProperties();
        return prop;
    }
}