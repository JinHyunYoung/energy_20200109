package kr.or.wabis.framework.email;

import java.io.File;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import kr.or.wabis.framework.util.StringUtil;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;

@Service
public class MailManageServiceImpl{

    private JavaMailSender mailSender;
    private VelocityEngine velocityEngine;

    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void setVelocityEngine(VelocityEngine velocityEngine) {
        this.velocityEngine = velocityEngine;
    }

    public boolean sendConfirmationEmail(final String toMail
						    		, final String fromMail
						    		, final String subject
						    		, final Map<String, Object> model
						    		, final String vmFilePath) {
    	 try {
    		
	        MimeMessagePreparator preparator = new MimeMessagePreparator() {
	            public void prepare(MimeMessage mimeMessage) throws Exception {
	                MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
	                message.setTo(toMail);
	                message.setFrom(fromMail); // could be parameterized...
	                message.setSubject(subject);
	                
	                //첨부파일
	                if(!StringUtil.nvl(model.get("file_name")).equals("")){
	                	File file = new File(StringUtil.nvl(model.get("file_path")));
	                	message.addAttachment(StringUtil.nvl(model.get("file_name")), file);
	                }
	                
	                //com/dns/registration-confirmation.vm
	                String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, vmFilePath, model);
	                message.setText(text, true);
	            }
	        };
        	
	        this.mailSender.send(preparator);
        	return true;
        	
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
        
        
    }

	public boolean sendEmail(String toMail, String fromMail, String subject, Map<String, Object> model, String vmFilePath) {
		return sendConfirmationEmail(toMail, fromMail, subject, model, vmFilePath);
	}

}
