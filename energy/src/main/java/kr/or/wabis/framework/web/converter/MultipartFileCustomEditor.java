package kr.or.wabis.framework.web.converter;

import java.beans.PropertyEditorSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MultipartFileCustomEditor extends PropertyEditorSupport {
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * if Empty String, set MultipartFile to Null. (empty String cause error)
     */
    public void setAsText(String text) {
        log.debug("### Detected Empty String in MultipartFile. Changed to Null Object");
        setValue(null);
    }
}
