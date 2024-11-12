package kr.co.amonsoft.service.com.impl;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.dto.com.CommonDTO;
import kr.co.amonsoft.mapper.com.Com7060Mapper;
import kr.co.amonsoft.service.com.Com7060Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class Com7060ServiceImpl implements Com7060Service {

    private final Com7060Mapper memberMapper;

    private final BCryptPasswordEncoder passwordEncoder;

    /**
     * 구성원 등록
     * @param param
     * @return
     */
    @Override
    public Map<String, Object> insertMember(Map<String, Object> param) {
        int result = 0;
        log.info("[구성원 서비스단] param : {}", param);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String createdId = "";
        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();

            if (principal instanceof CustomUserDetails) {
                // Spring Security의 UserDetails를 구현한 사용자 객체에서 ID를 가져옴
                createdId = ((CustomUserDetails)principal).getUserId();

            } else {
                // principal이 String 타입으로 제공될 때 (ex: anonymous 사용자)

                log.info("insertMember하다가 CustomUserDetail : {} ", principal.toString());
            }
        }


        // job_start_date를 기준으로 'yyyyMMdd' 형식으로 변환
        String datePart = param.get("hireDate").toString();
//        String datePart = param.get("hireDate").toString().replaceAll("-", "");

        // 동일한 날짜에 입사한 인원 수 조회 (예: 2024102901, 2024102902 ...)
        int count = memberMapper.countUsersByStartDate(datePart);

        // user_id 생성 (2024102901, 2024102902 ...)
        String generatedUserId = datePart.replaceAll("-", "") + String.format("%02d", count + 1);
        log.info("########## generatedUserId : {}", generatedUserId);
        // 비밀번호 암호화
        String defaultPassword = "1234";
        String hashedPassword = passwordEncoder.encode(defaultPassword);

        // 현재 날짜를 문자열로 설정 (varchar 타입에 맞추기 위해)
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String currentDate = dateTimeFormat.format(new Date());

        // 사용자 정보 설정
        param.put("userId", generatedUserId);
        param.put("password", hashedPassword);
        param.put("createdId", createdId);
        param.put("updatedId", createdId);
        param.put("currentDate", currentDate);
        log.info("[구성원 서비스단] INSERT 전 param : {}", param);
        // DB에 유저 정보 삽입
        result = memberMapper.insertMember(param);

        param.put("result", result);

        return param;
    }

    @Override
    public Map<String, Object> updateMember(Map<String, Object> param) {
        log.info("[구성원 서비스단] UPDATE 전 param : {}", param);
        memberMapper.updateMember(param);
        return Map.of();
    }


    @Override
    public int deleteMember(Map<String, Object> param) {
        int result = 0;
        result = memberMapper.deleteMember(param);
        if (result == 0) {
            // 예외 발생: 삭제 대상 구성원을 찾을 수 없는 경우
            throw new RuntimeException("삭제할 구성원을 찾을 수 없습니다.");
        }
        return result;
    }


    @Override
    public int resetPassword(String userId) {

        log.info("[비밀번호 초기화 서비스 단] userId : {}", userId);

        // 비밀번호 쿼리에 보낼 데이터 맵
        Map<String, Object> param = new HashMap<>();
        int result = 0;                                 // 쿼리 결과 변수
        String defaultPassword = "1234";                // 비밀번호 디폴트
        
        //비밀번호 암호화
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encryptedPassword = passwordEncoder.encode(defaultPassword);         // 1234 인코드한 비밀번호

        param.put("userId", userId);                    // userId
        param.put("password", encryptedPassword);       // 비밀번호

        result = memberMapper.resetPassword(param);
        if (result == 0) {
            // 예외 발생: 삭제 대상 구성원을 찾을 수 없는 경우
            throw new RuntimeException("비밀번호 초기화를 실패하였습니다.");
        }
        return result;
    }






















    // **************************************** 공통(부서, 직책, 권한) 조회 *************************************************
    @Override
    public List<CommonDTO> departmentList() {

        List<CommonDTO> list = memberMapper.departmentList();

        log.info("#### [departmentList] 부서 : {}",list);

        return list;
    }

    @Override
    public List<CommonDTO> positionList() {
        List<CommonDTO> list = memberMapper.positionList();

        log.info("#### [positionList] 부서 : {}",list);

        return list;
    }

    @Override
    public List<CommonDTO> roleList() {
        List<CommonDTO> list = memberMapper.roleList();

        log.info("#### [roleList] 부서 : {}",list);

        return list;
    }
}
