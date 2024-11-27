<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
  * {font-family: 'Pretendard', sans-serif; !important}
  div{
    /* border: 1px solid black; */
  }
  div#sideBar{
    height: 100%;
    background-color: #f9fafa;
  }
  div#sideTop{
    width: 80%;
    height: 260px;
    margin: 15px auto 0 auto;
  }
  .sideTr{
    width: 100%;
    height: 40px;
    border-radius: 0.5rem;
    display: flex;
    align-items: center;
    font-weight: bold;
    color: #687482;
    margin-top: 3px;
  }
  .sideTr:hover {
    background-color: #efefef;
    cursor: pointer;
  }
  div#prof{
    width: 50px;
    height: 50px;
    border-radius: 40%;
    background-color: #239afe;
    color: white;
    text-align: center;
    padding-top: 13px;
    border: 1px solid #ccced0;
    font-weight: bold;
    margin: auto 8px;
  }
  div#sideMiddle{
    width: 80%;
    height:490px;
    overflow: auto;
    margin: auto;
    padding-top: 30px;
    padding-bottom: 50px;
  }
  #sideMiddle::-webkit-scrollbar {
    width: 10px;
  }
  #sideMiddle::-webkit-scrollbar-thumb {
    background-color: #ababab;
    border-radius: 10px;
  }
  #sideMiddle::-webkit-scrollbar-track {
    background-color: #dedfe0;
    border-radius: 10px;
  }
  div#sideBottom{
    width: 80%;
    height : 130px;
    margin: auto;
    padding-top: 30px;
    padding-bottom: 20px;
  }
  i.sideIcon{
    width: 40px;
    margin-left: 15px;
  }
  #start_work {
    cursor: pointer;
  }
  #position {
    top: -27px;
    left: 151px;
  }
  input[type="checkbox"] {
    -webkit-appearance: none;
    position: relative;
    width: 18px;
    height: 18px;
    cursor: pointer;
    outline: none !important;
    border: 2px solid #cccccc;
    border-radius: 2px;
    background: #fbfbfb;
  }
  input[type="checkbox"]::before {
    content: "\2713";
    position: absolute;
    top: 50%;
    left: 50%;
    overflow: hidden;
    transform: scale(0) translate(-50%, -50%);
    line-height: 1;
  }
  input[type="checkbox"]:hover {
    border-color: rgba(170, 170, 170, 0.5);
  }
  input[type="checkbox"]:checked {
    background-color: #2eb82e;
    border-color: rgba(255, 255, 255, 0.3);
    color: white;
  }
  input[type="checkbox"]:checked::before {
    border-radius: 2px;
    transform: scale(1) translate(-50%, -50%)
  }
</style>

<script type="text/javascript">

  $(document).ready(function(){
    // 화면 높이만큼 body div에 height를 주겠다
    const web_browser_height = $(window).height();
    // $("div#sideBar").css({"height":web_browser_height-10});

    // 출근하기 버튼 클릭 이벤트 (정적)
    $(document).on("click","#start_work",function(){
      Swal.fire({
        title: '출근하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '승인',
        cancelButtonText: '취소',
        reverseButtons: true
      }).then(result => {
        if (result.isConfirmed) {
          Swal.fire('출근처리가 완료되었습니다.','출근완료','success');
          let html = "<a class='btn btn-outline-secondary dropdown-toggle' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style='width: 90%;margin: auto 5%;'>" +
                  "<small class='border rounded bg-success text-white text-sm mr-2'>근무중</small><span id='work-time'>1시간 10분</span></a>" +
                  "<div class='dropdown-menu' aria-labelledby='dropdownMenuLink' style='width: 90%;'>" +
                  "<div id='start_or_end'><a class='dropdown-item' id='end_work'>퇴근하기</a></div>" +
                  "</div>";
          $("#commute-div").html(html);
        }
      });
    });
    // 퇴근하기 버튼 클릭 이벤트 (정적)
    $(document).on("click","#end_work", function(){
      let html = "<a id='dropdown' class='btn btn-outline-secondary dropdown-toggle' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style='width: 90%;margin: auto 5%;'>" +
              "금일퇴근완료</a>";
      $("#commute-div").html(html);
      Swal.fire('퇴근이 완료되었습니다.','퇴근완료','success');
    });
  });
