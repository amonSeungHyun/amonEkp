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
			events: {
				url: '/admin/calendar/selectCalendarList',
				method: 'GET',
				failure: function () {
					alert("이벤트를 불러오는 중 오류가 발생했습니다.");
				},
				success: function (data) {
					// docType에 따라 색상 지정
					return data.map(event => {
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

                        // 제목에 "(안민영)" 추가 조건
                        const titleWithName = event.docType === '01'
                            ? event.docTitle + "(" + event.userName + ")" : event.docTitle;

						return {
							id: event.docId,
							title: titleWithName,
							start: event.startDate,
							end: event.endDate,
							color: color, // docType에 따라 동적으로 색상 지정
							extendedProps: {
                                userId: event.userId,       // 유저아이디
                                userName: event.userName, // 유저이름
                                description: event.docTitle,
								docType: event.docType,
								docTypeNm: event.docTypeNm
							}
						};
					});
				}
			},
            eventDidMount: function(info) {
                console.log(info); // 로그로 툴팁 데이터 확인

                const title = '<div class="tooltip-inner">' +
                    '<div class="tooltip-title">' + info.event.title + '</div>' +
                    '<div class="tooltip-content">' + (info.event.extendedProps.userName || " 이다 이 자석들아") + '</div>' +
                    '</div>';

                $(info.el).tooltip({
                    html: true,
                    title: title,
                    placement: 'top',
                    trigger: 'hover',
                    container: 'body'
                });
            }
			// dateClick: function (info) {
			// 	// 일정 등록 모달 띄우기
			// 	$('#scheduleModal').modal('show');
			// 	$("input[name='start_date']").val(info.dateStr + " 09:00");
			// 	$("input[name='end_date']").val(info.dateStr + " 18:00");
			// 	setupDateRangePicker(info.dateStr, info.dateStr);
			// },
			// eventClick: function (info) {
			// 	// 일정 상세보기 모달 띄우기
			// 	$('#modify_scheduleModal').modal('show');
			// 	loadEventDetails(info.event.id);
			// }
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
        <span class="legend-color" style="background-color: #B573FF;"></span> 지출
    </span>
	<span class="legend-item">
        <span class="legend-color" style="background-color: #73C2F0;"></span> 출장
    </span>
	<span class="legend-item">
        <span class="legend-color" style="background-color: #FFFFBA;"></span> 회의
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
