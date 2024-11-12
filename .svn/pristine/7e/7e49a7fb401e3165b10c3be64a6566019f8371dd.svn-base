<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- CSS 파일 import -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/member.css"/>
<link rel="stylesheet" type="text/css" href="/css/common.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	// 전역 변수 선언
	let isEditMode = false;
	let currentMemberData = {};
	let page = 1;     // 기본 페이지 번호 설정
	let size = 10;    // 기본 페이지 크기 설정
	let pageNum = 1;     // 페이지 번호 전역 변수
	let pageSize = 5;    // 페이지 크기 전역 변수
	let searchDepart = "";
	let searchPosition = "";
	let searchWord = "";

	$(document).ready(function(){
		selectDepartmentBox();
		selectPositionBox();
		selectMemberList();

		<%-- bootstrap 툴팁 --%>
		$(function () {
			$('[data-toggle="tooltip"]').tooltip();
		});
		<%-- bootstrap 드롭다운 multi level --%>
		$('.dropdown-toggle').dropdown();

		<%-- ===== 달력 하나만 출력 시작 =====  --%>
		$("input.daterange").daterangepicker({
			"singleDatePicker": true,
			"locale": {
				"format": "YYYY-MM-DD", // 날짜표현 형식
				"separator": " - ",
				"applyLabel": "선택",
				"cancelLabel": "취소",
				"fromLabel": "From",
				"toLabel": "To",
				"customRangeLabel": "Custom",
				"weekLabel": "W",
				"daysOfWeek": ["일","월","화","수","목","금","토"],
				"monthNames": ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
				"firstDay": 1
			}
		});
		<%-- ===== 달력 하나만 출력 끝 =====  --%>

		// 구성원 등록 모달에서 드롭다운으로 나오는 속성 클릭 시
		$(document).on("click","button.btn_label",function(){
			let selected = $(this).text();
			let val = $(this).find("input.input_registValue").val();

			// if($(this).hasClass("selectedDepartment")){
			// 	console.log("부서 :", val);
			// 	console.log("부서 :", selected);
			// 	$(this).parent().parent().find("input.selected").val(val); // 전송을 위해 input 태그에 값 입력
			// 	$(this).parent().parent().find("div.regist_value").text(selected);
			// } else if($(this).hasClass("selectedPositionCode")){
			// 	console.log("부서 :", val);
			// 	console.log("부서 :", selected);
			// 	$(this).parent().parent().find("input.selected").val(val); // 전송을 위해 input 태그에 값 입력
			// 	$(this).parent().parent().find("div.regist_value").text(selected);
			// } else{
			// 	console.log("부서 :", val);
			// 	console.log("부서 :", selected);
				$(this).parent().parent().find("input.selected").val(val); // 전송을 위해 input 태그에 값 입력
				$(this).parent().parent().find("div.regist_value").text(selected);
			// }
		});

		// 구성원 등록 모달 닫기 시
		$('.modal').on('hidden.bs.modal', function (e) {
			$(this).find('form')[0].reset();
		});

		// 구성원 추가하기 버튼 클릭시
		$(document).on("click","button#registMember",function(){
			isEditMode = false; // 추가 모드로 설정
			currentMemberData = {}; // 초기화
			$("#modalTitle").text("구성원 등록");
			$("#modalButtonLabel").text("입력완료");
			$("#regist_frm")[0].reset(); // 폼 초기화
			$("#userId").val(""); // 사용자 ID 초기화

			departmentList(); // 부서 조회
			positionList(); // 직위 조회
			roleList(); // 권한 조회

			$("#modal_registMember").modal("show"); // 모달 열기
		});

		// 테이블 행 클릭 시 수정 모드로 전환하고 데이터 로드
		$(document).on("click", "#contentList tbody tr", function() {

			// 체크박스, 초기화 버튼, 체크박스나 초기화 버튼이 포함된 td를 클릭한 경우 이벤트 중지
			if (
					$(event.target).is(".row-check") ||
					$(event.target).is(".reset-password-btn") || // 초기화 버튼 클릭 시
					$(event.target).closest("td").find(".row-check").length > 0 ||
					$(event.target).closest("td").find(".reset-password-btn").length > 0 // 초기화 버튼 포함된 td 클릭 시
			) {
				return; // 체크박스, 초기화 버튼, 해당 요소가 포함된 td를 클릭한 경우 모달을 띄우지 않음
			}

			isEditMode = true; // 수정 모드로 설정
			$("#modalTitle").text("구성원 수정");
			$("#modalButtonLabel").text("수정 완료");

			const rowData = $(this).data("memberData"); // 추가된 부분: 행 데이터 저장
			currentMemberData = rowData; // 현재 수정할 구성원 데이터를 저장
			console.log("12312312312",rowData);
			// 기존 데이터 모달에 설정
			$("#userId").val(rowData.userId);
			$("input[name='name']").val(rowData.userName);
			$("input[name='email']").val(rowData.email);
			$("input[name='hireDate']").val(rowData.jobStartDate);
			$("input[name='quitDate']").val(rowData.jobEndDate);
			$("input[name='phoneNo']").val(rowData.phoneNo);

			// 주소 데이터 세팅 추가
			$("#address").val(rowData.address); // 주소 세팅
			$("#addressDetails").val(rowData.addressDetails); // 상세 주소 세팅

			// 부서, 직위, 권한 목록 조회 후, 선택된 값 설정
			departmentList(rowData.organizationId);
			positionList(rowData.positionCode);
			roleList(rowData.role);

			// 모달 열기
			$("#modal_registMember").modal("show");
		});

		// 추가/수정 완료 버튼 클릭 시
		$("#regist_member_btn").click(function() {
			if (isEditMode) {
				updateEmployee(); // 수정 모드일 때 업데이트 함수 호출
			} else {
				registEmployee(); // 추가 모드일 때 등록 함수 호출
			}
		});

		$(document).on("click","div#modal_registMember button.dropdown-item",function(){

		});

		// 검색어 입력 후 엔터키 입력 시 검색 실행
		$('#searchWord').on('keypress', function(e) {
			if (e.which === 13) { // Enter key
				searchMembers();
			}
		});

		// 돋보기 버튼 클릭 시 검색 실행
		$('#btn_search').on('click', function() {
			searchMembers();
		});

		// 체크박스 클릭시
		$("#checkAll").on("click", function(){
			//전체 선택 체크박스가 체크된 상태인지 확인
			const isChecked = $(this).prop("checked");

			//tbody안에 있는 모든 체크박스를 isChecked 값에 따라 체크 또는 해제
			$("#contentList tbody input[type='checkbox']").prop("checked", isChecked);
		});

		// 체크박스 클릭 시 해당 userId를 기반으로 삭제 요청을 보내는 코드
		$(document).on("click", ".row-check", function() {
			if (!$(this).is(":checked")) {
				$("#checkAll").prop("checked", false); // 개별 체크 해제 시 전체 선택 해제
			}
			// 모든 개별 체크박스가 체크된 경우 전체 선택 체크박스 체크
			else if ($("#contentList tbody input[type='checkbox']:checked").length === $("#contentList tbody input[type='checkbox']").length) {
				$("#checkAll").prop("checked", true);
			}
		});

		// 주소 input 필드 클릭 시 searchAddress 함수 호출
		// $("#address").on("click", function() {
		// 	searchAddress(); // 주소 검색 함수 호출
		// })

	});// end of $(document).ready(function(){}------------------------------------------------

	// 검색어를 사용하여 selectMemberList 호출
	function searchMembers() {
		searchDepart = $('#searchDepart').val(); // 검색어 가져오기
		searchPosition = $('#searchPosition').val(); // 검색어 가져오기
		searchWord = $('#searchWord').val(); // 검색어 가져오기
		selectMemberList(searchDepart, searchPosition, searchWord); // 검색어를 인자로 전달하여 selectMemberList 호출
	}







	// ############################################ 구성원 추가하기 모달 #########################################################
	//
	function selectMemberList(searchDepart = "", searchPosition = "", searchWord = "", pageNum = 1, pageSize = 10) {

		page = pageNum;
		size = pageSize;

		$.ajax({
			type: "POST",
			url: "/admin/members/selectMemberList",
			dataType: "json",
			// contentType: "application/json",
			data: {
				searchDepart : searchDepart,
				searchPosition : searchPosition,
				searchWord : searchWord,
				pageNum: pageNum,
				pageSize: pageSize
			},
			success: function(data) {
				let tableBody = $("#contentList tbody");
				tableBody.empty();  // 기존 데이터를 지우고 새로운 데이터를 추가

				if (data.resultList.length > 0) {
					$("#totalCountText").text("총 " + data.pager.totalCnt + " 건");
				} else {
					$("#totalCountText").text("총 0 건");
				}

				console.log("dfsadf");
				console.log("dfsadf", data.resultList);
				$.each(data.resultList, function(index, item) {
					console.log("조회 리스트 userId : ", item.userId);
					// 테이블 행에 data 속성으로 각 데이터 항목을 추가합니다.
					let rowHtml = $('<tr>')
							.attr('data-member-data', JSON.stringify(item)) // 각 행에 데이터 바인딩
							.append('<td><input type="checkbox" class="row-check"/></td>') // 체크박스 추가
							.append('<td>' + item.userName + '</td>')
							.append('<td>' + item.userId + '</td>')
							.append('<td>' + item.employmentStatusNm + '</td>')
							.append('<td>' + item.positionNm + '</td>')
							.append('<td>' + item.department + '</td>')
							.append('<td>' + item.jobStartDate + '</td>')
							.append('<td>' + item.jobEndDate + '</td>')
							.append('<td>' + item.phoneNo + '</td>')
							// .append('<td>' + item.address + item.addressDetails + '</td>')
							.append('<td class="address-cell" title="' + item.address + ' ' + item.addressDetails + '">' + item.address + ' ' + item.addressDetails + '</td>')
							// .append('<td>' + item.address + '<br>' + item.addressDetails + '</td>') // 두 줄로 표시
							.append('<td><button class="reset-password-btn" onclick="resetPassword(\'' + item.userId + '\')">초기화</button></td>');
					tableBody.append(rowHtml);
				});
				// 페이징 표시 함수 호출
				pageNumDisplay(data.pager, searchDepart, searchPosition, searchWord);
			},
			error: function(xhr, status, error) {
				console.error("데이터 조회 실패:", error);
			}
		});
	}

	function pageNumDisplay(pager, searchDepart, searchPosition, searchWord) {
		var html = '';

		// 이전 버튼
		if (pager.startPage > pager.blockSize) {
			html += '<a href="javascript:selectMemberList(\'' + searchDepart + '\', \'' + searchPosition + '\', \'' + searchWord + '\', ' + pager.prevPage + ', ' + size + ');" class="" style="padding-top: 3px;"><button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&lt;</button></a>';
		}

		// 페이지번호
		for (var i = pager.startPage; i <= pager.endPage; i++) {
			if (pager.pageNum !== i) {
				html += '<a class="page-num box" href="javascript:selectMemberList(\'' + searchDepart + '\', \'' + searchPosition + '\', \'' + searchWord + '\', ' + i + ', ' + size + ');">' + i + '</a>';
			} else {
				html += '<a class="page-num is-active" disabled>' + i + '</a>';
			}
		}

		// 다음 버튼
		if (pager.endPage < pager.totalPage) {
			html += '<a href="javascript:selectMemberList(\'' + searchDepart + '\', \'' + searchPosition + '\', \'' + searchWord + '\', ' + pager.nextPage + ', ' + size + ');" class="" style="padding-top: 3px;"><button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&gt;</button></a>';
		}

		$("#pageNumDiv").html(html);
	}


	// 비밀번호 초기화
	function resetPassword(userId) {
		console.log("비밀번호 초기화 : ", userId);
		const confirmReset = confirm("해당 사용자의 비밀번호를 초기화하시겠습니까?");
		if (!confirmReset) return;

		$.ajax({
			url: "/admin/members/resetPassword",
			type: "POST",
			data: { userId: userId },
			success: function(response) {
				Swal.fire({
					icon: 'success',
					title: '비밀번호 초기화 성공',
					text: '비밀번호가 성공적으로 초기화되었습니다.'
				});
			},
			error: function(xhr, status, error) {
				console.error("비밀번호 초기화 실패:", error);
				Swal.fire({
					icon: 'error',
					title: '비밀번호 초기화 실패',
					text: '비밀번호 초기화 중 오류가 발생했습니다.'
				});
			}
		});
	}



	// 부서리스트
	function departmentList(selectedDepartment){
		$.ajax({
			url: '/admin/members/departmentList',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				const $dropdown = $('#div_department');
				$dropdown.empty(); // 기존 항목 초기화

				console.log("부서 리스트 : ", data);

				$.each(data, function(index, department) {
					const $button = $('<button></button>')
							.addClass('btn_label dropdown-item selectedDepartment')
							.attr('type', 'button');

					const $hiddenInput = $('<input>')
							.attr('type', 'hidden')
							.addClass('input_registValue')
							.val(department.codeDetailNumber);

					$button.append($hiddenInput).append(department.codeDetailName);

					$button.on('click', function() {
						$('#department').val(department.codeDetailNumber);
						$('#title_department .regist_value').text(department.codeDetailName);
					});

					$dropdown.append($button);
				});

				// 수정 모드일 경우, 선택된 값 설정
				if (selectedDepartment) {
					$('#department').val(selectedDepartment);
					const selectedName = data.find(dept => dept.codeDetailNumber === selectedDepartment).codeDetailName;
					$('#title_department .regist_value').text(selectedName);
				}

			},
			error: function(xhr, status, error) {
				console.error('Error fetching departments:', error);
			}
		});
	}

	// 직위리스트
	function positionList(selectedPosition){
		$.ajax({
			url: '/admin/members/positionList',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				const $dropdown = $('#div_position');
				$dropdown.empty(); // 기존 항목 초기화

				console.log("직위 리스트 : ", data);

				$.each(data, function(index, position) {
					const $button = $('<button></button>')
							.addClass('btn_label dropdown-item selectedPositionCode')
							.attr('type', 'button');

					const $hiddenInput = $('<input>')
							.attr('type', 'hidden')
							.addClass('input_registValue')
							.val(position.codeDetailNumber);

					$button.append($hiddenInput).append(position.codeDetailName);

					$button.on('click', function() {
						$('#positionCode').val(position.codeDetailNumber);
						$('#title_positionCode .regist_value').text(position.codeDetailName);
					});

					$dropdown.append($button);
				});

				// 수정 모드일 경우, 선택된 값 설정
				if (selectedPosition) {
					$('#positionCode').val(selectedPosition);
					const selectedName = data.find(pos => pos.codeDetailNumber === selectedPosition).codeDetailName;
					$('#title_positionCode .regist_value').text(selectedName);
				}

			},
			error: function(xhr, status, error) {
				console.error('Error fetching departments:', error);
			}
		});
	}

	// 권한리스트
	function roleList(selectedRole){
		$.ajax({
			url: '/admin/members/roleList',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				const $dropdown = $('#div_role');
				$dropdown.empty(); // 기존 항목 초기화

				console.log("권한 리스트 : ", data);

				$.each(data, function(index, role) {
					const $button = $('<button></button>')
							.addClass('btn_label dropdown-item selectedRole')
							.attr('type', 'button');

					const $hiddenInput = $('<input>')
							.attr('type', 'hidden')
							.addClass('input_registValue')
							.val(role.codeDetailNumber);

					$button.append($hiddenInput).append(role.codeDetailName);

					$button.on('click', function() {
						$('#role').val(role.codeDetailNumber);
						$('#title_role .regist_value').text(role.codeDetailName);
					});

					$dropdown.append($button);
				});

				// 수정 모드일 경우, 선택된 값 설정
				if (selectedRole) {
					$('#role').val(selectedRole);
					const selectedName = data.find(r => r.codeDetailNumber === selectedRole).codeDetailName;
					$('#title_role .regist_value').text(selectedName);
				}

			},
			error: function(xhr, status, error) {
				console.error('Error fetching departments:', error);
			}
		});
	}

	// 신규 사원 등록하는 메소드(amy등록)
	function registEmployee(){

		let regist_flag = true;

		let name = $("input[name='name']").val();
		let email = $("input[name='email']").val();
		let hireDate = $("input[name='hireDate']").val();
		let phoneNo = $("input[name='phoneNo']").val();
		let department = $("input[name='department']").val();
		let position = $("input[name='positionCode']").val();
		let role = $("input[name='role']").val();
		let address = $("input[name='address']").val(); // 추가된 주소 필드


		if(name.trim() == "" || hireDate.trim()==""|| phoneNo.trim() == "" ||department.trim() == "" || position.trim() == "" ){
			regist_flag = false;
			Swal.fire({
				icon: 'warning',
				title: '필수 정보를 입력해주세요.',
				text: '필수 정보를 입력해주세요.'
			});
		}

		let formValues = $("form[name=regist_frm]").serialize() ;
		if(regist_flag) {
			Swal.fire({
				title: '등록하시겠습니까?',
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '등록',
				cancelButtonText: '취소'
			}).then((result) => {
				if (result.isConfirmed) { // 값이 모두 입력된 경우
					$.ajax({
						url: "/admin/members/insertMember",
						data: formValues,
						type: "POST",
						dataType: "JSON",
						success: function (json) {
							Swal.fire({
								icon: 'success',
								title: '입력 완료',
								text: '데이터가 성공적으로 저장되었습니다.'
							});
							$('#modal_registMember').modal('hide'); // 모달을 닫기
							selectMemberList();
							// window.location.reload(); // 페이지 새로고침 (필요시)

							// if(json.duplicateEmail == 1){
							// 	alert('중복된 이메일입니다.');
							// 	return;
							// }
							// else{
							// 	if(json.registResult == 1){
							// 		alert('가입 성공!');
							// 		window.location.reload();
							// 	}
							// }

						},
						error: function (request, status, error) {
							Swal.fire({
								icon: 'error',
								title: '오류 발생',
								text: '데이터 저장에 실패했습니다.'
							});
						}
					}); // end of ajax{}-------------------

				}
			});
		}
	}

	// 삭제
	function deleteMember() {

		// 선택된 모든 체크박스의 userId 값을 배열로 수집
		const selectedUserIds = [];
		$("#contentList tbody input[type='checkbox']:checked").each(function () {
			const rowData = $(this).closest("tr").data("memberData"); // tr에 저장된 data-member-data 속성 가져오기
			selectedUserIds.push(rowData.userId);
		});

		if (selectedUserIds.length === 0) {
			Swal.fire({
				icon: 'warning',
				title: '삭제할 항목을 선택하세요.',
				text: '삭제할 데이터를 먼저 선택해주세요.'
			});
			// alert("삭제할 항목을 선택하세요.");
			return;
		}

		// 삭제 확인 메시지
		Swal.fire({
			title: '삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '삭제',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: "/admin/members/deleteMember",
					type: "POST",
					contentType: "application/json",
					data: JSON.stringify({userIds: selectedUserIds}),
					success: function (response) {
						Swal.fire({
							icon: 'success',
							title: '삭제 완료',
							text: '선택된 항목이 삭제되었습니다.'
						});
						selectMemberList(); // 목록 새로고침
					},
					error: function (xhr, status, error) {
						console.error("삭제 요청 실패:", error);
						Swal.fire({
							icon: 'error',
							title: '삭제 실패',
							text: '삭제에 실패했습니다.'
						});
					}
				});
			}
		});

	}


	// 구성원 정보 수정 함수 (추가된 부분)
	function updateEmployee() {
		let formValues = $("form[name=regist_frm]").serialize();

		Swal.fire({
			title: '수정하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '수정',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: "/admin/members/updateMember", // 서버에 수정 요청
					data: formValues,
					type: "POST",
					dataType: "JSON",
					success: function (response) {
						Swal.fire({
							icon: 'success',
							title: '수정 완료',
							text: '구성원 수정 완료했습니다.'
						});
						$("#modal_registMember").modal("hide");
						selectMemberList();
						// window.location.reload();
					},
					error: function (request, status, error) {
						Swal.fire({
							icon: 'success',
							title: '수정 실패',
							text: '구성원 수정 실패했습니다.'
						});
					}
				});
			}
		});
	}

	// 연락처 - 추가
	function formatPhoneNumber(input) {
		let value = input.value.replace(/[^0-9]/g, ''); // 숫자만 남기기

		if (value.length > 11) {
			let formattedValue = value.slice(0, 11).replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
			input.value = formattedValue;
			Swal.fire({
				icon: 'warning',
				title: '데이터 오류',
				text: '전화번호는 최대 11자리까지만 입력 가능합니다.'
			});
			return;
		}

		if (value.length >= 3 && value.length <= 7) {
			input.value = value.replace(/(\d{3})(\d{1,4})/, '$1-$2');
		} else if (value.length > 7) {
			input.value = value.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
		}
	}

	function searchAddress() {
		new daum.Postcode({
			oncomplete: function(data) {
				// 선택한 주소를 기본 주소 필드에 입력
				$("#address").val(data.address);
				$("#addressDetails").focus(); // 상세 주소 입력 필드로 포커스 이동
			}
		}).open();
	}

	// ######################################## 모달 공통 조회 #######################################
	// 부서리스트
	function selectDepartmentBox(){
		$.ajax({
			url: '/admin/members/departmentList',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				let departNm = $("#searchDepart");
				departNm.empty();
				departNm.append('<option value="">전체</option>');

				$.each(data, function(index, item) {
							let option = $('<option></option>').attr("value", item.codeDetailNumber).text(item.codeDetailName);
					departNm.append(option);
				});
			},
			error: function(xhr, status, error) {
					console.error("데이터 조회 실패:", error);
			}
		});
	}

	// 직위리스트
	function selectPositionBox(){
		$.ajax({
			url: '/admin/members/positionList',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				let positionNm = $("#searchPosition");
				positionNm.empty();
				positionNm.append('<option value="">전체</option>');

				$.each(data, function(index, item) {
					let option = $('<option></option>').attr("value", item.codeDetailNumber).text(item.codeDetailName);
					positionNm.append(option);
				});
			},
			error: function(xhr, status, error) {
				console.error('Error fetching departments:', error);
			}
		});
	}

	// 권한리스트
	function selectRoleBox(){
		$.ajax({
			url: '/admin/members/roleList',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				const $dropdown = $('#div_role');
				$dropdown.empty(); // 기존 항목 초기화

				console.log("권한 리스트 : ", data);

				$.each(data, function(index, department) {
					const $button = $('<button></button>')
							.addClass('btn_label dropdown-item selectedRole')
							.attr('type', 'button');

					const $hiddenInput = $('<input>')
							.attr('type', 'hidden')
							.addClass('input_registValue')
							.val(department.codeDetailNumber);

					$button.append($hiddenInput).append(department.codeDetailName);

					$button.on('click', function() {
						$('#role').val(department.codeDetailNumber);
						$('#title_role .regist_value').text(department.codeDetailName);
					});

					$dropdown.append($button);
				});
			},
			error: function(xhr, status, error) {
				console.error('Error fetching departments:', error);
			}
		});
	}

