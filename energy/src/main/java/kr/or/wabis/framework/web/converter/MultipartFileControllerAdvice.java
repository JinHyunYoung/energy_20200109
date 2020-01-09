package kr.or.wabis.framework.web.converter;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@ControllerAdvice
@EnableWebMvc
public class MultipartFileControllerAdvice {
    
    @InitBinder
    public void initBinder(WebDataBinder binder) throws Exception {
        binder.registerCustomEditor(MultipartFile.class, new MultipartFileCustomEditor());
    }
}
