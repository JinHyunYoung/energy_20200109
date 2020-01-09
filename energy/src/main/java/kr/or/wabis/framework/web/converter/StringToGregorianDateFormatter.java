package kr.or.wabis.framework.web.converter;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import org.springframework.format.Formatter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.util.StringUtils;

import kr.or.wabis.framework.util.DateUtil;

/**
 * This Class replace org.springframework.format.datetime.DateFormatter.
 * 
 */
public class StringToGregorianDateFormatter implements Formatter<Date> {
    
    private static final Map<DateTimeFormat.ISO, String> ISO_PATTERNS;
    private String pattern;
    private int style = 2;
    private String stylePattern;
    private DateTimeFormat.ISO iso;
    private TimeZone timeZone;
    private boolean lenient = false;
    
    public StringToGregorianDateFormatter() {
    }
    
    public StringToGregorianDateFormatter(String pattern) {
        this.pattern = pattern;
    }
    
    public void setPattern(String pattern) {
        this.pattern = pattern;
    }
    
    public void setIso(DateTimeFormat.ISO iso) {
        this.iso = iso;
    }
    
    public void setStyle(int style) {
        this.style = style;
    }
    
    public void setStylePattern(String stylePattern) {
        this.stylePattern = stylePattern;
    }
    
    public void setTimeZone(TimeZone timeZone) {
        this.timeZone = timeZone;
    }
    
    public void setLenient(boolean lenient) {
        this.lenient = lenient;
    }
    
    public String print(Date date, Locale locale) {
        return getDateFormat(locale).format(date);
    }
    
    /**
     * If Ethiopic-Date, Convert to Gregorian
     */
    public Date parse(String text, Locale locale) throws ParseException {
        // return getDateFormat(locale).parse(text);
        return DateUtil.convertToGregorian(text, pattern);
    }
    
    protected DateFormat getDateFormat(Locale locale) {
        DateFormat dateFormat = createDateFormat(locale);
        if (this.timeZone != null) {
            dateFormat.setTimeZone(this.timeZone);
        }
        dateFormat.setLenient(this.lenient);
        return dateFormat;
    }
    
    private DateFormat createDateFormat(Locale locale) {
        if (StringUtils.hasLength(this.pattern)) {
            return new SimpleDateFormat(this.pattern, locale);
        }
        if ((this.iso != null) && (this.iso != DateTimeFormat.ISO.NONE)) {
            String pattern = (String) ISO_PATTERNS.get(this.iso);
            if (pattern == null) {
                throw new IllegalStateException("Unsupported ISO format " + this.iso);
            }
            SimpleDateFormat format = new SimpleDateFormat(pattern);
            format.setTimeZone(TimeZone.getTimeZone("UTC"));
            return format;
        }
        if (StringUtils.hasLength(this.stylePattern)) {
            int dateStyle = getStylePatternForChar(0);
            int timeStyle = getStylePatternForChar(1);
            if ((dateStyle != -1) && (timeStyle != -1)) {
                return DateFormat.getDateTimeInstance(dateStyle, timeStyle, locale);
            }
            if (dateStyle != -1) {
                return DateFormat.getDateInstance(dateStyle, locale);
            }
            if (timeStyle != -1) {
                return DateFormat.getTimeInstance(timeStyle, locale);
            }
            throw new IllegalStateException("Unsupported style pattern '" + this.stylePattern + "'");
        }
        
        return DateFormat.getDateInstance(this.style, locale);
    }
    
    private int getStylePatternForChar(int index) {
        if ((this.stylePattern != null) && (this.stylePattern.length() > index)) {
            switch (this.stylePattern.charAt(index)) {
                case 'S':
                    return 3;
                case 'M':
                    return 2;
                case 'L':
                    return 1;
                case 'F':
                    return 0;
                case '-':
                    return -1;
            }
        }
        throw new IllegalStateException("Unsupported style pattern '" + this.stylePattern + "'");
    }
    
    static {
        Map formats = new HashMap(4);
        formats.put(DateTimeFormat.ISO.DATE, "yyyy-MM-dd");
        formats.put(DateTimeFormat.ISO.TIME, "HH:mm:ss.SSSZ");
        formats.put(DateTimeFormat.ISO.DATE_TIME, "yyyy-MM-dd'T'HH:mm:ss.SSSZ");
        ISO_PATTERNS = Collections.unmodifiableMap(formats);
    }
    
}
