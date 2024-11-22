package kr.co.amonsoft.dto.com;

import lombok.Data;

@Data
public class CalendarListDTO {

    private String docId;             // 결재 문서 번호 (document 테이블)
    private String docTitle;          // 결재 제목
    private String docType;           // 결재 문서 유형
    private String docTypeNm;         // 결재 문서 유형 이름
    private String startDate;         // 시작 날짜
    private String endDate;           // 종료 날짜
    private String createdId;         // 생성자 ID
    private String createdDate;       // 생성 일시
    private String updatedId;         // 수정자 ID
    private String updatedDate;       // 수정 일시
    private String content;           // 일정 내용
    private String place;             // 장소
    private String color;             // 색상
    private String joinUser;          // 공유자
    private String category;          // 일정 분류
    private String name;              // 작성자 이름
    private String userId;            // 유저아이디
    private String userName;          // 유저이름

}
