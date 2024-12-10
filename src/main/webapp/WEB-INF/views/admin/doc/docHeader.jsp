<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
<script src="https://printjs-4de6.kxcdn.com/print.min.js"></script>
<style type="text/css">
a.link:link {color: #cccccc;}
a:visited {text-decoration: none; color: #cccccc;}
a.link:hover {text-decoration: none; color: gray;}
a.mylink:hover {text-decoration: none; }
a:active {text-decoration: none; color: #cccccc;}

	button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background-color: #010194;
		/*margin-left:75%;*/
		width: 140px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
		margin-right: 20px;
	}

/* 인쇄용 스타일 */
@media print {
	@page {
		size: A4;
		margin: 10mm 15mm; /* 상하 10mm, 좌우 15mm 여백 설정 */
	}

	body * {
		visibility: hidden;
	}

	/* 인쇄 영역 설정 */
	#printableTable, #printableTable * {
		visibility: visible;
	}

	#printableTable {
		position: absolute;
		left: 15mm; /* 좌측 여백 */
		top: 10mm;  /* 상단 여백 */
		width: calc(100% - 30mm); /* 좌우 여백을 제외한 너비 */
	}

	/* 테이블 너비 조정 */
	.first-table, .col-table {
		width: 100% !important; /* !important로 기존 스타일 덮어쓰기 */
		margin: 0 0 20px 0;
		page-break-inside: avoid; /* 테이블 중간에서 페이지 나눔 방지 */
	}

	/* 승인란 테이블 비율 조정 */
	.col1 {
		width: calc(100% / 6) !important;
	}

	/* 상세 내역 테이블 열 비율 조정 */
	.detail-col1 { width: 8% !important; }  /* 날짜 */
	.detail-col2 { width: 15% !important; } /* 지출항목 */
	.detail-col3 { width: 20% !important; } /* 이용점명 */
	.detail-col4 { width: 27% !important; } /* 사용내역 */
	.detail-col5 { width: 15% !important; } /* 사용금액 */
	.detail-col6 { width: 15% !important; } /* 비고 */

	/* 테이블 셀 여백 및 정렬 조정 */
	td, th {
		padding: 8px 4px !important;
		word-break: keep-all; /* 단어 중간 줄바꿈 방지 */
	}

	/* 승인 이미지 크기 조정 */
	.approval-image-td {
		height: 80px !important;
	}

	.approval-image {
		width: 60px !important;
		height: 60px !important;
	}

	/* 하단 텍스트 정렬 */
	.text-center {
		text-align: center !important;
		margin: 5px 0 !important;
	}

	/* 파일 업로드 영역 숨김 */
	.file-area, .filebox {
		display: none !important;
	}

	/* 불필요한 스크롤바 제거 */
	.contai {
		overflow: visible !important;
	}

	/* 글꼴 설정 */
	* {
		font-family: '맑은 고딕', sans-serif !important;
	}
}
</style>
<script type="text/javascript">

	function goBackToList() {
		const previousApprovalStatus = localStorage.getItem('previousApprovalStatus') || 'pending'; // 기본값을 설정 (예: 'pending')
		console.log(previousApprovalStatus)
		alert(previousApprovalStatus);
		if (previousApprovalStatus === "pending") {
			window.location.href = "/docPendingList";
		} else {
			window.location.href = "/docList";
		}
	}

	function getDocumentConfig(docCode) {
		switch (docCode) {
			case "01":
				return {
					data : collectAnnualLeaveData(),
					ajaxUrl: "/approval/insertAnnualLeaveDetail",
				};
			case "02":
				return {
					data: collectExpenseDetailData(),
					ajaxUrl: "/approval/insertExpenseDetail",
				};
			case "03":	// 품의서
				return {
					data : collectApprovalRequest(),
					ajaxUrl: "/doc/insertApprovalRequest",
				};
			case "04":	// 사직서
				return {
					data : collectResignationData(),
					ajaxUrl: "/approval/insertResignationDetail",
				};
			case "05":	// 법인카드
				return {
					data : collectcorporateCardDetailData(),
					ajaxUrl: "/doc/insertDoc1050",
				};
			case "06":	// 교통비
				return {
					data : collectVehicleExpenseDetailData(),
					ajaxUrl: "/doc/insertTransportExpense",
				};

			default:
				throw new Error(("Unknown docType:" + docCode));
		}
	}

	function getRedirectUrl(docId, docType, referenceType) {
		const urls = {
			"01": "/approval/annualLeaveView?docId=" + docId + "&referenceType=doc",
			"02": "/approval/expenseDetailView?docId=" + docId + "&referenceType=doc",
			"03": "/doc/doc1040View?docId=" + docId + "&referenceType=doc",
			"04": "/doc/doc1070View?docId=" + docId + "&referenceType=doc",
			"05": "/doc/doc1050View?docId=" + docId + "&referenceType=doc",
			"06": "/doc/doc1060View?docId=" + docId + "&referenceType=doc",
		};
		return urls[docType];
	}

	/*결재선 구성 List 함수*/
	function collectApprovalSteps() {
		const approvalData = [];

		// Select all the table cells containing approval steps using jQuery
		$('.approval-step').each(function() {
			const stepData = {
				approvalStepNo: $(this).data('approval-step'),
				approvalStatus : $(this).data('approval-status'),
				userId: $(this).data('user-id')
			};
			approvalData.push(stepData);
		});

		console.log(approvalData);
		return approvalData;
	}

	/* 결재 함수*/
	function insertApprovalDocumentDetail() {
		var docType = $("#docType").val();
		const referenceType = "doc";
		const approvalData = collectApprovalSteps();
		let documentConfig = getDocumentConfig(docType);
		const data = documentConfig.data
		const files = $("#fileInput")[0].files;


		Swal.fire({
			title: '결재 신청을 하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '신청',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				const formData = new FormData();
				formData.append("data", JSON.stringify({
					approvalData: approvalData,
					data: data,
					docType: docType,
					referenceType: referenceType, // 결재문서는 doc 게시글은 board로 할예정
					docTitle: $("#docTitle").val()
				}));

				$.each(files, function (i, file) {
					formData.append("files", file); //
				});

				$.ajax({
					url: documentConfig.ajaxUrl, // 데이터를 보낼 서버의 URL로 변경
					type: 'POST',
					processData: false,
					contentType: false,
					data: formData,
					success: function (docId) {
						Swal.fire({
							title: '결재 신청이 완료되었습니다.',
							text: '신청완료',
							icon: 'success',
							confirmButtonText: '확인'
						}).then((result) => {
							if (result.isConfirmed) {
								// 확인 버튼을 누르면 페이지 이동
								var redirectUrl = getRedirectUrl(docId, docType,referenceType);
								$(location).attr("href", redirectUrl);
							}
						});
					},
					error: function (error) {
						console.error('Error sending data:', error);
						let msg = error.responseJSON.resultMsg;
						alert(msg);
					}
				});
			}
		});
	}

	function updateApproveDocument() {
		var docType = $("#docType").val();
		const referenceType = "doc";
		Swal.fire({
			title: '승인 하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '승인',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: '/approval/updateApprovalStep', // 데이터를 보낼 서버의 URL로 변경
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({
						status: '03',
						docId: $("#docId").val(),
						approverId: $("#approverId").val(),
						userStepNo: $("#userStepNo").val()
					}),
					success: function (docId) {
						Swal.fire({
							title: '승인처리 되었습니다.',
							text: '승인완료',
							icon: 'success',
							confirmButtonText: '확인'
						}).then((result) => {
							if (result.isConfirmed) {
								var redirectUrl = getRedirectUrl(docId, docType, referenceType);
								console.log(redirectUrl);
								$(location).attr("href", redirectUrl);
							}
						});
					},
					error: function (error) {
						console.error('Error sending data:', error);
					}
				});
			}
		})
	}

	function updateRejectDocument() {
		var docType = $("#docType").val();
		const referenceType = "doc";
		Swal.fire({
			title: '반려 하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '반려',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: '/approval/updateApprovalStep', // 데이터를 보낼 서버의 URL로 변경
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({
						status: '04',
						docId: $("#docId").val(),
						approverId: $("#approverId").val(),
						userStepNo: $("#userStepNo").val()
					}),
					success: function (docId) {
						Swal.fire({
							title: '반려처리 되었습니다.',
							text: '반려완료',
							icon: 'success',
							confirmButtonText: '확인'
						}).then((result) => {
							if (result.isConfirmed) {
								var redirectUrl = getRedirectUrl(docId, docType, referenceType);
								$(location).attr("href", redirectUrl);
							}
						});
					},
					error: function (error) {
						console.error('Error sending data:', error);
					}
				});
			}
		})
	}

	async function printTable() {
		window.print();
	}
	function goBack() {
		window.history.back(); // 브라우저의 이전 페이지로 이동
	}

	<!-- 여기서부터 팝업 function-->
	function initializeJsTree() {
		const treeData = [
			{ "id": "1", "parent": "#", "text": "1본부" },
			{ "id": "1-1", "parent": "1", "text": "Child node 1 (1본부)" },
			{ "id": "1-2", "parent": "1", "text": "Child node 2 (1본부)" },
			{ "id": "2", "parent": "#", "text": "2본부" },
			{ "id": "2-1", "parent": "2", "text": "Child node 1 (2본부)" },
			{ "id": "2-2", "parent": "2", "text": "Child node 2 (2본부)" },
			{ "id": "3", "parent": "#", "text": "3본부" },
			{ "id": "3-1", "parent": "3", "text": "Child node 1 (3본부)" },
			{ "id": "3-2", "parent": "3", "text": "Child node 2 (3본부)" }
		];

		$('#jstree').jstree({
			'core': {
				'data': treeData
			}
		});

		// 노드 선택 이벤트 연결
		$('#jstree').on('select_node.jstree', function (e, data) {
			handleNodeSelect(data);
		});
	}

	function initializeJsTree() {
		$('#jstree').jstree({
			'core': {
				'data': treeData
			}
		});

		// 노드 선택 이벤트 연결
		$('#jstree').on('select_node.jstree', function (e, data) {
			handleNodeSelect(data);
		});
	}

	function handleNodeSelect(data) {
		const nodeId = data.node.id;
		const nodeText = data.node.text;

		// 선택된 결재자 목록을 DOM 요소에 저장
		const selectedApprovers = getSelectedApprovers();

		// 중복 추가 방지
		if (!selectedApprovers.some(item => item.id === nodeId)) {
			selectedApprovers.push({ id: nodeId, text: nodeText });
			updateApproverList(selectedApprovers);
		}
	}

	function getSelectedApprovers() {
		const approversJson = $('#approver-list').data('selectedApprovers');
		return approversJson ? approversJson : [];
	}

	function setSelectedApprovers(selectedApprovers) {
		$('#approver-list').data('selectedApprovers', selectedApprovers);
	}

	function updateApproverList(selectedApprovers) {
		const approverList = $('#approver-list');
		approverList.empty();

		selectedApprovers.forEach((approver, index) => {
			const approverItem = $(`
            <div class="approver-item">
                <span>${index + 1}. ${approver.text}</span>
                <button class="btn btn-danger btn-sm remove-approver" data-id="${approver.id}">제거</button>
            </div>
        `);
			approverList.append(approverItem);
		});

		// 선택된 결재자 목록 저장
		setSelectedApprovers(selectedApprovers);

		// 제거 버튼 이벤트 연결
		bindRemoveApproverEvents();
	}

	function bindRemoveApproverEvents() {
		$('.remove-approver').off('click').on('click', function () {
			const idToRemove = $(this).data('id');
			let selectedApprovers = getSelectedApprovers();

			// 해당 ID를 목록에서 제거
			selectedApprovers = selectedApprovers.filter(item => item.id !== idToRemove);

			// 목록 업데이트
			updateApproverList(selectedApprovers);
		});
	}


	function handleConfirmSelection() {
		const selectedApprovers = getSelectedApprovers();
		console.log("선택된 결재자:", selectedApprovers);
		$('#approverModal').modal('hide'); // 모달 닫기
	}


