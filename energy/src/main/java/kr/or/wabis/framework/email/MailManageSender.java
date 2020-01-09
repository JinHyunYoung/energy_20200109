package kr.or.wabis.framework.email;

import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.velocity.VelocityEngineUtils;

public class MailManageSender {

    @Autowired
    protected JavaMailSender mailSender;

    @Resource(name="velocityEngine")
    VelocityEngine velocityEngine;

    Logger log = Logger.getLogger(this.getClass());

    // 템플릿 사용한 이메일(Velocity 사용)
    public boolean sendMail(String toMail, String fromMail, String subject, Map<String, Object> model, String vmTemplatePath) {

        MimeMessage msg = mailSender.createMimeMessage();
        
        try {
            MimeMessageHelper helper = new MimeMessageHelper(msg, false);
            
            //email.getEmailMap().put("test", "test222323");
            //String[] reciever = {"aaa@aaa.aa", "bbb@bbb.bb"}; 
            
            String veloTemplate = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, vmTemplatePath, "UTF-8", model);
            helper.setSubject(subject);
            helper.setFrom(fromMail);
            helper.setTo(toMail);
            helper.setText(veloTemplate, true);
            //helper.setTo(reciever);

        } catch(MessagingException e) {
            log.error("이메일 전송 에러");
            log.debug(e.getMessage());
        }

        try {
            mailSender.send(msg);
            return true;
        } catch(MailException e) {
            log.error("Email MailException...");
            log.debug(e.getMessage());
            return false;
        }

    }

}