package kr.or.wabis.framework.util.email;

import java.util.Map;

import javax.activation.DataHandler;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;

import org.apache.commons.io.IOUtils;

import kr.or.wabis.framework.util.ProjectConfigUtil;
import kr.or.wabis.framework.util.StringUtil;

public class DirectoryApprovalService extends EmailService {

	public DirectoryApprovalService() {
	}

	/**
	 * 메일 전송
	 * 
	 * @param receiveEmail
	 * @param quest_title
	 * @param quest_contents
	 * @param reply_title
	 * @param reply_contents
	 * @return
	 * @throws Exception
	 */
	public long sendEmail(String receive_email, Map<String, Object> param) throws Exception {
		
		try {			
			
	        String siteName = (String) ProjectConfigUtil.getProperty("project.site.name");			
			String title = "기업디렉토리 신청이 승인되었습니다.";
			
			// SMTP 연결
			super.connectSMTP();
			
			// 메일 생성
			super.createMail(receive_email, title);
			
			// 답변 메일 생성
			this.makeEmail(param);
			
			// 메일 전송
			super.sendMail();
			
		} catch (Exception e) {
			e.printStackTrace();			
		}
		
		return -1;
	}
	
	
	/**
	 * 답변 메일 생성
	 * 
	 * @param quest_title
	 * @param quest_contents
	 * @param reply_title
	 * @param reply_contents
	 * @throws Exception
	 */
	private void makeEmail(Map<String, Object> param) throws Exception {

        //String url = (String) ProjectConfigUtil.getProperty("project.server.webUrl");
		 String url = (String) ProjectConfigUtil.getProperty("project.mail.serverUrl");

		// 기본 답변 메일 html 을 읽어드려서 내용을 replace을 해서 내용을 교체 한다.		
		String replyHtml = IOUtils.toString(getClass().getResourceAsStream("/email/directoryApproval.html"), "UTF-8");
		replyHtml = replyHtml.replaceAll("#URL#", url);
		
		replyHtml = replyHtml.replaceAll("#cmpy_nm#", StringUtil.nvl(param.get("cmpy_nm")));
		replyHtml = replyHtml.replaceAll("#cmpy_nm_en#", StringUtil.nvl(param.get("cmpy_nm_en")));
		replyHtml = replyHtml.replaceAll("#biz_reg_no#", StringUtil.nvl(param.get("biz_reg_no")));
		replyHtml = replyHtml.replaceAll("#ceo_nm#", StringUtil.nvl(param.get("ceo_nm")));
		replyHtml = replyHtml.replaceAll("#auth_no#", StringUtil.nvl(param.get("auth_no")));
				
		// message 객체에 본문을 넣기 위하여 Multipart 객체 생성
		Multipart multipart = new MimeMultipart("alternative");

		// html일 경우
		MimeBodyPart htmlPart = new MimeBodyPart();
		htmlPart.setDataHandler(new DataHandler( new ByteArrayDataSource(replyHtml.getBytes(), "text/html")));			
		multipart.addBodyPart(htmlPart);	
		
		// 메일 본문을 넣기
		message.setContent(multipart);
		
		// Required magic (violates principle of least astonishment).
	    message.saveChanges();
	}
}