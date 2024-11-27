<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/admin/doc/docHeader.jsp"></jsp:include>

<style type="text/css">
	/* CSS 정리된 스타일 */
	p { margin:0pt 0pt 8pt }
	table { margin-top:0pt; margin-bottom:8pt }
	/* Additional styles for table formatting and inputs */
	.filebox .upload-name {
		display: inline-block;
		height: 40px;
		padding: 0 10px;
		vertical-align: middle;
		border: 1px solid #dddddd;
		width: 70%;
		border-radius: 0.4rem;
		color: #999999;
	}
	.filebox label {
		display: inline-block;
		padding: 9px 20px;
		color: #fff;
		vertical-align: middle;
		text-align: center;
		background-color: #88eb1e;
		cursor: pointer;
		width : 25%;
		height: 40px;
		margin-left: 5px;
		margin-top: 5px;
		border-radius: 0.4rem;
	}
	/* CSS 정리된 스타일 */

	.table-area {
		border:0.75pt solid #000000;
		border-collapse:collapse;
		margin:10px;
		float: left;
	}
	.file-area {
		width: 25%;
		margin-left: 20px;
		float: left;
	}
	.clearfix::after {
		content: "";
		clear: both;
		display: table;
	}
	/* Additional styles for table formatting and inputs */
	.filebox .upload-name {
		display: inline-block;
		height: 40px;
		padding: 0 10px;
		vertical-align: middle;
		border: 1px solid #dddddd;
		width: 70%;
		border-radius: 0.4rem;
		color: #999999;
	}
	.filebox label {
		display: inline-block;
		padding: 9px 20px;
		color: #fff;
		vertical-align: middle;
		text-align: center;
		background-color: #88eb1e;
		cursor: pointer;
		width : 25%;
		height: 40px;
		margin-left: 5px;
		margin-top: 5px;
		border-radius: 0.4rem;
	}
	.first-table{
		width : 780px;
		margin: 20px;
	}

	.col-table{
		border-collapse: collapse; /* 테두리 중첩 방지 */
		width: 780px;
		margin: 20px;
		border: 0.75pt solid #cccccc;
	}

	.col1{
		width:64.85pt;
		border-top:0.75pt solid #000000;
		border-right:0.75pt solid #a0a0a0;
		border-left:0.75pt solid #000000;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
	}

	.col2{
		width:77.25pt;
		border-right:0.75pt solid #a0a0a0;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
		background-color:#f3f3f3;
	}

	.col3{
		width:158.55pt;
		border-right:0.75pt solid #a0a0a0;
		border-left:0.75pt solid #a0a0a0;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
	}

	.detail-col1{
		width:48.05pt;
		border-top:0.75pt solid #a0a0a0;
		border-right:0.75pt solid #a0a0a0;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
	}

	.detail-col2{
		width:90.9pt;
		border-top:0.75pt solid #a0a0a0;
		border-right:0.75pt solid #a0a0a0;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
	}

	.detail-col3{
		width:87.15pt;
		border-top:0.75pt solid #a0a0a0;
		border-right:0.75pt solid #a0a0a0;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
	}

	.detail-col4{
		width:80.55pt;
		border-top:0.75pt solid #a0a0a0;
		border-right:0.75pt solid #a0a0a0;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
	}

	.detail-col5{
		width:85.3pt;
		border-top:0.75pt solid #a0a0a0;
		border-right:0.75pt solid #a0a0a0;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
	}

	.detail-col6{
		width:78.7pt;
		border-top:0.75pt solid #a0a0a0;
		border-right:0.75pt solid #a0a0a0;
		border-bottom:0.75pt solid #a0a0a0;
		padding-right:0.22pt;
		padding-left:0.22pt;
		vertical-align:middle;
	}

	.font-malgungothic {
		font-family: '맑은 고딕';
	}

	/* Style for the textarea */
	textarea {
		width: 100%; /* Make textarea take full width of the cell */
		height: 100%; /* Adjust height as needed */
		border: none; /* Remove border */
		background-color: transparent; /* Make background transparent */
		resize: none; /* Disable resizing */
		overflow: hidden; /* Hide overflow */
		text-align: center; /* Center-align text if needed */
		padding: 0;
		line-height: 1.2;
	}

	p { margin:0pt 0pt 8pt }
	table { margin-top:0pt; margin-bottom:8pt }

	/* 유형 */
	.checkbox-group {
		display: flex;
		justify-content: space-around;
		padding: 5px;
	}
	.checkbox-group label {
		flex: 1;
		text-align: center;
	}

	/* 기간 */
	/*.input-field.short {*/
	/*	width: 150px;*/
	/*	padding: 5px;*/
	/*	text-align: center;*/
	/*}*/
	/* 날짜 필드 스타일 */
	.input-field.short {
		width: 200px; /* input 필드 너비 조정 */
		padding: 8px;
		text-align: center;
		border: 1px solid #cccccc;
		border-radius: 4px;
		box-sizing: border-box;
	}

	.duration-container {
		display: flex;
		align-items: center;
		gap: 5px; /* 간격 조정 */
		border: none; /* 추가 테두리 제거 */
	}

	.col-table td {
		border: 1px solid #cccccc; /* 테두리 색상 설정 (연한 회색) */
		padding: 10px; /* 셀 내 여백 조정 */
		vertical-align: middle;
	}

	/* 연락처 입력 필드 테두리 제거 */
	.input-field.no-border {
		width: 100%;
		padding: 8px;
		border: none; /* 테두리 제거 */
		box-sizing: border-box;
	}

	/* 기본 설정: 초기 높이 유지 */
	.auto-expand {
		overflow: hidden; /* 스크롤바 제거 */
		min-height: 50px; /* 최소 높이 설정 */
	}

	/* 추가: 공휴일 및 주말 강조 스타일 */
	.holiday a {
		background-color: #ffcccc !important;
		color: #d9534f !important;
	}
	.weekend a {
		background-color: #e6e6e6 !important;
	}

	/* daterangepicker 내 특정 요일 스타일링 */
	.daterangepicker .calendar-table th:nth-child(1), /* 일요일 */
	.daterangepicker .calendar-table td.weekend:nth-child(1) { /* 일요일 */
		color: red !important;
	}

	.daterangepicker .calendar-table th:nth-child(7), /* 토요일 */
	.daterangepicker .calendar-table td.weekend:nth-child(7) { /* 토요일 */
		color: blue !important;
	}

	/* 공휴일 스타일 추가 */
	.daterangepicker td.active-holiday a {
		background-color: #ffcccc !important;
		color: #d9534f !important;
	}

	.centered-cell {
		text-align: center;       /* 수평 가운데 정렬 */
		vertical-align: middle;   /* 수직 가운데 정렬 */
		height: 100px;            /* td의 높이 지정 */
	}

	/* 이미지 크기를 조절하는 스타일 */
	.centered-image {
		max-width: 80px;          /* 이미지의 최대 너비 지정 */
		max-height: 80px;         /* 이미지의 최대 높이 지정 */
	}

