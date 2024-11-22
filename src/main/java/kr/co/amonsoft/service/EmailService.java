package kr.co.amonsoft.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendEmail(String toEmail, String subject, String text) {
        try {
            log.info("메일 보내졋나??????");
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("anrh0213@amonsoft.co.kr"); // 보내는 사람 이메일
            message.setTo(toEmail);
            message.setSubject(subject);
            message.setText(text);
            mailSender.send(message);
        }catch (MailException e) {
            // 메일 전송 실패 또는 타임아웃에 대한 예외 처리
            System.err.println("메일 전송 중 오류 발생: " + e.getLocalizedMessage());
            throw new RuntimeException("메일 전송에 실패했습니다.", e);
        }
    }

}
