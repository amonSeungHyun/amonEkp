<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/member.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css">

<style>
	/* 기본 스타일 */
	#calendar {
		width: 80%;
		margin-top: 20px; /* 위 여백 */
		margin-bottom: 50px; /* 아래 여백 */
		margin-left: 50px; /* 위 여백 */
		height: 600px;
	}

	/* 스타일 최적화 */
	.fc-day-sun a {
		color: red;
	}

	.fc-day-sat a {
		color: blue;
	}

	/* 반응형 스타일 */
	@media (max-width: 1024px) {
		#calendar {
			width: 90%;
			margin-left: 5%;
		}
	}

	@media (max-width: 768px) {
		#calendar {
			width: 100%;
			margin-left: 0;
		}
	}

	/* 캘린더 높이 조정 */
	@media (max-width: 480px) {
		#calendar {
			height: 600px;
		}
	}

	/* 날짜 칸의 기본 높이 고정 */
	.fc-daygrid-day-events {
		height: 100px; /* 칸 높이 고정 */
		position: relative;
		/*overflow-x: visible !important; !* 가로 넘침 표시 *!*/
		/*overflow-y: auto;*/
		padding: 3px; /* 날짜 칸 내부 여백 */
	}

	/* 캘린더 내부 요소의 위아래 간격 추가 */
	.fc {
		margin-top: 20px; /* 위 여백 */
		margin-bottom: 20px; /* 아래 여백 */
	}


	#calendarLegend {
		display: flex;
		justify-content: flex-end; /* 범례를 오른쪽 정렬 */
		align-items: center;
		margin-top: 10px;
		width: 80%;
	}

	.legend-item {
		display: flex;
		align-items: center;
		margin-right: 15px; /* 항목 간 간격 */
		font-size: 14px;
	}

	.legend-color {
		display: inline-block;
		width: 12px;
		height: 12px;
		margin-right: 5px;
		/*border-radius: 3px; !* 색상 박스 둥근 모서리 *!*/
        border-radius: 50%; /* 원형으로 설정 */
		border: 1px solid #ccc; /* 테두리 추가 */
	}



    .tooltip {
        position: absolute;
        z-index: 9999;
        background: #fff; /* 흰색 배경 */
        color: #000; /* 검은색 글씨 */
        border-radius: 5px; /* 모서리를 둥글게 */
        padding: 10px; /* 내부 여백 */
        text-align: left; /* 텍스트 왼쪽 정렬 */
        font-size: 14px; /* 글씨 크기 */
        max-width: 250px; /* 최대 너비 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
        border: 1px solid #ccc; /* 외곽선 추가 */
    }

    .tooltip-inner {
        display: flex;
        flex-direction: column;
    }

    .tooltip-title {
        font-weight: bold; /* 제목은 굵게 */
        font-size: 16px; /* 제목 글씨 크기 */
        margin-bottom: 5px; /* 제목과 내용 사이 간격 */
        color: #333; /* 제목 색상 */
        background: #f5f5f5; /* 제목 배경색 */
        padding: 5px;
        border-radius: 3px; /* 제목 둥근 모서리 */
        text-align: center; /* 제목 중앙 정렬 */
    }

    .tooltip-content {
        font-size: 14px; /* 내용 글씨 크기 */
        color: #555; /* 내용 색상 */
        line-height: 1.5; /* 줄 간격 */
        padding: 5px; /* 내용 내부 여백 */
    }





</style>

