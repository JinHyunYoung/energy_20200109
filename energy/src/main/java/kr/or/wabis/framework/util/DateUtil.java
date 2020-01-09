package kr.or.wabis.framework.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import kr.or.wabis.framework.contants.DateFormatConstant;

public class DateUtil {
    
    public static final int REAL = 1;
    public static final int FIRST = 2;
    public static final int LAST = 3;
    
    /**
     * getToday (ddMMyyyy) != 오늘 날짜를 리턴한다. (ddMMyyyy) =!
     * 
     * @param dateFormat
     *            String
     * @return String
     */
    public static String getTodayStr() {
        return dateToStr(new Date(), DateFormatConstant.JAVA_DATE_FORMAT);
    }
    
    /**
     * getToday != 오늘 날짜를 리턴한다. =!
     * 
     * @param dateFormat
     *            String
     * @return String
     */
    public static String getTodayStr(String dateFormat) {
        return dateToStr(new Date(), dateFormat);
    }
    
    /**
     * getToday != 오늘 날짜를 리턴한다. ISO 표준일. =!
     * 
     * @param dateFormat
     *            String
     * @return String
     */
    public static String getTodayISOStr(String dateFormat) {
        
        DateTime dtISO = DateTime.now();
        DateTimeFormatter dtf = DateTimeFormat.forPattern(dateFormat);
        
        return dtISO.toString(dtf);
    }
    
    /**
     * getDateStr != 주어진 날짜를 포맷에 맞게 변경하여 리턴한다.=!
     * 
     * @param date
     *            String
     * @param dateFormat
     *            String
     * @return String
     */
    public static String dateToStr(Date isoDate, String dateFormat) {
        
        if (isoDate == null) {
            return "";
        }
        
        return convertWithLocale(isoDate, dateFormat);
    }
    
    /**
     * 
     * @param isoDateStr
     * @param dateFormat
     * @return
     * @throws ParseException
     */
    public static Date strToDate(String isoDateStr, String dateFormat) throws ParseException {
        
        if (StringUtil.isEmpty(isoDateStr)) {
            return null;
        }
        
        SimpleDateFormat formatter = new SimpleDateFormat(dateFormat);
        Date date = formatter.parse(isoDateStr);
        
        return convertWithLocale(date);
    }
    
    /**
     * 
     * @param isoDateStr
     * @param format
     * @return
     */
    public static boolean isDateFormat(String isoDateStr, String format) {
        
        boolean isDateStr = true;
        try {
            strToDate(isoDateStr, format);
        } catch (ParseException e) {
            isDateStr = false;
        }
        
        return isDateStr;
    }
    
    /**
     * Change DateString Format != 날짜형식의 String의 포맷을 변경한다. =!
     * 
     * @param dateStr
     *            - source DateString Value
     * @param beforeFormat
     * @param afterFormat
     * @return String
     * @throws ParseException
     */
    public static String changeFormat(String dateStr, String beforeFormat, String afterFormat) throws ParseException {
        
        if (dateStr == null || "".equals(dateStr)) {
            return null;
        }
        
        SimpleDateFormat srcSdf = new SimpleDateFormat(beforeFormat);
        Date date = srcSdf.parse(dateStr);
        
        SimpleDateFormat targetSdf = new SimpleDateFormat(afterFormat);
        
        return targetSdf.format(date);
    }
    
    /**
     * 
     * @param date
     * @return
     * @throws ParseException
     */
    public static Date addHHmmss(Date date) throws ParseException {
        
        String today = DateTime.now().toString(DateTimeFormat.forPattern("HHmmss"));
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, Integer.parseInt(today.substring(0, 2)));
        cal.set(Calendar.MINUTE, Integer.parseInt(today.substring(2, 4)));
        cal.set(Calendar.SECOND, Integer.parseInt(today.substring(4, 6)));
        
