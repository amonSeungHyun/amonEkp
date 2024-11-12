package kr.co.amonsoft.service.com.impl;

import kr.co.amonsoft.dto.com.MemberListDTO;
import kr.co.amonsoft.mapper.com.Com7050Mapper;
import kr.co.amonsoft.service.com.Com7050Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class Com7050ServiceImpl implements Com7050Service {

    private final Com7050Mapper memberMapper;

    private final BCryptPasswordEncoder passwordEncoder;


    @Override
    public List<MemberListDTO> selectMemberList(Map<String, Object> param) {
        log.info("[구성원 서비스-selectMemberList] param : {}", param);

        return memberMapper.selectMemberList(param);
    }

    @Override
    public int selectMemberCnt(Map<String, Object> param) {
        return memberMapper.selectMemberCnt(param);
    }
}
