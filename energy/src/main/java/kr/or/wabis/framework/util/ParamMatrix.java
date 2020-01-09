package kr.or.wabis.framework.util;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.wabis.framework.contants.DateFormatConstant;

/**
 * != HTML form 에서 중복된 name 의 input 값들은 특정 클래스의 List로 만든다 =!
 * 
 * @since
 * @author
 * @version
 * 
 */
public class ParamMatrix {
    
    private static boolean isValidParamType(Method m) {
        @SuppressWarnings("rawtypes")
        Class[] clazzs = m.getParameterTypes();
        if (clazzs.length == 1) {
            
            @SuppressWarnings("rawtypes")
            Class clazz = clazzs[0];
            if (clazz.equals(Double.TYPE) || clazz.equals(Float.TYPE) || clazz.equals(Integer.TYPE) || clazz.equals(Long.TYPE) || clazz.equals(Short.TYPE) || clazz.equals(Double.class) || clazz.equals(Float.class) || clazz.equals(Integer.class) || clazz.equals(Long.class) || clazz.equals(Short.class) || clazz.equals(String.class) || clazz.equals(BigDecimal.class) || clazz.equals(MultipartFile.class) || clazz.equals(Date.class) || clazz.equals(BigDecimal.class) || clazz.equals(BigInteger.class)) {
                return true;
            }
        }
        return false;
    }
    
    private static String getParamKey(Method m) {
        
        String r = null;
        if (isValidParamType(m) && m.getName().startsWith("set") && m.getName().length() > 3) {
            r = m.getName().substring(3, 4).toLowerCase();
            if (m.getName().length() > 4)
                r += m.getName().substring(4);
            return r;
        }
        
        return null;
    }
    
    static class MethodToValues {
        Method m;
        String[] values;
        
        MethodToValues(Method m, String[] values) {
            this.m = m;
            this.values = values;
        }
        
        @SuppressWarnings("rawtypes")
        Class getArgType() {
            assert m.getParameterTypes().length > 0;
            return m.getParameterTypes()[0];
        }
        
        Integer getInteger(int index) {
            return Integer.parseInt(StringUtils.isEmpty(values[index]) ? "0" : values[index]);
        }
        
        Long getLong(int index) {
            return Long.parseLong(StringUtils.isEmpty(values[index]) ? "0" : values[index]);
        }
        
        Double getDouble(int index) {
            return Double.parseDouble(StringUtils.isEmpty(values[index]) ? "0" : values[index]);
        }
        
        BigDecimal getBigDecimal(int index) {
            return new BigDecimal((StringUtils.isEmpty(values[index]) ? "0" : values[index]));
        }
        
        BigInteger getBigInteger(int index) {
            return new BigInteger((StringUtils.isEmpty(values[index]) ? "0" : values[index]));
        }
        
        String getString(int index) {
            return values[index];
        }
        
        Date getDate(int index) {
            try {
                SimpleDateFormat srcSdf = new SimpleDateFormat(DateFormatConstant.UI_DATETIME_FORMAT);
                return srcSdf.parse(values[index]);
            } catch (Exception e) {
                return null;
            }
        }
        
        Object getValue(int index) {
            Class clazz = getArgType();
            if (clazz.equals(Double.TYPE) || clazz.equals(Float.TYPE) || clazz.equals(Double.class) || clazz.equals(Float.class))
                return getDouble(index);
            else if (clazz.equals(Integer.TYPE) || clazz.equals(Short.TYPE) || clazz.equals(Integer.class) || clazz.equals(Short.class))
                return getInteger(index);
            else if (clazz.equals(Long.TYPE) || clazz.equals(Long.class))
                return getLong(index);
            else if (clazz.equals(BigDecimal.class))
                return getBigDecimal(index);
            else if (clazz.equals(BigInteger.class))
                return getBigInteger(index);
            else if (clazz.equals(Date.class))
                return getDate(index);
            else
                return getString(index);
        }
    }
    
    private static <T> MethodToValues[] getMethodToValues(Class<T> t, final Map<String, String[]> params, String prefix) {
        ArrayList<MethodToValues> r = new ArrayList<MethodToValues>();
        
        for (Method m : t.getMethods()) {
            
            String key = getParamKey(m);
            
            if (key != null) {
                if (prefix != null && !prefix.isEmpty())
                    key = prefix + key;
                
                String[] values = params.get(key);
                
                if (values != null && values.length > 0)
                    r.add(new MethodToValues(m, values));
            }
        }
        
        return r.toArray(new MethodToValues[r.size()]);
    }
    
    private static int getMaxValuesLength(MethodToValues[] values) {
        int r = 0;
        for (MethodToValues e : values) {
            if (r < e.values.length)
                r = e.values.length;
        }
        return r;
    }
    
    public static <T> List<T> getObjectList(Class<T> t, final Map<String, String[]> params, String prefix) throws Exception {
        
        LinkedList<T> r = new LinkedList<T>();
        MethodToValues[] values = getMethodToValues(t, params, prefix);
        int maxValuesLength = getMaxValuesLength(values);
        
        for (int i = 0; i < maxValuesLength; i++) {
            T o = t.newInstance();
            for (MethodToValues v : values) {
                if (v.values.length > i) {
                    try {
                        v.m.invoke(o, v.getValue(i));
                    } catch (Exception cause) {
                        cause.printStackTrace();
                    }
                }
            }
            r.add(o);
        }
        
        return r;
    }
    
    public static <T> List<T> getObjectList(Class<T> t, final Map<String, String[]> params) throws Exception {
        return getObjectList(t, params, null);
    }
    
    public static class FooVo {
        private Integer id = null;
        private String name = null;
        private Double money = null;
        
        public Integer getId() {
            return id;
        }
        
        public void setId(Integer id) {
            this.id = id;
        }
        
        public String getName() {
            return name;
        }
        
        public void setName(String name) {
            this.name = name;
        }
        
        public Double getMoney() {
            return money;
        }
        
        public void setMoney(Double money) {
            this.money = money;
        }
        
        @Override
        public String toString() {
            return "id[" + (id == null ? "(null)" : id) + "]" + ", name[" + (name == null ? "(null)" : name) + "]" + ", money[" + (money == null ? "(null)" : money) + "]";
        }
    }
    
    public static void main(String[] args) throws Exception {
        HashMap<String, String[]> params = new HashMap<String, String[]>();
        
        String[] ids = { "1", "2", "3" };
        String[] names = { "name 1", "name 2" };
        String[] moneys = { "1.1", "2.2", "3.3" };
        params.put("id", ids);
        params.put("name", names);
        params.put("money", moneys);
        
        String[] ids2 = { "10", "20", "30" };
        String[] names2 = { "name 10", "name 20", "name 30" };
        String[] moneys2 = { "10.1", "20.2", "30.3" };
        params.put("prefix.id", ids2);
        params.put("prefix.name", names2);
        params.put("prefix.money", moneys2);
        
        List<FooVo> foos = ParamMatrix.getObjectList(FooVo.class, params);
        
        foos = ParamMatrix.getObjectList(FooVo.class, params, "prefix.");
    }
}
