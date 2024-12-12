<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/views/admin/doc/docHeader.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/css/doc/doc1050.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready (function(){
		calculateTotal();
		var date = "${documentCreatorInfo.createdDate}".substring(0, 9);
		
	    $('#Ymtitle').html(date + "<br>교통비 청구서");
		
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

		$(document).on('input', '[id^=expenseAmount_]', calculateTotal);
	});

	function collectExpenseDetailData(){
		const data = [];
		for (let i = 1; i <= 15; i++) {
			if(!$('#expenseDate_' + i).val()){
				break;
			}
			const rowData = {
				expenseDate: $('#expenseDate_' + i).val(),
				vehicleStart: $('#vehicleStart_' + i).val(),
				vehicleEnd: $('#vehicleEnd_' + i).val(),
				vehiclePurpose: $('#vehiclePurpose_' + i).val(),
				visitDescription: $('#visitDescription_' + i).val(),
				expenseAmount: $('#expenseAmount_' + i).val(),
				remark: $('#remark_' + i).val(),
			};
			data.push(rowData);
		}
		console.log(data); // Logs the list map structure to the console
		return data;
	}


	function numberToKorean(num) {
		const units = ["", "만", "억", "조"];
		let result = "";
		let count = 0;

		while (num > 0) {
			const part = num % 10000;
			if (part > 0) {
				result = part + units[count] + result;
			}
			num = Math.floor(num / 10000);
			count++;
		}
		return result + "원";
	}

	/*숫자 소수점함수*/
	function formatNumberWithCommas(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	/*합계 계산 함수*/
	function calculateTotal() {
		let total = 0;

		// Loop through all `textarea` elements with id starting `expenseAmount_`
		$('[id^=expenseAmount_]').each(function () {
			const value = $(this).val();
			total += parseInt(value) || 0;
		});

		// Update display for Korean and numeric formats
		$('#koreanAmount').text(numberToKorean(total));
		$('#numericAmount').text(formatNumberWithCommas(total));
	}

</script>
<div class="contai" style="overflow-x: hidden;">
	<form name="writeFrm" enctype="multipart/form-data">
		<input id="docType" type="hidden" value="06">
		<div id="printableTable" class="table-area">
			<table class="first-table">
				<tr style="height:17.1pt">
					<td rowspan="3" style="width:211.45pt; border-right:0.75pt solid #000000; padding-right:0.22pt; padding-left:0.6pt; vertical-align:middle">
						<p class="a7" style="text-align:center; line-height:normal; font-size:30px">
							<strong><span class="font-malgungothic" style="color:#000000;font-size: 35px" id="Ymtitle"></span></strong>
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
			            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">성&#xa0;&#xa0;&#xa0; 명</p>
			        </td>
			        <td class="col3">${documentCreatorInfo.userName}</td>
			        <td class="col2">
			            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">직&#xa0;&#xa0;&#xa0; 급</p>
			        </td>
			        <td class="col3">${documentCreatorInfo.positionName}</td>
			    </tr>
			    <tr style="height:22.55pt">
			        <td class="col2">
			            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">부&#xa0;&#xa0;&#xa0; 서</p>
			        </td>
			        <td class="col3">${documentCreatorInfo.organizationName}</td>
			        <td class="col2">
			            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">청구일자</p>
			        </td>
			        <td class="col3">
			            ${documentCreatorInfo.createdDate}
			        </td>
			    </tr>
			</table>
			<table class="col-table">
				<tr style="height:22.5pt">
					<td colspan="7" style="width:476.65pt; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">내&#xa0;&#xa0;&#xa0; 역</p>
					</td>
				</tr>
				<tr style="height:29.2pt">
					<td colspan="2" style="width:140.15pt; border-top:0.75pt solid #a0a0a0; border-right:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
						<p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">총 금 액</p>
					</td>
					<td colspan="5" style="width:335.3pt; border-top:0.75pt solid #a0a0a0; border-left:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle">
						<p class="a font-malgungothic" style="margin-right:5pt; margin-left:5pt; line-height:normal; font-size:12pt">
							일금 <span id="koreanAmount">____</span>  (￦<span id="numericAmount">____</span>)
						</p>
					</td>
				</tr>
				<tr style="height:22.5pt">
					<td class="detail-col1 header-cell font-malgungothic text-center">일</td>
					<td class="detail-col2 header-cell font-malgungothic text-center">출발</td>
					<td class="detail-col3 header-cell font-malgungothic text-center">도착</td>
					<td class="detail-col4 header-cell font-malgungothic text-center">목적지</td>
					<td class="detail-col5 header-cell font-malgungothic text-center">방문내용</td>
					<td class="detail-col6 header-cell font-malgungothic text-center">비용</td>
					<td class="detail-col7 header-cell font-malgungothic text-center">비고</td>
				</tr>
				<c:forEach var="i" begin="1" end="15">
					<input id="docId" type="hidden" value="${transportExpenseDetails[0].docId}"/>
					<input id="d" type="hidden" value="${transportExpenseDetails[0].docId}"/>
					<tr style="height:22.5pt">
						<td class="detail-col1 header-cell font-malgungothic text-center">
						<c:if test="${i <= transportExpenseDetails.size()}">
								${transportExpenseDetails[i - 1].expenseDate}
							</c:if>
						</td>
						<td class="detail-col1 header-cell font-malgungothic text-center">
							<c:if test="${i <= transportExpenseDetails.size()}">
								${transportExpenseDetails[i - 1].vehicleStart}
							</c:if>
						</td>
						<td class="detail-col1 header-cell font-malgungothic text-center">
							<c:if test="${i <= transportExpenseDetails.size()}">
								${transportExpenseDetails[i - 1].vehicleEnd}
							</c:if>
						</td>
						<td class="detail-col1 header-cell font-malgungothic text-center">
							<c:if test="${i <= transportExpenseDetails.size()}">
								${transportExpenseDetails[i - 1].vehiclePurpose}
							</c:if>
						</td>
						<td class="detail-col1 header-cell font-malgungothic text-center">
							<c:if test="${i <= transportExpenseDetails.size()}">
								${transportExpenseDetails[i - 1].visitDescription}
							</c:if>
						</td>
						<td class="detail-col1 header-cell font-malgungothic text-center">
							<c:if test="${i <= transportExpenseDetails.size()}">
							 	<input type="hidden" id="expenseAmount_${i}" value="${transportExpenseDetails[i - 1].expenseAmount}">
							 	<fmt:formatNumber value="${transportExpenseDetails[i - 1].expenseAmount}" type="number" groupingUsed="true" />
							</c:if>
						</td>
						<td class="detail-col1 header-cell font-malgungothic text-center">
							<c:if test="${i <= transportExpenseDetails.size()}">
								${transportExpenseDetails[i - 1].remark}
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
			<p class="a7 font-malgungothic text-center">* 날짜순으로 순차적으로 작성.</p>
			<p class="a7 font-malgungothic text-center">* 영수증 및 인터넷으로 확인 가능한 사용내역서 첨부</p>
			<p class="a7 font-malgungothic text-center">${documentCreatorInfo.createdDate}</p>
			<p class="a7 font-malgungothic text-center" style="margin-right:9pt;">작성자 : ${documentCreatorInfo.userName}</p>
		</div>
		<!-- File upload area -->
		<jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
	</form>
</div>