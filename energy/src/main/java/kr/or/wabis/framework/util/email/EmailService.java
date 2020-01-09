package kr.or.wabis.framework.util.email;

import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.wabis.framework.util.ProjectConfigUtil;

public class EmailService {
	
	protected Logger logger = LoggerFactory.getLogger(EmailService.class);
	
	protected Message message;

	/**
	 * SMTP 서버와 연결
	 * 
	 * @return
	 * @throws Exception
	 */
	protected void connectSMTP() throws Exception {

        String protocol = (String) ProjectConfigUtil.getProperty("project.mail.protocol");
        String authority = (String) ProjectConfigUtil.getProperty("project.mail.authority");
        String starttls = (String) ProjectConfigUtil.getProperty("project.mail.starttls");
		
        String host = (String) ProjectConfigUtil.getProperty("project.mail.smtp.host");
        int port = ProjectConfigUtil.getIntValue("project.mail.smtp.port", 25);
        String userid = (String) ProjectConfigUtil.getProperty("project.mail.smtp.userid");
        String password = (String) ProjectConfigUtil.getProperty("project.mail.smtp.password");        
        
		Properties prop = new Properties();

		// Gmail 연결을 위하여 아래 설정 적, 사내 메일 망일 경우 smtp host 만 설정해도 됨 (특정 포트가 아닐경우)
		prop.put("mail.transport.protocol", protocol);		// 프로토콜
		prop.put("mail.smtp.host", host);					// smtp 서버 주소
		prop.put("mail.smtp.port", port);					// smtp 포트
		prop.put("mail.smtp.auth", authority);				// gmail은 무조건 true 고정
		prop.put("mail.smtp.starttls.enable", starttls); 	// gmail은 무조건 true 고정

		EmailAuthenticator auth = new EmailAuthenticator(userid, password);
		Session session = Session.getInstance(prop, auth);
		
		message = new MimeMessage(session);
	}


	/**
	 * 메일 생성
	 * 
	 * @param receiveEmail
	 * @param message
	 */
	protected void createMail(String receiveEmail, String title) throws Exception {
		
        String adminemail = (String) ProjectConfigUtil.getProperty("project.mail.adminemail");

		// 메일 제목 넣기
		message.setSubject(title);

		// 보내는 날짜
		message.setSentDate(new Date());

		// 보내는 메일 주소
		message.setFrom(new InternetAddress(adminemail));

		// 단건 전송일 때
		message.setRecipient(RecipientType.TO, new InternetAddress(receiveEmail));
	}


	/**
	 * 메일 생성
	 * 
	 * @param receiveEmail
	 * @param message
	 */
	protected void createSampleMail(String receiveEmail) throws Exception {
		
		MimeBodyPart mbp = new MimeBodyPart();

		// 메일 본문 작성
		
		// text 경우
		mbp.setText("Mail send");

		// 메일 제목 넣기
		message.setSubject("[보낼 메일 제목]");

		// 보내는 날짜
		message.setSentDate(new Date());

		// 보내는 메일 주소
		message.setFrom(new InternetAddress("[보낸 사람의 메일 주소]]"));

		// message 객체에 본문을 넣기 위하여 Multipart 객체 생성
		Multipart mp = new MimeMultipart();
		mp.addBodyPart(mbp);		

		// 파일 첨부일 경우
		MimeBodyPart mbp_file = new MimeBodyPart();
		mbp_file.setDataHandler(new DataHandler(new FileDataSource("[보낼 파일 경로]")));
		mbp_file.setFileName("[보낼 파일 이름]");
		mp.addBodyPart(mbp_file);	
		
		// html일 경우
		FileInputStream st = new FileInputStream(new File("[보낼 HTML 경로]"));
		MimeBodyPart mbp_html = new MimeBodyPart();
		mbp_html.setDataHandler(new DataHandler( new ByteArrayDataSource(st, "text/html")));
		mp.addBodyPart(mbp_html);

		// 메일 본문을 넣기
		message.setContent(mp);

		// 단건 전송일 때
		message.setRecipient(RecipientType.TO, new InternetAddress(receiveEmail));

		// 복수 건 전송일 때
		// InternetAddress[] receive_address = { new InternetAddress(receiveEmail) };
		// message.setRecipients(RecipientType.TO, receive_address);
	}

	/**
	 * 메일 전송
	 * 
	 * @param message
	 * @throws Exception
	 */
	public void sendMail() throws Exception {
		Transport.send(message);
	}
	
	public static void main(String[] args) throws Exception {
		
		try {	
			
			// 기본 답변 메일 html 을 읽어드려서 내용을 replace을 해서 내용을 교체 한다.		
			File file = new File("src/main/resources/email/replyEmail.html");
			
			System.out.println(file.getAbsolutePath());
			System.out.println(file.exists());
			
			String replyHtml = IOUtils.toString(new FileInputStream(file), "UTF-8");
			replyHtml = replyHtml.replaceAll("#URL#", "http://localhost:15000");
			replyHtml = replyHtml.replaceAll("#quest_title#", "질문 요청");
			replyHtml = replyHtml.replaceAll("#quest_contents#", "이메일 전송 가능?");
			replyHtml = replyHtml.replaceAll("#reply_title#", "답변 응수");
			replyHtml = replyHtml.replaceAll("#reply_contents#", "당근");
			
			System.out.println("### replyHtml : \n" + replyHtml);
			
		
			Properties prop = new Properties();

			prop.put("mail.transport.protocol", "smtp");		
			prop.put("mail.smtp.host", "smtp.gmail.com");	
			prop.put("mail.smtp.port", "587");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.starttls.enable", "true"); 	
			prop.put("mail.smtp.quitwait", "false"); 
			
			prop.put("mail.smtp.debug", "true");
			
			Session session = Session.getInstance(prop, 
			         new javax.mail.Authenticator() { 
			        protected PasswordAuthentication getPasswordAuthentication() { 
			        return new PasswordAuthentication("wabis.email@gmail.com", "anftksdjq"); 
			        }});
			
			session.setDebug(true);
			
			MimeMessage message = new MimeMessage(session);			

			// message 객체에 본문을 넣기 위하여 Multipart 객체 생성
			Multipart multipart = new MimeMultipart("alternative");
	
			// html일 경우
			MimeBodyPart htmlPart = new MimeBodyPart();
			htmlPart.setDataHandler(new DataHandler( new ByteArrayDataSource(replyHtml.getBytes(), "text/html")));			
			multipart.addBodyPart(htmlPart);	
			
			// 메일 본문을 넣기
			message.setContent(multipart);
				
			// 메일 제목 넣기
			message.setSubject("SMTP 메일 테스트");
	
			// 보내는 날짜
			message.setSentDate(new Date());
	
			// 보내는 메일 주소
			message.setFrom(new InternetAddress("wabis.email@gmail.com"));	
			
			 // Unexpected output.
		    System.out.println( "HTML = text/html : " + htmlPart.isMimeType( "text/html" ) );
		    System.out.println( "HTML Content Type: " + htmlPart.getContentType() );

		    // Required magic (violates principle of least astonishment).
		    message.saveChanges();
	
			// 단건 전송일 때
			message.setRecipient(RecipientType.TO, new InternetAddress("seokgun@gmail.com"));
						
			Transport.send(message);			
			
		} catch (AddressException e) {
            throw new Exception("메일 주소가 정확하지 않습니다.", e);
        } catch (MessagingException e) { 
            throw new Exception("메일 내용에 이상이 있습니다.", e);
        } catch (Exception e) {
            throw new Exception("메일 보내기가 실패 했습니다.", e);
        }
	}
	
}