</script>

<div id="sideBar">
  <div id="sideTop" class="border-bottom">
    <div data-toggle="dropdown" class="sideTr mt-2" style="height: 70px;">
      <div id="prof" style="background-color:#239afe;">
        <c:choose>
          <c:when test="${not empty sessionScope.username and fn:length(sessionScope.username) > 1}">
            ${fn:substring(sessionScope.username, 1, fn:length(sessionScope.username))} <!-- 두 번째 글자부터 끝까지 표시 -->
          </c:when>
          <c:otherwise>
            <c:out value="${sessionScope.username}" /> <!-- 이름 전체 표시 -->
          </c:otherwise>
        </c:choose>
      </div>
      <div>
        <!-- 세션에서 전체 이름과 직책 정보 불러오기 -->
        <span class="ml-2" style="display: block; padding-top: 3px;">${sessionScope.username}</span>
        <span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">
					${sessionScope.department} · ${sessionScope.position}
				</span>
      </div>
    </div>
    <div id="div_team" class="dropdown-menu">
      <form action="/amonsoft/controller/com/com7080" style="display: inline;">
        <button class="dropdown-item" type="submit">내 정보</button>
      </form>
      <form action="/logout" method="post" style="display: inline;">
        <button class="dropdown-item" type="submit">로그아웃</button>
      </form>
    </div>

    <div class="dropdown my-4" id="commute-div">
      <a class="btn btn-outline-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 90%;margin: auto 5%;">
        출근하기
      </a>
      <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" style="width: 90%;">
        <div id="start_or_end"><a class="dropdown-item" id="start_work"><i class="fa-solid fa-laptop-file"></i>출근하기</a></div>
      </div>
    </div>
    <div class="sideTr">
      <i class="fas fa-regular fa-paper-plane sideIcon"></i><span>메신저</span>
    </div>
    <div class="sideTr">
      <i class="fas fa-regular fa-bell sideIcon"></i><span>새로운 소식</span>
    </div>
  </div>

  <div id="sideMiddle" class="border-bottom">
    <a href="/amonsoft/controller/com/com1010">
      <div class="sideTr">
        <i class="fas fa-regular fa-flag sideIcon"></i><span>공지사항</span>
      </div>
    </a>
    <a href="/admin/members/com7050">
      <div class="sideTr">
        <i class="fas fa-solid fa-users sideIcon"></i><span>구성원</span>
      </div>
    </a>
    <a href="/admin/calendar/com2010">
      <div class="sideTr">
        <i class="fas fa-regular fa-calendar-check sideIcon"></i><span>캘린더</span>
      </div>
    </a>
    <a href="/amonsoft/controller/com/com7010">
      <div class="sideTr">
        <i class="fas fa-regular fa-solid fa-poo sideIcon"></i><span>공통코드</span>
      </div>
    </a>

    <%--
    <div class="sideTr">
        <i class="fas fa-regular fa-clock sideIcon"></i><span>출퇴근</span>
    </div>
    --%>
    <%--
    <div class="sideTr">
        <i class="fas fa-solid fa-plane sideIcon"></i><span>휴가</span>
    </div>
    --%>
    <c:if test="${sessionScope.role > 3}">
      <a href="/docList">
        <div class="sideTr">
          <i class="fas fa-solid fa-pen-nib sideIcon"></i>
          <span>결재</span>
        </div>
      </a>
    </c:if>
    <c:if test="${sessionScope.role <= 3}">
      <a href="/docPendingList">
        <div class="sideTr">
          <i class="fas fa-solid fa-pen-nib sideIcon"></i>
          <span>결재</span>
        </div>
      </a>
    </c:if>
    <%--
<div class="sideTr">
    <i class="fas fa-solid fa-dollar-sign sideIcon"></i><span>급여</span>
</div>
--%>
    <%--
    <div class="sideTr">
      <i class="fas fa-solid fa-chart-pie sideIcon"></i><span>인사이트</span>
    </div>
    --%>
  </div>


</div>