        return cal.getTime();
    }
    
    /**
     * add days to date
     * 
     * @param days
     * @return
     */
    public static Date addDays(int days) {
        return addDays(new Date(), days);
    }
    
    /**
     * add days to date
     * 
     * @param date
     * @param days
     * @return
     */
    public static Date addDays(Date date, int days) {
        
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(date);
        cal.add(Calendar.DATE, days);
        
        return cal.getTime();
    }
    
    /**
     * add months to date
     * 
     * @param days
     * @return
     */
    public static Date addMonth(int month) {
        return addMonth(new Date(), month);
    }
    
    /**
     * add months to date
     * 
     * @param date
     * @param days
     * @return
     */
    public static Date addMonth(Date date, int month) {
        
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(date);
        cal.add(Calendar.MONTH, month);
        
        return cal.getTime();
    }
    
    /**
     * Return strtDt's 00:00:00
     * 
     * @param strtDt
     * @param defaultDate
     *            if strtDt null, Default Date
     * @return
     */
    public static Date getStartOfDay(Date strtDt) {
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(strtDt);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        
        return cal.getTime();
    }
    
    /**
     * Return strtDt's 00:00:00
     * 
     * @param strtDt
     * @param defaultDate
     *            if strtDt null, Default Date
     * @return
     */
    public static Date getStartOfDay(Date strtDt, Date defaultDate) {
        return getStartOfDay(strtDt == null ? defaultDate : strtDt);
    }
    
    /**
     * Return endDt's 23:59:59
     * 
     * @param endDt
     * @param defaultDate
     *            if endDt null, Default Date
     * @return
     */
    public static Date getEndOfDay(Date endDt) {
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(endDt);
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        
        return cal.getTime();
    }
    
    /**
     * Return endDt's 23:59:59
     * 
     * @param endDt
     * @param defaultDate
     *            if endDt null, Default Date
     * @return
     */
    public static Date getEndOfDay(Date endDt, Date defaultDate) {
        return getEndOfDay(endDt == null ? defaultDate : endDt);
    }
    
    /**
     * Using Joda-Time, Convert Ethiopian-Date to ISO-Date
     * 
     * @param
     * @return date string
     */
    public static Date convertToGregorian(String dateStr, String format) {
        
        // input value is ddMMyyyy ('02122016'), but VO is
        // @DateTimeFormat(pattern = DateFormatConstant.JAVA_DATETIME_FORMAT)
        if (StringUtil.length(dateStr) == 8 && DateFormatConstant.JAVA_DATETIME_FORMAT.equals(format)) {
            dateStr = dateStr + " 00:00:00"; // force append hour,minute,second
        }
        
        DateTimeFormatter formatter = DateTimeFormat.forPattern(format);
        DateTime dtEthiopic = formatter.parseDateTime(dateStr);
        
        return dtEthiopic.toDate();
    }
    
    /**
     * Using Joda-Time, Convert ISO-Date to Other Chronology like Ethiopian
     * 
     * @param
     * @return date string
     */
    public static Date convertWithLocale(Date isoDate) {
        
        DateTime dtISO = new DateTime(isoDate);
        return dtISO.toDate();
    }
    
    /**
     * Using Joda-Time, Convert ISO-Date to Other Chronology like Ethiopian
     * 
     * @param
     * @return date string
     */
    public static String convertWithLocale(Date isoDate, String format) {
        
        DateTime dtISO = new DateTime(isoDate);
        DateTimeFormatter dtf = DateTimeFormat.forPattern(format);
        String nowStr = dtISO.toString(dtf);
        
        return nowStr;
    }
    
    /**
     * Date형 날짜를 포맷에 맞는 문자열로 변환
     * 
     * @param dt
     *            : 문자열로 변경할 날짜
     * @param format
     *            : 날짜포맷(yyyy-MM-dd HH:mm:ss)
     * @return String : 포맷형식으로 변환된 시간
     */
    public final static String getDateToString(Date dt, String format) {
        
        DateFormat df = new SimpleDateFormat(format);
        
        String strDate = "";
        if (df != null)
            strDate = df.format(dt);
        return strDate;
    }
    
    /**
     * Date를 타임존에 해당하는 시간으로 포맷에 맞게 변환하여 리턴하는 함수
     * 
     * @param timeZone
     *            : 타임존(Asia/Seoul, Greenwich, America/Los_Angeles, America/New_York 등)
     * @param format
     *            : 날짜포맷(yyyy-MM-dd HH:mm:ss)
     * @param date
     *            : 변환할 Date
     * @return String : 타임존의 시간
     */
    public final static String getDateTimeOfGMT(String timeZone, String format, Date date) {
        
        DateFormat df = new SimpleDateFormat(format);
        TimeZone tz = TimeZone.getTimeZone(timeZone);
        df.setTimeZone(tz);
        String gmtDate = df.format(date);
        
        return gmtDate;
    }
    
    /**
     * 
     * @param dt
     * @param minutes
     * @return
     */
    public final static Date AddMinute(Date dt, int minutes) {
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.MINUTE, minutes);
        return cal.getTime();
    }
    
    /**
     * 
     * @param dt
     * @param seconds
     * @return
     */
    public final static Date AddSecond(Date dt, int seconds) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.SECOND, seconds);
        return cal.getTime();
    }
    
    /**
     * 
     * @param dt
     * @param days
     * @return
     */
    public final static Date AddDay(Date dt, int days) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.DATE, days);
        return cal.getTime();
    }
    
    /**
     * 
     * @param dt
     * @return
     */
    public final static String getYYYYMMDD(Date dt) {
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        String strDate = df.format(dt);
        return strDate;
    }
    
    /**
     * 
     * @param dt
     * @param amount
     * @return
     * @throws ParseException
     */
    public static Date getAddMonth(Date dt, int amount) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.MONTH, amount);
        return cal.getTime();
    }
    
    /**
     * 
     * @param dt
     * @param amount
     * @return
     * @throws ParseException
     */
    public static Date getAddYear(Date dt, int amount) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.YEAR, amount);
        return cal.getTime();
    }
    
    /**
     * 
     * @param dt
     * @param amount
     * @return
     * @throws ParseException
     */
    public static Date getAddHour(Date dt, int amount) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.HOUR_OF_DAY, amount);
        return cal.getTime();
    }
    
    /**
     * 
     * @param dt
     * @param amount
     * @return
     * @throws ParseException
     */
    public static Date getAddDate(Date dt, int amount) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.DATE, amount);
        return cal.getTime();
    }
    
    /**
     * 
     * @param dt
     * @return
     */
    public static int getYear(Date dt) {
        Calendar cal = Calendar.getInstance(Locale.FRANCE);
        cal.setTime(dt);
        int i = cal.get(Calendar.YEAR);
        return i;
    }
    
    /**
     * 
     * @param dt
     * @return
     */
    public static int getMonth(Date dt) {
        Calendar cal = Calendar.getInstance(Locale.FRANCE);
        cal.setTime(dt);
        int i = cal.get(Calendar.MONTH);
        return i;
    }
    
    /**
     * 
     * @param dt
     * @return
     */
    @SuppressWarnings("deprecation")
    public static Date getLastDayOfMon(Date dt) {
        Calendar cal = Calendar.getInstance();
        cal.set(dt.getYear(), dt.getMonth(), 1);
        dt.setDate(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        return dt;
    }
    
    /**
     * <p>
     * 입력 날짜와 시각을 DBFormat 형태로 변환 후 return.
     * 
     * @param dt
     * @param calcMethod
     *            [1:실제값, 2:첫번째일, 3:마지막일]
     * @param intervalType
     *            [년도기준:yyyy,월:m,일자:d,시:h ,10분:10mi,15분:15mi, 30분:30mi]
     * @param interval
     * @param outputDBFormat
     * @return EvaluationValue
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * String strValue = DateUtil.getDateParamEvaluation(now(),"1:실제값","년도기준:yyyy",-1,"YYYYMMDD")
     *         </pre>
     */
    public final static String getDateParamEvaluation(Date dt, String calcMethod, String intervalType, int interval, String outputDBFormat) throws ParseException {
        Date toDate = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        
        int intervalUnit = Calendar.DATE;
        int intervalCount = 1;
        
        switch (intervalType) {
            case "년도기준:yyyy":
                intervalUnit = Calendar.YEAR;
                intervalCount = 1;
                break;
            case "월:m":
                intervalUnit = Calendar.MONTH;
                intervalCount = 1;
                break;
            case "일자:d":
                intervalUnit = Calendar.DATE;
                intervalCount = 1;
                break;
            case "시:h":
                intervalUnit = Calendar.HOUR;
                intervalCount = 1;
                break;
            case "10분:10mi":
                intervalUnit = Calendar.MINUTE;
                intervalCount = 10;
                break;
            case "1분:1mi":
                intervalUnit = Calendar.MINUTE;
                intervalCount = 1;
                break;
            case "15분:15mi":
                intervalUnit = Calendar.MINUTE;
                intervalCount = 15;
                break;
            case "30분:30mi":
                intervalUnit = Calendar.MINUTE;
                intervalCount = 30;
                break;
        }
        
        cal.add(intervalUnit, interval * intervalCount);
        toDate = cal.getTime();
        
        if (calcMethod.equals("2:첫번째일")) {
            switch (intervalUnit) {
                case Calendar.YEAR:
                    toDate = getToDate(getToString(toDate, "YYYY"), "YYYY");
                    break;
                case Calendar.MONTH:
                    toDate = getToDate(getToString(toDate, "YYYYMM"), "YYYYMM");
                    break;
                case Calendar.DATE:
                    toDate = getToDate(getToString(toDate, "YYYYMMDD"), "YYYYMMDD");
                    break;
                case Calendar.HOUR:
                    toDate = getToDate(getToString(toDate, "YYYYMMDDHH"), "YYYYMMDDHH");
                    break;
                case Calendar.MINUTE:
                    toDate = getToDate(getToString(toDate, "YYYYMMDDHHMI"), "YYYYMMDDHHMI");
                    break;
            }
            cal.setTime(toDate);
            while (cal.get(intervalUnit) % intervalCount != 0) {
                cal.add(intervalUnit, -1);
            }
            toDate = cal.getTime();
        } else if (calcMethod.equals("3:마지막일")) {
            switch (intervalUnit) {
                case Calendar.YEAR:
                    toDate = getToDate(getToString(toDate, "YYYY") + "1231235959", "YYYYMMDDHHMISS");
                    break;
                case Calendar.MONTH:
                    toDate = getToDate(getToString(toDate, "YYYYMM") + "01235959", "YYYYMMDDHHMISS");
                    break;
                case Calendar.DATE:
                    toDate = getToDate(getToString(toDate, "YYYYMMDD") + "235959", "YYYYMMDDHHMISS");
                    break;
                case Calendar.HOUR:
                    toDate = getToDate(getToString(toDate, "YYYYMMDDHH") + "5959", "YYYYMMDDHHMISS");
                    break;
                case Calendar.MINUTE:
                    toDate = getToDate(getToString(toDate, "YYYYMMDDHHMI") + "59", "YYYYMMDDHHMISS");
                    break;
            }
            cal.setTime(toDate);
            if (cal.get(intervalUnit) + 1 % intervalCount != 0) {
                cal.add(intervalUnit, +1);
                while (cal.get(intervalUnit) % intervalCount != 0) {
                    cal.add(intervalUnit, +1);
                }
                cal.add(intervalUnit, -1);
            }
            if (intervalUnit == Calendar.MONTH) {
                cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
            }
            toDate = cal.getTime();
        }
        
        return getToString(toDate, outputDBFormat);
    }
    
    /**
     * <p>
     * 입력 날짜와 시각을 DBFormat 형태로 변환 후 return.
     * 
     * @param dt
     * @param DBFormat
     * @return strDate
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * String strDate = DateUtil.getToString(now(),"YYYY/MM/DD HH:MMISS")
     *         </pre>
     */
    public final static String getToString(Date dt, String DBFormat) {
        
        String toFormat;
        toFormat = DBFormat;
        toFormat = toFormat.replace("YYYY", "yyyy");
        toFormat = toFormat.replace("MM", "MM");
        toFormat = toFormat.replace("DD", "dd");
        toFormat = toFormat.replace("HH", "HH");
        toFormat = toFormat.replace("MI", "mm");
        toFormat = toFormat.replace("SS", "ss");
        
        DateFormat df = new SimpleDateFormat(toFormat);
        String strDate = df.format(dt);
        return strDate;
    }
    
    /**
     * <p>
     * 입력 날짜와 시각을 DBFormat 형태로 변환 후 return.
     * 
     * @param StringDate
     * @param DBFormat
     * @return Date
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * String strDate = DateUtil.getToDate("20150101012110","YYYYMMDDHHMISS")
     *         </pre>
     * 
     * @throws ParseException
     */
    
    public final static Date getToDate(String StringDate, String DBFormat) throws ParseException {
        
        Date dt;
        String toFormat;
        toFormat = DBFormat;
        toFormat = toFormat.replace("YYYY", "yyyy");
        toFormat = toFormat.replace("MM", "MM");
        toFormat = toFormat.replace("DD", "dd");
        toFormat = toFormat.replace("HH", "HH");
        toFormat = toFormat.replace("MI", "mm");
        toFormat = toFormat.replace("SS", "ss");
        DateFormat df = new SimpleDateFormat(toFormat);
        
        if (StringDate.length() > DBFormat.length())
            StringDate = StringDate.substring(0, DBFormat.length() - 1);
        
        dt = df.parse(StringDate);
        return dt;
    }
    
    /**
     * <p>
     * 현재 날짜와 시각을 yyyyMMdd 형태로 변환 후 return.
     * 
     * @param null
     * @return yyyyMMdd
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * String date = DateUtil.getYyyymmdd()
     *         </pre>
     */
    public static String getYyyymmdd(Calendar cal) {
        
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "yyyyMMdd";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        return formatter.format(cal.getTime());
    }
    
    /**
     * <p>
     * GregorianCalendar 객체를 반환함.
     * 
     * @param yyyymmdd
     *            날짜 인수
     * @return GregorianCalendar
     * @see java.util.Calendar
     * @see java.util.GregorianCalendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * Calendar cal = DateUtil.getGregorianCalendar(DateUtil.getCurrentYyyymmdd())
     *      </pre>
     */
    public static GregorianCalendar getGregorianCalendar(String yyyymmdd) {
        
        int yyyy = Integer.parseInt(yyyymmdd.substring(0, 4));
        int mm = Integer.parseInt(yyyymmdd.substring(4, 6));
        int dd = Integer.parseInt(yyyymmdd.substring(6));
        
        GregorianCalendar calendar = new GregorianCalendar(yyyy, mm - 1, dd, 0, 0, 0);
        
        return calendar;
        
    }
    
    /**
     * <p>
     * 현재 날짜와 시각을 yyyyMMddhhmmss 형태로 변환 후 return.
     * 
     * @param null
     * @return yyyyMMddhhmmss
     * @see java.util.Date
     * @see java.util.Locale
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * String date = DateUtil.getCurrentDateTime()
     *      </pre>
     */
    public static String getCurrentDateTime() {
        
        Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "yyyyMMddHHmmss";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        return formatter.format(today);
    }
    
    /**
     * 
     * @return
     */
    public static String getCurrentYear() {
        
        Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "yyyy";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        return formatter.format(today);
    }
    
    /**
     * 현재년도 int로 추출.
     * 
     * @param year
     *            +-년도 0이면 현재년도
     * @return int
     */
    public static int getCurrentYear(final int year) {
        Calendar now = Calendar.getInstance();
        int iYear = now.get(Calendar.YEAR) + year;
        return iYear;
    }
    
    /**
     * 
     * @return
     */
    public static String getCurrentMonth() {
        Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "MM";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        return formatter.format(today);
    }
    
    /**
     * 
     * @return
     */
    public static String getCurrentDay() {
        Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "dd";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        return formatter.format(today);
    }
    
    /**
     * <p>
     * 현재 시각을 hhmmss 형태로 변환 후 return.
     * 
     * @param null
     * @return hhmmss
     * @see java.util.Date
     * @see java.util.Locale
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     *  String date = DateUtil.getCurrentDateTime()
     *      </pre>
     */
    public static String getCurrentTime() {
        Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "HHmmss";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        return formatter.format(today);
        
    }
    
    /**
     * <p>
     * 현재 날짜를 yyyyMMdd 형태로 변환 후 return.
     * 
     * @param null
     * @return yyyyMMdd *
     *         <p>
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * String date = DateUtil.getCurrentYyyymmdd()
     *         </pre>
     */
    public static String getCurrentYyyymmdd() {
        return getCurrentDateTime().substring(0, 8);
    }
    
    /**
     * <p>
     * 주로 일자를 구하는 메소드.
     * 
     * @param yyyymm
     *            년월
     * @param week
     *            몇번째 주
     * @param pattern
     *            리턴되는 날짜패턴 (ex:yyyyMMdd)
     * @return 연산된 날짜
     * @see java.util.Calendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * String date = DateUtil.getWeekToDay("200801" , 1, "yyyyMMdd")
     *      </pre>
     */
    public static String getWeekToDay(String yyyymm, int week, String pattern) {
        
        Calendar cal = Calendar.getInstance(Locale.FRANCE);
        
        int new_yy = Integer.parseInt(yyyymm.substring(0, 4));
        int new_mm = Integer.parseInt(yyyymm.substring(4, 6));
        int new_dd = 1;
        
        cal.set(new_yy, new_mm - 1, new_dd);
        
        // 임시 코드
        if (cal.get(cal.DAY_OF_WEEK) == cal.SUNDAY) {
            week = week - 1;
        }
        
        cal.add(Calendar.DATE, (week - 1) * 7 + (cal.getFirstDayOfWeek() - cal.get(Calendar.DAY_OF_WEEK)));
        
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, Locale.FRANCE);
        
        return formatter.format(cal.getTime());
        
    }
    
    /**
     * <p>
     * 지정된 플래그에 따라 연도 , 월 , 일자를 연산한다.
     * 
     * @param field
     *            연산 필드
     * @param amount
     *            더할 수
     * @param date
     *            연산 대상 날짜
     * @return 연산된 날짜
     * @see java.util.Calendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * String date = DateUtil.getOpDate(java.util.Calendar.DATE , 1, "20080101")
     *      </pre>
     */
    public static String getOpDate(int field, int amount, String date) {
        
        GregorianCalendar calDate = getGregorianCalendar(date);
        
        if (field == Calendar.YEAR) {
            calDate.add(GregorianCalendar.YEAR, amount);
        } else if (field == Calendar.MONTH) {
            calDate.add(GregorianCalendar.MONTH, amount);
        } else {
            calDate.add(GregorianCalendar.DATE, amount);
        }
        
        return getYyyymmdd(calDate);
        
    }
    
    /**
     * <p>
     * 입력된 일자를 더한 주를 구하여 return한다
     * 
     * @param yyyymmdd
     *            년도별
     * @param addDay
     *            추가일
     * @return 연산된 주
     * @see java.util.Calendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * int date = DateUtil.getWeek(DateUtil.getCurrentYyyymmdd() , 0)
     *      </pre>
     */
    public static int getWeek(String yyyymmdd, int addDay) {
        Calendar cal = Calendar.getInstance(Locale.FRANCE);
        int new_yy = Integer.parseInt(yyyymmdd.substring(0, 4));
        int new_mm = Integer.parseInt(yyyymmdd.substring(4, 6));
        int new_dd = Integer.parseInt(yyyymmdd.substring(6, 8));
        
        cal.set(new_yy, new_mm - 1, new_dd);
        cal.add(Calendar.DATE, addDay);
        
        int week = cal.get(Calendar.DAY_OF_WEEK);
        return week;
    }
    
    /**
     * <p>
     * 입력된 년월의 마지막 일수를 return 한다.
     * 
     * @param year
     * @param month
     * @return 마지막 일수
     * @see java.util.Calendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * int date = DateUtil.getLastDayOfMon(2008 , 1)
     *      </pre>
     */
    public static int getLastDayOfMon(int year, int month) {
        
        Calendar cal = Calendar.getInstance();
        cal.set(year, month, 1);
        return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        
    }// :
    
    /**
     * <p>
     * 입력된 년월의 마지막 일수를 return한다
     * 
     * @param year
     * @param month
     * @return 마지막 일수
     *         <p>
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * int date = DateUtil.getLastDayOfMon("2008")
     *         </pre>
     */
    public static int getLastDayOfMon(String yyyymm) {
        
        Calendar cal = Calendar.getInstance();
        int yyyy = Integer.parseInt(yyyymm.substring(0, 4));
        int mm = Integer.parseInt(yyyymm.substring(4)) - 1;
        
        cal.set(yyyy, mm, 1);
        return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    }
    
    /**
     * <p>
     * 입력된 날자가 올바른지 확인합니다.
     * 
     * @param yyyymmdd
     * @return boolean
     *         <p>
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * boolean b = DateUtil.isCorrect("20080101")
     *         </pre>
     */
    public static boolean isCorrect(String yyyymmdd) {
        boolean flag = false;
        if (yyyymmdd.length() < 8)
            return false;
        try {
            int yyyy = Integer.parseInt(yyyymmdd.substring(0, 4));
            int mm = Integer.parseInt(yyyymmdd.substring(4, 6));
            int dd = Integer.parseInt(yyyymmdd.substring(6));
            flag = isCorrect(yyyy, mm, dd);
        } catch (Exception ex) {
            return false;
        }
        return flag;
    }
    
    /**
     * <p>
     * 입력된 날자가 올바른 날자인지 확인합니다.
     * 
     * @param yyyy
     * @param mm
     * @param dd
     * @return boolean
     *         <p>
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * boolean b = DateUtil.isCorrect(2008,1,1)
     *         </pre>
     */
    public static boolean isCorrect(int yyyy, int mm, int dd) {
        if (yyyy < 0 || mm < 0 || dd < 0)
            return false;
        if (mm > 12 || dd > 31)
            return false;
        
        String year = "" + yyyy;
        String month = "00" + mm;
        String year_str = year + month.substring(month.length() - 2);
        int endday = getLastDayOfMon(year_str);
        
        if (dd > endday)
            return false;
        
        return true;
        
    }// :
    
    /**
     * <p>
     * 현재 일자를 입력된 type의 날짜로 반환합니다.
     * 
     * @param type
     * @return String
     * @see java.text.DateFormat
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * String date = DateUtil.getThisDay("yyyymmddhhmmss")
     *      </pre>
     */
    public static String getThisDay(String type) {
        Date date = new Date();
        SimpleDateFormat sdf = null;
        
        try {
            if (type.toLowerCase().equals("yyyymmdd")) {
                sdf = new SimpleDateFormat("yyyyMMdd");
                return sdf.format(date);
            }
            if (type.toLowerCase().equals("yyyymmddhh")) {
                sdf = new SimpleDateFormat("yyyyMMddHH");
                return sdf.format(date);
            }
            if (type.toLowerCase().equals("yyyymmddhhmm")) {
                sdf = new SimpleDateFormat("yyyyMMddHHmm");
                return sdf.format(date);
            }
            if (type.toLowerCase().equals("yyyymmddhhmmss")) {
                sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                return sdf.format(date);
            }
            if (type.toLowerCase().equals("yyyymmddhhmmssms")) {
                sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
                return sdf.format(date);
            } else {
                sdf = new SimpleDateFormat(type);
                return sdf.format(date);
            }
        } catch (Exception e) {
            return "[ ERROR ]: parameter must be 'YYYYMMDD', 'YYYYMMDDHH', 'YYYYMMDDHHSS'or 'YYYYMMDDHHSSMS'";
        }
    }
    
    /**
     * <p>
     * 입력된 일자를 '9999년 99월 99일' 형태로 변환하여 반환한다.
     * 
     * @param yyyymmdd
     * @return String
     *         <p>
     * 
     *         <pre>
     *  
     *  - 사용 예 
     * String date = DateUtil.changeDateFormat("20080101")
     *         </pre>
     */
    public static String changeDateFormat(String yyyymmdd) {
        String rtnDate = null;
        
        String yyyy = yyyymmdd.substring(0, 4);
        String mm = yyyymmdd.substring(4, 6);
        String dd = yyyymmdd.substring(6, 8);
        rtnDate = yyyy + " 년 " + mm + " 월 " + dd + " 일";
        
        return rtnDate;
    }
    
    /**
     * <p>
     * 두 날짜간의 날짜수를 반환(윤년을 감안함)
     * 
     * @param startDate
     *            시작 날짜
     * @param endDate
     *            끝 날짜
     * @return 날수
     * @see java.util.GregorianCalendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * long date = DateUtil.getDifferDays("20080101","20080202")
     *      </pre>
     */
    public static long getDifferDays(String startDate, String endDate) {
        
        GregorianCalendar StartDate = getGregorianCalendar(startDate);
        GregorianCalendar EndDate = getGregorianCalendar(endDate);
        long difer = (EndDate.getTime().getTime() - StartDate.getTime().getTime()) / 86400000;
        return difer;
    }
    
    /**
     * <p>
     * 현재의 요일을 구한다.
     * 
     * @param
     * @return 요일
     * @see java.util.Calendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * int day = DateUtil.getDayOfWeek() 
     *  SUNDAY    = 1 
     *  MONDAY    = 2 
     *  TUESDAY  = 3 
     *  WEDNESDAY = 4 
     *  THURSDAY  = 5 
     *  FRIDAY    = 6
     *      </pre>
     */
    public static int getDayOfWeek() {
        Calendar rightNow = Calendar.getInstance();
        int day_of_week = rightNow.get(Calendar.DAY_OF_WEEK);
        return day_of_week;
    }
    
    /**
     * <p>
     * 현재주가 올해 전체의 몇째주에 해당되는지 계산한다.
     * 
     * @param
     * @return 요일
     * @see java.util.Calendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * int day = DateUtil.getWeekOfYear()
     *      </pre>
     */
    public static int getWeekOfYear() {
        Locale LOCALE_COUNTRY = Locale.KOREA;
        Calendar rightNow = Calendar.getInstance(LOCALE_COUNTRY);
        int week_of_year = rightNow.get(Calendar.WEEK_OF_YEAR);
        return week_of_year;
    }
    
    /**
     * <p>
     * 현재주가 현재월에 몇째주에 해당되는지 계산한다.
     * 
     * @param
     * @return 요일
     * @see java.util.Calendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * int day = DateUtil.getWeekOfMonth()
     *      </pre>
     */
    public static int getWeekOfMonth() {
        Locale LOCALE_COUNTRY = Locale.KOREA;
        Calendar rightNow = Calendar.getInstance(LOCALE_COUNTRY);
        int week_of_month = rightNow.get(Calendar.WEEK_OF_MONTH);
        return week_of_month;
    }
    
    /**
     * <p>
     * 해당 p_date날짜에 Calendar 객체를 반환함.
     * 
     * @param p_date
     * @return Calendar
     * @see java.util.Calendar
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * Calendar cal = DateUtil.getCalendarInstance(DateUtil.getCurrentYyyymmdd())
     *      </pre>
     */
    public static Calendar getCalendarInstance(String p_date) {
        // Locale LOCALE_COUNTRY = Locale.KOREA;
        Locale LOCALE_COUNTRY = Locale.FRANCE;
        Calendar retCal = Calendar.getInstance(LOCALE_COUNTRY);
        
        if (p_date != null && p_date.length() == 8) {
            int year = Integer.parseInt(p_date.substring(0, 4));
            int month = Integer.parseInt(p_date.substring(4, 6)) - 1;
            int date = Integer.parseInt(p_date.substring(6));
            
            retCal.set(year, month, date);
        }
        return retCal;
    }
    
    /**
     * 현재 날짜에서 일을 더한 만큼의 날자를 돌려준다
     * 
     * @param amount
     * @return
     */
    public static String getAddDate(int amount) {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.add(Calendar.DATE, amount);
        StringBuffer buf = new StringBuffer();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if (month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if (day.length() == 1)
            day = "0" + day;
        buf.append(month);
        buf.append(day);
        return buf.toString();
    }
    
    /**
     * 현재 날짜에서 일을 더한 만큼의 날자를 돌려준다
     * 
     * @param amount
     * @return
     */
    public static String getAddMonth(int amount) {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.add(Calendar.MONTH, amount);
        StringBuffer buf = new StringBuffer();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if (month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if (day.length() == 1)
            day = "0" + day;
        buf.append(month);
        buf.append(day);
        return buf.toString();
    }
    
    /**
     * 특정날짜에서 달을 더한 날짜를 돌려준다
     * 
     * @param date
     * @param amount
     * @return
     */
    public static String getAddDate(String date, int amount) throws ParseException {
        SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
        Date dt = fommatter.parse(date);
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.DATE, amount);
        StringBuffer buf = new StringBuffer();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if (month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if (day.length() == 1)
            day = "0" + day;
        buf.append(month);
        buf.append(day);
        return buf.toString();
    }
    
    /**
     * 특정날짜에서 달을 더한 날짜를 돌려준다
     * 
     * @param date
     * @param amount
     * @return
     */
    public static String getAddMonth(String date, int amount) throws ParseException {
        SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
        Date dt = fommatter.parse(date);
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.MONTH, amount);
        StringBuffer buf = new StringBuffer();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if (month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if (day.length() == 1)
            day = "0" + day;
        buf.append(month);
        buf.append(day);
        return buf.toString();
    }
    
    /**
     * 
     * @param date
     * @param amount
     * @param delimiter
     * @return
     * @throws ParseException
     */
    public static String getAddMonth(String date, int amount, String delimiter) throws ParseException {
        SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
        Date dt = fommatter.parse(date.replaceAll(delimiter, ""));
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.MONTH, amount);
        StringBuffer buf = new StringBuffer();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if (month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if (day.length() == 1)
            day = "0" + day;
        buf.append(delimiter + month);
        buf.append(delimiter + day);
        return buf.toString();
    }
    
    /**
     * 특정날짜에서 달을 더한 날짜를 돌려준다
     * 
     * @param date
     * @param amount
     * @return
     */
    public static String getAddDate(String date, int amount, String delimiter) throws ParseException {
        SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
        Date dt = fommatter.parse(date.replaceAll(delimiter, ""));
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.DATE, amount);
        StringBuffer buf = new StringBuffer();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if (month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if (day.length() == 1)
            day = "0" + day;
        buf.append(delimiter + month);
        buf.append(delimiter + day);
        return buf.toString();
    }
    
    /**
     * 현재날자의 다음달을 되돌려준다
     * 
     * @return 20110113
     */
    public static String getNowNextMonth() {
        SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, 1);
        return fommatter.format(calendar.getTime());
    }
    
    /**
     * 현재 날자의 밀리세컨드 날자를 가지고 온다
     * 
     * @return
     */
    public static long getCurTimeMili() {
        Calendar cal = Calendar.getInstance();
        long toDate = cal.getTimeInMillis();
        return toDate;
    }
    
    /**
     * 날자를 받아 밀리세컨드 값을 가지고 온다
     * 
     * @param dateStr
     * @return
     */
    public static long getTimeMili(String datetime) {
        java.sql.Timestamp timestamp = null;
        long value = 0;
        try {
            if (datetime != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA);
                Date date = sdf.parse(datetime);
                value = date.getTime();
            } else {
                return 0;
            }
        } catch (java.text.ParseException pe) {
        }
        
        return value;
    }
    
    /**
     * 스트링 timestamp 값을 받아 원하는 포맷 형태로 변화하여 리턴한다
     * 
     * @param date
     * @return
     */
    public static String getConvertDate(String date, String type) {
        return getConvertDate(date, type, "-");
    }
    
    /**
     * 
     * @param date
     * @param type
     * @param delimeter
     * @return
     */
    public static String getConvertDate(String date, String type, String delimeter) {
        if (date == null) {
            return "";
        }
        date = date.trim();
        
        if (date.length() == 6 && type.equals("5")) {
            return date.substring(0, 4) + delimeter + date.substring(4, 6);
        }
        
        if (type.equals("1")) {
            return date.substring(0, 4) + delimeter + date.substring(4, 6) + delimeter + date.substring(6, 8);
        } else if (type.equals("2")) {
            return date.substring(0, 4) + delimeter + date.substring(4, 6) + delimeter + date.substring(6, 8) + " " + date.substring(8, 10);
        } else if (type.equals("3")) {
            return date.substring(0, 4) + delimeter + date.substring(4, 6) + delimeter + date.substring(6, 8) + " " + date.substring(8, 10) + ":" + date.substring(10, 12);
        } else if (type.equals("4")) {
            return date.substring(0, 4) + delimeter + date.substring(4, 6) + delimeter + date.substring(6, 8) + " " + date.substring(8, 10) + ":" + date.substring(10, 12) + ":" + date.substring(12, 14);
        } else {
            return date;
        }
    }
    
    /**
     * 시작일부터 종료일까지 사이의 월을 배열에 담아 리턴 ( 시작일과 종료일을 모두 포함한다 )
     * 
     * @param fromDate
     *            yyyyMMdd 형식의 시작일
     * @param toDate
     *            yyyyMMdd 형식의 종료일
     * @return yyyyMMdd 형식의 날짜가 담긴 배열
     */
    public static String[] getDiffMonth(String fromDate, String toDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(sdf.parse(fromDate));
        } catch (Exception e) {
        }
        int count = getDiffDayCount(fromDate, toDate);
        // 시작일부터
        cal.add(Calendar.MONTH, -1);
        // 데이터 저장
        List list = new ArrayList();
        for (int i = 0; i <= count; i++) {
            cal.add(Calendar.MONTH, 1);
            list.add(sdf.format(cal.getTime()));
        }
        String[] result = new String[list.size()];
        list.toArray(result);
        
        return result;
    }
    
    /**
     * 두날짜 사이의 일수를 리턴
     * 
     * @param fromDate
     *            yyyyMMdd 형식의 시작일
     * @param toDate
     *            yyyyMMdd 형식의 종료일
     * @return 두날짜 사이의 일수
     */
    public static int getDiffDayCount(String fromDate, String toDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        try {
            return (int) ((sdf.parse(toDate).getTime() - sdf.parse(fromDate).getTime()) / 1000 / 60 / 60 / 24);
        } catch (Exception e) {
            return 0;
        }
    }
    
    /**
     * String 을 Date 타입으로 변환(quartz용)
     * 
     * @param str_date
     * @return Date
     */
    public static Date StringToDate(String str_date) {
        // String startDateStr = "2015-06-10 16:32:00.0";
        Date date = null;
        try {
            date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(str_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        return date;
    }
    
    /**
     * 현재시간을 백분의 1초까지 반환해준다.
     * 
     * @return
     */
    public static String currentTimeMillDate() {
        long time = System.currentTimeMillis();
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String strDT = dayTime.format(new Date(time));
        return strDT;
    }
    
    /**
     * 시간 문자열을 날짜만을 가져와서 웹상에서 표시할 형식으로 변환<BR>
     * 길이가 맞지 않거나 null일때 원래 스트링을 리턴함<BR>
     * strFormat = "/" Ex) "20011014123020" --> "2001/10/14"
     * 
     * @param strDate
     *            시간 문자열
     * @return 날짜만의 문자열
     */
    public static String getFormattedDate(String strDate, String strFormat) {
        
        if (strDate == null || strDate.equals("") || !(strDate.length() == 8 || strDate.length() == 14)) {
            return strDate;
        }
        
        // 날짜를 가져온다.
        StringBuffer sbufferFormattedDay = new StringBuffer("");
        
        sbufferFormattedDay.append(strDate.substring(0, 4));
        sbufferFormattedDay.append(strFormat);
        
        String strMonth = strDate.substring(4, 6);
        sbufferFormattedDay.append(strMonth);
        sbufferFormattedDay.append(strFormat);
        
        String strDay = strDate.substring(6, 8);
        sbufferFormattedDay.append(strDay);
        
        return sbufferFormattedDay.toString();
    }
    
    /**
     * 주어진 000000시간을 strFormat delimiter를 적용하여 추출.
     * 
     * @param strTime
     * @param strFormat
     * @return
     */
    public static String getFormattedTime(String strTime, String strFormat) {
        StringBuffer str = new StringBuffer();
        
        if (strTime != null && !strTime.equals("")) {
            str.append(strTime.substring(0, 2));
            str.append(strFormat);
            str.append(strTime.substring(2, 4));
            str.append(strFormat);
            str.append(strTime.substring(4, 6));
        }
        
        return str.toString();
    }
    
    /**
     * <p>
     * 현재 날짜와 시각을 yyyyMMddhhmmss 형태로 변환 후 return.
     * 
     * @param null
     * @return yyyyMMddhhmmss
     * @see java.util.Date
     * @see java.util.Locale
     *      <p>
     * 
     *      <pre>
     *  
     *  - 사용 예 
     * String date = DateUtil.getCurrentDateTime()
     *      </pre>
     */
    public static String getCurrentDateTimeFormat(String format) {
        Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        SimpleDateFormat formatter = new SimpleDateFormat(format, currentLocale);
        return formatter.format(today);
    }
    
    /**
     * <p>
     * Type을 기준으로 시작일과 종료일의 비교값을 리턴
     * </p>
     * 
     * @author P081305
     * @param type
     *            : 날짜 계산 Type<br />
     *            - Y: 년<br />
     *            - M: 월<br />
     *            - D: 일
     * @param startDate
     *            : 시작일
     * @param endDate
     *            : 종료일
     * @param dateFormat
     *            : 시작일과 종료일의 날짜 형태( ex. yyyy-MM-dd )
     * @return 계산 결과<br />
     *         - 음수: 시작 > 종료<br />
     *         - 0: 시작 = 종료<br />
     *         - 양수: 시작 < 종료
     */
    public static Long getDifferenceDate(String type, String startDate, String endDate, String dateFormat) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormat);
        
        Calendar startCal = Calendar.getInstance();
        startCal.setTime(simpleDateFormat.parse(startDate));
        
        Calendar endCal = Calendar.getInstance();
        endCal.setTime(simpleDateFormat.parse(endDate));
        
        if (type != null && !"".equals(type)) {
            if ("Y".equals(type.toUpperCase())) {
                return (long) (((endCal.get(Calendar.YEAR) - startCal.get(Calendar.YEAR)) * 12 + (endCal.get(Calendar.MONTH) - startCal.get(Calendar.MONTH))) / 12);
            } else if ("M".equals(type.toUpperCase())) {
                return (long) (endCal.get(Calendar.YEAR) - startCal.get(Calendar.YEAR)) * 12 + (endCal.get(Calendar.MONTH) - startCal.get(Calendar.MONTH));
            } else if ("D".equals(type.toUpperCase())) {
                return (long) (endCal.getTimeInMillis() - startCal.getTimeInMillis()) / 1000 / 60 / 60 / 24;
            } else {
                return 0l;
            }
        }
        
        return 0l;
    }
    
    /**
     * 
     * @return
     * @throws ParseException
     */
    public static String currentDateStr() throws ParseException {
        String[] weekDay = { "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT" };
        String retStr = "";
        Calendar date = Calendar.getInstance();
        retStr = date.get(Calendar.YEAR) + "년 " + (date.get(Calendar.MONTH) + 1) + "월 " + (date.get(Calendar.DATE)) + "일 " + weekDay[date.get(Calendar.DAY_OF_WEEK) - 1];
        
        return retStr;
    }
}