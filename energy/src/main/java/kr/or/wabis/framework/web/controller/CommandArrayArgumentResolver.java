package kr.or.wabis.framework.web.controller;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Array;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import kr.or.wabis.framework.util.ObjectUtil;
import kr.or.wabis.framework.util.SessionUtil;

/**
 * Array Argument Resolver in Controller.
 * 
 * @author kimjangsoo
 *
 */
public class CommandArrayArgumentResolver implements HandlerMethodArgumentResolver {
    
    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.getParameterType().isArray();
    }
    
    
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory webBinder) throws Exception {
        
        Class<?> clazz = parameter.getParameterType();
        Class<?> targetClazz = clazz.getComponentType(); // target VO
        
        log.debug("### Controller parameter {} is array", targetClazz.getSimpleName());
        
        HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
        
        String[] properties = getPropertyName(targetClazz);
        
        int max = 0;
        for (String getter : properties) {
            
            if (request.getParameterValues(getter) == null) {
                continue;
            }            
            
            if (max < request.getParameterValues(getter).length) {
                max = request.getParameterValues(getter).length;
            }
        }
        
        log.debug("### {} array's max length : {}", targetClazz.getSimpleName(), max);
        
        Object ret = Array.newInstance(targetClazz, max);
        for (int index = 0; index < max; index++) { // index
            
            Object target = targetClazz.newInstance();
            
            for (String property : properties) {
                String[] values = request.getParameterValues(property);
                
                if (values != null && index < values.length) {
                    callSetter(target, property, values[index]); // ⑤
                }
            }
            
            SessionUtil.copySessionToVo(target);
            
            Array.set(ret, index, target);
        }
        
        return ret;
    }
    
    /**
     * 
     * @param clazz
     * @return
     */
    protected String[] getPropertyName(Class<?> clazz) {
        List<String> list = new ArrayList<String>();
        
        for (Method method : clazz.getMethods()) {
            if (method.getName().startsWith("set") && method.getParameterTypes().length == 1) {
                list.add(method.getName().substring(3, 4).toLowerCase() + method.getName().substring(4));
            }
        }
        
        return list.toArray(new String[0]);
    }
    
    /**
     * 
     * @param vo
     * @param propertyName
     * @param value
     * @throws Exception
     */
    protected void callSetter(Object vo, String propertyName, String value) throws Exception {
        PropertyDescriptor pd = BeanUtils.getPropertyDescriptor(vo.getClass(), propertyName);
        
        Method method = pd.getWriteMethod();
        Object realVal = ObjectUtil.convertToObject(method.getParameterTypes()[0], value);
        
        try {
            pd.getWriteMethod().invoke(vo, realVal);
        } catch (IllegalArgumentException e) {
            log.error("### VO Method : {} {}", vo.getClass(), pd.getWriteMethod().getName());
            log.error("### Method.getParameterTypes()[0] : {}", method.getParameterTypes()[0]);
            log.error("### But, Binding parameter type : {}", realVal.getClass().getName());
            throw e;
        }
    }
    
}
