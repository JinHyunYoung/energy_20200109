package kr.or.wabis.framework.util.email;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class EmailAuthenticator extends Authenticator {
	
	private String id;
	private String pw;

	public EmailAuthenticator(String id, String pw) {
		this.id = id;
		this.pw = pw;
	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(id, pw);
	}

}