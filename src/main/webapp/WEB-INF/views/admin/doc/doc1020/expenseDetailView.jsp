<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/admin/doc/docHeader.jsp"></jsp:include>

<style type="text/css">
  /* CSS 정리된 스타일 */
  p { margin:0pt 0pt 8pt }

  table {
    width: 1200px;
    margin-top:0pt;
    margin-bottom:8pt
  }
  /* Additional styles for table formatting and inputs */

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
  .file-area {
    width: 50%; /* 영역 너비 */
    border: 2px solid #dddddd; /* 테두리 추가 */
    border-radius: 0.5rem;
    padding: 15px;
    margin: 10px;
    margin-left: 20px;
    float: left;
  }
  /* Additional styles for table formatting and inputs */
  .filebox input[type="file"] {
    display: none;
  }

  .filebox {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
  }

  .filebox .file-text {
    color: #999999;
    font-size: 16px;
    margin-right: 10px;
  }

  .filebox .add-file-btn {
    background-color: #88eb1e;
    color: #fff;
    border: none;
    padding: 9px 15px;
    border-radius: 0.4rem;
    cursor: pointer;
  }

  .uploaded-files {
    border-top: 1px solid #dddddd;
    padding-top: 10px;
    margin-top: 10px;
  }

  .uploaded-file {
    display: flex;
    align-items: center;
    margin-top: 5px;
  }

  .uploaded-file-name {
    width: 60%;
    border: 1px solid #dddddd;
    padding: 5px;
    border-radius: 0.4rem;
    margin-right: 10px;
    color: #333;
  }

  .download-btn, .delete-btn {
    background-color: #f0f0f0;
    border: 1px solid #dddddd;
    padding: 5px 10px;
    border-radius: 0.4rem;
    cursor: pointer;
    margin-right: 5px;
  }


  .first-table{
    width : 780px;
    border-collapse:collapse;
    margin: 20px;
  }
  .approval-image-td{
    text-align: center;
    vertical-align: center;
  }

  .approval-image{
    width: 80px;
    height:80px;
  }

  .col-table{
    border:0.75pt solid #000000;
    border-collapse:collapse;
    width : 780px;
    margin: 20px;
  }

  .col1{
    width: 64.85pt;
    border: 0.75pt solid #000000; /* 단일 테두리 */
    padding-right: 0.22pt;
    padding-left: 0.22pt;
    vertical-align: middle;
  }

  .col2{
    width:77.25pt;
    border: 0.75pt solid #000000;
    padding-right:0.22pt;
    padding-left:0.22pt;
    vertical-align:middle;
    background-color:#f3f3f3;
  }

  .col3{
    width:158.55pt;
    border: 0.75pt solid #000000;
    padding-right:0.22pt;
    padding-left:0.22pt;
    vertical-align:middle;
  }

  .detail-col1{
    width:48.05pt;
    border: 0.75pt solid #000000;
    padding-right:0.22pt;
    padding-left:0.22pt;
    vertical-align:middle;
  }

  .detail-col2{
    width:90.9pt;
    border: 0.75pt solid #000000;
    padding-right:0.22pt;
    padding-left:0.22pt;
    vertical-align:middle;
  }

  .detail-col3{
    width:87.15pt;
    border: 0.75pt solid #000000;
    padding-right:0.22pt;
    padding-left:0.22pt;
    vertical-align:middle;
  }

  .detail-col4{
    width:80.55pt;
    border: 0.75pt solid #000000;
    padding-right:0.22pt;
    padding-left:0.22pt;
    vertical-align:middle;
  }

  .detail-col5{
    width:85.3pt;
    border: 0.75pt solid #000000;
    padding-right:0.22pt;
    padding-left:0.22pt;
    vertical-align:middle;
  }

  .detail-col6{
    width:78.7pt;
    border: 0.75pt solid #000000;
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



</style>
<script type="text/javascript">
  $(document).ready (function(){
	  calculateTotal();
	  
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
    <input id="docType" type="hidden" value="02">
    <div id="printableTable" class="table-area">
      <table class="first-table">
        <tr style="height:17.1pt">
          <td rowspan="3" style="width:211.45pt; border-right:0.75pt solid #000000; padding-right:0.22pt; padding-left:0.6pt; vertical-align:middle">
            <p class="a7" style="text-align:center; line-height:normal; font-size:20pt">
              <strong><span class="font-malgungothic" style="color:#000000">지출결의서</span></strong>
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
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">작성일</p>
          </td>
          <td class="col3">${documentCreatorInfo.createdDate}</td>
        </tr>
      </table>
      <table class="col-table">
        <tr style="height:22.5pt">
          <td colspan="2" style="width:140.15pt; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">제 목</p>
          </td>
          <td colspan="4" style="width:335.3pt; border-top:0.75pt solid #a0a0a0; border-left:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle">
            ${documentCreatorInfo.docTitle}
          </td>
        </tr>
        <tr style="height:22.5pt">
          <td colspan="6" style="width:476.65pt; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">내&#xa0;&#xa0;&#xa0; 역</p>
          </td>
        </tr>
        <tr style="height:29.2pt">
          <td colspan="2" style="width:140.15pt; border-top:0.75pt solid #a0a0a0; border-right:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">총 금 액</p>
          </td>
          <td colspan="4" style="width:335.3pt; border-top:0.75pt solid #a0a0a0; border-left:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle">
            <p class="a font-malgungothic" style="margin-right:5pt; margin-left:5pt; line-height:normal; font-size:12pt">
            	일금 <span id="koreanAmount">____</span>  (￦<span id="numericAmount">____</span>)
            </p>
          </td>
        </tr>
        <tr style="height:22.5pt">
          <td class="detail-col1 header-cell font-malgungothic text-center">일</td>
          <td class="detail-col2 header-cell font-malgungothic text-center">지출항목</td>
          <td class="detail-col3 header-cell font-malgungothic text-center">이용점명</td>
          <td class="detail-col4 header-cell font-malgungothic text-center">사용 내역</td>
          <td class="detail-col5 header-cell font-malgungothic text-center">사용 금액</td>
          <td class="detail-col6 header-cell font-malgungothic text-center">비고</td>
        </tr>
        <c:forEach var="i" begin="1" end="15">
          <input id="docId" type="hidden" value="${expenseDetails[0].docId}"/>
          <input id="d" type="hidden" value="${expenseDetails[0].docId}"/>
          <tr style="height:22.5pt">
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <c:if test="${i <= expenseDetails.size()}">
                ${expenseDetails[i - 1].expenseDate}
              </c:if>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <c:if test="${i <= expenseDetails.size()}">
                ${expenseDetails[i - 1].expenseItem}
              </c:if>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <c:if test="${i <= expenseDetails.size()}">
                ${expenseDetails[i - 1].storeName}
              </c:if>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <c:if test="${i <= expenseDetails.size()}">
                ${expenseDetails[i - 1].usageDetail}
              </c:if>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <c:if test="${i <= expenseDetails.size()}">
              	<input type="hidden" id="expenseAmount_${i}" value="${expenseDetails[i - 1].expenseAmount}">
              	<fmt:formatNumber value="${expenseDetails[i - 1].expenseAmount}" type="number" groupingUsed="true" />
              </c:if>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <c:if test="${i <= expenseDetails.size()}">
                ${expenseDetails[i - 1].remark}
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </table>
      <p class="a7 font-malgungothic text-center">* 날짜순으로 순차적으로 작성.</p>
      <p class="a7 font-malgungothic text-center">* 영수증 및 인터넷으로 확인 가능한 증빙 첨부</p>
      <p class="a7 font-malgungothic text-center">${documentCreatorInfo.createdDate}</p>
      <p class="a7 font-malgungothic text-right" style="margin-right:9pt;">작성자 : ${documentCreatorInfo.userName}</p>
    </div>
    <!-- File upload area -->
    <jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
  </form>
</div>