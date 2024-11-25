package kr.co.amonsoft.service;

import kr.co.amonsoft.mapper.doc.DocCommonMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private DocCommonMapper docCommonMapper;

    public void sendEmail(String toEmail, String subject, String text) {
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
        }catch (MailException e) {
            // 메일 전송 실패 또는 타임아웃에 대한 예외 처리
            System.err.println("메일 전송 중 오류 발생: " + e.getLocalizedMessage());
            throw new RuntimeException("메일 전송에 실패했습니다.", e);
        }
    }

    public String getEmailTitle(String docType) {
        // 데이터베이스에서 문서 유형과 제목을 매핑한 Map 불러오기
        List<Map<String, Object>> titleMap = docCommonMapper.findDocTypeTitles();

        // docType에 해당하는 docTypeNm 찾기
        for (Map<String, Object> map : titleMap) {
            if (docType.equals(map.get("docType"))) {
                return (String) map.get("docTypeNm");
            }
        }

        return "결재 요청입니다.";
    }

    public void sendApprovalEmails(String docType) {
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
