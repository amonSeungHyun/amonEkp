package kr.co.amonsoft.service;

import kr.co.amonsoft.mapper.doc.DocCommonMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutorService;

@Service
@Slf4j
public class EmailService {

    private final ExecutorService executorService;
    private final JavaMailSender mailSender;
    private final DocCommonMapper docCommonMapper;

    public EmailService(ExecutorService executorService, JavaMailSender mailSender, DocCommonMapper docCommonMapper) {
        this.executorService = executorService;
        this.mailSender = mailSender;
        this.docCommonMapper = docCommonMapper;
    }

    public void sendEmail(String toEmail, String subject, String text) {
        executorService.submit(() -> {
            try {
                log.info("###################");
                log.info("메일 보내졋나??????");
                log.info("email : {}", toEmail);
                log.info("subject : {}", subject);
                log.info("text : {}", text);
                log.info("###################");
                SimpleMailMessage message = new SimpleMailMessage();
                message.setFrom("anrh0213@amonsoft.co.kr"); // 보내는 사람 이메일
                message.setTo(toEmail);
                message.setSubject(subject);
                message.setText(text);
                mailSender.send(message);
            } catch (MailException e) {
                log.error("메일 전송 중 오류 발생: {}", e.getLocalizedMessage());
                throw new RuntimeException("메일 전송에 실패했습니다.", e);
            }
        });
    }

    public String getEmailTitle(String docType) {
        List<Map<String, Object>> titleMap = docCommonMapper.findDocTypeTitles();

        for (Map<String, Object> map : titleMap) {
            if (docType.equals(map.get("docType"))) {
                return (String) map.get("docTypeNm");
            }
        }

        return "결재 요청입니다.";
    }

    public void sendApprovalEmails(String docType, String userId) {
        String title = getEmailTitle(docType);
        List<Map<String, Object>> findEmail = docCommonMapper.findCeoAndManager();

        findEmail.forEach(data -> {
            String email = (String) data.get("email");
            String userName = (String) data.get("userName");

            if (email != null && !email.isEmpty()) {
                sendEmail(email, title, userName + "님, 결재 요청이 도착했습니다.");
            }
        });
    }
}

