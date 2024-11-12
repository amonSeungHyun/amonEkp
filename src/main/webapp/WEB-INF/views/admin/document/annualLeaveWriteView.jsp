<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/views/admin/jihee/writeHeader2.jsp"></jsp:include>

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
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">
	let holidays = [];
	const API_KEY = 'AIzaSyBbeKqVO3mATJcINNGJPyf1a-zrZmWtI0k'; // 여기에 Google API 키를 입력
	const CALENDAR_ID = 'ko.south_korea#holiday@group.v.calendar.google.com';
	$(document).ready (function(){

		$('#startDate, #endDate').daterangepicker({
			singleDatePicker: false,  // 범위 선택을 위해 false로 설정
			locale: {
				format: 'YYYY-MM-DD',
				separator: ' ~ ',
				applyLabel: '적용',
				cancelLabel: '취소',
				daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				firstDay: 1
			}
		}, function(start, end) {
			// daterangepicker의 콜백 함수에서 선택한 날짜 범위를 startDate와 endDate 필드에 설정
			$('#startDate').val(start.format('YYYY-MM-DD'));
			$('#endDate').val(end.format('YYYY-MM-DD'));
			calculateDuration();  // 선택한 날짜 범위로 기간 계산
		});

		$("#file").on('change',function(){
			var fileName = $("#file").val();
			$(".upload-name").val(fileName);
		});

		$("input[name='annualLeave']").on("change", function() {
			// 현재 선택한 체크박스를 제외하고 모두 해제
			$("input[name='annualLeave']").not(this).prop("checked", false);
		});

		$('input[name="annualLeave"]').on("change", function() {
			calculateDuration();
		});

		// 날짜를 선택할 때도 기간을 다시 계산
		$('#startDate, #endDate').on("change", function() {
			calculateDuration();
		});

		// 텍스트 영역 높이 자동 조정
		$('.auto-expand').on('input', function() {
			this.style.height = 'auto'; // 높이 초기화
			this.style.height = (this.scrollHeight) + 'px'; // 내용에 맞춰 높이 조정
		});


	});

	function insertApprovalExpenseDetail() {
		const approvalData = collectApprovalSteps();
		const expenseDetailData = collectAnnualLeaveData();
		if(confirm("결재 신청을 하시겠습니까?")) {
			$.ajax({
				url: '/approval/insertExpenseDetail', // 데이터를 보낼 서버의 URL로 변경
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					approvalData: approvalData,
					expenseDetailData: expenseDetailData
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
	/*결재선 구성 List 함수*/
	function collectApprovalSteps() {
		const approvalData = [];

		// Select all the table cells containing approval steps using jQuery
		$('.approval-step').each(function() {
			const stepData = {
				approvalStepNo: $(this).data('approval-step'),
				userId: $(this).data('user-id')
			};
			approvalData.push(stepData);
		});

		console.log(approvalData);
		return approvalData;
	}


	function collectAnnualLeaveData(){
		const data = [];
		const rowData = {
			// amy
			annualLeave: $("input[name='annualLeave']:checked").val(), // 선택된 유형 추가
			startDate: $("#startDate").val(),
			endDate: $("#endDate").val(),
			emergencyContact: $("#emergencyContact").val(),
			details: $("#details").val()
		};
		data.push(rowData);
		console.log(data); // Logs the list map structure to the console
		return data;
	}

	function calculateDuration() {
		const startDate = $("#startDate").val();
		const endDate = $("#endDate").val();
		const isHalfDay = $("#halfDay").is(":checked");

		if (startDate && endDate) {
			let duration = calculateWorkdaysExcludingHolidays(startDate, endDate);

			if (isHalfDay && duration === 1) {
				duration = 0.5;
			}

			$("#duration").text(duration > 0 ? duration : 0);
		}
	}


	// function calculateDuration() {
	// 	const startDate = $("#startDate").val();
	// 	const endDate = $("#endDate").val();
	// 	const isHalfDay = $("#halfDay").is(":checked"); // 반차 여부 확인
	//
	// 	if (startDate && endDate) {
	// 		const start = new Date(startDate);
	// 		const end = new Date(endDate);
	//
	// 		// 날짜 차이 계산 (밀리초 단위에서 일 단위로 변환)
	// 		let duration = Math.floor((end - start) / (1000 * 60 * 60 * 24)) + 1;
	//
	// 		// 반차 선택 시 하루로 표시되는 경우 0.5일로 변경, 반차가 아닐 경우는 1일로 설정
	// 		if (isHalfDay && duration === 1) {
	// 			duration = 0.5;
	// 		} else if (!isHalfDay && duration === 1) {
	// 			duration = 1;
	// 		}
	//
	// 		// 계산된 기간을 표시
	// 		$("#duration").text(duration > 0 ? duration : 0);
	// 	}
	// }

	function calculateWeekdays(startDate, endDate) {
		const start = new Date(startDate);
		const end = new Date(endDate);
		let weekdaysCount = 0;

		while (start <= end) {
			// 주말인지 확인 (토요일: 6, 일요일: 0)
			const dayOfWeek = start.getDay();
			if (dayOfWeek !== 0 && dayOfWeek !== 6) {
				weekdaysCount++;
			}
			start.setDate(start.getDate() + 1); // 다음 날로 이동
		}

		return weekdaysCount;
	}


	// 공휴일을 서버에서 가져오는 함수
	function loadHolidays() {
		return fetch(`https://www.googleapis.com/calendar/v3/calendars/${CALENDAR_ID}/events?key=${API_KEY}`)
				.then(response => response.json())
				.then(data => {
					if (data.items) {
						holidays = data.items.map(event => ({
							date: event.start.date,
							name: event.summary
						}));
						console.log("Holidays loaded:", holidays); // 데이터 로드 확인용 콘솔 출력
					} else {
						console.error("No holiday data found");
					}
				})
				.catch(error => console.error("Failed to fetch holidays:", error));
	}

	function initializeDatepicker() {
		$("#startDate, #endDate").datepicker({
			dateFormat: "yy.mm.dd",
			beforeShowDay: function (date) {
				const dateString = $.datepicker.formatDate('yy-mm-dd', date);
				const holiday = holidays.find(h => h.date === dateString);

				if (holiday) {
					return [true, "holiday", holiday.name]; // 공휴일 클래스 추가 및 툴팁
				} else if (date.getDay() === 0 || date.getDay() === 6) { // 주말
					return [true, "weekend"];
				}
				return [true, ""];
			},
			onSelect: function () {
				calculateDuration();
			}
		});
	}


	// 이벤트 바인딩 함수
	function bindEvents() {
		$("#file").on('change', function () {
			var fileName = $("#file").val();
			$(".upload-name").val(fileName);
		});

		$("input[name='annualLeave']").on("change", function () {
			$("input[name='annualLeave']").not(this).prop("checked", false);
		});

		$('#startDate, #endDate').on("change", function () {
			calculateDuration();
		});

		$('.auto-expand').on('input', function () {
			this.style.height = 'auto';
			this.style.height = (this.scrollHeight) + 'px';
		});
	}
	// 공휴일 및 주말 제외 근무일 계산 함수
	function calculateWorkdaysExcludingHolidays(startDate, endDate) {
		const start = new Date(startDate);
		const end = new Date(endDate);
		let workdaysCount = 0;

		while (start <= end) {
			const dayOfWeek = start.getDay();
			const isHolidayFlag = isHoliday(start);

			if (dayOfWeek !== 0 && dayOfWeek !== 6 && !isHolidayFlag) {
				workdaysCount++;
			}
			start.setDate(start.getDate() + 1);
		}

		return workdaysCount;
	}

	// 특정 날짜가 공휴일인지 확인하는 함수
	function isHoliday(date) {
		const formattedDate = $.datepicker.formatDate('yy-mm-dd', date);
		return holidays.some(holiday => holiday.date === formattedDate);
	}

</script>
<div class="contai" style="overflow-x: hidden;">
	<form name="writeFrm" enctype="multipart/form-data">
		<div class="table-area">
			<table class="first-table">
				<tr style="height:17.1pt">
					<td rowspan="3" style="width:211.45pt; border-right:0.75pt solid #000000; padding-right:0.22pt; padding-left:0.6pt; vertical-align:middle">
						<p class="a7" style="text-align:center; line-height:normal; font-size:20pt">
							<a href="http://www.yesform.com/z_n/forms/search.php?mrown=IT&amp;free_search=&amp;focus_count=0&amp;focus_cus=0&amp;focus_prev=0&amp;is_show_lvch=1&amp;skwid=&amp;bq=%25C1%25F6%25C3%25E2%25B0%25E1%25C0%25C7%25BC%25AD%25C8%25C4%25BA%25B8%25C0%25DA%25C0%25CC%25B7%25C2%25BC%25AD&amp;isc=&amp;q=%C1%25F" style="text-decoration:none"><strong><span class="font-malgungothic" style="color:#000000">휴가계</span></strong></a>
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
					<td class="col1">확인</td>
					<td class="col1"></td>
					<td class="col1"></td>
					<td class="col1"></td>
				</tr>
				<tr style="height:22.05pt">
					<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal"><c:out value="${sessionScope.username}" /> / <c:out value="${sessionScope.positionNm}" /></td>
					<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="1" data-user-id="${leaderInfo.userId}">${leaderInfo.userName} / ${leaderInfo.positionName}</td>
					<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="2" data-user-id="">최선영 / 이사</td>
					<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="3" data-user-id="">이길호 / 대표</td>
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
							<label><input type="checkbox" id="annualLeave" name="annualLeave" value="연차"
										  <c:if test="${vacationDetails.vacationType eq '연차'}">checked</c:if> disabled> 연차</label>
							<label><input type="checkbox" id="halfDay" name="annualLeave" value="반차"
										  <c:if test="${vacationDetails.vacationType eq '반차'}">checked</c:if> disabled> 반차</label>
							<label><input type="checkbox" id="sickLeave" name="annualLeave" value="병가"
										  <c:if test="${vacationDetails.vacationType eq '병가'}">checked</c:if> disabled> 병가</label>
							<label><input type="checkbox" id="other" name="annualLeave" value="기타"
										  <c:if test="${vacationDetails.vacationType eq '기타'}">checked</c:if> disabled> 기타</label>
						</div>
					</td>
				</tr>

				<tr>
					<td class="col2">기간</td>
					<td colspan="3" class="duration-container">
						<input type="text" class="input-field short daterange" id="startDate" name="startDate" value="${vacationDetails.startDate}" readonly> ~
						<input type="text" class="input-field short daterange" id="endDate" name="endDate" value="${vacationDetails.endDate}" readonly>
						<span>(<span id="duration">${vacationDetails.vacationPeriod}</span> 일간)</span>
					</td>
				</tr>

				<tr>
					<td class="col2">비상연락처</td>
					<td colspan="3">
						<input type="text" id="emergencyContact" class="input-field no-border" name="emergencyContact"
							   value="${vacationDetails.emergencyContact}" readonly>
					</td>
				</tr>

				<tr>
					<td class="col2">개인사유</td>
					<td colspan="3">
						<textarea class="input-field auto-expand" id="details" name="details" readonly>${vacationDetails.personalReason}</textarea>
					</td>
				</tr>

			</table>
			<p class="a7 font-malgungothic text-center">* 날짜순으로 순차적으로 작성.</p>
			<p class="a7 font-malgungothic text-center">* 영수증 및 인터넷으로 확인 가능한 사용내역서 첨부</p>
			<p class="a7 font-malgungothic text-center"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy년 MM월 dd일" /></p>
			<p class="a7 font-malgungothic text-right" style="margin-right:9pt;">작성자 :</p>
		</div>
		<!-- File upload area -->
		<div class="file-area" id="attachArea">
			<div class="filebox">
				<label for="file">파일 찾기</label>
				<input class="upload-name" value="첨부파일" placeholder="첨부파일">
				<input type="file" id="file" multiple="multiple" name="attach">
			</div>
		</div>
	</form>
</div>