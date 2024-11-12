<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

    $(document).ready (function(){

        /* $("input.email").focus();	 */
        /* $("button#continue").hide(); */

        //input 클릭시 색 바꾸기
        $("div.borderID").click(function(){
            $(this).css("border", "2px solid #66cc66");
        });


        // ID 입력 후 엔터 입력시
        $("#userId").keydown(function(e) {
            if (e.keyCode === 13) {
                $("input#password").focus();
            }
        });

        // 비밀번호 입력 후 엔터 입력시 로그인
        $("#password").keydown(function(e) {
            if (e.keyCode === 13) {
                func_login();
            }
        });

        // 로그인 버튼 클릭시
        $("#btn_login").click(function() {
            func_login();
        });

    });
    // 비밀번호 찾기
    function goFindPW() {
        const frm = document.loginFrm;
        frm.method="POST";
        frm.action="/findPW.yolo";
        frm.submit();
    }

    // 로그인 처리 함수
    function func_login() {
        const frm = document.loginFrm;
        frm.method = "POST";
        frm.action = "/loginProc"; // 로그인 처리를 위한 URL
        frm.submit();
    }


    // 로그인버튼 클릭시 호출하는 함수(로그인시 공지사항으로 이동)
    function goNotice() {
        location.href="/admin/jinji/notice/noticeList";
    }

    $("div.borderID").click(function(){
        $(this).css("border", "2px solid #66cc66");
        $("div.borderPW").css("border", "1px solid #b3b3b3");
    });


    $("div.borderPW").click(function(){
        $(this).css("border", "2px solid #66cc66");
        $("div.borderID").css("border", "1px solid #b3b3b3");
    });
</script>

<div class="inner">
    <form name="loginFrm">
        <div style="margin-bottom: 25px;">
            <span class="gradtext">에이몬소프트</span>
            <span class="title">인트라넷</span>
        </div>
        <div class="borderID" id="borderID">
            <span class="icon"><i class="bi bi-envelope"></i></span>
            <input placeholder="아이디" id="userId" name="userId" class="email search" autocomplete='off'/>
        </div>
        <div id="userpw">
            <div class='borderPW' id='text'>
                <span class='icon'><i class='bi bi-key'></i></span>
                <input placeholder='비밀번호' type='password' id='password' name='password' class='search'/>
            </div>
            <div style='margin-top: 20px;'>
                <button id='btn_login' type='button' class='headerBtn' onclick="func_login()">로그인 하기</button>
            </div>
            <div id='findPW' onclick='goFindPW();'>
                비밀번호를 잊으셨나요?
            </div>
        </div>
    </form>
</div>

