<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
<!-- Bootstrap JavaScript 로드 (모달 기능 지원) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap CSS 로드 (스타일링 포함) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<!-- DateRangePicker CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<!-- DateRangePicker JavaScript -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>



<style type="text/css">

	.kind-color {
		border-radius: 100%;
		width: 8px;
		height: 8px;
		flex: 0 0 auto;
		margin-top: 5px;
	}

	.kind-name {
		font-size: 13px;
	}

	ul.ui-autocomplete {
		z-index: 1100;
	}

	nav.top-nav {
		padding-top: 30px;
		padding-right: 40px;
		display: flex;
		align-items: center;
	}

	div.plusUser {
		margin-top: 4px;
		width:100%;
		background-color: #e6e6e6;
		border-radius: 5px;
		margin-right: 4px;
		text-align: center;
	}

	div.plusUser > i {
		cursor: pointer;
	}

	.ui-autocomplete {
		max-height: 100px;
		overflow-y: auto;
	}

	/* ========== full calendar css 시작 ========== */
	.fc-header-toolbar {
		height: 30px;
	}

	a, a:hover, .fc-daygrid {
		color: #000;
		text-decoration: none;
		background-color: transparent;
		cursor: pointer;
	}

	/* 일요일 날짜 빨간색 */
	.fc-day-sun a {
		color: red;
		text-decoration: none;
	}

	/* 토요일 날짜 파란색 */
	.fc-day-sat a {
		color: blue;
		text-decoration: none;
	}

	.fc .fc-button-group>.fc-button {
		background: #07B419;
		border: none;
	}

	.fc-today-button {
		background: #07B419;
		border: none;
	}

	#calendar > div.fc-header-toolbar.fc-toolbar.fc-toolbar-ltr > div:nth-child(1) > button {
		background: #07B419;
		border: none;
	}

	button.fc-dayGridMonth-button.fc-button.fc-button-primary.fc-button-active {
		background: #07B419;
		border: none;
		border-right: 1px solid;
	}

	#calendar {
		height: 800px;
	}

	/* ========== full calendar css 끝 ========== */

	input:focus{
		outline-color: #07B419;
	}

	.form-control:focus {
		box-shadow:none;
		border: 2px solid #07B419;
	}

	.select2-container--bootstrap4.select2-container--focus .select2-selection {
		box-shadow: none;
		border: 2px solid #07B419;
	}

	.select2-container--bootstrap4 .select2-selection--multiple .select2-search__field {
		width: 80% !important;
	}

</style>

