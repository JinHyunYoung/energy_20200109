package kr.or.wabis.framework.web.tld;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.Locale;

import javax.servlet.jsp.JspException;

import kr.or.wabis.framework.contants.DateFormatConstant;
import kr.or.wabis.framework.util.DateUtil;
import kr.or.wabis.framework.util.LocaleUtil;

public class UserFunctionDate extends ExtendedTagSupport {
    
    @Override
    public void doTag() throws JspException, IOException {
        getJspContext().getOut().print("Tag Library " + this.getClass().getSimpleName());
    }
    
    public static Locale getLocale() {
        return LocaleUtil.getLocale();
    }
    
    public static String currentDate() {
        return DateUtil.getTodayStr(DateFormatConstant.UI_DATE_FORMAT);
    }
    
    public static String currentDateFmt(String format) {
        return DateUtil.getTodayStr(format);
    }
    
    public static String currentDateTime() {
        return formatDateFmt(new Date(), DateFormatConstant.UI_DATETIME_FORMAT);
    }
    
    public static String formatDate(Date date) {
        return DateUtil.dateToStr(date, DateFormatConstant.UI_DATE_FORMAT);
    }
    
    public static String formatTime(Date date) {
        return DateUtil.dateToStr(date, DateFormatConstant.UI_TIME_FORMAT);
    }
    
    public static String formatDateTime(Date date) {
        return DateUtil.dateToStr(date, DateFormatConstant.UI_DATETIME_FORMAT);
    }
    
    public static String formatDateFmt(Date date, String format) {
        return DateUtil.dateToStr(date, format);
    }
    
    public static String changeFormat(String dateStr, String beforeFormat, String afterFormat) throws ParseException {
        return DateUtil.changeFormat(dateStr, beforeFormat, afterFormat);
    }
    
}
