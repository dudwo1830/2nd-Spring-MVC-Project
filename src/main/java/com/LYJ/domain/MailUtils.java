package com.LYJ.domain;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailUtils {

	private JavaMailSender mailSender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;
	
	public MailUtils(JavaMailSender mailSender) throws MessagingException{
		this.mailSender = mailSender;
		message = this.mailSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	}
	
	public void setSubject(String subject) throws MessagingException{
		messageHelper.setSubject(subject);
	}
	
	public void setText(String htmlContent) throws MessagingException{
		messageHelper.setText(htmlContent, true);
	}
	
	public void setFrom(String uid, String unickname) throws UnsupportedEncodingException, MessagingException{
		messageHelper.setFrom(uid, unickname);
	}
	
	public void setTo(String uid) throws MessagingException{
		messageHelper.setTo(uid);
	}
	
	public void addInline(String contentId, DataSource dataSource) throws MessagingException{
		messageHelper.addInline(contentId, dataSource);
	}
	
	public void send() {
		mailSender.send(message);
	}
}
