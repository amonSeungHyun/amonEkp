<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/views/admin/doc/doc1040Header.jsp"></jsp:include>

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
		border:0.75pt solid #000000;
		border-collapse:collapse;
		width : 780px;
		margin: 20px;
	}
	
	.col-table td {
	    height: auto !important;
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
		height: 100% !important; /* td padding을 고려한 높이 조정 */
		border: none;
		background-color: transparent; /* Make background transparent */
		resize: none; /* Disable resizing */
		overflow: hidden; /* Hide overflow */
		text-align: left; /* Center-align text if needed */
		border-radius: 10px;
		padding: 10px;
		line-height: 1.2;
	}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready (function(){
		getApprovalId();
		
		$("#file").on('change',function(){
			var fileName = $("#file").val();
			$(".upload-name").val(fileName);
		});

		$('textarea').each(function() {
			adjustHeight(this);
		}).on('input', function() {
			adjustHeight(this);
		});

		/*textarea의 줄바꿈에 따라 td늘어나기*/
		function adjustHeight(textarea) {
			// Reset height to auto to get scrollHeight
			$(textarea).css('height', 'auto');
			// Set the textarea height to its scroll height
			$(textarea).height(textarea.scrollHeight);
			// Set the td height to match the textarea height
			$(textarea).closest('td').height(textarea.scrollHeight);
		}

	});
	
	// 결재
	function insertApprovalRequest() {
		const formData = $("#writeFrm").serializeArray();
		const jsonData = {};
		formData.forEach(field => {
		    jsonData[field.name] = field.value;
		});
		
		Object.assign(jsonData, {
		    userId: "<c:out value="${sessionScope.userId}" />",
		});
		console.log("form >> ", JSON.stringify(jsonData));
		
		const approvalData = collectApprovalSteps();
		
		if(!validationChk()){
			return ;
		}
		
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
	            $.ajax({
	                url: "/doc/insertApprovalRequest",
	                type: "POST",
	                dataType: "JSON",
	                data: JSON.stringify({
	                	approvalData: approvalData,
	                	approvalRequestData : jsonData
	                }),
	                contentType: "application/json",
	                success: function (response) {
	                    Swal.fire({
	                        icon: 'success',
	                        title: '결재신청 완료',
	                        text: '결재가 성공적으로 신청되었습니다.',
	                        confirmButtonText: '확인',
	                    }).then((result) => {
	            	        if (result.isConfirmed) {
		                    	$(location).attr("href", "/workflow");
	            	        }
	                    }); 
	                },
	                error: function (xhr, status, error) {
	                    console.error("데이터 전송 실패:", error);
	                    Swal.fire({
	                        icon: 'error',
	                        title: '오류 발생',
	                        text: '결재 신청에 실패했습니다.'
	                    });
	                }
	            });
	        }
	    });
		
	}
	
	// 품의번호 가져오기
	function getApprovalId(){
		$.ajax({
			url: '/doc/getApprovalId', // 데이터를 보낼 서버의 URL로 변경
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({}),
			success: function(data) {
				console.log("data >> ", data)
		        $("#approval_id").val(data.approval_id);
			},
			error: function (error) {
				console.error('Error sending data:', error);
			}
		});
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
	
	function validationChk(){
		if($("#approval_title").val() == null || $("#approval_title").val() == ""){
			alert("품의제목을 입력해 주세요");
			$("#approval_title").focus();
			return false;
		}
		if($("#approval_content").val() == null || $("#approval_content").val() == ""){
			alert("품의내용을 입력해 주세요");
			$("#approval_content").focus();
			return false;
		}
		return true;
	}

</script>
<div class="contai" style="overflow-x: hidden;">
	<form name="writeFrm" id="writeFrm" enctype="multipart/form-data">
		<div class="table-area">
			<table class="first-table">
				<tr style="height:17.1pt">
					<td rowspan="3" style="width:211.45pt; border-right:0.75pt solid #000000; padding-right:0.22pt; padding-left:0.6pt; vertical-align:middle">
						<p class="a7" style="text-align:center; line-height:normal; font-size:20pt">
							<strong><span class="font-malgungothic" style="color:#000000">품의서</span></strong>
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
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">기안일</p>
					</td>
					<td class="col3">
						<input id="draft_date" name="draft_date" class="input_modal" style="width : 100%; border : none;" type="text" autocomplete="off" readonly
						value="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy년 MM월 dd일' />">
					</td>
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">품의번호</p>
					</td>
					<td class="col3">
						<input id="approval_id" name="approval_id" class="input_modal" style="width : 100%; border : none;" type="text" autocomplete="off" readonly/>						
					</td>
				</tr>
				<tr style="height:22.55pt">
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">소속부서</p>
					</td>
					<td class="col3">
						<input id="department" name="department" class="input_modal" style="width : 100%; border : none;" type="text" autocomplete="off" readonly
						value="<c:out value="${sessionScope.department}" />">
					</td>
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">기안자</p>
					</td>
					<td class="col3">
						<input id="drafter" name="drafter" class="input_modal" style="width : 100%; border : none;" type="text" autocomplete="off" readonly
						value="<c:out value="${sessionScope.username}" />">
					</td>
				</tr>
				<tr style="height:22.55pt">
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">품의제목</p>
					</td>
					<td colspan="3">
						<input style="width : 100%; border : none;" id="approval_title" name="approval_title" class="input_modal" type="text" autocomplete="off" />
					</td>
				</tr>
			</table>
			<table class="col-table">
				<tr style="height:29.2pt">
					<td colspan="2" style="width:140.15pt; border-top:0.75pt solid #a0a0a0; border-right:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">품의내용</p>
					</td>
				</tr>
				<tr style="height:330px">
					<td colspan="2" style="height: 330px !important; ">
					    <textarea id="approval_content" name="approval_content" style="height: 330px; width: 100%; margin-top:5px; resize: none;"></textarea>
					</td>
				</tr>
				<tr style="height:29.2pt">
					<td colspan="2" style="width:140.15pt; border-top:0.75pt solid #a0a0a0; border-right:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">지시사항</p>
					</td>
				</tr>
				<tr style="height:90pt">
					<td colspan="2" style="height: 90pt !important; ">
					    <textarea id="instructions" name="instructions" style="height: 90pt; width: 100%; margin-top:5px; resize: none;" ></textarea>
					</td>
				</tr>
				
			</table>
			
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