package kr.or.wabis.framework.web.tld;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;

import javax.servlet.jsp.JspException;

public class UserFunctionNumber extends ExtendedTagSupport {
    
    public void doTag() throws JspException, IOException {
        getJspContext().getOut().print("Tag Library " + this.getClass().getSimpleName());
    }
    
    public static String formatNumberZero(Object obj) {
        if (obj == null) {
            return "0";
        }
        
        return formatNumber(obj, 3);
    }
    
    public static String formatNumber(Object obj) {
        if (obj == null) {
            return "";
        }
        
        return formatNumber(obj, 3);
    }
    
    public static String formatNumber(Object obj, int p) {
        
        if (obj == null)
            return "0";
        
        if (obj instanceof String) {
            // return changeComma( getCommaNumber( stringToNumber(
            // obj.toString() ), p ) );
            return getCommaNumber(stringToNumber(obj.toString()), p);
        } else if (obj instanceof BigDecimal) {
            // return changeComma( getCommaNumber( ((BigDecimal)
            // obj).doubleValue() , p ) );
            return getCommaNumber(((BigDecimal) obj).doubleValue(), p);
        } else if (obj instanceof Number) {
            // return changeComma( getCommaNumber( ((Number) obj).doubleValue()
            // , p ) );
            return getCommaNumber(((Number) obj).doubleValue(), p);
        }
        
        return null;
    }
    
    /**
     * number format using round != 숫자에 콤마를 삽입하고 소수점을 지정한 자리수까지 반올림한다. =!
     * 
     * @param d
     *            Number != 변환할 숫자 =!
     * @param рMaximum
     *            Fraction Digits != 소수점 자리수 =!
     * @return String
     * 
     *         <p>
     * 
     *         <pre>
     *         - msg : fmt:commaNumber( 123456789.2222 , 2 ) - result : 123,456,789.22
     */
    public static String getCommaNumber(double d, int p) {
        NumberFormat nf = NumberFormat.getNumberInstance(new Locale("en"));
        nf.setMaximumFractionDigits(p);
        return nf.format(d);
    }
    
    /**
     * currency format != 숫자에 콤마를 삽입하고 앞에 국가의 통화를 표시한다. =!
     * 
     * @param d
     *            Number != d 변환할 숫자 =!
     * @param рMaximum
     *            Fraction Digits != p 소수점 자리수 =!
     * @return
     */
    public static String getCurrencyNumber(double d, int p) {
        return getCurrencyNumber(d, p, new Locale("en"));
    }
    
    /**
     * В число вставьте запятую и вначале укажите валюту страны != 숫자에 콤마를 삽입하고 앞에 국가의 통화를 표시한다. =!
     * 
     * @param d
     *            Number != d 변환할 숫자 =!
     * @param рMaximum
     *            Fraction Digits != p 소수점 자리수 =!
     * @return
     */
    public static String getCurrencyNumber(double d, int p, Locale locale) {
        NumberFormat nf = NumberFormat.getCurrencyInstance(locale);
        nf.setMaximumFractionDigits(p);
        return nf.format(d);
    }
    
    /**
     * percent format != 숫자의 뒤에 %를 붙인다. =!
     * 
     * @param d
     *            Number != d 변환할 숫자 =!
     * @param рMaximum
     *            Fraction Digits != p 소수점 자리수 =!
     * @return
     */
    public static String getPercentNumber(double d, int p) {
        NumberFormat nf = NumberFormat.getPercentInstance(new Locale("en"));
        nf.setMinimumFractionDigits(p);
        return nf.format(d);
    }
    
    /**
     * ceil != 입력받은 실수를 지정한 소수점 자리수로 올림한다. =!
     *
     * @param d
     *            Number != d 변환할 숫자 =!
     * @param рMaximum
     *            Fraction Digits != p 소수점 자리수 =!
     * @return
     */
    public static double ceil(double d, int p) {
        
        double temp = decToDigit(p);
        
        d = d * temp;
        d = Math.ceil(d);
        d = d / temp;
        
        return d;
    }
    
    /**
     * round != 입력받은 실수를 지정한 소수점 자리수로 반올림한다. =!
     * 
     * @param d
     *            Number != d 변환할 숫자 =!
     * @param рMaximum
     *            Fraction Digits != p 소수점 자리수 =!
     * @return
     */
    public static double round(double d, int p) {
        
        double temp = decToDigit(p);
        
        d = d * temp;
        d = Math.round(d);
        d = d / temp;
        return d;
    }
    
    /**
     * floor != 입력받은 실수를 지정한 소수점 자리수로 내림한다.=!
     * 
     * @param d
     *            Number != d 변환할 숫자 =!
     * @param рMaximum
     *            Fraction Digits != p 소수점 자리수 =!
     * @return
     */
    public static double floor(double d, int p) {
        
        double temp = decToDigit(p);
        
        d = d * temp;
        d = Math.floor(d);
        d = d / temp;
        
        return d;
    }
    
    private static double decToDigit(int p) {
        double temp = 1;
        if (p >= 1) {
            for (int i = 0; i < p; i++) {
                temp = temp * 10;
            }
        } else if (p < 1) {
            for (int i = p; i < 0; i++) {
                temp = temp / 10;
            }
        }
        return temp;
    }
    
    /**
     * parse double * != 숫자와 '.'가 아닌 문자가 있으면 문자를 제외한 후 double형으로 리턴한다. =!
     * 
     * @param str
     *            number string != 변경할 문자 =!
     * @return double
     */
    public static double stringToNumber(String str) {
        StringBuffer sb = new StringBuffer();
        String number = "1234567890.";
        
        for (int i = 0; i < str.length(); i++) {
            if (number.indexOf(str.charAt(i)) > -1) {
                sb.append(str.charAt(i));
            }
        }
        
        return Double.parseDouble(sb.toString());
    }
    
    public static int doubleToInt(double num) {
        return (int) num;
    }
    
    public static double intToDouble(int num) {
        return (double) num;
    }
    
}
