package kr.co.amonsoft.mapper.com;

import kr.co.amonsoft.dto.com.CalendarListDTO;
import kr.co.amonsoft.dto.com.MemberListDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface Com2010Mapper {

    // 캘린더 조회
    List<CalendarListDTO> selectCalendarList();

}