</style>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script type="text/javascript">
	// === 공휴일 추가 (연도별) ===
	let holidays = [];		// 공휴일 저장 객체

	// 특정 연도의 공휴일 설정 함수
	function setHolidaysForYear(year) {
		console.log("year : ", year);

		holidays[year] = [
			year + "-01-01", // 신정
			year + "-03-01", // 삼일절
			year + "-05-05", // 어린이날
			year + "-06-06", // 현충일
			year + "-08-15", // 광복절
			year + "-10-01", // 근로자의 날
			year + "-10-03", // 개천절
			year + "-10-09", // 한글날
			year + "-12-25"  // 성탄절
		];

		// 설날 추가 (음력 1월 1일 기준으로 앞뒤 1일 포함하여 3일)
		const lunarNewYear = lunarToSolar(`${year}-01-01`);
		if (lunarNewYear) {
			const lunarNewYearStart = new Date(lunarNewYear);
			holidays[year].push(
					formatDate(new Date(lunarNewYearStart.setDate(lunarNewYearStart.getDate() - 1))), // 설날 전날
					formatDate(new Date(lunarNewYearStart.setDate(lunarNewYearStart.getDate() + 1))), // 설날 당일
					formatDate(new Date(lunarNewYearStart.setDate(lunarNewYearStart.getDate() + 1)))  // 설날 다음날
			);
		}

		// 추석 추가 (음력 8월 15일 기준으로 앞뒤 1일 포함하여 3일)
		const chuseokDate = lunarToSolar(`${year}-08-15`);
		if (chuseokDate) {
			const chuseokStart = new Date(chuseokDate);
			holidays[year].push(
					formatDate(new Date(chuseokStart.setDate(chuseokStart.getDate() - 1))), // 추석 전날
					formatDate(new Date(chuseokStart.setDate(chuseokStart.getDate() + 1))), // 추석 당일
					formatDate(new Date(chuseokStart.setDate(chuseokStart.getDate() + 1)))  // 추석 다음날
			);
		}

		// 대체 공휴일 추가: 휴일이 일요일인 경우 월요일을 추가
		holidays[year].forEach(dateStr => {
			const holidayDate = new Date(dateStr);
			if (holidayDate.getDay() === 0) { // 일요일인지 확인
				const substituteHoliday = new Date(holidayDate);
				substituteHoliday.setDate(holidayDate.getDate() + 1); // 다음 날인 월요일로 설정
				holidays[year].push(formatDate(substituteHoliday));
			}
		});

	}
	const currentYear = new Date().getFullYear();
	console.log("currentYear : ", currentYear);
	setHolidaysForYear(currentYear);

	// 공휴일 데이터를 문자열 배열로 변환
	const holidayDates = holidays[currentYear];

	$(document).ready (function(){
		console.log("holidayDates : ", holidayDates);
		// daterangepicker를 startDate와 endDate 필드에 적용
		$('#startDate').daterangepicker({
			singleDatePicker: true,
			autoUpdateInput: true,
			autoApply: true,
			locale: {
				format: 'YYYY-MM-DD',
				daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				firstDay: 0
			},
			isInvalidDate: function(date) {
				return holidayDates.includes(date.format('YYYY-MM-DD'));
			}
		}).on('apply.daterangepicker', function() {
			calculateDuration(); // startDate 변경 시 기간 계산
		}).on('show.daterangepicker', function(event, picker) {
			applyHolidayStyles(picker);
		});

		// endDate에 daterangepicker 적용
		$('#endDate').daterangepicker({
			singleDatePicker: true,
			autoUpdateInput: true,
			autoApply: true,
			locale: {
				format: 'YYYY-MM-DD',
				daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				firstDay: 0
			},
			isInvalidDate: function(date) {
				return holidayDates.includes(date.format('YYYY-MM-DD'));
			}
		}).on('apply.daterangepicker', function() {
			calculateDuration(); // endDate 변경 시 기간 계산
		}).on('show.daterangepicker', function(event, picker) {
			applyHolidayStyles(picker);
		});

		$("input[name='vacationType']").on("change", function() {
			// 현재 선택한 체크박스를 제외하고 모두 해제
			$("input[name='vacationType']").not(this).prop("checked", false);
		});

		$('input[name="vacationType"]').on("change", function() {
			calculateDuration();
		});

		// 날짜를 선택할 때도 기간을 다시 계산
		$('#startDate, #endDate').on("change", function() {
			// 시작일과 종료일을 Date 객체로 변환하여 비교
			const start = new Date(startDate);
			const end = new Date(endDate);

			// 시작일이 종료일보다 큰 경우 경고창 표시
			if (start > end) {
				alert("시작일은 종료일보다 클 수 없습니다.");
				$("#duration").text(0);
				return;
			}

			calculateDuration();

		});

		// daterangepicker가 열릴 때 공휴일 스타일 적용
		$('#startDate, #endDate').on('show.daterangepicker', function (event, picker) {
			applyHolidayStyles(picker);
		});

		// 텍스트 영역 높이 자동 조정
		$('.auto-expand').on('input', function() {
			this.style.height = 'auto'; // 높이 초기화
			this.style.height = (this.scrollHeight) + 'px'; // 내용에 맞춰 높이 조정
		});


		bindEvents();
		console.log("공휴일 : ", holidays);
	});

	function lunarToSolar(lunarDate) {
		// 여기서 실제 변환 API 호출을 추가해야 합니다.
		if (lunarDate.endsWith("-01-01")) {
			return "2024-02-10"; // 예: 2024년 설날 날짜 (음력 1월 1일)
		} else if (lunarDate.endsWith("-08-15")) {
			return "2024-09-17"; // 예: 2024년 추석 날짜 (음력 8월 15일)
		}
		return null;
	}

	// 날짜 객체를 'YYYY-MM-DD' 형식 문자열로 변환하는 함수
	function formatDate(date) {
		return date.toISOString().split('T')[0];
	}

	function applyHolidayStyles() {
		$('.daterangepicker td').each(function () {
			const date = $(this).attr('data-title');
			if (date) {
				const formattedDate = moment(date, 'D-MMMM-YYYY').format('YYYY-MM-DD');
				if (holidayDates.includes(formattedDate)) {
					$(this).addClass('active-holiday');
				}
			}
		});
	}
	function insertApprovalExpenseDetail() {
		const approvalData = collectApprovalSteps();
		const annualLeaveData = collectAnnualLeaveData();
		if(confirm("결재 신청을 하시겠습니까?")) {
			$.ajax({
				url: '/approval/insertAnnualLeaveDetail', // 데이터를 보낼 서버의 URL로 변경
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					approvalData: approvalData,
					annualLeaveData: annualLeaveData
				}),
				success: function (docId) {
					$(location).attr("href", "/approval/annualLeaveView?docId=" + docId);
				},
				error: function (error) {
					console.error('Error sending data:', error);
				}
			});
		}
	}

	function collectAnnualLeaveData(){
		const data = [];
		const rowData = {
			// amy
			vacationType: $("input[name='vacationType']:checked").val(), // 선택된 유형 추가
			startDate: $("#startDate").val(),
			endDate: $("#endDate").val(),
			emergencyContact: $("#emergencyContact").val().replace(/-/g, ''),
			personalReason: $("#personalReason").val(),
			vacationPeriod: $("#duration").text(),
			docTitle: $("#docTitle").val()
		}
		data.push(rowData);
		return data;
	}

	function calculateDuration() {
		const startDate = $("#startDate").val();
		const endDate = $("#endDate").val();
		const isHalfDay = $("#halfDay").is(":checked");
		console.log("123", isHalfDay);

		if (startDate && endDate) {
			let duration = "";

			// 시작일과 종료일이 같을 경우
			if (startDate === endDate) {
				duration = isHalfDay ? 0.5 : 1;  // 반차 체크 시 0.5일, 그렇지 않으면 1일
			} else {
				// 시작일과 종료일이 다를 경우, 반차 체크는 무시하고 주말 제외 일수로 계산
				duration = calculateWorkdaysExcludingWeekendsAndHolidays(startDate, endDate);
			}

			$("#duration").text(duration > 0 ? duration : 0);
		}
	}

	// 공휴일 및 주말 제외 근무일 계산 함수
	function calculateWorkdaysExcludingWeekendsAndHolidays(startDate, endDate) {
		const start = new Date(startDate);
		const end = new Date(endDate);
		let workdaysCount = 0;

		while (start <= end) {
			const dayOfWeek = start.getDay();
			const formattedDate = start.toISOString().split('T')[0]; // 'YYYY-MM-DD' 형식으로 변환
			console.log("dayOfWeek : ", dayOfWeek);
			console.log("formattedDate : ", formattedDate);

			// 주말이 아니고 공휴일이 아닐 때만 근무일로 계산
			if (dayOfWeek !== 0 && dayOfWeek !== 6 && !holidayDates.includes(formattedDate)) {
				workdaysCount++;
			}
			start.setDate(start.getDate() + 1); // 다음 날로 이동
		}
		console.log("일간 : ", workdaysCount);
		return workdaysCount;
	}

	// 이벤트 바인딩 함수
	function bindEvents() {

		$("input[name='vacationType']").on("change", function () {
			$("input[name='vacationType']").not(this).prop("checked", false);
		});

		$('#startDate, #endDate').on("change", function () {
			calculateDuration();
		});

		$('.auto-expand').on('input', function () {
			this.style.height = 'auto';
			this.style.height = (this.scrollHeight) + 'px';
		});
	}

	function formatPhoneNumber(input) {
		let value = input.value.replace(/\D/g, ''); // 숫자만 남기기
		if (value.length > 3 && value.length <= 7) {
			// 중간에 하이픈 삽입 (3-4 형식)
			input.value = value.replace(/(\d{3})(\d{1,4})/, '$1-$2');
		} else if (value.length > 7) {
			// 끝에 하이픈 삽입 (3-4-4 형식)
			input.value = value.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
		} else {
			input.value = value; // 3자리 이하일 때는 그대로 출력
		}

		// 최대 길이 제한 (13자리 - '010-1234-5678' 형식)
		if (input.value.length > 13) {
			input.value = input.value.slice(0, 13);
		}
	}

