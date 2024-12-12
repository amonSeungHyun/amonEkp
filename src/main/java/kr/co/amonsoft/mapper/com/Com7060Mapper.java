package kr.co.amonsoft.mapper.com;

import kr.co.amonsoft.dto.com.CommonDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface Com7060Mapper {

    // 구성원 등록
    int insertMember(Map<String, Object> param);

    // 구성원 수정
    int updateMember(Map<String, Object> param);

    // 구성원 삭제
    int deleteMember(Map<String, Object> param);

    // 아이디 중복 체크
    int duplicateUserId(String param);

    // 이메일 중복 체크
    int duplicateEmail(String param);

    // 입사일 같은거잇는지 카운트
    int countUsersByStartDate(String param);

    // 비밀번호 초기화
    int resetPassword(Map<String, Object> param);

    /** ********************************************** 공통(부서, 직책, 권한 조회) 조회 *************************************************************** */
    List<CommonDTO> departmentList();
    List<CommonDTO> positionList();
    List<CommonDTO> roleList();

}
