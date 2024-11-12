<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="listnav.jsp" />

<style type="text/css">
	/* nav 시작 */
	#cate2, #cate3 {
		color: #d1d3d1;
	}
	/* nav 끝 */

	div#boardList{
		height: 100%;
		width: 99.9%;
	}

	div.listRow {
		border: 1px solid #f9fafa;
		min-height: 110px;
		width: 99.9%;
	}

	div.listRowInside {
		width: 99.9%;
		min-height: 90px;
		margin: 10px auto;
		display: flex;
		align-items: center;
		padding-right: 10px;
	}

	span.spanBlock {
		display: block;
		font-size: 11pt;
	}

	div.listcontent1:hover {
		cursor: pointer;
	}

	button.listBnt {
		width: 100px;
		height: 40px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 15px;
		font-weight: bold;
		font-size : 11pt;
		background-color: #07b419;
		color: white;
		display: none;
	}

	button.listBnt:hover {
		filter: brightness(90%);
	}

	/* 페이징 처리 */
	a {
		text-decoration: none;
	}

	p, li, a {
		font-size: 14px;
	}

	.container {
		width: 50%;
		margin: 0 auto;
		position: relative;
		text-align: center;
	}

	.pagination {
		padding: 30px 0;
	}

	.pagination ul {
		margin: 0;
		padding: 0;
		list-style-type: none;
	}

	.pagination a {
		display: inline-block;
		width: 40px;
		height: 40px;
		text-align: center;
		padding-top: 7px;
		color: #2ecc71;
		font-weight: bold;
	}

	.p12 a.last {
		border: 2px solid #2ecc71;
		background-color: #2ecc71;
		color: #fff;
		font-weight: bold;
		border-radius: 50%;
	}

	.p12 .is-active {
		border: 2px solid #2ecc71;
		background-color: #2ecc71;
		color: #fff;
		font-weight: bold;
		border-radius: 50%;
	}

	.p12 a.box {
		border: 2px solid #2ecc71;
		color: #2ecc71;
		width: 100px;
		font-weight: bold;
		border-radius: 1.8rem;
		margin-left: 5px;
		margin-right: 5px;
	}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$("div.listRow").hover(function(){
			$(this).css("background-color","#f9fafa");
			$(this).find("button").css("display","block");
		}, function(){
			$(this).css("background-color","");
			$(this).find("button").css("display","none");
		});

		// 공지 수정하기 버튼 클릭 이벤트
		$("button.EditBnt").click(function(){
			let notino = $(this).parent().find($("input#notino")).val();
			let fk_senderno = $(this).parent().find($("input#fk_senderno")).val();
			let empno = "9999";  // 하드코딩된 empno 값

			if( empno == fk_senderno || empno == '9999' ){
				openNoticeEditModal(notino);
			} else {
				alert('작성자만 수정 가능합니다.');
				$(this).attr("disabled", true);
				top.document.location.reload();
			}
		});

		// 공지글 삭제하기 버튼 클릭 이벤트
		$(document).on("click","button.DeleteBnt",function(){
			const notino = $(this).next().find("#notino").val();
			const fk_senderno = $(this).next().find("#fk_senderno").val();

			alert("공지글이 삭제되었습니다.");
			location.reload();
		});
	});

	// 공지 리스트 수정
	function openNoticeEditModal(notino) {
		alert("공지 수정 모달을 엽니다. (공지 번호: " + notino + ")");
	}
</script>

<!-- 게시판 리스트 시작 -->
<div id="boardList">
	<!-- 예시 데이터로 공지 사항 리스트 -->
	<div class="listRow">
		<div class="listRowInside" style="width: 100%;">
			<div id="prof" class="mt-3" style="background-color: #239afe;"> 홍길</div>
			<div class="listcontent1 ml-4" style="width: 500px;" onclick="openmyListModal(1)">
				<input type="hidden" id="notino" value="1">
				<input type="hidden" id="fk_senderno" value="9999">
				<span style="font-weight: bold;" id="subject">
					<span style='font-size: 20px;'>&#128226;</span> 중요 공지사항
				</span>&nbsp;
				<span id="readCount" style="color: green;">[10]</span>
				<span><i class="fa fa-paperclip" aria-hidden="true"></i></span>
				<span id="writedate" style="margin-left: 20px; font-size: 10pt;">2024-10-22</span>
				<span id="name" style="display:block; font-size: 10pt;">홍길동 · 팀장 · 개발팀 ▶ 전사</span>
				<span id="content" class="spanBlock mt-2" style="color: gray">공지 내용입니다...</span>&nbsp;&nbsp;
				<span class="mt-2 mb-2" style="font-size: 10pt; color: gray; display: inline-block;">
					<span> ┗ &nbsp;</span><span id="cmtCount" style="color: green;">
						<span style='font-size:25px;'>&#128172;</span> [3]
					</span>
				</span>
			</div>
			<button class="listBnt EditBnt" style="background-color: white; color: #07b419; margin-left: 620px; float: right;">수정하기</button>
			<button type="button" class="listBnt DeleteBnt" style="float: right;">삭제하기</button>
		</div>
	</div>

	<!-- 공지가 없을 때 -->
	<div class="listRow">
		<div class="listRowInside" style="width: 100%;">
			<div class="px-3">작성된 공지글이 없습니다.</div>
		</div>
	</div>

	<!-- 페이징 처리 -->
	<div class="container">
		<div class="pagination p12">
			<a href="#" class="box">Previous</a>
			<a href="#" class="is-active">1</a>
			<a href="#" class="box">Next</a>
		</div>
	</div>
</div> <!-- 공지 리스트(boardlist) 끝 -->

<!-- 공지 수정 모달 -->
<div class="modal fade noticeEditModal" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">공지 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group">
						<label for="editsubject">제목</label>
						<input type="text" class="form-control" id="editsubject" value="공지 수정 예시">
					</div>
					<div class="form-group">
						<label for="editContent">내용</label>
						<textarea class="form-control" id="editContent" rows="3">공지 내용 수정 예시...</textarea>
					</div>
					<button type="button" class="btn btn-primary">저장</button>
				</form>
			</div>
		</div>
	</div>
</div>
