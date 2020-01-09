package kr.or.wabis.framework.web.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class LoggerAspect {
    
    protected Logger log = LoggerFactory.getLogger(LoggerAspect.class);
    
    @Around("execution(* kr.or.wabis..*Controller.*(..)) or execution(* kr.or.wabis..*Service.*(..)) or execution(* kr.or.wabis..*Dao.*(..))")
    public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable {
        
        String type = joinPoint.getSignature().getDeclaringTypeName();
        String name = "";
        
        if (type.indexOf("Controller") > -1) {
            name = "### [Enter] Controller : ";
        } 
        
        else if (type.indexOf("Service") > -1) {
            name = "### [Enter] Service : ";
        } 
        
        else if (type.indexOf("Dao") > -1) {
            name = "### [Enter] Dao : ";
        }
        
        log.debug(name + type + "." + joinPoint.getSignature().getName() + "()");
        
        return joinPoint.proceed();
    }
}