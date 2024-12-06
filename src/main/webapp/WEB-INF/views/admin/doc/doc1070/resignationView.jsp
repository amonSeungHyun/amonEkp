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

	/* CSS 정리된 스타일 */
	.table-area {
		border:0.75pt solid #000000;
		border-collapse:collapse;
		margin:10px;
		float: left;
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
	/* daterangepicker 내 특정 요일 스타일링 */
	.daterangepicker .calendar-table th:nth-child(1), /* 일요일 */
	.daterangepicker .calendar-table td.weekend:nth-child(1) { /* 일요일 */
		color: red !important;
	}

	.daterangepicker .calendar-table th:nth-child(7), /* 토요일 */
	.daterangepicker .calendar-table td.weekend:nth-child(7) { /* 토요일 */
		color: blue !important;
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
	let today = new Date();

	$(document).ready (function(){
		// 퇴사일에 daterangepicker 적용
		$('#jobEndDate').daterangepicker({
			singleDatePicker: true,
			autoUpdateInput: true,
			autoApply: true,
			locale: {
				format: 'YYYY-MM-DD',
				daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				firstDay: 0
			},
			minDate: today
		});
		// 텍스트 영역 높이 자동 조정
		$('.auto-expand').on('input', function() {
			this.style.height = 'auto'; // 높이 초기화
			this.style.height = (this.scrollHeight) + 'px'; // 내용에 맞춰 높이 조정
		});
		bindEvents();
	});


	function collectResignationData(){
		const data = [];
		const rowData = {
			// amy
			resignationDate: $("#jobEndDate").val(),
			phoneNo: $("#phoneNo").val().replace(/-/g, ''),
			resignationReason: $("#resignationReason").val(),
			docTitle: $("#docTitle").val()
		}
		data.push(rowData);
		return data;
	}
	// 이벤트 바인딩 함수
	function bindEvents() {
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
	<form name="writeFrm">
		<input id="docType" type="hidden" value="04">
		<input id="docTitle" type="hidden" value="사직서">
		<div class="table-area">
			<table class="first-table">
				<tr style="height:17.1pt">
					<td rowspan="3" style="width:211.45pt; border-right:0.75pt solid #000000; padding-right:0.22pt; padding-left:0.6pt; vertical-align:middle">
						<p class="a7" style="text-align:center; line-height:normal; font-size:20pt">
							<strong><span class="font-malgungothic" style="color:#000000">사직서</span></strong>
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
			<table class="col-table">
				<tr style="height:22.55pt">
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">입사일</p>
					</td>
					<td class="col3"><c:out value="${sessionScope.jobStartDate}" /></td>
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">퇴사일</p>
					</td>
					<td class="col3">
						<input type="text" class="input-field short daterange" id="jobEndDate" name="jobEndDate" autocomplete="off" readonly>
					</td>
				</tr>

				<tr>
					<td class="col2" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">연락처</td>
					<td colspan="3">
						<input type="text" class="input-field no-border" id="phoneNo" name="phoneNo" oninput="formatPhoneNumber(this)" placeholder="연락처 입력">
						<%--<c:out value="${sessionScope.phoneNo}" />--%>
					</td>
				</tr>
				<tr>
					<td class="col2" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">퇴사사유</td>
					<td colspan="3">
						<textarea class="input-field auto-expand" id="resignationReason" name="resignationReason" style="width:100%; resize:none; text-align:left;"  placeholder="퇴사사유 입력"></textarea>
					</td>
				</tr>
			</table>
			<p class="a7 font-malgungothic text-center">상가 본인은 위와 같은 사정으로 사직서를 제출하오니 조치하여 주시기 바랍니다.</p>
			<p class="a7 font-malgungothic text-center"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy년 MM월 dd일" /></p>
			<p class="a7 font-malgungothic text-center" style="margin-right:9pt;">작성자 : <c:out value="${sessionScope.username}"/></p>
		</div>
		<!-- File upload area -->
		<jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
	</form>
</div>