</script>

<div id="peopleContent">
	<div id="header">
		<div id="header_title">
			<a class="current" href="/admin/members/com7050"><span class="memberTitle">구성원</span></a>
<%--			<a class="a_title" href="/organization_chart.yolo"><span class="title">조직도</span></a>--%>
<%--			<a class="a_title" href="/change_history.yolo"><span class="title">인사 정보 관리</span></a>--%>
		</div>
		<div id="button_title">
			<button id="registMember" type="button" class="btn" data-toggle="modal" data-target="#modal_registMember">
				<span>
					<i class="fas fa-plus" style="margin: 0px; width: 20px;"></i>&nbsp;&nbsp;구성원 추가하기
				</span>
			</button>

		</div>
	</div>
	<!-- ========================== 구성원 추가/수정 모달 시작 ========================== -->
	<div class="modal fade" id="modal_registMember">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content" style="padding: 5px;">
				<!-- Modal header -->
				<div class="modal-header">
					<h2 id="modalTitle">구성원 등록</h2>
					<button id="btn_close_registModal" type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form id="regist_frm" name="regist_frm">
						<input type="hidden" name="userId" id="userId" /> <!-- 추가된 부분: 사용자 ID 저장 -->
						<div id="div_regist">
							<div style="display: flex; justify-content: space-between;">
								<div>
									<div class="regitst_title"> 이름<span style="color: red;">*</span>
									</div>
									<input name="name" class="input_modal" type="text" autocomplete="off" placeholder="이름 입력" maxlength="15" />
								</div>
								<div>
									<div class="regitst_title">
										이메일
									</div>
									<input name="email" class="input_modal" type="text" autocomplete="off" placeholder="이메일 입력" maxlength="50" />
								</div>
							</div>

							<div style="margin: 10px 0;">
								<%-- daterange --%>
								<div class="regitst_title">
									입사일<span style="color: red;">*</span>
								</div>
								<input name="hireDate" type="text" class="input_modal daterange" autocomplete="off"  placeholder="입사일 입력"></input>
							</div>

							<div style="margin: 10px 0;">
								<%-- daterange --%>
								<div class="regitst_title">
									퇴사일
								</div>
								<input name="quitDate" type="text" class="input_modal daterange" autocomplete="off"  placeholder="퇴사일 입력"></input>
							</div>

							<div>
								<div class="regitst_title">
									연락처<span style="color: red;">*</span>
								</div>
								<input name="phoneNo" class="input_modal" type="text"
									   autocomplete="off" placeholder="연락처 입력" oninput="formatPhoneNumber(this);" maxlength="13" />
							</div>

							<!-- 주소 검색 필드 추가 -->
							<div style="margin-top: 10px;">
								<label for="address" class="regitst_title">주소</label>
								<div id="addressContainer">
									<input id="address" name="address" type="text" placeholder="주소 검색을 통해 입력" class="input_modal" readonly />
									<button type="button" id="addressSearchButton" onclick="searchAddress()">주소 검색</button>
								</div>
							</div>

							<div style="margin-top: 10px;">
								<input id="addressDetails" name="addressDetails" type="text" placeholder="상세 주소 입력" class="input_modal" />
							</div>



						<%-- =========== 부서 선택 =========== --%>
							<div style="margin: 10px 0;">
								<div class="regitst_title">부서<span style="color: red;">*</span></div>
								<input class="selected" type="hidden" name="department" id="department" />

								<button id="btn" class="btn choice_type" type="button" data-toggle="dropdown">
									<div id="title_department" style="display: flex; justify-content: space-between;">
										<div class="regist_value">부서 선택</div>
										<i class="fas fa-bars" style="padding: 5px;"></i>
									</div>
								</button>

								<div id="div_department" class="dropdown-menu"></div>
							</div>
							<%-- =========== 부서 선택 =========== --%>

							<%-- =========== 직위 선택 =========== --%>
							<div style="margin: 10px 0;">
								<div class="regitst_title">직위 선택<span style="color: red;">*</span></div>
								<input class="selected" type="hidden" name="positionCode" id="positionCode" />

								<button id="btn2" class=" btn choice_type" type="button"
										data-toggle="dropdown">
									<div id="title_positionCode" style="display: flex; justify-content: space-between;">
										<div class="regist_value">직위 선택</div>
										<i class="fas fa-bars" style="padding: 5px;"></i>
									</div>
								</button>

								<div id="div_position" class="dropdown-menu">
								</div>
							</div>
							<%-- =========== 직위 선택 =========== --%>

							<%-- =========== 권한 선택 =========== --%>
							<div style="margin: 10px 0;">
								<div class="regitst_title">권한 선택<span style="color: red;">*</span></div>
								<input class="selected" type="hidden" name="role" id="role" />

								<button id="btn3" class=" btn choice_type" type="button"
										data-toggle="dropdown">
									<div id="title_role" style="display: flex; justify-content: space-between;">
										<div class="regist_value">권한 선택</div>
										<i class="fas fa-bars" style="padding: 5px;"></i>
									</div>
								</button>

								<div id="div_role" class="dropdown-menu">
								</div>
							</div>
							<%-- =========== 권한 선택 =========== --%>

						</div>
					</form>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer"
					 style="display: flex; justify-content: space-between;">
					<%-- form 전송 --%>
					<button type="button" class="btn" id="regist_member_btn">
						<i class="fas fa-check" ></i><span id="modalButtonLabel">입력완료</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ========================== 구성원 추가 모달 끝 ========================== -->


	<div id="title">
		<div id="bottomcate" style="float: none;">

			<div style="display: inline-block; float:left; margin: 40px 0;">
				<span id="totalCountText" style="font-weight: bold;"></span>
			</div>

			<div style="display: inline-block; float:right; margin: 0;">
				<!-- 부서 -->
				<label for="searchDepart" style="margin-right: 5px; font-weight: bold;">부서</label>
				<select id="searchDepart" style="height: 30px; margin-right: 5px; border: solid 1px #66cc66; border-radius: 0.4rem;">
				</select>

				<!-- 직책 -->
				<label for="searchPosition" style="margin-right: 5px; font-weight: bold;">직책</label>
				<select id="searchPosition" style="height: 30px; margin-right: 5px; border: solid 1px #66cc66; border-radius: 0.4rem;">
				</select>

				<!-- 검색어 입력 input 추가 -->
				<label for="searchWord" style="margin-right: 5px; font-weight: bold;">이름</label>
				<input id="searchWord" name="searchWord" style="padding-left: 7px; height: 25px; width: 160px; margin-right: 5px; border: solid 1px #66cc66; border-radius: 0.4rem;" type="text" placeholder="이름" />

				<button class="btn" id="btn_search" type="button" style="border:none; background-color: #66cc66; height: 30px; color: white;">
					<i class="fa fa-search"></i>
				</button>

				<button class="btn" id="delete-button" onclick="deleteMember()" type="button" style="border:none; background-color: #ff6666; height: 30px; color: white; margin-left: 5px;">
					<i class="fa fa-trash"></i>
				</button>

			</div>

		</div>

	</div>


	<!-- 게시판 리스트 시작 -->
	<!-- 예시 데이터로 공지 사항 리스트 -->
	<div id="contentList">
		<!-- 테이블 형태로 공지사항 리스트 출력 -->
		<div class="listRow">
			<table class="table table-bordered table-hover">
				<thead>
				<th><input type="checkbox" id="checkAll" /></th>
				<th>이름</th>
				<th>ID</th>
				<th>재직여부</th>
				<th>직급</th>
				<th>부서</th>
				<th>입사일</th>
				<th>퇴사일</th>
				<th>연락처</th>
				<th>주소</th>
				<th>비밀번호</th>
				</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>

		<!-- 페이징 처리 -->
		<div class="container">
			<div id="pageNumDiv" class="pagination p12">
			</div>
		</div>
	</div> <!-- 공지 리스트(content) 끝 -->
</div>

