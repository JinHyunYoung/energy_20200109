package kr.or.wabis.framework.web.aop;

import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import kr.or.wabis.framework.util.SessionUtil;
import kr.or.wabis.framework.util.StringUtil;
import kr.or.wabis.framework.web.vo.AttchFileInfoVo;
import kr.or.wabis.framework.web.vo.DefaultVo;

@Aspect
public class DefaultVoSetterAspect {
    
    protected Logger log = LoggerFactory.getLogger(DefaultVoSetterAspect.class);
    
    @Around("execution(* kr.or.wabis..*Controller.*(..))")
    public Object setDefaultVo(ProceedingJoinPoint joinPoint) throws Throwable {
        
        Object[] params = joinPoint.getArgs();
        
        if (params != null) {
            
            for (Object param : params) {
                
                if (param instanceof DefaultVo) {
                    
                    String paramClsName = param.getClass().getSimpleName();
                    SessionUtil.copySessionToVo(param);
                    log.debug("### Session-Value copyed to {}", paramClsName);
                    
                    try {
                        
                        // if have list in Vo, copy to list
                        Method[] methods = param.getClass().getMethods();
                        for (Method method : methods) {
                            
                            if (method.getName().startsWith("get") && 
                                    method.getParameterTypes().length == 0 && 
                                    (method.getModifiers() == Modifier.PUBLIC || method.getModifiers() == Modifier.PROTECTED) ) {
                                                                
                                Object getted = method.invoke(param);
                                if (getted == null) {
                                    continue;
                                }
                                                                
                                String propName = StringUtil.uncapitalize(method.getName().substring(3));
                                String gettedClsName = getted.getClass().getSimpleName();
                                
                                if (getted instanceof DefaultVo) {
                                    SessionUtil.copySessionToVo(getted);
                                    log.debug("### Session-Value copyed to {} ({})", paramClsName + "." + gettedClsName, propName);
                                } 
                                
                                else if (getted instanceof ArrayList) {
                                    
                                    List<?> list = (List<?>) getted;
                                    
                                    if (list.size() != 0 && list.get(0) instanceof DefaultVo) {
                                        
                                        int idx = 0;
                                        for (Object object : list) {
                                            SessionUtil.copySessionToVo(object);
                                            log.debug("### Session-Value copyed to {}[{}] (" + propName + ")", paramClsName + "." + list.get(0).getClass().getSimpleName(), idx++);
                                        }
                                    }
                                }
                            }
                        }
                        
                    } catch (Exception e) {
                        e.printStackTrace();
                        log.error("### Session-Value copy failed.");
                    }
                    
                    this.multipartToFile((DefaultVo) param);
                    
                    log.debug("### Param Log:\n{}", ToStringBuilder.reflectionToString(param, ToStringStyle.MULTI_LINE_STYLE));
                }
            }
        }
        
        return joinPoint.proceed();
    }
    
    /**
     * 
     * @param vo
     * @throws Exception
     */
    public void multipartToFile(DefaultVo vo) throws Exception {
        
        List<AttchFileInfoVo> list = vo.getAttchFileList();
        if (list == null) {
            return;
        }
        
        int size = list.size();
        int count = 0;
        
        for (int idx = size - 1; idx >= 0; idx--) {
            
            AttchFileInfoVo attchFileInfoVo = list.get(idx);
            
            MultipartFile multipart = attchFileInfoVo.getAttchFile();
            
            if (multipart != null) {
                
                // 첨부파일관리번호
                String attchFileMtNo = attchFileInfoVo.getAttchFileMtNo(); 
                
                // 첨부파일일련번호                                           
                Integer attchFileSn = attchFileInfoVo.getAttchFileSn(); 
                
                String attchFileOgnlFileNm = multipart.getOriginalFilename();
                String attchFileCtenTpNm = multipart.getContentType();
                long attchFileSize = multipart.getSize();
                
                log.debug("-----------------------------------------------------------------------------");
                log.debug("attchFileMtNo    : {}", attchFileMtNo);
                log.debug("attchFileSn      : {}", attchFileSn);
                log.debug("originalFilename : {}", attchFileOgnlFileNm);
                log.debug("contentType      : {}", attchFileCtenTpNm);
                log.debug("size             : {}", attchFileSize);
                
                // Multipart to AttchFileInfoVo
                
                // 첨부파일원본파일명
                attchFileInfoVo.setAttchFileOgnlFileNm(attchFileOgnlFileNm); 
                
                // 첨부파일컨텐츠구분명
                attchFileInfoVo.setAttchFileCtenTpNm(attchFileCtenTpNm); 
                
                // 첨부파일크기
                attchFileInfoVo.setAttchFileSize(new BigDecimal(attchFileSize)); 
                
                count++;
            }
        }
        
        if (count > 0) {
            log.debug("-----------------------------------------------------------------------------");
            log.debug("### Normal Multipart file count : {}", count);
            log.debug("-----------------------------------------------------------------------------");
        }
    }
    
}