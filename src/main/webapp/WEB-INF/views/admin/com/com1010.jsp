<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet" type="text/css" href="/css/common.css">

<script type="text/javascript">
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
			//페이지 이동 url추가
	    });	    
		
		$("#checkAll").on("click", function() {
		    const isChecked = $(this).prop("checked");
		    
		    $("#contentList tbody input[type='checkbox']").prop("checked", isChecked);
		});

	});
	
	function searchCom1010() {
	    const searchInput = $("#searchInput").val();
	    const selected_type = $("#selected_type").val();
	    
	    selectCom1010(searchInput, selected_type);
	}
	
	function selectCom1010(searchInput = '', selected_type = '') {
		$.ajax({
			type: "POST",
			url: "/amonsoft/controller/com/selectCom1010List",
			dataType: "json",
			contentType: "application/json",
			data: JSON.stringify({ searchInput: searchInput,
								 selected_type: selected_type}),
			success: function(data) {
				console.log(">>>>>>>>>>>>",data)
				let tableBody = $("#contentList tbody");
				tableBody.empty();  // 기존 데이터 삭제하기
				
				if (data.length > 0) {
	                $("#totalCountText").text("총 " + data[0].total_count + " 건");
	            } else {
	                $("#totalCountText").text("총 0 건");
	            }
				
				$.each(data, function(index, item) {
				var formattedCreatedDate = item.created_date.substring(0, 4) + '-' + 
				item.created_date.substring(4, 6) + '-' + 
				item.created_date.substring(6, 8);
	                let rowHtml = 
	                    '<tr>'
	                       + '<td><input type="checkbox" class="row-check" /></td>'
	                       + '<td>' + item.board_number + '</td>'
	                       + '<td>' + item.type + '</td>'
	                       + '<td>' + item.title + '</td>'
	                       + '<td>' + item.content + '</td>'
	                       + '<td>' + item.created_id + '</td>'
	                       + '<td>' + formattedCreatedDate + '</td>'
	                    + '</tr>';
	                tableBody.append(rowHtml);
	            });
	        },
			error: function(xhr, status, error) {
				console.error("데이터 조회 실패:", error);
			}
		});
	}

	
	// 추가 및 수정
	function insertCom1010() {
		
	    const codeNumber = $("input[name='code_number']").val().trim();
	    const codeName = $("input[name='code_name']").val().trim();
	    const codeDetailNumber = $("input[name='code_detail_number']").val().trim();
	    const codeDetailName = $("input[name='code_detail_name']").val().trim();
	    const sort = $("input[name='sort']").val().trim();

	    if (codeNumber === "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력 오류',
	            text: '상위그룹코드를 입력하세요.'
	        });
	        return;
	    }

	    if (codeName === "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력 오류',
	            text: '상위그룹코드명을 입력하세요.'
	        });
	        return;
	    }

	    if (codeDetailNumber === "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력 오류',
	            text: '상세코드번호를 입력하세요.'
	        });
	        return;
	    }

	    if (codeDetailName === "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력 오류',
	            text: '상세코드명을 입력하세요.'
	        });
	        return;
	    }
	    
	    if (sort === "") {
	        Swal.fire({
	            icon: 'warning',
	            title: '필수 입력 오류',
	            text: '정렬순서를 입력하세요.'
	        });
	        return;
	    }
	    
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
	            // serializeArray()로 폼 데이터를 객체 형태로 변환
	            const formDataArray = $("form[name=comCode_frm]").serializeArray();
	            const param = {};
	            $.each(formDataArray, function (i, field) {
	                param[field.name] = field.value;
	            });
	
	            console.log("param >>>", param);
	            $.ajax({
	                url: "/amonsoft/controller/com/insertCom1010",
	                type: "POST",
	                dataType: "JSON",
	                data: JSON.stringify(param), // JSON 형태로 전송
	                contentType: "application/json",
	                success: function (response) {
	                    $("#modal_comCodeModal").modal("hide");
	                    Swal.fire({
	                        icon: 'success',
	                        title: '입력 완료',
	                        text: '데이터가 성공적으로 저장되었습니다.'
	                    });
	                    selectCom1010(); // 재조회
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
	    
	    const selectedItems = [];
	    $("#contentList tbody input[type='checkbox']:checked").each(function () {
	        const row = $(this).closest("tr");
	        const codeNumber = row.find("td:eq(2)").text();
	        const codeDetailNumber = row.find("td:eq(4)").text();
	        selectedItems.push({ codeNumber: codeNumber, codeDetailNumber: codeDetailNumber });
	    });

	    if (selectedItems.length === 0) {
	        Swal.fire({
	            icon: 'warning',
	            title: '삭제할 항목을 선택하세요.',
	            text: '삭제할 데이터를 먼저 선택해주세요.'
	        });
	        return;
	    }

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
	                url: "/amonsoft/controller/com/deleteCom1010",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify({ selectedItems: selectedItems }),
	                success: function (response) {
	                    selectCom1010();  // 재조회
	                    Swal.fire({
	                        icon: 'success',
	                        title: '삭제 완료',
	                        text: '선택된 항목이 삭제되었습니다.'
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

<div id="title">
	<div id="category">
		<span style="font-size: 20pt; font-weight: bold;">공지사항</span>
	</div>
	<br>
	<div id="bottomcate" style="float: none;">
	<div style="display: inline-block; float:left; margin: 40px 0;">
		<span id="totalCountText" style="font-weight: bold;"></span> 
	</div>
		
	<hr width = "100%;" style="margin: 7px 0 40px 0; border-color: #d1d3d1;">
		
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
		
		<button class="btn" id="delete-button" onclick="deleteCom1010()" type="button" style="border:none; background-color: #ff6666; height: 30px; color: white; margin-left: 5px;">
		    <i class="fa fa-trash"></i>
		</button>
	</div>	

	</div>
	
</div>

<!-- 게시판 리스트 시작 -->
	<!-- 예시 데이터로 공지 사항 리스트 -->
<div id="contentList">
    <!-- 테이블 형태로 공지사항 리스트 출력 -->
    <div class="listRow">
        <table class="table table-bordered table-hover">
            <thead>
            		<th><input type="checkbox" id="checkAll" /></th>
                	<th>no</th>
                	<th>유형</th>
                    <th>제목</th>
                    <th>내용</th>
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
        <div class="pagination p12">
            <a href="#" class="box">Previous</a>
            <a href="#" class="is-active">1</a>
            <a href="#" class="box">Next</a>
        </div>
    </div>

	
</div> <!-- 공지 리스트(content) 끝 -->


	
