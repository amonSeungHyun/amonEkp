<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>
<jsp:include page="/WEB-INF/views/admin/doc/docHeader.jsp"></jsp:include>

<style type="text/css">
  /* CSS 정리된 스타일 */
  p { margin:0pt 0pt 8pt }
  table { margin-top:0pt; margin-bottom:8pt }
  /* Additional styles for table formatting and inputs */

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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
  $(document).ready (function(){

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

  function downloadFile(file) {
    alert("다운로드 버튼 클릭됨: " + file.name);
    // 실제 다운로드 기능은 서버 연동이 필요합니다.
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
    <div class="table-area">
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
        <tr style="height:22.5pt">
          <td colspan="2" style="width:140.15pt; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle; background-color:#f3f3f3">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">제 목</p>
          </td>
          <td colspan="4" style="width:335.3pt; border-top:0.75pt solid #a0a0a0; border-left:0.75pt solid #a0a0a0; border-bottom:0.75pt solid #a0a0a0; padding-right:0.22pt; padding-left:0.22pt; vertical-align:middle">
            <input id="docTitle" style="width:500px; margin-left: 10px"  type="text">
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
          <tr style="height:22.5pt">
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <textarea wrap="soft" rows="1"  id="expenseDate_${i}"></textarea>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <textarea wrap="soft" rows="1" id="expenseItem_${i}"></textarea>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <textarea wrap="soft" rows="1" id="storeName_${i}"></textarea>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <textarea wrap="soft" rows="1" id="usageDetail_${i}"></textarea>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <textarea wrap="soft" rows="1" id="expenseAmount_${i}"></textarea>
            </td>
            <td class="detail-col1 header-cell font-malgungothic text-center">
              <textarea wrap="soft" rows="1" id="remark_${i}"></textarea>
            </td>
          </tr>
        </c:forEach>
      </table>
      <p class="a7 font-malgungothic text-center">* 날짜순으로 순차적으로 작성.</p>
      <p class="a7 font-malgungothic text-center">* 영수증 및 인터넷으로 확인 가능한 사용내역서 첨부</p>
      <p class="a7 font-malgungothic text-center"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy년 MM월 dd일" /></p>
      <p class="a7 font-malgungothic text-center" style="margin-right:9pt;">작성자 : <c:out value="${sessionScope.username}"/></p>
    </div>
    <!-- File upload area -->
    <jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
  </form>
</div>