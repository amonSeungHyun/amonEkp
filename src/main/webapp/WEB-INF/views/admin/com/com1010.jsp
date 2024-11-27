<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/member.css"/>

<style>
	#td_title{
		text-align : left;
		padding: 8px 20px;
	}
</style>

<script type="text/javascript">
	
	//전역 변수 선언
	let isEditMode = false;
	let currentMemberData = {};
	let page = 1;     // 기본 페이지 번호 설정
	let size = 10;    // 기본 페이지 크기 설정
	let pageNum = 1;     // 페이지 번호 전역 변수
	let pageSize = 5;    // 페이지 크기 전역 변수

	$(document).ready(function() {
		
		selectCom1010();
		
		// 테이블 행 hover 효과 추가
		$("#contentList tbody").on("mouseenter", "tr", function() {
	        $(this).css("background-color", "#f1f1f1");
	    });
	
	    $("#contentList tbody").on("mouseleave", "tr", function() {
	        $(this).css("background-color", "");
	    });
	    
	    $('#searchInput').on('keypress', function(e) {
	        if (e.which === 13) {
	            searchCom1010();
	            e.preventDefault();
	        }
	    });
		
	    $("#contentList tbody").on("click", "tr", function() {
	    	if (
					$(event.target).is(".row-check") ||
					$(event.target).closest("td").find(".row-check").length > 0 
			) {
				return; // 체크박스, 초기화 버튼, 해당 요소가 포함된 td를 클릭한 경우 모달을 띄우지 않음
			}
	    	let referenceType = "board";
	    	var board_number = parseInt($(this).data("board-number"));
	    	var url = '/com/com1020?board_number='+ board_number + "&referenceType=" + referenceType ;
			window.location.href = url;
	    });	    
		
		$("#checkAll").on("click", function() {
		    const isChecked = $(this).prop("checked");
		    
		    $("#contentList tbody input[type='checkbox']").prop("checked", isChecked);
		});
		
		$('.modal').on('hidden.bs.modal', function (e) {
			$(this).find('form')[0].reset();
		});

	});
	
	function searchCom1010() {
	    const searchInput = $("#searchInput").val();
	    const selected_type = $("#selected_type").val();
	    
	    selectCom1010(searchInput, selected_type);
	}
	
	function selectCom1010(searchInput = '', selected_type = '', pageNum = 1, pageSize = 10) {
		page = pageNum;
		size = pageSize;
		$.ajax({
			type: "POST",
			url: "/com/selectCom1010List",
			dataType: "json",
			//contentType: "application/json",
			data: { searchInput: searchInput,
								 selected_type: selected_type,
								 pageNum: pageNum,
								 pageSize: pageSize},
			success: function(data) {
				console.log(">>>>>>>>>>>>",data)
				let tableBody = $("#contentList tbody");
				tableBody.empty();  // 기존 데이터 삭제하기
				
				if (data.resultList.length > 0) {
	                $("#totalCountText").text("총 " + data.pager.totalCnt + " 건");
	            } else {
	                $("#totalCountText").text("총 0 건");
	            }
				
				$.each(data.resultList, function(index, item) {
				var formattedCreatedDate = item.created_date.substring(0, 4) + '-' + 
				item.created_date.substring(4, 6) + '-' + 
				item.created_date.substring(6, 8);
	                let rowHtml = 
	                    '<tr data-board-number="' + item.board_number + '">'
	                       + '<td><input type="checkbox" class="row-check" /></td>'
	                       + '<td>' + item.rowNum + '</td>'
	                       + '<td id = "td_title">' + item.title + '</td>'
	                       + '<td>' + item.created_id + '</td>'
	                       + '<td>' + formattedCreatedDate + '</td>'
	                    + '</tr>';
	                tableBody.append(rowHtml);
	            });
				// 페이징 표시 함수 호출
				pageNumDisplay(data.pager, searchInput, selected_type);
	        },
			error: function(xhr, status, error) {
				console.error("데이터 조회 실패:", error);
			}
		});
	}

	function pageNumDisplay(pager, searchInput, selected_type) {
	    var html = '';

	    // 이전 버튼
	    if (pager.startPage > pager.blockSize) {
	        html += '<a href="javascript:selectCom1010(\'' + searchInput + '\', \'' + selected_type + '\', ' + pager.prevPage + ', ' + size + ');" class="" style="padding-top: 3px;">';
	        html += '<button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&lt;</button></a>';
	    }

	    // 페이지 번호
	    for (var i = pager.startPage; i <= pager.endPage; i++) {
	        if (pager.pageNum !== i) {
	            html += '<a class="page-num box" href="javascript:selectCom1010(\'' + searchInput + '\', \'' + selected_type + '\', ' + i + ', ' + size + ');">' + i + '</a>';
	        } else {
	            html += '<a class="page-num is-active" disabled>' + i + '</a>';
	        }
	    }

	    // 다음 버튼
	    if (pager.endPage < pager.totalPage) {
	        html += '<a href="javascript:selectCom1010(\'' + searchInput + '\', \'' + selected_type + '\', ' + pager.nextPage + ', ' + size + ');" class="" style="padding-top: 3px;">';
	        html += '<button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&gt;</button></a>';
	    }

	    $("#pageNumDiv").html(html);
	}
	
	
	// 추가 및 수정
	function insertCom1010() {
		
	    if ($("#board_title").val() === "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력 오류',
	            text: '제목을 입력하세요.'
	        });
	        return;
	    }

	    if ($("#board_content").val() === "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력 오류',
	            text: '내용을 입력하세요.'
	        });
	        return;
	    }
	    
	    $("#userId").val("${sessionScope.userId}");
	    
	    const formData = new FormData();
		formData.append("data", JSON.stringify({
			userId: $("#userId").val(),
			board_title: $("#board_title").val(),
			board_content: $("#board_content").val(),
		}));
		
		console.log("form >> " , formData.data);
		const files = $("#fileInput")[0].files;
	    $.each(files, function (i, file) {
	        formData.append("files", file);
	    });
	    
	    console.log("form >> " , formData.files);
	    
	    Swal.fire({
	        title: '등록하시겠습니까?',
	        icon: 'question',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '저장',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $.ajax({
	                url: "/com/insertCom1010",
	                type: "POST",
	                processData: false, 
	                contentType: false,
	                data: formData, 
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
	
	// 삭제
	function deleteCom1010() {
	    
		const selectedBoardNumbers = [];
		$("#contentList tbody input[type='checkbox']:checked").each(function () {
			const rowData = $(this).closest("tr").data("boardNumber"); // tr에 저장된 data-member-data 속성 가져오기
			selectedBoardNumbers.push(rowData);
		});

	    if (selectedBoardNumbers.length === 0) {
	        Swal.fire({
	            icon: 'warning',
	            title: '삭제할 항목을 선택하세요.',
	            text: '삭제할 데이터를 먼저 선택해주세요.'
	        });
	        return;
	    }
	    
	    console.log("selectedBoardNumbers >> ", selectedBoardNumbers)

	    Swal.fire({
	        title: '삭제하시겠습니까?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '삭제',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $.ajax({
	                url: "/com/deleteCom1010",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify({ boardNumbers: selectedBoardNumbers }),
	                success: function (response) {
	                    Swal.fire({
	                        icon: 'success',
	                        title: '삭제 완료',
	                        text: '선택된 항목이 삭제되었습니다.',
	                        confirmButtonText: '확인',
	                    }).then((result) => {
	            	        if (result.isConfirmed) {
		                    	$(location).attr("href", "/amonsoft/controller/com/com1010");
	            	        }
	                    });
	                },
	                error: function (xhr, status, error) {
	                    console.error("삭제 요청 실패:", error);
	                    Swal.fire({
	                        icon: 'error',
	                        title: '삭제 실패',
	                        text: '삭제에 실패했습니다.'
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
			<span class="memberTitle">공지사항</span>
		</div>
		<c:if test="${not empty role}">
			<div id="button_title">
				<button id="registMember" type="button" class="btn" data-toggle="modal" data-target="#modal_registMember">
					<span>
						<i class="fas fa-plus" style="margin: 0px; width: 20px;"></i>&nbsp;&nbsp;공지사항 등록하기
					</span>
				</button>
			</div>
		</c:if>
	</div>
	
	<!-- ========================== 공지사항 추가/수정 모달 시작 ========================== -->
	<div class="modal fade" id="modal_registMember">
		<div class="modal-dialog modal-dialog-centered"  style="max-width : 1200px">
			<div class="modal-content" style="padding: 5px;">
				<!-- Modal header -->
				<div class="modal-header">
					<h2 id="modalTitle">공지사항 등록</h2>
					<button id="btn_close_registModal" type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form id="regist_frm" name="regist_frm">
						<input type="hidden" name="userId" id="userId" /> <!-- 추가된 부분: 사용자 ID 저장 -->
						<div id="div_regist">
							<div style="margin: 10px 0;">
								<div>
									<div class="regitst_title"> 제목<span style="color: red;">*</span>
									</div>
									<input id="board_title" name="board_title" class="input_modal daterange" type="text" autocomplete="off" placeholder="제목 입력" />
								</div>
							</div>

							<div style="margin: 10px 0;">
								<%-- daterange --%>
								<div class="regitst_title">
									내용<span style="color: red;">*</span>
								</div>
								<textarea id="board_content" name="board_content" style="height: 200pt; width: 100%; margin-top:5px; resize: none;" placeholder="내용 입력"></textarea>
							</div>
						</div>
						<jsp:include page="/WEB-INF/views/admin/doc/docFileList.jsp"></jsp:include>
					</form>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer"
					 style="display: flex; justify-content: space-between;">
					<%-- form 전송 --%>
					<button type="button" class="btn" id="regist_member_btn" onclick="insertCom1010()">
						<i class="fas fa-check" ></i><span id="modalButtonLabel">입력완료</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ========================== 구성원 추가 모달 끝 ========================== -->
	
	
	<div id="title">
		<div id="bottomcate" style="float: none;">
			<div style="display: inline-block; float:left; margin: 40px 0;">
				<span id="totalCountText" style="font-weight: bold;"></span> 
			</div>
			<div style="display: inline-block; float:right; margin: 0;">
				<!-- 콤보박스 추가 -->
			    <label for="searchBoard" style="margin-right: 5px; font-weight: bold;">검색</label>
		    	<select id="selected_type" name="selected_type" style="height: 30px; margin-right: 5px; border: solid 1px #66cc66; border-radius: 0.4rem;">
		    		<option value="01">제목</option>
		            <option value="02">내용</option>
		            <option value="03">작성자</option>
			    </select>
			    
			    <!-- 검색어 입력 input 추가 -->
		    	<input id="searchInput" name="searchInput" style="padding-left: 7px; height: 25px; width: 280px; margin-right: 5px; border: solid 1px #66cc66; border-radius: 0.4rem;" type="text" placeholder="검색어를 입력해주세요." />
				
				<button class="btn" id="advanced-search-button" onclick="searchCom1010()" type="button" style="border:none; background-color: #66cc66; height: 30px; color: white;">
				<i class="fa fa-search"></i>
				</button> 
				<c:if test="${not empty role}">
					<button class="btn" id="delete-button" onclick="deleteCom1010()" type="button" style="border:none; background-color: #ff6666; height: 30px; color: white; margin-left: 5px;">
					    <i class="fa fa-trash"></i>
					</button>
				</c:if>
			</div>	
		</div>
	</div>
		<!-- 게시판 리스트 시작 -->
			<!-- 예시 데이터로 공지 사항 리스트 -->
	<div id="contentList">
	    <!-- 테이블 형태로 공지사항 리스트 출력 -->
	    <div class="listRow">
	        <table class="table table-bordered table-hover">
	        	<colgroup>
	        		<col style="width:5%">
	        		<col style="width:10%">
	        		<col style="width:60%">
	        		<col style="width:15%">
	        		<col style="width:10%">
        		</colgroup>
	            <thead>
	            		<th><input type="checkbox" id="checkAll" /></th>
	                	<th>no</th>
	                    <th>제목</th>
	                    <th>작성자</th>
	                    <th>작성일</th>
	                </tr>
	            </thead>
	            <tbody>
	            </tbody>
	        </table>
	    </div>
		<!-- 페이징 처리 -->
		<div class="container">
			<div id="pageNumDiv" class="pagination p12">
			</div>
		</div>
	</div> <!-- 공지 리스트(content) 끝 -->
</div>


	
