package kr.or.wabis.framework.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.StringUtils;
import org.springframework.web.util.HtmlUtils;

public class StringUtil extends org.apache.commons.lang.StringUtils {
    
    public static final int LEFT = 1;
    public static final int CENTER = 2;
    public static final int RIGHT = 3;
    public static final String DefaultSep = ",";
    
    private StringUtil() {
    }
    
    /**
     * 인자값으로 전달받은 두 문자열이 같은지 비교해서 같으면 true 틀리면 false 를 리턴한다
     * 
     * @param str1
     * @param str2
     * @return
     */
    public static boolean equals(String str1, String str2) {
        return (null == str1 ? null == str2 : str1.compareTo(str2) == 0);
    }
    
    /**
     * 전달받은 문자열이 null 인지 아닌지 체크한다
     * 
     * @param str
     * @return
     */
    public static boolean isEmpty(String str) {
        return (str == null || str.trim().length() == 0);
    }
    
    /**
     * 전달받은 인자값이 문자열인지 아닌지 체크한다
     * 
     * @param str
     * @return
     */
    public static boolean isWord(String str) {
        if (null == str)
            return false;
        int len = str.length();
        for (int i = 0; i < len; i++) {
            if (!Character.isLetter(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }
    
    /**
     * 주어진 문자열이 AlphaNumeric인지 확인
     *
     * @param str
     * @return
     */
    public static boolean isAlphanumeric(String str) {
        if (null == str)
            return false;
        int len = str.length();
        for (int i = 0; i < len; i++) {
            if (!Character.isLetterOrDigit(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }
    
    /**
     * 주어진 문자열이 숫자인지 확인
     *
     * @param str
     * @return
     */
    public static boolean isNumeric(String str) {
        return str.matches("[-+]?\\d*\\.?\\d+");
        /*
         * if (null == str) return false; int len = str.length(); for (int i = 0; i < len; i++) { if (!Character.isDigit(str.charAt(i))) { return false; } } return true;
         */
    }
    
    /**
     * 문자열 앞뒤 공백을 없앰
     *
     * @param str
     * @return
     */
    public static String trim(String str) {
        return trim(str, null);
    }
    
    /**
     * <pre>
     * 인자로 받은 String이 null일 경우 &quot;&quot;로 리턴한다.
     * &#064;param src null값일 가능성이 있는 String 값.
     * &#064;return 만약 String이 null 값일 경우 &quot;&quot;로 바꾼 String 값.
     * </pre>
     */
    public static long zeroConvertLong(String src) {
        
        if (src == null || src.equals("null") || "".equals(src) || " ".equals(src)) {
            return 0;
        } else {
            return Long.parseLong(src.trim());
        }
    }
    
    /**
     * 문자열 앞뒤공백을 없앰, 만약 null이면 def를 돌려줌.
     *
     * @param str
     * @param def
     * @return
     */
    public static String trim(String str, String def) {
        return (null == str ? def : str.trim());
    }
    
    /**
     * 문자열 앞 공백을 없앰
     *
     * @param str
     * @return
     */
    public static String ltrim(String str) {
        return stripStart(str, null);
    }
    
    /**
     * 문자열뒤 공백을 없앰
     *
     * @param str
     * @return
     */
    public static String rtrim(String str) {
        return stripEnd(str, null);
    }
    
    /**
     * leftPad, rightPad에 의해 실행되는 메소드
     * 
     * @param str
     *            문자열
     * @param size사이즈
     * @param padStr
     *            채울 문자열
     * @param where
     *            true : left, false : right
     * @return 변환된 문자열
     */
    private static String strPad(String str, int size, String padStr, boolean where) {
        if (str == null)
            return "";
        if (str.length() >= size)
            return str;
        
        String res = null;
        StringBuffer sb = new StringBuffer();
        String tmpStr = null;
        int tmpSize = size - str.length();
        
        for (int i = 0; i < size; i = i + padStr.length()) {
            sb.append(padStr);
        }
        tmpStr = sb.toString().substring(0, tmpSize);
        
        if (where)
            res = tmpStr.concat(str);
        else
            res = str.concat(tmpStr);
        return res;
    }
    
    /**
     * 문자열과 자릿수 넘겨받아 문자열 왼쪽에서부터 자릿수(byte) 만큼 리턴
     * 
     * @param str
     * @param len
     * @return
     */
    public static String left(String str, int len) {
        if (str == null || len < 0)
            return "";
        if (str.length() < len)
            return str;
        else
            return str.substring(0, len);
    }
    
    /**
     * 문자열과 자릿수 넘겨받아 문자열 오른쪽에서부터 자릿수(byte) 만큼 리턴
     * 
     * @param str
     * @param len
     * @return
     */
    public static String right(String str, int len) {
        if (str == null || len < 0)
            return "";
        if (str.length() < len)
            return str;
        else
            return str.substring(str.length() - len);
    }
    
    /**
     * 문자열과 자릿수 인자 2개를 넘겨받아 pos 에서부터 len 까지의 문자열 리턴
     * 
     * @param str
     * @param pos
     * @param len
     * @return
     */
    public static String mid(String str, int pos, int len) {
        if (str == null || len < 0 || pos > str.length())
            return "";
        if (pos < 0)
            pos = 0;
        if (str.length() < pos + len)
            return str.substring(pos);
        else
            return str.substring(pos, pos + len);
    }
    
    /**
     * 문자열의 왼쪽에 해당 사이즈 만큼 문자로 채운다.
     * 
     * @param str
     *            문자열
     * @param size
     *            사이즈
     * @param padChar
     *            채울 문자
     * @return 변환된 문자열
     */
    public static String lPad(String str, int size, char padChar) {
        return lPad(str, size, String.valueOf(padChar));
    }
    
    /**
     * 문자열의 왼쪽에 해당 사이즈 만큼 문자열로 채운다.
     * 
     * @param str
     *            문자열
     * @param size
     *            사이즈
     * @param padStr
     *            채울 문자열
     * @return 변환된 문자열
     */
    public static String lPad(String str, int size, String padStr) {
        return strPad(str, size, padStr, true);
    }
    
    /**
     * 문자열의 오른쪽에 해당 사이즈 만큼 문자로 채운다.
     * 
     * @param str
     *            문자열
     * @param size
     *            사이즈
     * @param padChar
     *            채울 문자
     * @return 변환된 문자열
     */
    public static String rPad(String str, int size, char padChar) {
        return rPad(str, size, String.valueOf(padChar));
    }
    
    /**
     * 문자열의 오른쪽에 해당 사이즈 만큼 문자열로 채운다.
     * 
     * @param str
     *            문자열
     * @param size
     *            사이즈
     * @param padStr
     *            채울 문자열
     * @return 변환된 문자열
     */
    public static String rPad(String str, int size, String padStr) {
        return strPad(str, size, padStr, false);
    }
    
    /**
     * 문자열 ,시작자릿수 , 끝날자리수를 받아 문자열을 자른후 리턴한다
     * 
     * @param input
     * @param beginIndex
     * @param endIndex
     * @return
     */
    public static String substring(String input, int beginIndex, int endIndex) {
        if (input == null)
            input = "";
        if (beginIndex >= input.length())
            return "";
        if (beginIndex < 0)
            beginIndex = 0;
        if (endIndex < 0 || endIndex > input.length())
            endIndex = input.length();
        if (endIndex < beginIndex)
            return "";
        return input.substring(beginIndex, endIndex);
    }
    
    /**
     *
     * 입력된 스트링을 지정된 길이만큼 Byte단위로 남기고 나머지를 잘라낸다.! <br>
     * 
     * @param inputString
     *            잘라내고자 하는 원본 문자열
     * @param sz
     *            자르고 남을 문자열의 byte단위 길이.
     * @return 원본 문자열에서 자르고 남은 sz만큼의 문자열
     * @throws UnsupportedEncodingException
     */
    
    public static String getByteCut(String inputString, int maxBytes) throws UnsupportedEncodingException {
        String outputString = "";
        final Charset CHARSET = Charset.forName("UTF-8");
        if (inputString == null)
            return "";
        final byte[] bytes = inputString.getBytes(CHARSET);
        int len = 0;
        if (bytes.length > maxBytes)
            len = maxBytes;
        else
            len = bytes.length;
        
        final CharsetDecoder decoder = CHARSET.newDecoder();
        decoder.onMalformedInput(CodingErrorAction.IGNORE);
        decoder.reset();
        CharBuffer decoded;
        try {
            decoded = decoder.decode(ByteBuffer.wrap(bytes, 0, len));
            outputString = decoded.toString();
        } catch (CharacterCodingException e) {
            e.printStackTrace();
        }
        
        return outputString;
    }
    
    public static String getStringCut(String str, int sz) throws UnsupportedEncodingException {
        str = ObjectUtil.nvl(str, "");
        
        if (str.equals("") || str.getBytes().length <= sz) {
            return str;
        }
        
        String a = str;
        int i = 0;
        String imsi = "";
        String rlt = "";
        imsi = a.substring(0, 1);
        while (i < sz) {
            byte[] ar = imsi.getBytes();
            
            i += ar.length;
            
            rlt += imsi;
            a = a.substring(1);
            if (a.length() == 1) {
                imsi = a;
            } else if (a.length() > 1) {
                imsi = a.substring(0, 1);
            }
        }
        
        return rlt + "...";
    }
    
    /**
     * 문자열을 대체한다
     * 
     * @param source
     * @param ch
     * @param replace
     * @return
     */
    public static String replace(String source, char ch, String replace) {
        return replace(source, ch, replace, -1);
    }
    
    /**
     * 문자열 대체함수
     * 
     * @param source
     * @param ch
     * @param replace
     * @param max
     * @return
     */
    public static String replace(String source, char ch, String replace, int max) {
        return replace(source, ch + "", replace, max);
    }
    
    /**
     * 문자열 대체함수
     * 
     * @param source
     * @param ch
     * @param replace
     * @param max
     * @return
     */
    public static String replace(String source, String original, String replace) {
        return replace(source, original, replace, -1);
    }
    
    /**
     * 문자열 대체함수
     * 
     * @param source
     * @param ch
     * @param replace
     * @param max
     * @return
     */
    public static String replace(String source, String original, String replace, int max) {
        if (null == source)
            return null;
        int nextPos = 0; //
        int currentPos = 0; //
        int len = original.length();
        StringBuffer result = new StringBuffer(source.length());
        while ((nextPos = source.indexOf(original, currentPos)) != -1) {
            result.append(source.substring(currentPos, nextPos));
            result.append(replace);
            currentPos = nextPos + len;
            if (--max == 0) {
                break;
            }
        }
        if (currentPos < source.length()) {
            result.append(source.substring(currentPos));
        }
        return result.toString();
    }
    
    /**
     * 주어진 문자열(pattern)을 n번 반복하여 돌려줌
     *
     * @param pattern
     * @param n
     * @return
     */
    public static String repeat(String pattern, int n) {
        if (null == pattern)
            return null;
        StringBuffer sb = new StringBuffer(n * pattern.length());
        repeat(sb, pattern, n);
        return sb.toString();
    }
    
    /**
     * 문자열 반복함수
     * 
     * @param sb
     * @param pattern
     * @param n
     */
    private static void repeat(StringBuffer sb, String pattern, int n) {
        if (null == pattern)
            return;
        for (int i = 0; i < n; i++) {
            sb.append(pattern);
        }
    }
    
    /**
     * 문자열과 문자열 배역을 받아 문자열 배열안에 문자열이 존재하면 0 존재하지 않으면 -1 을 리턴
     * 
     * @param str
     * @param strs
     * @return
     */
    public static int indexOf(String str, String[] strs) {
        if (null == str)
            return -1;
        int len = strs.length;
        int tmp = 0;
        int ret = Integer.MAX_VALUE;
        
        for (int i = 0; i < len; i++) {
            tmp = str.indexOf(strs[i]);
            if (tmp == -1) {
                continue;
            }
            if (tmp < ret) {
                ret = tmp;
                break;
            }
        }
        return (ret == Integer.MAX_VALUE ? -1 : ret);
    }
    
    /**
     * 문자열과 문자열 배역을 받아 문자열 배열안에 문자열이 존재하면 0 존재하지 않으면 -1 을 리턴
     * 
     * @param str
     * @param strs
     * @return
     */
    public static int lastIndexOf(String str, String[] strs) {
        if (null == str)
            return -1;
        int len = strs.length;
        int ret = -1;
        int tmp = 0;
        for (int i = 0; i < len; i++) {
            tmp = str.lastIndexOf(strs[i]);
            if (tmp > ret) {
                ret = tmp;
            }
        }
        return ret;
    }
    
    /**
     * 문자열 인자값을 전달받아 마지막 "." 이루 문자열을 리턴한다
     * 
     * @param packageName
     * @return
     */
    public static String getLastValue(String packageName) {
        return packageName.substring(packageName.lastIndexOf('.') + 1);
    }
    
    /**
     * deli로 구분된 문자열을 List<String>로 돌려줌
     *
     * @param source
     * @param deli
     * @return
     */
    public static List<String> tokenizer(String source, String deli) {
        if (source == null)
            return null;
        if (deli == null)
            deli = " ";
        int idx = source.indexOf(deli);
        List<String> list = new ArrayList<String>();
        while (idx > -1) {
            String sub = source.substring(0, idx);
            source = source.substring(idx + 1);
            idx = source.indexOf(deli);
            list.add(sub);
        }
        list.add(source);
        return list;
        // String[] result = (String[]) list.toArray(new String[list.size()]);
        // return result;
    }
    
    /**
     * HTML 문자열을 escape한다.
     *
     * @param s
     * @return
     */
    public static String htmlEscape(String s) {
        if (s == null) {
            s = "";
        } else {
            // s = s.replaceAll("&", "&amp;");
            // s = s.replaceAll("<", "&lt;");
            // s = s.replaceAll(">", "&gt;");
            // s = s.replaceAll("\"", "&quot;");
            // s = s.replaceAll("'", "&#39;");
            s = HtmlUtils.htmlEscape(s);
        }
        return s;
    }
    
    /**
     * Turn special characters into escaped characters conforming to JavaScript. Handles complete character set defined in HTML 4.01 recommendation.
     *
     * @param input
     *            the input string
     * @return the escaped string
     */
    public static String javaScriptEscape(String input) {
        if (input == null) {
            return input;
        }
        
        StringBuffer filtered = new StringBuffer(input.length());
        char prevChar = '\u0000';
        char c;
        for (int i = 0; i < input.length(); i++) {
            c = input.charAt(i);
            if (c == '"') {
                filtered.append("\\\"");
            } else if (c == '\'') {
                filtered.append("\\'");
            } else if (c == '\\') {
                filtered.append("\\\\");
            } else if (c == '/') {
                filtered.append("\\/");
            } else if (c == '\t') {
                filtered.append("\\t");
            } else if (c == '\n') {
                if (prevChar != '\r') {
                    filtered.append("\\n");
                }
            } else if (c == '\r') {
                filtered.append("\\n");
            } else if (c == '\f') {
                filtered.append("\\f");
            } else {
                filtered.append(c);
            }
            prevChar = c;
            
        }
        return filtered.toString();
    }
    
    /**
     * 모든 Object의 String 값을 가져온다.
     *
     * <pre>
     *  null =&gt; null;
     *  String =&gt; string.trim();
     *  Collection =&gt; delimited by &quot;;&quot; string
     *  Object -&gt; obj.toString();
     * </pre>
     *
     * @author : 김상준
     * @param obj
     * @return
     */
    public static String getSafeString(Object obj) {
        if (obj == null) {
            return null;
        } else if (obj instanceof String) {
            return String.valueOf(obj).trim();
            // return ((String) obj).v;
        } else if (obj instanceof Collections) {
            return StringUtils.collectionToDelimitedString((Collection) obj, ";");
            // return ((String) obj).v;
        } else {
            return obj.toString();
        }
        
    }
    
    /**
     * TRUE나 T, Y, y의 경우 true로
     *
     * @param v
     * @return
     */
    public static boolean toBoolean(Object v) {
        if (v instanceof String) {
            if ("t".equalsIgnoreCase((String) v) || "true".equalsIgnoreCase((String) v) || "y".equalsIgnoreCase((String) v) || "yes".equalsIgnoreCase((String) v)) {
                return true;
            } else {
                return false;
            }
        } else if (v instanceof Boolean) {
            return ((Boolean) v).booleanValue();
        } else {
            return false;
        }
        
    }
    
    /**
     * Capitalize a <code>String</code>, changing the first letter to upper case as per {@link Character#toUpperCase(char)}. No other letters are lower.
     *
     * @param str
     *            the String to capitalize, may be <code>null</code>
     * @return the capitalized String, <code>null</code> if null
     */
    public static String capitalize(String str) {
        if (str == null || str.length() == 0) {
            return str;
        }
        return changeFirstCharacterCase(str.toLowerCase(), true);
    }
    
    /**
     * Uncapitalize a <code>String</code>, changing the first letter to lower case as per {@link Character#toLowerCase(char)}. No other letters are changed.
     *
     * @param str
     *            the String to uncapitalize, may be <code>null</code>
     * @return the uncapitalized String, <code>null</code> if null
     */
    public static String uncapitalize(String str) {
        return changeFirstCharacterCase(str, false);
    }
    
    private static String changeFirstCharacterCase(String str, boolean capitalize) {
        if (str == null || str.length() == 0) {
            return str;
        }
        StringBuffer buf = new StringBuffer(str.length());
        if (capitalize) {
            buf.append(Character.toUpperCase(str.charAt(0)));
        } else {
            buf.append(Character.toLowerCase(str.charAt(0)));
        }
        buf.append(str.substring(1));
        return buf.toString();
    }
    
    /**
     * 문자열을 대문자로 , null일 경우 def값을 리턴
     *
     * @param str
     * @param def
     * @return
     */
    public static String toUpperCase(String str, String def) {
        if (str == null) {
            return def;
        } else {
            return str.toUpperCase();
        }
    }
    
    /**
     * 문자열을 대문자로 , null일 경우 ""값을 리턴
     *
     * @param str
     * @param def
     * @return
     */
    public static String toUpperCase(String str) {
        return toUpperCase(str, "");
    }
    
    /**
     * 문자열을 소문자로 , null일 경우 def값을 리턴
     *
     * @param str
     * @param def
     * @return
     */
    public static String toLowerCase(String str, String def) {
        if (str == null) {
            return def;
        } else {
            return str.toLowerCase();
        }
    }
    
    /**
     * 문자열을 소문자로 , null일 경우 ""값을 리턴
     *
     * @param str
     * @param def
     * @return
     */
    public static String toLowerCase(String str) {
        return toLowerCase(str, "");
    }
    
    /**
     * 비어 있지 않은경우 앞뒤에 문자 삽입
     *
     * @param pre
     * @param dst
     * @param after
     * @return
     */
    public static String capsule(String pre, Object dst, String after) {
        if (ObjectUtil.isEmpty(dst))
            return "";
        else
            return pre + dst + after;
    }
    
    /**
     * multiplier번 반복한 input_str을 반환합니다. multiplier는 0 이상이여야 합니다. multiplier를 0으로 설정하면, 빈 문자열을 반환합니다.
     */
    public static String strRepeat(String input, int multiplier) {
        StringBuffer sBuf = new StringBuffer();
        try {
            for (int i = 0; i < multiplier; i++) {
                sBuf.append(input);
            }
        } catch (Exception e) {
            return null;
        }
        return sBuf.toString();
    }
    
    public static String toCamelCase(String columnName) {
        return convert2CamelCase(columnName);
    }
    
    /**
     * underscore ('_') 가 포함되어 있는 문자열을 Camel Case ( 낙타등 표기법 - 단어의 변경시에 대문자로 시작하는 형태. 시작은 소문자) 로 변환해주는 utility 메서드 ('_' 가 나타나지 않고 첫문자가 대문자인 경우도 변환 처리 함.)
     * 
     * @param underScore
     *            - '_' 가 포함된 변수명
     * @return Camel 표기법 변수명
     */
    public static String convert2CamelCase(String underScore) {
        
        // '_' 가 나타나지 않으면 이미 camel case 로 가정함.
        // 단 첫째문자가 대문자이면 camel case 변환 (전체를 소문자로) 처리가
        // 필요하다고 가정함. --> 아래 로직을 수행하면 바뀜
        if (underScore.indexOf('_') < 0
        /* && Character.isLowerCase(underScore.charAt(0) ) */) {
            return underScore;
        }
        StringBuilder result = new StringBuilder();
        boolean nextUpper = false;
        int len = underScore.length();
        
        for (int i = 0; i < len; i++) {
            char currentChar = underScore.charAt(i);
            if (currentChar == '_') {
                nextUpper = true;
            } else {
                if (nextUpper) {
                    result.append(Character.toUpperCase(currentChar));
                    nextUpper = false;
                } else {
                    result.append(Character.toLowerCase(currentChar));
                }
            }
        }
        return result.toString();
    }
    
    /**
     * get count of line seperator in string
     * 
     * @param str
     * @return
     */
    public static int countLines(String str) {
        if (str != null) {
            String[] lines = str.split("\r\n|\r|\n");
            return lines.length;
        } else {
            return 0;
        }
    }
    
    /**
     * null인 경우 ""를 return
     * 
     * @param value
     * @return
     */
    public static String nvl(String value) {
        return nvl(value, "");
    }
    
    /**
     *
     * @param value
     * @return
     */
    public static int nvl(int value) {
        return nvl(value, 0);
    }
    
    /**
     * value가 null인 경우 defalult값을 return
     * 
     * @param value
     * @param defaultValue
     * @return
     */
    public static String nvl(String value, String defaultValue) {
        if (value == null || value.equals("") || value.equals("null"))
            return defaultValue;
        else
            return value;
    }
    
    /**
     * value가 null인 경우 defalult값을 return
     * 
     * @param value
     * @param defaultValue
     * @return
     */
    public static int nvl(String value, int defaultValue) {
        if (value == null || value.equals("") || value.equals("null"))
            return defaultValue;
        else
            return Integer.parseInt(value);
    }
    
    /**
     * null인 경우 ""를 return
     * 
     * @param value
     * @return
     */
    public static String nvl(Object value) {
        return nvl(value, "");
    }
    
    /**
     * value가 null인 경우 defalult값을 return
     * 
     * @param value
     * @param defaultValue
     * @return
     */
    public static String nvl(Object value, String defaultValue) {
        if (value == null || value.toString().equals("null")) {
            return defaultValue;
        } else {
            if (value.toString().equals(""))
                return defaultValue;
            else
                return value.toString();
        }
        
    }
    
    /**
     * value가 null인 경우 defalult값을 return
     * 
     * @param value
     * @param defaultValue
     * @return
     */
    public static int nvl(Object value, int defaultValue) {
        if (value == null) {
            return defaultValue;
        } else {
            if (value.toString().equals(""))
                return defaultValue;
            else
                return Integer.parseInt(value.toString());
        }
    }
    
    /**
     *
     * @param str
     * @param setstr
     * @return String
     * @throws Exception
     */
    public static String isNull(final String str, final String setstr) {
        return isNull(str, setstr, null);
    }
    
    /**
     * String 이 null 일경우 바꿀 대치할 문자열.
     * 
     * @param str
     * @param setstr
     *            String str 검사할 String
     * @param setstr2
     *            String setstr str 이 null 일 경우 리턴할 문자열
     * @return 리턴 String
     */
    public static String isNull(final String str, final String setstr, final String setstr2) {
        String result = null;
        
        if (str == null) {
            result = setstr;
        } else {
            if (setstr2 == null) {
                result = str;
            } else {
                result = setstr2;
            }
        }
        return result;
    }
    
    /**
     * 구분자로 구분된 문자열과 문자열중에 존재여부를 확인하기위한 문자값을 넘겨 받아 해당 문자열이 존재 하는지를 체크 하는 함수
     * 
     * @param source
     * @param sepe_str
     * @param compare
     * @return
     */
    public static boolean splitExistYn(String source, String sepe_str, String compare) {
        boolean result1 = false;
        String result[] = split(source, sepe_str);
        if ("".equals(compare))
            return false;
        
        for (int index = 0; index < result.length; index++) {
            if (nvl(result[index]).trim().equalsIgnoreCase(compare.trim())) {
                result1 = true;
                break;
            }
        }
        return result1;
    }
    
    /**
     * 구분자로 구분된 문자열과 문자열중에 존재여부를 확인하기위한 문자값을 넘겨 받아 해당 문자열이 존재 하는지를 체크 하는 함수
     * 
     * @param source
     * @param sepe_str
     * @param compare
     * @return
     */
    public static boolean splitExistYn(String source[], String compare) {
        boolean result1 = false;
        String result[] = source;
        if ("".equals(compare))
            return false;
        
        for (int index = 0; index < result.length; index++) {
            if (nvl(result[index]).trim().equalsIgnoreCase(compare.trim())) {
                result1 = true;
                break;
            }
        }
        return result1;
    }
    
    /**
     *
     * @param str
     * @param sepe_str
     * @return
     */
    public static String[] split(String str, String sepe_str) {
        int index = 0;
        String[] result = new String[search(str, sepe_str) + 1];
        String strCheck = new String(str);
        while (strCheck.length() != 0) {
            int begin = strCheck.indexOf(sepe_str);
            if (begin == -1) {
                result[index] = strCheck;
                break;
            } else {
                int end = begin + sepe_str.length();
                if (true) {
                    result[index++] = strCheck.substring(0, begin);
                }
                strCheck = strCheck.substring(end);
                if (strCheck.length() == 0 && true) {
                    result[index] = strCheck;
                    break;
                }
            }
        }
        return result;
    }
    
    public static String[] split(String str) {
        
        return split(str, DefaultSep);
    }
    
    /**
     *
     * @param strTarget
     * @param strSearch
     * @return
     */
    public static int search(String strTarget, String strSearch) {
        int result = 0;
        String strCheck = new String(strTarget);
        for (int i = 0; i < strTarget.length();) {
            int loc = strCheck.indexOf(strSearch);
            if (loc == -1) {
                break;
            } else {
                result++;
                i = loc + strSearch.length();
                strCheck = strCheck.substring(i);
            }
        }
        return result;
    }
    
    /**
     * 문자형배열값을 받아 구분자로 구분된 문자열을 리턴한다
     * 
     * @param str
     * @param sepe_str
     * @return
     */
    public static String unSplit(String[] str) {
        return unSplit(str, DefaultSep);
    }
    
    /**
     * 문자형배열값을 받아 구분자로 구분된 문자열을 리턴한다
     * 
     * @param str
     * @param sepe_str
     * @return
     */
    public static String unSplit(String[] str, String sepe_str) {
        int index = 0;
        String result = "";
        if (str != null)
            for (int i = 0; i < str.length; i++) {
                if (i != str.length - 1) {
                    result = result + str[i] + sepe_str;
                } else {
                    result = result + str[i];
                }
            }
        return result;
    }
    
    /**
     * 구분자로 구분된 문자열을 받아 문자 리스트로 넘겨준다
     * 
     * @param str
     * @param sepe_str
     * @return
     */
    public static List<String> unSplitList(String[] str) {
        
        String result = "";
        List<String> list = new ArrayList<String>();
        
        for (int i = 0; i < str.length; i++) {
            result = str[i];
            list.add(result);
        }
        
        return list;
    }
    
    /**
     * 구분자로 구분된 문자열을 받아 리스트에 담아 넘겨준다
     * 
     * @param str
     * @return
     */
    public static List<String> unSplitList(String str, String sep) {
        return unSplitList(split(str, sep));
    }
    
    /**
     * ","로 구분된 문자열을 받아 리스트에 담아 넘겨준다
     * 
     * @param str
     * @return
     */
    public static List<String> unSplitList(String str) {
        return unSplitList(split(str, DefaultSep));
    }
    
    /**
     * 랜덤 문자열을 리넡한다(패스워드 초기화)
     * 
     * @param length
     * @return
     */
    public static String getRandomString(int length) {
        
        StringBuffer buffer = new StringBuffer();
        Random random = new Random();
        
        String chars[] = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,!,@,#,$,%,^,&,(,),*".split(",");
        
        for (int i = 0; i < length; i++) {
            buffer.append(chars[random.nextInt(chars.length)]);
        }
        return buffer.toString();
    }
    
    /**
     * 문자열을 숫자로 바꿔준다.
     * 
     * @param val
     * @return
     */
    public static double getValueNum(String val) {
        if (val == null) {
            return 0;
        }
        
        String retValue = val.equals("") ? "0" : val;
        
        retValue = retValue.replaceAll(",", "");
        
        return Double.parseDouble(retValue);
    }
    
    /**
     * 숫자문자열에 콤마를 넣어준다. 12345678.1 --> 12,345,678.10 <BR>
     */
    public static String amountFormater(String in) {
        Double amount = Double.parseDouble(in);
        NumberFormat nf = NumberFormat.getInstance();
        return nf.format(amount);
    }
    
    /**
     * URL Encoding
     * 
     * @param url
     * @return
     */
    public static String getUrlEncode(String url) {
        if (url != null) {
            try {
                url = url.replaceAll(" ", "*20");
                url = URLEncoder.encode(url, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            url = url.replace('%', '*');
        }
        return url;
    }
    
    /**
     * URL Decoding
     * 
     * @param url
     * @return
     */
    public static String getUrlDecode(String url) {
        if (url != null) {
            url = url.replace('*', '%');
            try {
                url = URLDecoder.decode(url, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return url;
    }
    
    /**
     * 문자열을 특정 크기로 만듬, 만약 남는 공간이 있으면 왼쪽에서부터 특정문자(cSpace)를 채움<BR>
     * null이 입력되더라도 크기 만큼 특정문자를 채움
     * 
     * @param strText
     *            String 문자열
     * @param cSpace
     *            char 빈공란에 채울 특정문자
     * @param iTotalSize
     *            int 특정 크기
     * @return 변경된 문자열
     */
    public static String fixTextSize(String strText, char cSpace, int iTotalSize) {
        
        if (strText == null) {
            strText = "";
        }
        
        if (strText.length() < iTotalSize) {
            
            // 문자열의 크기가 특정크기보다 작을 때는 특정문자로 채움
            char[] carraySpace = new char[iTotalSize - strText.length()];
            Arrays.fill(carraySpace, cSpace);
            String strSpace = new String(carraySpace);
            
            return strSpace + strText;
        } else {
            // 문자열의 크기가 특정크기보다 클때는 앞쪽의 문자열 잘라냄
            return strText.substring(strText.length() - iTotalSize, strText.length());
            
        }
    }
    
    /**
     * HttpServletRequest 에서 특정 컬럼(strColumnName)의 데이터를 읽어와 String 형으로 리턴. 데이터값이 NULL일 경우 공백("")값을 리턴
     * 
     * @param request
     *            HttpServletRequest
     * @param strParameterName
     *            읽어올 컬럼명
     * @return 컬럼의 데이터
     */
    public static String getString(final HttpServletRequest request, final String strParameterName) {
        return trim(request.getParameter(strParameterName), "");
    }
    
    /**
     * HttpServletRequest 에서 특정 컬럼(strColumnName)의 데이터를 읽어와 String 형으로 리턴. 데이터값이 NULL일 경우 공백("")값을 리턴
     * 
     * @param request
     *            HttpServletRequest
     * @param strParameterName
     *            String 읽어올 컬럼명
     * @param sDefaultValue
     * @return 컬럼의 데이터
     */
    public static String getString(final HttpServletRequest request, final String strParameterName, final String sDefaultValue) {
        
        return trim(request.getParameter(strParameterName), sDefaultValue);
    }
    
    /**
     * HttpServletRequest 에서 특정 컬럼(strColumnName)의 데이터를 읽어와 String 형으로 리턴. 데이터값이 NULL일 경우 디폴트값을 리턴
     * 
     * @param request
     *            HttpServletRequest
     * @param strParameterName
     *            String 읽어올 컬럼명
     * @return 컬럼의 데이터
     */
    public static String[] getStringArr(final HttpServletRequest request, final String strParameterName) {
        String[] arrTemp = request.getParameterValues(strParameterName);
        
        if (arrTemp != null) {
            for (int i = 0; i < arrTemp.length; i++) {
                if (arrTemp[i] != null) {
                    arrTemp[i] = trim(arrTemp[i], "");
                } else {
                    arrTemp[i] = "";
                }
            }
        }
        
        return arrTemp;
    }
    
    /**
     * toDB() 메소드를 이용하여 DB에 저장되어진 데이타를 WEB상에 input box나 textarea에 뿌릴때 전환
     * 
     * @param str
     * @return String str
     */
    public static String toWEB_BOX(String str) {
        try {
            str = str.replace("<br>", "\r\n");
            str = str.replace("&amp;", "&&");
            str = str.replace("&lt;", "<");
            str = str.replace("&gt;", ">");
            str = str.replace("&quot;", "\\\"");
            str = str.replace("&#039;", "\\\'");
            str = str.replace("&#092;", "\\\\");
        } catch (Exception e) {
        }
        return str;
    }
    
    /**
     * html tag 를 제거 한다
     * 
     * @param html
     * @return
     * @throws Exception
     */
    public static String removeTag(String html) {
        if (html == null && "".equals(html))
            return "";
        return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
    }
    
    /**
     * 긴문자열을 받아 일정 자릿수가 넘어가면 라인 브레이크를 넣는다
     * 
     * @param input
     * @param maxLineLength
     * @return
     */
    public static String addLinebreaks(String input, int maxCharInLine) {
        StringTokenizer tok = new StringTokenizer(input, "");
        StringBuilder output = new StringBuilder(input.length());
        int lineLen = 0;
        while (tok.hasMoreTokens()) {
            String word = tok.nextToken();
            
            while (word.length() > maxCharInLine) {
                output.append(word.substring(0, maxCharInLine - lineLen) + "\n");
                word = word.substring(maxCharInLine - lineLen);
                lineLen = 0;
            }
            
            if (lineLen + word.length() > maxCharInLine) {
                output.append("\n");
                lineLen = 0;
            }
            output.append(word + " ");
            
            lineLen += word.length() + 1;
        }
        return output.toString();
        
    }
    
    /**
     * 고정 길이 문자열을 돌려준다. 문자열이 작을 시 나머지 공간은 공백문자로 채워집
     * 
     * @return
     */
    public static String getStrFixLength(String str, int length) {
        char[] strArr = new char[length];
        int len = 0;
        if (str.length() > length)
            len = length;
        else
            len = str.length();
        System.arraycopy(str.toCharArray(), 0, strArr, 0, len);
        return new String(strArr);
    }
    
    /**
     * 문자열 바이트 길이 체크 한글 > 2Byte, 영어&숫자 1Byte
     *
     * @author P081305
     * @param
     */
    public static Boolean checkByteLength(String sourceStr, Integer maxLength) {
        Integer byteLen = 0;
        char ch;
        Boolean flag = true;
        
        if (maxLength < 0) {
            return flag;
        }
        
        for (Integer idx = 0; idx < sourceStr.length(); idx++) {
            ch = sourceStr.charAt(idx);
            Integer len = (ch >> 11) > 11 ? 3 : (ch >> 7) > 7 ? 2 : 1;
            
            byteLen += len;
            if (byteLen > maxLength) {
                flag = false;
            }
        }
        
        return flag;
    }
    
    /**
     * 문자열 중 kye 로 전달받은 값을가지고 온다
     *
     * @author P081305
     * @param
     */
    public static String parseKeyValue(String sourceStr, String key) {
        if ("".equals(nvl(sourceStr)) || "".equals(nvl(sourceStr)))
            return "";
        
        String rv = "";
        KeyValuePairParser kv = new KeyValuePairParser(sourceStr);
        rv = kv.find(key);
        
        return rv;
    }
    
    /**
     * 문자열 중 kye 로 전달받은 값들의 리스트를 가지고 온다
     *
     *
     * @author P081305
     * @param
     */
    public static List<String> parseKeyValueList(String sourceStr, String key) {
        if ("".equals(nvl(sourceStr)) || "".equals(nvl(sourceStr)))
            return null;
        
        KeyValuePairParser kv = new KeyValuePairParser(sourceStr);
        Iterable<String> values = kv.findAll(key);
        List<String> list = new ArrayList<String>();
        for (String item1 : values) {
            list.add(item1);
        }
        return list;
    }
    
    public static String convertTextAreaToStringCRLF(String sOrgString) {
        StringBuffer sbRet = new StringBuffer();
        
        for (int i = 0; i < sOrgString.length(); i++) {
            switch (sOrgString.charAt(i)) {
                case '\n':
                    sbRet.append("<br>");
                    if (i + 1 < sOrgString.length() && sOrgString.charAt(i + 1) == '\r')
                        i++;
                    break;
                /*
                 * case '\r': sbRet.append("<br>"); if (i + 1 < sOrgString.length() && sOrgString.charAt(i+1) == '\n') i++; break; case '\t': sbRet.append('\\').append('t'); break; case '\\': sbRet.append('\\').append('\\'); break; case '<': sbRet.append("&lt;"); break; case '>':
                 * sbRet.append("&gt;"); break; case '"': sbRet.append("&quot;"); break;
                 */
                default:
                    if ((sOrgString.charAt(i) & 0x80) > 0) {
                        if (i + 1 >= sOrgString.length())
                            break;
                        sbRet.append(sOrgString.charAt(i));
                        i++;
                    }
                    
                    sbRet.append(sOrgString.charAt(i));
            }
        }
        return sbRet.toString();
        
    }
    
    /**
     * 파라미터를 XSS 처리해준다.
     * 
     * @param values
     * @return
     */
    public static String[] getXssValues(String[] values) {
        
        if (values == null) {
            return null;
        }
        
        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = cleanXSS(values[i]);
        }
        
        return encodedValues;
    }
    
    private static String cleanXSS(String value) {
        value = value.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
        // value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "&
        // #41;");
        value = value.replaceAll("'", "& #39;");
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        //value = value.replaceAll("script", "");
        //value = value.replaceAll("iframe", "");
        return value;
    }
    
    /**
     * 파라미터를 XSS Script만 처리해준다.
     * 
     * @param values
     * @return
     */
    public static String[] getXssScript(String[] values) {
        
        if (values == null) {
            return null;
        }
        
        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = cleanXssScript(values[i]);
        }
        
        return encodedValues;
    }
    
    private static String cleanXssScript(String value) {
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        //value = value.replaceAll("script", "");
        //value = value.replaceAll("iframe", "");
        return value;
    }
    
    public static boolean equalsAny(String src, String... compare) {
        if (src == null || compare == null) {
            return false;
        }
        
        boolean eq = false;
        for (String str : compare) {
            if (src.equals(str)) {
                eq = true;
                break;
            }
        }
        
        return eq;
    }
    
    /**
     * 카멜 표기법(첫글자 대문자, 나머지 소문자)으로 수정해서 반환한다.
     * 
     * @param value
     *            String - 수정할 문자
     * @return String - 수정된 문자
     */
    public static String toCamel(String value) {
        return capitalize(lowerCase(value));
    }
    
    /**
     * 구분자(devide)로 분할하여 각각 첫글자를 대문자로 생성
     * 
     * @param originalStr
     *            String - 수정할 문자
     * @param devide
     *            String - 구분자
     * @return String - 수정된 문자
     */
    public static String toCamel(String value, String devide) {
        String s = "";
        for (String str : split(value, devide)) {
            s += toCamel(str);
        }
        return s;
    }
    
    /**
     * Camel 형식을 대문자 앞에 '_' 넣음 (DB 컬럼 또는 Class 사용) msg) StringUtil - > String_Util 변환
     * 
     * @param originalStr
     *            String - 수정할 문자
     * @return String - 수정된 문자
     */
    public static String camelToUnderscore(String value) {
        return uncapitalize(value).replaceAll("([A-Z])", "_$1").replaceAll("__", "_");
    }
    
    /**
     * 배열의 첫번째에 값을 삽입한다.
     * 
     * @param valueList
     *            String[] - 원본 배열
     * @param value
     *            - 삽입할 문자
     * @return String[] - 수정된 배열
     */
    public static String[] firstAdd(String[] valueList, String value) {
        String[] result = new String[valueList.length + 1];
        result[0] = value;
        for (int index = 1; index < valueList.length + 1; index++) {
            result[index] = valueList[index - 1];
        }
        
        return result;
    }
    
    /**
     * 배열의 마지막에 값을 추가한다.
     * 
     * @param valueList
     *            String[] - 원본 배열
     * @param value
     *            - 추가할 문자
     * @return String[] - 수정된 배열
     * @return
     */
    public static String[] lastAdd(String[] valueList, String value) {
        String[] result = new String[valueList.length + 1];
        for (int index = 0; index < valueList.length; index++) {
            result[index] = valueList[index];
        }
        result[valueList.length] = value;
        return result;
    }
    
    /**
     * 배열에 찾는 값이 있는지 여부를 체크한다.
     * 
     * @param valueList
     *            String[] - 원본 배열
     * @param value
     *            String - 체크할 문자
     * @return boolean - 체크 여부
     */
    public static boolean isNotExist(String[] valueList, String value) {
        if (value == null)
            return true;
        
        for (int index = 0; index < valueList.length; index++) {
            if (value.equals(valueList[index]))
                return false;
        }
        return true;
    }
    
    /**
     * NULL 이거나 "NULL" 일 경우 "" 을 리턴한다.
     * 
     * @param str
     *            String 체크할 문자
     * @return String - 수정된 문자
     */
    public static String nullToString(String str) {
        return nullToString(str, "");
    }
    
    /**
     * NULL 이거나 "NULL" 일 경우 "" 을 리턴한다.
     * 
     * @param str
     *            String - 체크할 문자
     * @param str1
     *            String - 대체될 문자
     * @return String 수정된 문자
     */
    public static String nullToString(String str, String str1) {
        return isNotEmpty(str) ? str : (isNotEmpty(str1) ? str1 : "");
    }
    
    /**
     * 대소문자구분없이 String 'Y', 'N', 'TURE', 'FALSE' 를 Boolean 으로 변경.
     * 
     * @param str
     *            String - 체크할 문자
     * @return - boolean - 체크 결과
     */
    public static boolean stringYnToBoolean(String str) {
        return "Y".equalsIgnoreCase(str) || "true".equalsIgnoreCase(str);
    }
    
    /**
     * Boolean True, False 를 'Y', 'N' 으로 변경
     */
    public static String booleanToStringYn(boolean bool) {
        return bool ? "Y" : "N";
    }
    
    /**
     * UTF-8 Byte 길이로 String 을 자름.
     * 
     * @param str
     * @param byteLength
     * @return
     */
    public static String substringBytes(String str, int start, int end) {
        if (str == null)
            return "";
        
        String tmp = str;
        int chrIdx = 0, byteLength = 0;
        char chr;
        
        if (tmp.getBytes().length > end - 1) {
            
            while (byteLength + 1 < end - 1) {
                
                chr = tmp.charAt(chrIdx);
                byteLength++;
                chrIdx++;
                
                if (chr > 127)
                    byteLength = byteLength + 2; // 2-byte character..
            }
            
            tmp = tmp.substring(start, chrIdx);
        }
        
        return tmp;
        
    }
    
}