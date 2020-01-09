package kr.or.wabis.framework.web.converter;

import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.context.support.EmbeddedValueResolutionSupport;
import org.springframework.format.AnnotationFormatterFactory;
import org.springframework.format.Formatter;
import org.springframework.format.Parser;
import org.springframework.format.Printer;
import org.springframework.format.annotation.DateTimeFormat;

public class StringDateTimeFormatAnnotationFormatterFactory extends EmbeddedValueResolutionSupport implements AnnotationFormatterFactory<DateTimeFormat> {
    
    private static final Set<Class<?>> FIELD_TYPES;
    
    public Set<Class<?>> getFieldTypes() {
        return FIELD_TYPES;
    }
    
    public Printer<?> getPrinter(DateTimeFormat annotation, Class<?> fieldType) {
        return getFormatter(annotation, fieldType);
    }
    
    public Parser<?> getParser(DateTimeFormat annotation, Class<?> fieldType) {
        return getFormatter(annotation, fieldType);
    }
    
    /**
     * Replace org.springframework.format.datetime.DateFormatter to StringToGregorianDateFormatter
     * 
     * @param annotation
     * @param fieldType
     * @return Formatter
     */
    protected Formatter<Date> getFormatter(DateTimeFormat annotation, Class<?> fieldType) {
        
        // DateFormatter formatter = new DateFormatter();
        StringToGregorianDateFormatter formatter = new StringToGregorianDateFormatter();
        
        formatter.setStylePattern(resolveEmbeddedValue(annotation.style()));
        formatter.setIso(annotation.iso());
        formatter.setPattern(resolveEmbeddedValue(annotation.pattern()));
        
        return formatter;
    }
    
    static {
        Set fieldTypes = new HashSet(4);
        fieldTypes.add(Date.class);
        FIELD_TYPES = Collections.unmodifiableSet(fieldTypes);
    }
}
