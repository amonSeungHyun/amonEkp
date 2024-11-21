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
import org.springframework.ui.Model;
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
    public List<CalendarListDTO> selectCalendarList(Model model) throws JsonProcessingException {

        log.info("################################ 캘린더 컨트롤러 조회 #####################################");

        // 하드코딩된 테스트 데이터

        return com2010Service.selectCalendarList();
    }


}
