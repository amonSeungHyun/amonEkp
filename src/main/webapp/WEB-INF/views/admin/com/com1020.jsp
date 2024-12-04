<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/member.css"/>

<style>

dd {
    margin-left: 0;
    margin-bottom : 0;
}

.board-btns {
    position: relative;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-pack: center;
        -ms-flex-pack: center;
            justify-content: center;
    margin-top: 20px;
}

.content-body{
	padding : 30px;
}

/* Board View */
.board-view {
    position: relative;
    border-top: 2px solid;
}

.board-item {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
        -ms-flex-align: center;
            align-items: center;
    font-size: var(--font-sm-size);
}
.board-item dt {
    font-weight: 600;
    line-height: 22px;
    white-space: nowrap;
}
.board-item dd {
    width: auto;
    font-weight: 400;
}
.board-item:has(.fileList) {
    -webkit-box-align: start;
        -ms-flex-align: start;
            align-items: start;
}
.board-item:has(.fileList) dt {
    padding-top: 1px;
}

.board-view-header {
    padding: 30px 20px;
    border-bottom: 1px solid;
}
.board-view-header h3 {
    line-height: 32px;
}
.board-view-header .board-header-items {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-flow: wrap;
        flex-flow: wrap;
    margin-top: 6px;
    gap: 6px 20px;
}
.board-view-header .board-header-items .board-item dt {
    padding-right: 4px;
}

.board-view-body {
    border-bottom: 1px solid;
}
.board-view-body .board-body-items {
    display: block;
    padding: 0 20px;
}
.board-view-body .board-body-items .board-item {
    padding: 20px 0;
}
.board-view-body .board-body-items .board-item dt {
    padding-right: 10px;
}
.board-view-body .board-body-items .board-item + .board-item {
    border-top: 1px solid;
}

.board-content {
    position: relative;
    padding: 30px 20px;
}
.board-content p + p {
    margin: revert;
    padding: revert;
}
.board-content p:not(last-child) {
    margin-bottom: 0;
    padding-bottom: 0;
}


</style>

<script type="text/javascript">
	
	var input_title = "";
	var input_content = "";
	
	$(document).ready(function() {
		selectCom1020();
		
		$('.modal').on('hidden.bs.modal', function (e) {
			$(this).find('form')[0].reset();
		});
		
		$("#registMember").on("click", function(){
			$("#input_title").val(input_title);
			$("#input_content").html(input_content);
		})
		
	});
	
	function selectCom1020() {
		$.ajax({
			type: "POST",
			url: "/com/selectCom1020",
			dataType: "json",
			contentType: "application/json",
			data: JSON.stringify({ boardNumber : "${board_number}"}),
			success: function(data) {
				console.log(">>>>>>>>>>>>",data)
				var formattedCreatedDate = data.created_date.substring(0, 4) + '-' + 
											data.created_date.substring(4, 6) + '-' + 
											data.created_date.substring(6, 8);
				$("#board_title").text(data.title);
	            $("#created_date").text(formattedCreatedDate);
	            $("#created_id").text(data.created_id);
	            const formattedContent = decodeHtmlEntities(
	                    data.content
	                        .replace(/\n/g, '<br>')  // 줄바꿈을 <br>로 변환
	                        .replace(/ {2,}/g, match => '&nbsp;'.repeat(match.length))
	                        .replace(/(^|\s)(\s|$)/g, '&nbsp;')  // "- 아   래 -" 앞뒤 공백 처리
	                );
                $("#board_content").html(formattedContent);
	            input_title = data.title;
	            input_content = data.content;
	        },
			error: function(xhr, status, error) {
				console.error("데이터 조회 실패:", error);
			}
		});
	}
	
	function decodeHtmlEntities(str) {
	      var textarea = document.createElement('textarea');
	      textarea.innerHTML = str;
	      return textarea.value;
	}
	
	function updateCom1020(){
		const formData = $("#regist_frm").serializeArray();
		const jsonData = {};
		formData.forEach(field => {
		    jsonData[field.name] = field.value;
		});
		Object.assign(jsonData, {
		    boardNumber: "${board_number}",
		    userId: "<c:out value="${sessionScope.userId}" />"
		});
		
		console.log("form >> ", JSON.stringify(jsonData));
		
		Swal.fire({
	        title: '수정하시겠습니까?',
	        icon: 'question',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '저장',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // serializeArray()로 폼 데이터를 객체 형태로 변환
	            $.ajax({
	                url: "/com/updateCom1020",
	                type: "POST",
	                dataType: "JSON",
	                data: JSON.stringify(jsonData), // JSON 형태로 전송
	                contentType: "application/json",
	                success: function (response) {
	                    $("#modal_comCodeModal").modal("hide");
	                    Swal.fire({
	                        icon: 'success',
	                        title: '입력 완료',
	                        text: '데이터가 성공적으로 저장되었습니다.',
                        	confirmButtonText: '확인',
	                    }).then((result) => {
	            	        if (result.isConfirmed) {
		                    	$(location).attr("href", "/amonsoft/controller/com/com1010");
	            	        }
	                    });
	                },
	                error: function (xhr, status, error) {
	                    console.error("데이터 전송 실패:", error);
	                    Swal.fire({
	                        icon: 'error',
	                        title: '오류 발생',
	                        text: '데이터 저장에 실패했습니다.'
	                    });
	                }
	            });
	        }
	    });
	}
	
