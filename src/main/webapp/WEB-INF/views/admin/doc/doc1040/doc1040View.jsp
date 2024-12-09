<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/views/admin/doc/docHeader.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/css/doc/doc1050.css">

<style type="text/css">
	/* CSS 정리된 스타일 */
	p { margin:0pt 0pt 8pt }
	pre {margin-top:30px; margin-left:10px; font-family: 'Pretendard', sans-serif; !important }
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
		
		approvalRequestDetailView();
		
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
	
	function decodeHtmlEntities(str) {
        var textarea = document.createElement('textarea');
        textarea.innerHTML = str;
        return textarea.value.replace(/&nbsp;/g, ' ');
    }
	
	function approvalRequestDetailView(){
		$.ajax({
			url: '/doc/approvalRequestDetailView', // 데이터를 보낼 서버의 URL로 변경
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({docId:"${docId}"}),
			success: function(data) {
				console.log("data >> ", data)

				const formattedContent1 = "<pre>" + decodeHtmlEntities(data.approval_content) + "</pre>";
	            const formattedContent2 = "<pre>" + decodeHtmlEntities(data.instructions) + "</pre>";

	            $("#approval_content").html(formattedContent1);
	            $("#instructions").html(formattedContent2);
	            if(data.reference_doc_id){
		            $.ajax({
		    			url: '/doc/selectReferenceApprovalView', // 데이터를 보낼 서버의 URL로 변경
		    			type: 'POST',
		    			contentType: 'application/json',
		    			data: JSON.stringify({reference_doc_id: data.reference_doc_id}),
		    			success: function(data) {
		    				console.log("data >> ", data);
		    	            console.log("result >> ", data.result);
		    	            if(data.result.length>0){
	    	            	$("#referDoc").append(
		   	            		`<div class="modal-header">
			    	    			<h2 id="modalTitle">참조된 품의서</h2>
			    	    		</div>
			    	    		<div style="display:flex; padding:10px;">
			    	    			<table id="referTable" class="table table-bordered table-hover" style="margin-top: 20px;">
			    	    				<colgroup>
			    	    	        		<col style="width:25%">
			    	    	        		<col style="width:45%">
			    	    	        		<col style="width:20%">
			    	    	        		<col style="width:10%">
			    	            		</colgroup>
			    	    				<thead>
			    	    					<th>품의번호</th>
			    	    					<th>품의제목</th>
			    	    					<th>기안일</th>
			    	    					<th>기안자</th>
			    	    				</thead>
			    	    				<tbody>
			    	    				</tbody>
			    	    			</table>
			    	    		</div>`)
		    	            	var tableBody = $("#referTable tbody");
		    					tableBody.empty();  // 기존 데이터를 지우고 새로운 데이터를 추가
		    					$.each(data.result, function(index, doc) {
		    						var rowHtml = $('<tr onclick="goDocView(' + doc.docId + ')">')
		    								.append('<td>' + doc.approvalId + '</td>')
		    								.append('<td>' + doc.approvalTitle + '</td>')
		    								.append('<td>' + doc.draftDate + '</td>')
		    								.append('<td>' + doc.drafter + '</td>')
		    						tableBody.append(rowHtml);
		    					});
		    	            }
		    			},
		    			error: function (error) {
		    				console.error('Error sending data:', error);
		    			}
		    		});
	            }
			},
			error: function (error) {
				console.error('Error sending data:', error);
			}
		});
	}
	
	function goDocView(docId){
        let referenceType = "doc";
		fullUrl = "/doc/doc1040View?docId=" + docId + "&referenceType=" + referenceType ;
		// 생성된 URL로 이동
		window.location.href = fullUrl;
	}

</script>
<div class="contai" style="overflow-x: hidden;">
	<form name="writeFrm" id="writeFrm" enctype="multipart/form-data">
		<input id="docId" type="hidden" value="${docId}"/>
		<input id="docType" type="hidden" value="03">
		<div id="printableTable" class="table-area">
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
					<c:forEach var="approvalStep" items="${approvalSteps}" >
						<c:if test="${approvalStep.status == '03'}">
							<td class="col1 approval-image-td">
								<img class="approval-image" src="/image/approval.png">
							</td>
						</c:if>
						<c:if test="${approvalStep.status == '04'}">
							<td class="col1 approval-image-td">
								<img class="approval-image" src="/image/reject.png">
							</td>
						</c:if>
						<c:if test="${approvalStep.status != '03' && approvalStep.status != '04'}">
							<td class="col1 approval-image-td">
							</td>
						</c:if>
					</c:forEach>
				</tr>
				<tr style="height:22.05pt">
					<c:forEach var="approvalStep" items="${approvalSteps}" >
						<td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="${approvalStep.stepNo}" data-user-id="${approvalStep.approvalId}">${approvalStep.userName} / ${approvalStep.positionName}</td>
					</c:forEach>
				</tr>
			</table>
			<table class="col-table">
				<tr style="height:22.5pt">
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">기안일</p>
					</td>
					<td class="col3">
						${approvalRequestDetails.draft_date}
					</td>
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">품의번호</p>
					</td>
					<td class="col3">
						${approvalRequestDetails.approval_id}					
					</td>
				</tr>
				<tr style="height:22.55pt">
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">소속부서</p>
					</td>
					<td class="col3">
						${approvalRequestDetails.department}		
					</td>
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">기안자</p>
					</td>
					<td class="col3">
						${approvalRequestDetails.drafter}	
					</td>
				</tr>
				<tr style="height:22.55pt">
					<td class="col2">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">품의제목</p>
					</td>
					<td colspan="3">
						${approvalRequestDetails.approval_title}	
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
				    	<p id="approval_content" style="width:100%; height:100%; margin-top:5px; margin-bottom:5px;"></p>
					</td>
				</tr>
				<tr style="height:29.2pt">
					<td colspan="2" style="width:140.15pt; border-top:0.75pt solid #a0a0a0; border-right:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">지시사항</p>
					</td>
				</tr>
				<tr style="height:90pt">
					<td colspan="2" style="height: 90pt !important; ">
				    	<p id="instructions" style="width:100%; height:100%; margin-top:5px; margin-bottom:5px;"></p>
					</td>
				</tr>
				
			</table>
			
		</div>
		<!-- File upload area -->
		<jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
	</form>
	<div id="referDoc">
	</div>
</div>