<script>
	$(document).ready(function() {
		console.log("캘린더 화면에 들어왔니?");

		let calendarEl = $('#calendar')[0];

		let calendar = new FullCalendar.Calendar(calendarEl, {
			googleCalendarApiKey: 'AIzaSyBbeKqVO3mATJcINNGJPyf1a-zrZmWtI0k',
			selectable: true,
			themeSystem: 'Litera',
			dayMaxEventRows: true,
			headerToolbar: {
				left: 'prev,next today',
				center: 'title',
				right: 'dayGridMonth,timeGridWeek'
			},
			locale: 'ko',
			eventSources: [
				// 서버에서 가져오는 이벤트 소스
				{
					url: '/admin/calendar/selectCalendarList',  // 서버의 이벤트를 가져오는 URL
					method: 'GET',  // HTTP GET 요청으로 서버에서 데이터를 가져옵니다.
					failure: function() {
						alert("Error while fetching events.");  // 데이터 가져오기에 실패했을 때 경고를 표시합니다.
					},
					color: 'white',  // 서버에서 가져오는 이벤트의 기본 색상
					textColor: 'black'  // 서버에서 가져오는 이벤트의 텍스트 색상
				},
				// Google Calendar에서 가져오는 이벤트 소스
				{
					googleCalendarId: 'anrh0213@amonsoft.co.kr',  // 개인 또는 조직 캘린더 ID
					className: 'google_event',  // 이벤트에 적용할 CSS 클래스 이름
					color: '#ffeb3b',  // 노란색으로 표시 (구글 캘린더 이벤트)
					textColor: 'black'
				},
				{
					googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',  // 한국 공휴일 캘린더
					className: 'ko_event',  // 이벤트에 적용할 CSS 클래스 이름
					color: 'white',  // 공휴일 이벤트 배경 색상
					textColor: 'red'  // 공휴일 이벤트 텍스트 색상
				}
			]
			,
			dateClick: function(info) {
				$('#scheduleModal').modal('show');
				$("input[name='start_date']").val(info.dateStr + " 09:00");
				$("input[name='end_date']").val(info.dateStr + " 18:00");

				$('#daterange_register').daterangepicker({
					timePicker: true,
					timePicker24Hour: true,
					startDate: info.dateStr + "09:00",
					endDate: info.dateStr + "18:00",
					locale: {
						format: 'YYYY-MM-DD HH:mm',
						separator: " ~ ",
						applyLabel: "확인",
						cancelLabel: "취소",
						daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
						monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
					}
				}).on('apply.daterangepicker', function(ev, picker) {
					$("input[name='start_date']").val(picker.startDate.format('YYYY-MM-DD HH:mm'));
					$("input[name='end_date']").val(picker.endDate.format('YYYY-MM-DD HH:mm'));
				});
			},
			select: function(info) {
				$('#scheduleModal').modal('show');
				$("input[name='start_date']").val(info.startStr + " 09:00");
				$("input[name='end_date']").val(info.endStr + " 18:00");

				$('#daterange_register').daterangepicker({
					timePicker: true,
					timePicker24Hour: true,
					startDate: info.startStr + "09:00",
					endDate: info.endStr + "18:00",
					locale: {
						format: 'YYYY-MM-DD HH:mm',
						separator: " ~ ",
						applyLabel: "확인",
						cancelLabel: "취소",
						daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
						monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
					}
				}).on('apply.daterangepicker', function(ev, picker) {
					$("input[name='start_date']").val(picker.startDate.format('YYYY-MM-DD HH:mm'));
					$("input[name='end_date']").val(picker.endDate.format('YYYY-MM-DD HH:mm'));
				});
			},
			eventClick: function(info) {
				$('#modify_scheduleModal').modal('show');
				let schedule_no = info.event.id;

				$.ajax({
					url: "/admin/calendar/selectCalendarList",
					data: { "schedule_no": schedule_no },
					dataType: "JSON",
					success: function(json) {
						if (json.redirect === "true") {
							window.location.href = "/admin/calendar/com2010";
						} else {
							let start_date = json.start_date;
							let end_date = json.end_date;
							$("#daterange_modify").val(start_date + " ~ " + end_date);
							$("form[name='schedule_modify_delete'] input[name='start_date']").val(start_date);
							$("form[name='schedule_modify_delete'] input[name='end_date']").val(end_date);

							$('#daterange_modify').daterangepicker({
								timePicker: true,
								timePicker24Hour: true,
								startDate: start_date,
								endDate: end_date,
								locale: {
									format: 'YYYY-MM-DD HH:mm',
									separator: " ~ ",
									applyLabel: "확인",
									cancelLabel: "취소",
									daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
									monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
								}
							}).on('apply.daterangepicker', function(ev, picker) {
								$("form[name='schedule_modify_delete'] input[name='start_date']").val(picker.startDate.format('YYYY-MM-DD HH:mm'));
								$("form[name='schedule_modify_delete'] input[name='end_date']").val(picker.endDate.format('YYYY-MM-DD HH:mm'));
							});

							$("#subject_modify").val(json.subject);
							$("#category_modify").val(json.category);

							if (json.joinuser) {
								let joinuser = json.joinuser.split(",");
								$(".displayUserList").empty();
								$.each(joinuser, function(i, user) {
									$(".displayUserList").append("<div class='plusUser'>" + user + "&nbsp;<i class='fas fa-times-circle x-button'></i></div>");
								});
							}

							$("#place_modify").val(json.place);
							$("#content_modify").val(json.content);
							$("#schedule_no_modify").val(schedule_no);

							let loginuser = '${sessionScope.loginuser.empno}';

							if (json.fk_empno === loginuser || loginuser === "9999") {
								$("#schedule_modify_button, #schedule_delete_button, .x-button").show();
								$("form[name='schedule_modify_delete'] input, form[name='schedule_modify_delete'] select, form[name='schedule_modify_delete'] textarea").prop("readonly", false).prop("disabled", false);
							} else {
								$("#schedule_modify_button, #schedule_delete_button, .x-button").hide();
								$("form[name='schedule_modify_delete'] input, form[name='schedule_modify_delete'] select, form[name='schedule_modify_delete'] textarea").prop("readonly", true).prop("disabled", true);
							}
						}
					},
					error: function(request, status, error) {
						console.log("code: " + request.status + "\nmessage: " + request.responseText + "\nerror: " + error);
					}
				});
			}
		});

		calendar.render();

		$("#schedule_register_button").click(function() {
			let daterange = $("#daterange_register").val().trim();
			if (!daterange) {
				toastr.warning('기간을 선택해주세요');
				return;
			}

			let subject = $("form[name='schedule_register'] input[name='subject']").val().trim();
			if (!subject) {
				toastr.warning('제목을 입력해주세요');
				return;
			}

			let joinuser = $(".displayUserList .plusUser").map(function() {
				return $(this).text().trim();
			}).get().join(",");
			$("form[name='schedule_register'] input[name='joinuser']").val(joinuser);

			let place = $("form[name='schedule_register'] input[name='place']").val().trim();
			if (!place) {
				toastr.warning('장소를 입력해주세요');
				return;
			}

			let content = $("form[name='schedule_register'] textarea[name='content']").val().trim();
			if (!content) {
				toastr.warning('내용을 입력해주세요');
				return;
			}

			$.ajax({
				url: "/schedule/insertSchedule.yolo",
				type: "POST",
				data: $("form[name='schedule_register']").serialize(),
				dataType: "JSON",
				success: function(json) {
					if (json.n === 1) {
						toastr.success('스케줄 등록 성공');
						setTimeout(function() {
							location.href = '/schedule/calendar.yolo';
						}, 1000);
					} else {
						toastr.error('스케줄 등록 실패');
					}
				}
			});
		});
	});

	function add_joinUser(value) {
		let plusUser_es = $(".displayUserList .plusUser").text();
		if (plusUser_es.includes(value)) {
			toastr.error('이미 추가한 회원입니다.');
		} else {
			$(".displayUserList").append("<div class='plusUser'>" + value + "&nbsp;<i class='fas fa-times-circle x-button'></i></div>");
			$("input#joinuser_register").val("");
		}
	}

	function calendarSet(arg) {
		let kind_calendar = $("#kind-calendar").val();
		if (kind_calendar === "0") {
			$(arg.el).show();
		} else if (arg.event.extendedProps.cid === 1) {
			$(arg.el).show();
		} else {
			$(arg.el).hide();
		}
	}

