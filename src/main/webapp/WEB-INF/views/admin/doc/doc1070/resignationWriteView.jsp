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
  table { margin-top:0pt; margin-bottom:8pt; width: 1200px;}
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

  /* amy */
  .approval-image-td{
    text-align: center;
    vertical-align: center;
  }

  .approval-image{
    width: 80px;
    height:80px;
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

  /* 유형 */
  .checkbox-group {
    display: flex;
    justify-content: space-around;
    padding: 5px;
  }
  .checkbox-group label {
    flex: 1;
    text-align: center;
  }

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

  .duration-container {
    display: flex;
    align-items: center;
    gap: 5px; /* 간격 조정 */
    border: none; /* 추가 테두리 제거 */
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

  /* 추가: 공휴일 및 주말 강조 스타일 */
  .holiday a {
    background-color: #ffcccc !important;
    color: #d9534f !important;
  }
  .weekend a {
    background-color: #e6e6e6 !important;
  }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">
  const API_KEY = 'AIzaSyBbeKqVO3mATJcINNGJPyf1a-zrZmWtI0k'; // 여기에 Google API 키를 입력
  const CALENDAR_ID = 'ko.south_korea#holiday@group.v.calendar.google.com';
</script>
<div class="contai" style="overflow-x: hidden;">
  <form name="writeFrm" enctype="multipart/form-data">
    <input id="docId" type="hidden" value="${docId}"/>
    <input id="docType" type="hidden" value="04">
    <div id="printableTable" class="table-area">
      <table class="first-table">
        <tr class="firstTr" style="height:17.1pt;">
          <td rowspan="3" style="width:211.45pt; border-right:0.75pt solid #000000; padding-right:0.22pt; padding-left:0.6pt; vertical-align:middle">
            <p class="a7" style="text-align:center; line-height:normal; font-size:30px">
              <a href="#" style="text-decoration:none"><strong><span class="font-malgungothic" style="color:#000000;font-size:60px;">사직서</span></strong></a>
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
        <tr class="secondTr" style="height:39.15pt">
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
        <tr class="thirdTr" style="height:22.05pt">
          <c:forEach var="approvalStep" items="${approvalSteps}" >
            <td class="col1"><p class="a7 font-malgungothic approval-step" style="text-align:center; line-height:normal" data-approval-step="${approvalStep.stepNo}" data-user-id="${approvalStep.approvalId}">${approvalStep.userName} / ${approvalStep.positionName}</td>
          </c:forEach>
        </tr>
      </table>
      <table class="col-table">
        <tr class="firstTr" style="height:22.5pt">
          <td class="col2">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">성&#xa0;&#xa0;&#xa0; 명</p>
          </td>
          <td class="col3"><c:out value="${resignationDetails.userName}"/></td>
          <td class="col2">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">직&#xa0;&#xa0;&#xa0; 급</p>
          </td>
          <td class="col3"><c:out value="${resignationDetails.positionName}" /></td>
        </tr>
        <tr class="secondTr" style="height:22.55pt">
          <td class="col2">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">부&#xa0;&#xa0;&#xa0; 서</p>
          </td>
          <td class="col3"><c:out value="${resignationDetails.orgName}" /></td>
          <td class="col2">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">작성일</p>
          </td>
          <td class="col3">
            <c:out value="${resignationDetails.createdDate}"></c:out>
          </td>
        </tr>
      </table>
      <table class="col-table">
        <tr>
          <td class="col2" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">제목</td>
          <td colspan="3">
            <c:out value="${resignationDetails.docTitle}"></c:out>
          </td>
        </tr>
        <tr class="secondTr" style="height:22.55pt">
          <td class="col2">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">입사일</p>
          </td>
          <td class="col3"><c:out value="${resignationDetails.jobStartDate}" /></td>
          <td class="col2">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">퇴사일</p>
          </td>
          <td class="col3">
            <c:out value="${resignationDetails.resignationDate}"></c:out>
          </td>
        </tr>

        <tr>
          <td class="col2">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">연락처</p>
          </td>
          <td colspan="3">
              <c:out value="${resignationDetails.phoneNumber}"></c:out>
          </td>
        </tr>
        <tr>
          <td class="col2">
            <p class="a7 font-malgungothic" style="margin-right:5pt; margin-left:5pt; text-align:center; line-height:normal">퇴사사유</p>
          </td>
          <td colspan="3">
            <textarea class="input-field auto-expand" id="details" name="details" style="width:100%; resize:none; text-align:left;" readonly>${resignationDetails.resignationReason}</textarea>
          </td>
        </tr>
      </table>
      <p class="a7 font-malgungothic text-center">상가 본인은 위와 같은 사정으로 사직서를 제출하오니 조치하여 주시기 바랍니다.</p>
      <p class="a7 font-malgungothic text-center">${resignationDetails.createdDate}</p>
      <p class="a7 font-malgungothic text-center" style="margin-right:9pt;">작성자 : ${resignationDetails.userName}</p>
    </div>
    <!-- File upload area -->
    <jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
  </form>
</div>