</script>
<div style="display: flex; padding-top: 30px; padding-left: 30px; padding-bottom: 40px;]" class="border-bottom">
	 <span ><a class="mylink" href="javascript:void(0);" onclick="goBack();" style="color: #404040; font-size: 23pt; font-weight: bold; padding-right: 20px;"><</a></span>
	<c:if test="${empty documentCreatorInfo.docStatus}">
		<span style="color:#404040; font-size: 23pt; font-weight: bold; margin-right:20px;" onclick="javascript:location.href='/workflow/modify'">작성하기</span>
		<button type="button" class="headerBtn" data-bs-toggle="modal" data-bs-target="#approverModal">
			<i class="bi bi-send" style="margin-right: 10px;"></i>
			결재선 지정
		</button>
		<button type="button" class="headerBtn" onclick="insertApprovalDocumentDetail();">
			<i class="bi bi-send" style="margin-right: 10px;"></i>
			 결재
		</button>
	</c:if>
	<c:if test="${not empty currentStepNo.currentStep}">
		<c:if test="${currentStepNo.currentStep == userStepNo.stepNo && documentCreatorInfo.docStatus != '03'}">
			<input id="approverId" type="hidden" value="${sessionScope.userId}">
			<input id="userStepNo" type="hidden" value="${userStepNo.stepNo}">
			<button type="button" class="headerBtn" onclick="updateApproveDocument();">
				<i class="bi bi-send" style="margin-right: 10px;"></i>
				승인
			</button>
			<button type="button" class="headerBtn" onclick="updateRejectDocument();">
				<i class="bi bi-send" style="margin-right: 10px;"></i>
				반려
			</button>
		</c:if>
	</c:if>
	<button type="button" class="headerBtn" onclick="goBackToList();">
		<i class="bi bi-send" style="margin-right: 10px;"></i>
		목록
	</button>
	<button type="button" class="headerBtn" onclick="printJS({
			printable: 'printableTable',
			type: 'html',
			css: ['/css/print.css'],
			scanStyles: false
	})">
		<i class="bi bi-send" style="margin-right: 10px;"></i>
		인쇄
	</button>
</div >
<!-- modal -->
<div class="modal fade" id="approverModal" tabindex="-1" aria-labelledby="approverModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="approverModalLabel">결재자 선택</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- jsTree -->
				<div id="jstree"></div>
				<!-- Selected approvers -->
				<div id="selected-approvers">
					<h5>선택된 결재자</h5>
					<div id="approver-list">
						<p>아직 선택된 결재자가 없습니다.</p>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="confirmSelection">확인</button>
			</div>
		</div>
	</div>
</div>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">