</script>


<div style="width: 90%; margin : 0 5% 0 5%;">
	<nav class="top-nav border-bottom mb-3" style="width: 80%">
		<span class="text-muted h4 font-weight-bold">캘린더</span>
	</nav>

	<div class="mb-4 d-flex" style="width: 80%;">
		<select id="kind-calendar" class="custom-select custom-select-sm" style="width: 125px;">
			<option value="0">전체 조직</option>
			<option value="1">내가 속한 조직</option>
		</select>
		<div style="margin-left: auto; margin-top: 6px">
			<div class="d-flex">
				<div class="kind-color mr-1" style="background: #ffd699;"></div>
				<span class="kind-name mr-3">미팅</span>
				<div class="kind-color mr-1" style="background: #bfbfbf;"></div>
				<span class="kind-name mr-3">출장</span>
				<div class="kind-color mr-1" style="background: #6666ff;"></div>
				<span class="kind-name mr-3">회의</span>
				<div class="kind-color mr-1" style="background: #b380ff;"></div>
				<span class="kind-name">휴가</span>
				<div class="kind-color mr-1" style="background: #b380ff;"></div>
				<span class="kind-name">휴가</span>
			</div>
		</div>
	</div>

	<div id='calendar' style="width: 80%;"></div>
</div>


<!-- register Modal -->
<div class="modal fade" id="scheduleModal" tabindex="-1" role="dialog" aria-labelledby="registerModalTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="registerModalTitle">일정 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form name="schedule_register" id="schedule_register_form">
				<div class="modal-body">
					<div class="form-group" id="daterange-group-register">
						<label>기간<span style="color: red;">＊</span></label><br>
						<input type="text" id="daterange_register" class="form-control text-center">
						<input type="hidden" name="start_date" class="form-control text-center">
						<input type="hidden" name="end_date" class="form-control text-center">
					</div>
					<div class="form-group" id="subject-group-register">
						<label>제목<span style="color: red;">＊</span></label><br>
						<input type="text" name="subject" class="form-control btn-custom">
					</div>
					<div class="form-group">
						<label for="category_register">분류<span style="color: red;">＊</span></label>
						<select name="category" id="category_register" class="custom-select">
							<option>출장</option>
							<option>회의</option>
							<option>미팅</option>
						</select>
					</div>
					<div class="form-group">
						<label>공유자:</label>
						<input type="text" class="form-control" id="joinuser_register" placeholder="일정을 공유할 회원명을 입력하세요">
						<div class="displayUserList mt-1"></div>
						<input type="hidden" name="joinuser"/>
						<input type="hidden" name="joinuser_empno"/>
					</div>
					<div class="form-group">
						<label>장소<span style="color: red;">＊</span></label>
						<input type="text" name="place" class="form-control">
					</div>
					<div class="form-group">
						<label>내용<span style="color: red;">＊</span></label>
						<textarea name="content" class="form-control" rows="5"></textarea>
					</div>
					<div class="form-group">
						<input type="hidden" name="fk_empno" value="${sessionScope.loginuser.empno}"/>
						<input type="hidden" name="fk_deptno" value="${sessionScope.loginuser.fk_deptno}"/>
					</div>
				</div>
			</form>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="schedule_register_button">등록</button>
			</div>
		</div>
	</div>
