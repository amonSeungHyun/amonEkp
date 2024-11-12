package kr.co.amonsoft.controller.com;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import kr.co.amonsoft.dto.com.CalendarListDTO;
import kr.co.amonsoft.service.com.Com2010Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/calendar")
public class Com2010Controller {

    private final Com2010Service com2010Service;

    @GetMapping("/com2010")
    public String calendar(){
        return "/admin/calendar/com2010";
    }

    @RequestMapping(value="/selectCalendarList", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String selectCalendarList() throws JsonProcessingException {

        log.info("################################ 캘린더 컨트롤러 조회 #####################################");

        // 하드코딩된 테스트 데이터
        List<CalendarListDTO> selectCalendarList = new ArrayList<>();

        CalendarListDTO event1 = new CalendarListDTO();
        event1.setScheduleNo("1");
        event1.setUserId("1001");
        event1.setStartDate("2024-11-05T09:00:00");
        event1.setEndDate("2024-11-05T18:00:00");
        event1.setSubject("회의");
        event1.setContent("팀 회의");
        event1.setColor("#6666ff");  // 파란색 (회의)
        event1.setCategory("회의");
        event1.setOrganizationId("001");
        event1.setJoinUser("홍길동");
        event1.setPlace("회의실 A");
        event1.setName("홍길동");

        CalendarListDTO event2 = new CalendarListDTO();
        event2.setScheduleNo("2");
        event2.setUserId("1002");
        event2.setStartDate("2024-11-10T09:00:00");
        event2.setEndDate("2024-11-10T18:00:00");
        event2.setSubject("출장");
        event2.setContent("서울 출장");
        event2.setColor("#bfbfbf");  // 회색 (출장)
        event2.setCategory("출장");
        event2.setOrganizationId("002");
        event2.setJoinUser("김철수");
        event2.setPlace("서울");
        event2.setName("김철수");

        CalendarListDTO event3 = new CalendarListDTO();
        event3.setScheduleNo("3");
        event3.setUserId("1003");
        event3.setStartDate("2024-11-15T09:00:00");
        event3.setEndDate("2024-11-15T18:00:00");
        event3.setSubject("미팅");
        event3.setContent("고객사 미팅");
        event3.setColor("#ffd699");  // 주황색 (미팅)
        event3.setCategory("미팅");
        event3.setOrganizationId("003");
        event3.setJoinUser("이영희");
        event3.setPlace("고객사 본사");
        event3.setName("이영희");

        CalendarListDTO event4 = new CalendarListDTO();
        event4.setScheduleNo("4");
        event4.setUserId("1004");
        event4.setStartDate("2024-11-02T09:00:00");  // 시작 날짜
        event4.setEndDate("2024-11-04T18:00:00");  // 종료 날짜 (연속 일정)
        event4.setSubject("출장");  // 일정 제목
        event4.setContent("장진혁 출장");  // 일정 내용
        event4.setColor("#8bc34a");  // 초록색
        event4.setCategory("출장");  // 카테고리
        event4.setOrganizationId("004");
        event4.setJoinUser("장진혁");
        event4.setPlace("서울");
        event4.setName("장진혁");

        // 테스트 데이터 추가
        selectCalendarList.add(event1);
        selectCalendarList.add(event2);
        selectCalendarList.add(event3);
        selectCalendarList.add(event4);

        // JSON 변환
        ObjectMapper mapper = new ObjectMapper();
        ArrayNode jsonArr = mapper.createArrayNode();

        for (CalendarListDTO scvo : selectCalendarList) {
            ObjectNode jsonObj = mapper.createObjectNode();
            jsonObj.put("id", scvo.getScheduleNo());  // id 필드 사용
            jsonObj.put("title", scvo.getSubject());  // title 필드 사용
            jsonObj.put("start", scvo.getStartDate());  // start 필드 사용
            jsonObj.put("end", scvo.getEndDate());  // end 필드 사용
            jsonObj.put("color", scvo.getColor());
            jsonArr.add(jsonObj);
        }

        return mapper.writerWithDefaultPrettyPrinter().writeValueAsString(jsonArr);
    }


}
