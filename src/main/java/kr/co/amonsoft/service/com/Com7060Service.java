package kr.co.amonsoft.service.com;

import kr.co.amonsoft.dto.com.CommonDTO;

import java.util.List;
import java.util.Map;

public interface Com7060Service {

    Map<String, Object> insertMember(Map<String, Object> param);
    Map<String, Object> updateMember(Map<String, Object> param);
    int deleteMember(Map<String, Object> param);

    // 비밀번호 초기화
    int resetPassword(String userId);

    // ************************************ 공통(부서, 권한, 직책) 조회 **************************************************************
    List<CommonDTO> departmentList();
    List<CommonDTO> positionList();
    List<CommonDTO> roleList();

}