</div>

<!-- Modify,Delete Modal -->
<div class="modal fade" id="modify_scheduleModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modifyModalTitle">일정 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form name="schedule_modify_delete" id="schedule_modify_delete_form">
				<div class="modal-body">
					<div class="form-group" id="daterange-group-modify">
						<label for="daterange_modify">기간<span style="color: red;">＊</span></label><br>
						<input type="text" id="daterange_modify" class="form-control text-center">
						<input type="hidden" name="start_date" class="form-control text-center">
						<input type="hidden" name="end_date" class="form-control text-center">
					</div>
					<div class="form-group" id="subject-group-modify">
						<label for="subject_modify">제목<span style="color: red;">＊</span></label><br>
						<input type="text" name="subject" class="form-control" id="subject_modify">
					</div>
					<div class="form-group">
						<label for="category_modify">분류<span style="color: red;">＊</span></label>
						<select name="category" id="category_modify" class="custom-select">
							<option>출장</option>
							<option>회의</option>
							<option>미팅</option>
						</select>
					</div>
					<div class="form-group">
						<label>공유자:</label>
						<input type="text" class="form-control" id="joinuser_modify" placeholder="일정을 공유할 회원명을 입력하세요">
						<div class="displayUserList mt-1"></div>
						<input type="hidden" name="joinuser"/>
						<input type="hidden" name="joinuser_empno"/>
					</div>
					<div class="form-group">
						<label>장소<span style="color: red;">＊</span></label>
						<input type="text" name="place" class="form-control" id="place_modify">
					</div>
					<div class="form-group">
						<label>내용<span style="color: red;">＊</span></label>
						<textarea name="content" class="form-control" rows="5" id="content_modify"></textarea>
					</div>
					<div class="form-group">
						<input type="hidden" name="schedule_no" id="schedule_no_modify"/>
					</div>
				</div>
			</form>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="schedule_modify_button">수정</button>
				<button type="button" class="btn btn-danger" id="schedule_delete_button">삭제</button>
			</div>
		</div>
	</div>
</div>