</script>
<div class="contai" style="overflow-x: hidden;">
	<form name="writeFrm" enctype="multipart/form-data">
		<input id="docType" type="hidden" value="01">
		<input id="docTitle" type="hidden" value="휴가계">
		<div class="table-area">
			<table class="first-table">
				<tr style="height:17.1pt">
					<td rowspan="3" style="width:211.45pt; border-right:0.75pt solid #000000; padding-right:0.22pt; padding-left:0.6pt; vertical-align:middle">
						<p class="a7" style="text-align:center; line-height:normal; font-size:20pt">
							<strong><span class="font-malgungothic" style="color:#000000">휴가계</span></strong>
						</p>
					</td>
					<td class="col1">
						<p class="a7 font-malgungothic" style="text-align:center; line-height:normal">
							담당
						</p>
					</td>
					<td class="col1">
						<p class="a7 font-malgungothic" style="text-align:center; line-height:normal">본부장</p>
					</td>
					<td class="col1">
						<p class="a7 font-malgungothic" style="text-align:center; line-height:normal">경영지원</p>
					</td>
					<td class="col1">
						<p class="a7 font-malgungothic" style="text-align:center; line-height:normal">대표</p>
					</td>
				</tr>
				<tr style="height:39.15pt">
					<td class="col1 centered-cell">
						<img src="/image/approval.png" class="centered-image">
					</td>
					<td class="col1"></td>
					<td class="col1"></td>
					<td class="col1"></td>
				</tr>
				<tr style="height:22.05pt">
					<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="1" data-approval-status="03" data-user-id="${sessionScope.userId}" ><c:out value="${sessionScope.username}" /> / <c:out value="${sessionScope.positionNm}" /></td>
					<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="2" data-approval-status="01" data-user-id="${leaderInfo.userId}">${leaderInfo.userName} / ${leaderInfo.positionName}</td>
					<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="3" data-approval-status="01" data-user-id="2015103001">최선영 / 이사</td>
					<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="4" data-approval-status="01" data-user-id="1999103001">이길호 / 대표</td>
				</tr>
			</table>
			<table class="col-table">
				<tr style="height:22.5pt">
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">성&#xa0;&#xa0;&#xa0; 명</p>
					</td>
					<td class="col3"><c:out value="${sessionScope.username}"/></td>
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">직&#xa0;&#xa0;&#xa0; 급</p>
					</td>
					<td class="col3"><c:out value="${sessionScope.positionNm}" /></td>
				</tr>
				<tr style="height:22.55pt">
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">부&#xa0;&#xa0;&#xa0; 서</p>
					</td>
					<td class="col3"><c:out value="${sessionScope.department}" /></td>
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">작성일</p>
					</td>
					<td class="col3">
						<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy년 MM월 dd일" />
					</td>
				</tr>
			</table>
			<!-- 새로운 휴가 신청 부분 추가 -->
			<table class="col-table">
				<tr>
					<td class="col2">유형</td>
					<td colspan="3">
						<div class="checkbox-group">
							<label><input type="checkbox" id="annualLeave" name="vacationType" value="연차" checked> 연차</label>
							<label><input type="checkbox" id="halfDay" name="vacationType" value="반차"> 반차</label>
							<label><input type="checkbox" id="sickLeave" name="vacationType" value="병가"> 병가</label>
							<label><input type="checkbox" id="other" name="vacationType" value="기타"> 기타</label>
						</div>
					</td>
				</tr>
				<tr>
					<td class="col2">기간</td>
					<td colspan="3" class="duration-container">
						<input type="text" class="input-field short daterange" id="startDate" name="startDate" onchange="calculateDuration()" autocomplete="off"> ~
						<input type="text" class="input-field short daterange" id="endDate" name="endDate" onchange="calculateDuration()" autocomplete="off">
						<span>(<span id="duration">0</span> 일간)</span>
					</td>
				</tr>
				<tr>
					<td class="col2">비상연락처</td>
					<td colspan="3"><input type="text" id="emergencyContact" class="input-field no-border" name="emergencyContact" placeholder="연락처 입력" oninput="formatPhoneNumber(this)"></td>
				</tr>
				</tr>
				<tr>
					<td class="col2">개인사유</td>
					<td colspan="3">
						<textarea class="input-field auto-expand" id="personalReason" name="personalReason" placeholder="개인사유" rows="4" style="width:100%; resize:none; text-align:left;"></textarea>
					</td>
				</tr>
			</table>
			<p class="a7 font-malgungothic text-center">* 날짜순으로 순차적으로 작성.</p>
			<p class="a7 font-malgungothic text-center">* 영수증 및 인터넷으로 확인 가능한 사용내역서 첨부</p>
			<p class="a7 font-malgungothic text-center"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy년 MM월 dd일" /></p>
			<p class="a7 font-malgungothic text-center" style="margin-right:9pt;">작성자 : <c:out value="${sessionScope.username}"/></p>
		</div>
		<!-- File upload area -->
		<jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
	</form>
</div>