<script>
	$(document).ready(function () {
		let calendarEl = $('#calendar')[0];

        // 대한민국 공휴일 배열
        const koreanHolidays = [
            { title: '신정', date: '2024-01-01' },
            { title: '설날 연휴', date: '2024-02-09' },
            { title: '설날', date: '2024-02-10' },
            { title: '설날 연휴', date: '2024-02-11' },
            { title: '삼일절', date: '2024-03-01' },
            { title: '어린이날', date: '2024-05-05' },
            { title: '어린이날 대체공휴일', date: '2024-05-06' },
            { title: '부처님 오신 날', date: '2024-05-15' },
            { title: '현충일', date: '2024-06-06' },
            { title: '광복절', date: '2024-08-15' },
            { title: '추석 연휴', date: '2024-09-16' },
            { title: '추석', date: '2024-09-17' },
            { title: '추석 연휴', date: '2024-09-18' },
            { title: '개천절', date: '2024-10-03' },
            { title: '한글날', date: '2024-10-09' },
            { title: '성탄절', date: '2024-12-25' }
        ];

        // 공휴일 이벤트 변환
        // const holidayEvents = koreanHolidays.map(holiday => ({
        //     title: holiday.title,
        //     start: holiday.date,
        //     color: '#FF0000', // 빨간색
        //     allDay: true
        // }));

		// FullCalendar 설정
        let calendar = new FullCalendar.Calendar(calendarEl, {
            selectable: true,
            locale: 'ko',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek'
            },
            contentHeight: 'auto', // 자동 높이 조정

            // 이벤트 소스 정의
            eventSources: [
                {
                    url: '/admin/calendar/selectCalendarList', // 기존 데이터 URL
                    method: 'GET',
                    failure: function () {
                        alert("이벤트를 불러오는 중 오류가 발생했습니다.");
                    },
                    success: function (data) {
                        return data.flatMap(event => {
                            let color;
                            switch (event.docType) {
                                case '01': // 휴가
                                    color = '#FF6F7A'; // 빨간색
                                    break;
                                case '02': // 지출
                                    color = '#81D98E'; // 초록색
                                    break;
                                case '03': // 출장
                                    color = '#73C2F0'; // 파란색
                                    break;
                                case '04': // 회의
                                    color = '#FFFFBA'; // 노란색
                                    break;
                                case '05': // 품의서
                                    color = '#F3E76D'; // 밝은 초록색
                                    break;
                                case '06': // 기타
                                    color = '#B573FF'; // 진한 빨간색
                                    break;
                                default:
                                    color = '#89848a'; // 기본 회색
                                    break;
                            }

                            const titleWithName = event.docType === '01'
                                ? event.docTitle + "(" + event.userName + ")" : event.docTitle;

                            // 이벤트 날짜 필터링: 공휴일 제외
                            const startDate = new Date(event.startDate);
                            const endDate = new Date(event.endDate);
                            const filteredDates = [];

                            // 공휴일 날짜 배열 생성
                            const holidayDates = koreanHolidays.map(h => h.date);

                            for (let d = new Date(startDate); d <= endDate; d.setDate(d.getDate() + 1)) {
                                const formattedDate = d.toISOString().split('T')[0]; // YYYY-MM-DD 형식
                                const dayOfWeek = d.getDay(); // 0: 일요일, 6: 토요일

                                if (!holidayDates.includes(formattedDate) && dayOfWeek !== 0 && dayOfWeek !== 6) {
                                    filteredDates.push(formattedDate); // 공휴일이 아닌 날짜만 추가
                                }
                            }

                            // 각 날짜별로 개별 이벤트 생성 (필요시 조합 가능)
                            return filteredDates.map(date => ({
                                id: event.docId + '-' + date, // 고유 ID
                                title: titleWithName,
                                start: date,
                                end: date, // 단일 날짜 이벤트
                                color: color,
                                extendedProps: {
                                    docId: event.docId,
                                    userId: event.userId,
                                    userName: event.userName,
                                    description: event.docTitle,
                                    docType: event.docType,
                                    docTypeNm: event.docTypeNm
                                }
                            }));
                        })
                    }
                },
                // {
                //     events: holidayEvents // 공휴일 추가
                // }
            ],

            // 공휴일 날짜 옆 텍스트 추가
            dayCellDidMount: function (info) {
                // info.date를 YYYY-MM-DD 형식으로 변환
                const date = info.date; // info.date는 Date 객체
                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1 필요
                const day = String(date.getDate()).padStart(2, '0'); // 날짜를 두 자리로 변환
                const currentDate = year + "-" + month + "-" + day; // YYYY-MM-DD 형식으로 변환
                console.log("현재 날짜 (변환됨):", currentDate);
                // 공휴일 배열에서 현재 날짜와 일치하는 공휴일 찾기
                const holiday = koreanHolidays.find(h => h.date === currentDate);
                console.log("공휴일 날짜 : ", holiday);
                if (holiday) {

                    // 날짜 번호 뒤에 공휴일 이름 추가
                    const dayCellContent = $(info.el).find('.fc-daygrid-day-top');
                    if (dayCellContent.length) {
                        // 날짜 번호를 빨간색으로 설정
                        // 날짜 번호를 빨간색으로 설정 (스타일 적용 확실히)
                        dayCellContent.css({
                            'color': 'red',
                            'font-weight': 'bold', // 강조 효과 추가
                        });
                        dayCellContent.append('<span style="color: red; font-size: 12px; margin-left: 5px; margin-top: 5px;">(' + holiday.title + ')</span>');
                    }
                }
            },

            eventDidMount: function (info) {
                const title = '<div class="tooltip-inner">' +
                    '<div class="tooltip-title">' + info.event.title + '</div>' +
                    '<div class="tooltip-content">' + (info.event.extendedProps.userName || "N/A") + '</div>' +
                    '</div>';

                $(info.el).tooltip({
                    html: true,
                    title: title,
                    placement: 'top',
                    trigger: 'hover',
                    container: 'body'
                });
            },

            // 이벤트 클릭 시 동작 추가
            eventClick: function (info) {
                console.log("이벤트 클릭 시 info : ", info);
                const docId = info.event.extendedProps.docId; // 이벤트 ID 가져오기
                const docType = info.event.extendedProps.docType; // docType 가져오기
                const referenceType = "doc"; // referenceType 고정값
                console.log("이벤트 클릭 시 docId : ", docId);
                console.log("이벤트 클릭 시 docType : ", docType);
                // Redirect URL 생성 함수 호출
                const goToUrl = goToUrUrl(docId, docType, referenceType);

                if (goToUrl) {
                    console.log("이동할 화면 URL:", goToUrl);
                    // 페이지 이동
                    window.location.href = goToUrl;
                } else {
                    alert("유효하지 않은 docType입니다.");
                }
            }

        });

        calendar.render();

		// DateRangePicker 설정
		function setupDateRangePicker(start, end) {
			$('#daterange_register').daterangepicker({
				timePicker: true,
				timePicker24Hour: true,
				startDate: start + " 09:00",
				endDate: end + " 18:00",
				locale: {
					format: 'YYYY-MM-DD HH:mm',
					separator: " ~ ",
					applyLabel: "확인",
					cancelLabel: "취소",
					daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
					monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
				}
			}).on('apply.daterangepicker', function (ev, picker) {
				$("input[name='start_date']").val(picker.startDate.format('YYYY-MM-DD HH:mm'));
				$("input[name='end_date']").val(picker.endDate.format('YYYY-MM-DD HH:mm'));
			});
		}

        // Redirect URL 생성 함수
        function goToUrUrl(docId, docType, referenceType) {
            const urls = {
                "01": "/approval/annualLeaveView?docId=" + docId + "&referenceType=" + referenceType,
                "02": "/approval/expenseDetailView?docId=" + docId + "&referenceType=" + referenceType,
                "03": "/doc/doc1040View?docId=" + docId + "&referenceType=" + referenceType,
                "05": "/doc/doc1050View?docId=" + docId + "&referenceType=" + referenceType,
                "06": "/doc/doc1060View?docId=" + docId + "&referenceType=" + referenceType,
            };

            return urls[docType] || null; // docType이 유효하지 않을 경우 null 반환
        }


		// 이벤트 상세 정보 불러오기
		function loadEventDetails(schedule_no) {
			$.ajax({
				url: "/admin/calendar/selectCalendarList",
				data: { "schedule_no": schedule_no },
				dataType: "JSON",
				success: function (json) {
					let start_date = json.startDate;
					let end_date = json.endDate;
					$("#daterange_modify").val(start_date + " ~ " + end_date);
					$("form[name='schedule_modify_delete'] input[name='start_date']").val(start_date);
					$("form[name='schedule_modify_delete'] input[name='end_date']").val(end_date);
					$("#subject_modify").val(json.docTitle);
					$("#category_modify").val(json.docTypeNm);
					$("#place_modify").val(json.place);
					$("#content_modify").val(json.content);
					$("#schedule_no_modify").val(schedule_no);
				},
				error: function (request, status, error) {
					console.log("Error:", error);
				}
			});
		}
	});
</script>

<div id="peopleContent">
	<div id="header">
		<div id="header_title">
			<a class="current" href="/admin/calendar/com2010"><span class="memberTitle">캘린더</span></a>
		</div>



	</div>

	<div id="calendarLegend" class="mb-3">
    <span class="legend-item">
        <span class="legend-color" style="background-color: #FF6F7A;"></span> 휴가
    </span>
	<span class="legend-item">
        <span class="legend-color" style="background-color: #81D98E;"></span> 지출
    </span>
	<span class="legend-item">
        <span class="legend-color" style="background-color: #73C2F0;"></span> 출장
    </span>
	<span class="legend-item">
        <span class="legend-color" style="background-color: #B573FF;"></span> 교통비 청구서
    </span>
	<span class="legend-item">
        <span class="legend-color" style="background-color: #F3E76D;"></span> 품의서
    </span>
	<span class="legend-item">
        <span class="legend-color" style="background-color: #89848a;"></span> 기타
    </span>
	</div>
		<div id="calendar"></div>

</div>
