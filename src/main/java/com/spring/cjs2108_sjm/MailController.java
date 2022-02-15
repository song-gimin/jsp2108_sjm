package com.spring.cjs2108_sjm;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/mail")
public class MailController {
	@Autowired
	JavaMailSender mailSender;
	
//임시비밀번호발급(메일로 보낼 준비하기)
	@RequestMapping(value="/pwdConfirmSend/{toMail}/{content}/", method = RequestMethod.GET)
	public String pwdConfirmGet(@PathVariable String toMail, @PathVariable String content) {
		try {
			String fromMail = "sssong5101@gmail.com";
			String title = ">> 임시비밀번호가 발급되었습니다.";
			String pwd = content;
			content = "<b>BODEUM</b>에서 발송한 메일입니다.\n아래 임시비밀번호가 발급되었으니 사이트에서 로그인 후 비밀번호를 변경해주세요.\n";
			
			// 메세지를 변환시켜서 보관함(messageHelper)에 저장하기 위한 준비를 한다.
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 메일보관함에 회원이 보낸 메세지를 모두 저장시켜준다.
			messageHelper.setFrom(fromMail);
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			
			// 메세지 내용 편집 후 보관함에 저장처리한다.
			content = content.replace("\n", "<br>");
			content += "<br><hr><h3>임시비밀번호 : <font color='red'>"+pwd+"</font></h3><hr><br>";
			
			content += "<p><img src='cid:logo.png' width='400px'></p><hr>";
			
		  /*
			content += "<p>안녕하세요.</p>";
		  content += "<p>접속주소 : <a href='http://218.236.203.157:9090/cjs2108_sjm'>cjs2108_sjm</a></p><hr>";
			*/
		
			messageHelper.setText(content, true);
			
		  FileSystemResource file = new FileSystemResource(
		  "D:\\JavaCourse\\SpringFramework\\cjs2108_sjm\\cjs2108_sjm\\src\\main\\webapp\\resources\\images\\logo.png"
		  ); messageHelper.addInline("logo.png", file);
			 
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/pwdConfirmOk";
	}
	
	
}
