package kr.or.wabis.framework.util;

import java.text.DecimalFormat;

public class NumberUtil {
    
    public NumberUtil() {
        
    }
    
    /**
     * 숫자를 금액표시법으로 변경 ( 1234560 -> 1,234,560)
     * 
     * @param iAmount
     *            int 숫자
     * @return 천단위로 콤마가 들어간 문자열
     */
    public static String putCommaByThousand(int iAmount) {
        DecimalFormat dfAmount = new DecimalFormat("###,###,###,###,###,###,###.####");
        return dfAmount.format(iAmount);
    }
    
    /**
     * 숫자를 금액표시법으로 변경 ( 1234560 -> 1,234,560)
     * 
     * @param lAmount
     *            long 숫자
     * @return 천단위로 콤마가 들어간 문자열
     */
    public static String putCommaByThousand(long lAmount) {
        DecimalFormat dfAmount = new DecimalFormat("###,###,###,###,###,###,###.####");
        return dfAmount.format(lAmount);
    }
    
    /**
     * 숫자를 금액표시법으로 변경 ( 1234560 -> 1,234,560)
     * 
     * @param lAmount
     *            double 숫자
     * @return 천단위로 콤마가 들어간 문자열
     */
    public static String putCommaByThousand(double dAmount) {
        DecimalFormat dfAmount = new DecimalFormat("###,###,###,###,###,###,###.####");
        return dfAmount.format(dAmount);
    }
    
    /**
     * 숫자를 금액표시법으로 변경 ( 1234560 -> 1,234,560)<BR>
     * 숫자의 문자열이 null이면 공백문자열("")을 리턴
     * 
     * @param strAmount
     *            String 숫자의 문자열
     * @return 천단위로 콤마가 들어간 문자열
     */
    public static String putCommaByThousand(String strAmount) throws NumberFormatException {
        if (strAmount == null || strAmount.equals("")) {
            return "";
        }
        
        if (strAmount.indexOf(".") != -1) {
            double dAmount = Double.parseDouble(strAmount);
            return putCommaByThousand(dAmount);
        } else {
            long lAmount = Long.parseLong(strAmount);
            return putCommaByThousand(lAmount);
        }
    }
    
}
