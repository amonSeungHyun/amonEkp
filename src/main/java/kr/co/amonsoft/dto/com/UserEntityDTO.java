package kr.co.amonsoft.dto.com;

import lombok.Data;

@Data
public class UserEntityDTO {

    private String userName;                // 이름
    private String userId;                  // ID
    private String employmentStatus;        // 재직상태
    private String positionCode;            // 직급코드
    private String positionNm;              // 직급명
    private String organizationId;          // 부서id
    private String department;              // 부서명
    private String jobStartDate;            // 입사일
    private String jobEndDate;              // 퇴사일
    private String phoneNo;                 // 연락처
    private String address;                 // 주소
    private String password;                // 비밀번호
    private String roleNm;                // 직책

}
