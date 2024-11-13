<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
a.link:link {color: #cccccc;}
a:visited {text-decoration: none; color: #cccccc;}
a.link:hover {text-decoration: none; color: gray;}
a.mylink:hover {text-decoration: none; }
a:active {text-decoration: none; color: #cccccc;}

	button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		/*margin-left:75%;*/
		width: 100px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}
	

</style>    

<script type="text/javascript">
	function goWrite() {
		window.location.href = "/workflow";
	}

	function insertApprovalExpenseDetail() {
		const approvalData = collectApprovalSteps();
		/*이쪽은 문서에 따라 데이터 분기(지출결의서/휴가계/*/
		const expenseDetailData = collectExpenseDetailData();
		if(confirm("결재 신청을 하시겠습니까?")) {
			$.ajax({
				url: '/approval/insertExpenseDetail', // 데이터를 보낼 서버의 URL로 변경
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					approvalData: approvalData,
					/*여기도 분기*/
					expenseDetailData: expenseDetailData,
					/*여기도 분기*/
					docType : "02"
				}),
				success: function (docId) {
					alert("결재되었습니다.")
					$(location).attr("href", "/approval/expenseDetailView?docId=" + docId);
				},
				error: function (error) {
					console.error('Error sending data:', error);
				}
			});
		}
	}

	function collectExpenseDetailData(){
		const data = [];
		for (let i = 1; i <= 15; i++) {
			if(!$('#expenseDate_' + i).val()){
				break;
			}
			const rowData = {
				expenseDate: $('#expenseDate_' + i).val(),
				expenseItem: $('#expenseItem_' + i).val(),
				storeName: $('#storeName_' + i).val(),
				usageDetail: $('#usageDetail_' + i).val(),
				expenseAmount: $('#expenseAmount_' + i).val(),
				remark: $('#remark_' + i).val(),
			};
			data.push(rowData);
		}
		return data;
	}

	function updateApproveDocument() {
		if(confirm("승인 하시겠습니까?")) {
			$.ajax({
				url: '/approval/updateApprovalStep', // 데이터를 보낼 서버의 URL로 변경
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					status : '03',
					docId : $("#docId").val(),
					approverId : $("#approverId").val(),
					userStepNo : $("#userStepNo").val()
				}),
				success: function (docId) {
					console.log('success');
					$(location).attr("href", "/approval/expenseDetailView?docId=" + docId);

				},
				error: function (error) {
					console.error('Error sending data:', error);
				}
			});
		}
	}

	function updateRejectDocument() {
		if(confirm("반려 하시겠습니까?")) {
			$.ajax({
				url: '/approval/updateApprovalStep', // 데이터를 보낼 서버의 URL로 변경
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					status : '04',
					docId : $("#docId").val(),
					approverId : $("#approverId").val(),
					userStepNo : $("#userStepNo").val()
				}),
				success: function (docId) {
					console.log('success');
					$(location).attr("href", "/approval/expenseDetailView?docId=" + docId);

				},
				error: function (error) {
					console.error('Error sending data:', error);
				}
			});
		}
	}
</script>
<div style="display: flex; padding-top: 30px; padding-left: 30px; padding-bottom: 40px;]" class="border-bottom">
	 <span ><a class="mylink" href="javascript:location.href='/workflow/selectWrite'" style="color: #404040; font-size: 23pt; font-weight: bold; padding-right: 20px;"><</a></span>
	<c:if test="${empty documentCreatorInfo.docStatus}">
		<span style="color:#404040; font-size: 23pt; font-weight: bold;" onclick="javascript:location.href='/workflow/modify'">작성하기</span>
		<button type="button" class="headerBtn" onclick="goWrite();">
			<i class="bi bi-send" style="margin-right: 10px;"></i>
			결재선 지정
		</button>
		<button type="button" class="headerBtn" onclick="insertApprovalExpenseDetail();">
			<i class="bi bi-send" style="margin-right: 10px;"></i>
			 결재
		</button>
	</c:if>
	<c:if test="${not empty currentStepNo.docCurrentStep}">
		<c:if test="${currentStepNo.docCurrentStep == userStepNo.stepNo && documentCreatorInfo.docStatus != '03'}">
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
	<button type="button" class="headerBtn" onclick="goWrite();">
		<i class="bi bi-send" style="margin-right: 10px;"></i>
		목록
	</button>
</div >


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">