</script>
<div id="peopleContent">
	<div id="header">
		<div id="header_title">
			<span class="memberTitle">공지사항 상세</span>
		</div>
		<c:if test="${role <= 3 }">
			<div id="button_title">
				<button id="registMember" type="button" class="btn" data-toggle="modal" data-target="#modal_registMember">
					<span>
						<i class="fas fa-plus" style="margin: 0px; width: 20px;"></i>&nbsp;&nbsp;공지사항 수정하기
					</span>
				</button>
			</div>
		</c:if>
	</div>
	
	<!-- ========================== 공지사항 추가/수정 모달 시작 ========================== -->
	<div class="modal fade" id="modal_registMember">
		<div class="modal-dialog modal-dialog-centered" style="max-width : 1200px">
			<div class="modal-content" style="padding: 5px;">
				<!-- Modal header -->
				<div class="modal-header">
					<h2 id="modalTitle">공지사항 수정</h2>
					<button id="btn_close_registModal" type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form id="regist_frm" name="regist_frm">
						<div id="div_regist">
							<div style="margin: 10px 0;">
								<div>
									<div class="regitst_title"> 제목<span style="color: red;">*</span>
									</div>
									<input id="input_title" name="input_title" class="input_modal daterange" type="text" autocomplete="off" placeholder="제목 입력" />
								</div>
							</div>

							<div style="margin: 10px 0;">
								<div class="regitst_title">
									내용<span style="color: red;">*</span>
								</div>
								<textarea id="input_content" name="input_content" style="height: 200pt; width: 100%; margin-top:5px; resize: none;" placeholder="내용 입력"></textarea>
							</div>
						</div>
						<jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
					</form>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer"
					 style="display: flex; justify-content: space-between;">
					<%-- form 전송 --%>
					<button type="button" class="btn" id="regist_member_btn" onclick="updateCom1020()">
						<i class="fas fa-check" ></i><span id="modalButtonLabel">입력완료</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ========================== 구성원 추가 모달 끝 ========================== -->
	<div class="content-body">
        <div class="board-view">
			<div class="board-view-header">
				<h3 id="board_title"></h3>
                <div class="board-header-items">
                    <dl class="board-item">
                        <dt>작성자</dt>
                        <dd id="created_id"></dd>
                    </dl>
                    <dl class="board-item">
                        <dt>작성일</dt>
                        <dd id="created_date"></dd>
                    </dl>
                </div>
            </div>
			<div class="board-view-body">
                <div class="board-content" id="board_content">
                </div>
                <div class="board-body-items">
                    <dl class="board-item">
                        <jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
                    </dl>
                </div>
            </div>
        </div>
        <div class="board-btns">
            <a href="/amonsoft/controller/com/com1010" class="btn btn-lg btn-light"><span>목록</span></a>
        </div>
    </div>
</div>