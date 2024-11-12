package kr.co.amonsoft.service.com.impl;

import kr.co.amonsoft.dto.com.CalendarListDTO;
import kr.co.amonsoft.dto.com.MemberListDTO;
import kr.co.amonsoft.mapper.com.Com2010Mapper;
import kr.co.amonsoft.mapper.com.Com7050Mapper;
import kr.co.amonsoft.service.com.Com2010Service;
import kr.co.amonsoft.service.com.Com7050Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class Com2010ServiceImpl implements Com2010Service {

    private final Com2010Mapper com2010Mapper;

    private final BCryptPasswordEncoder passwordEncoder;


    @Override
    public List<CalendarListDTO> selectCalendarList() {
        return com2010Mapper.selectCalendarList();
    }
}
