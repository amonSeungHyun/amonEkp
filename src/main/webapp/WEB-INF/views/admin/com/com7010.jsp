<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet" type="text/css" href="/css/common.css">

<script type="text/javascript">
	var page = 1;     // 기본 페이지 번호 설정
	var size = 10;    // 기본 페이지 크기 설정
	var codeNumber = ''; 
	var codeDetailName = '';

	$(document).ready(function() {
		
		selectCom7010();
		selectCom7010Code();
		
		// 테이블 행 hover 효과 추가
		$("#contentList tbody").on("mouseenter", "tr", function() {
	        $(this).css("background-color", "#f1f1f1");
	    });
	
	    $("#contentList tbody").on("mouseleave", "tr", function() {
	        $(this).css("background-color", "");
	    });
	    
	    $('#searchCodeNm, #searchCodeDetailNm').on('keypress', function(e) {
	        if (e.which === 13) {
	            serchCom7010();
	            e.preventDefault();
	        }
	    });
	    
	    $("input[name='sort']").on("input keypress", function(event) {
	        if (event.type === "keypress") {
	            const keyCode = event.which ? event.which : event.keyCode;
	            if (keyCode < 48 || keyCode > 57) {
	                Swal.fire({
	                    icon: 'warning',
	                    title: '경고',
	                    text: '숫자만 입력해주세요.'
	                });
	                event.preventDefault(); 
	                return;
	            }
	        }

	        // 한글일때
	        const currentValue = $(this).val();
	        if (/[^0-9]/.test(currentValue)) { 
	            Swal.fire({
	                icon: 'warning',
	                title: '경고',
	                text: '숫자만 입력해주세요.'
	            });
	            $(this).val(currentValue.replace(/[^0-9]/g, ''));
	        }
	    });
	    
		$("#comCodeInsert").on("click", function() {
			
			$(".use_yn_container").hide();
			
			$("input[name='code_number']").prop("readonly", false);
			$("input[name='code_detail_number']").prop("readonly", false);
			$("#comCode_frm")[0].reset();
			$("#modal_comCodeModal").modal("show");
		});
		
	    $("#contentList tbody").on("click", "tr", function() {
	    	
	    	$(".use_yn_container").show(); // 사용여부
			$("input[name='code_number']").prop("readonly", true);
			$("input[name='code_detail_number']").prop("readonly", true);
	    	
	    	if ($(event.target).is("input[type='checkbox']")) {
	            return;
	        }
	    	
	        const rowData = {
	            code_number: $(this).find("td:eq(2)").text(),
	            code_name: $(this).find("td:eq(3)").text(),
	            code_detail_number: $(this).find("td:eq(4)").text(),
	            code_detail_name: $(this).find("td:eq(5)").text(),
	            sort: $(this).find("td:eq(6)").text(),
	            use_yn: $(this).find("td:eq(7)").text().trim()
	        };

	        $("input[name='code_number']").val(rowData.code_number);
	        $("input[name='code_name']").val(rowData.code_name);
	        $("input[name='code_detail_number']").val(rowData.code_detail_number);
	        $("input[name='code_detail_name']").val(rowData.code_detail_name);
	        $("input[name='sort']").val(rowData.sort);

	        $("input[name='use_yn'][value='" + rowData.use_yn + "']").prop("checked", true);

	        $("#modal_comCodeModal").modal("show");
	    });	    
	    
	    $("#btn_close_comCodeModal").on("click", function() {
	        $("#comCode_frm")[0].reset();
	    });
		
		$("#checkAll").on("click", function() {
		    const isChecked = $(this).prop("checked");
		    
		    $("#contentList tbody input[type='checkbox']").prop("checked", isChecked);
		});

	});
	
	function serchCom7010() {
	    codeNumber = $("#searchCodeNm").val();
	    codeDetailName = $("#searchCodeDetailNm").val();

	    selectCom7010(codeNumber, codeDetailName);
	}
	
	function selectCom7010(codeNumber = '', codeDetailName = '', pageNum = 1, pageSize = 10) {
	    page = pageNum;
	    size = pageSize;
console.log("codeNumber 검색>>" + codeNumber);
	    $.ajax({
	        type: "POST",
	        url: "/amonsoft/controller/com/selectCom7010List",
	        dataType: "json",
	        contentType: "application/json",
	        data: JSON.stringify({ 
	            code_number: codeNumber,
	            code_detail_name: codeDetailName,
	            pageNum: pageNum,
	            pageSize: pageSize
	        }),
	        success: function(data) {
	            let tableBody = $("#contentList tbody");
	            tableBody.empty();  // 기존 데이터 삭제하기

	            console.log("pager >>> ", data.pager.totalCnt);

	            if (data.resultList.length > 0) {
	                $("#totalCountText").text("총 " + data.pager.totalCnt + " 건");
	            } else {
	                $("#totalCountText").text("총 0 건");
	            }

	            $.each(data.resultList, function(index, item) {
	                let rowHtml = 
	                    '<tr>' +
	                        '<td><input type="checkbox" class="row-check" /></td>' +
	                        '<td>' + item.rownum + '</td>' +
	                        '<td>' + item.code_number + '</td>' +
	                        '<td>' + item.code_name + '</td>' +
	                        '<td>' + item.code_detail_number + '</td>' +
	                        '<td>' + item.code_detail_name + '</td>' +
	                        '<td>' + item.sort + '</td>' +
	                        '<td>' + item.use_yn + '</td>' +
	                    '</tr>';
	                tableBody.append(rowHtml);
	            });

	            // 페이징 표시 함수 호출
	            pageNumDisplay(data.pager,codeNumber, codeDetailName);
	        },
	        error: function(xhr, status, error) {
	            console.error("데이터 조회 실패:", error);
	        }
	    });
	}
	
	// 검색
	function selectCom7010Code() {
		$.ajax({
			type: "POST",
			url: "/amonsoft/controller/com/selectCom7010Code",
			dataType: "json",
			contentType: "application/json",
			data: JSON.stringify({}),
			success: function(data) {
				let searchCodeNm = $("#searchCodeNm");
				searchCodeNm.empty();
				searchCodeNm.append('<option value="">전체</option>'); 

				$.each(data, function(index, item) {
					let option = $('<option></option>').attr("value", item.code_number).text(item.code_number + ' ' + item.code_name);
					searchCodeNm.append(option);
				});
			},
			error: function(xhr, status, error) {
				console.error("데이터 조회 실패:", error);
			}
		});
	}
	
	// 추가 및 수정
	function insertCom7010() {
		
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
	            const formDataArray = $("form[name=comCode_frm]").serializeArray();
	            const param = {};
	            $.each(formDataArray, function (i, field) {
	                param[field.name] = field.value;
	            });
	
	            console.log("param >>>", param);
	            $.ajax({
	                url: "/amonsoft/controller/com/insertCom7010",
	                type: "POST",
	                dataType: "JSON",
	                data: JSON.stringify(param), 
	                contentType: "application/json",
	                success: function (response) {
	                    $("#modal_comCodeModal").modal("hide");
	                    Swal.fire({
	                        icon: 'success',
	                        title: '입력 완료',
	                        text: '데이터가 성공적으로 저장되었습니다.'
	                    });
	                    selectCom7010(); // 재조회
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
	function deleteCom7010() {
	    
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
	                url: "/amonsoft/controller/com/deleteCom7010",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify({ selectedItems: selectedItems }),
	                success: function (response) {
	                    selectCom7010();  // 재조회
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
	
	function pageNumDisplay(pager, codeNumber, codeDetailName) {
	    var html = '';
	    console.log("codeNumber >> " + codeNumber);

	    // 이전 버튼
	    if (pager.startPage > pager.blockSize) {
	        html += '<a href="javascript:selectCom7010(\'' + codeNumber + '\', \'' + codeDetailName + '\', ' + pager.prevPage + ', ' + size + ');" class="" style="padding-top: 3px;"><button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&lt;</button></a>';
	    }

	    // 페이지번호 
	    for (var i = pager.startPage; i <= pager.endPage; i++) {
	        if (pager.pageNum !== i) {
	            html += '<a class="page-num box" href="javascript:selectCom7010(\'' + codeNumber + '\', \'' + codeDetailName + '\', ' + i + ', ' + size + ');">' + i + '</a>';
	        } else {
	            html += '<a class="page-num is-active" disabled>' + i + '</a>'; 
	        }
	    }

	    // 다음 버튼
	    if (pager.endPage < pager.totalPage) {
	        html += '<a href="javascript:selectCom7010(\'' + codeNumber + '\', \'' + codeDetailName + '\', ' + pager.nextPage + ', ' + size + ');" class="" style="padding-top: 3px;"><button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&gt;</button></a>';
	    }

	    $("#pageNumDiv").html(html);
	}
	
</script>

<div id="title">
	<div id="category">
		<span style="font-size: 20pt; font-weight: bold;">공통코드</span>
		<button id="comCodeInsert" type="button" class="headerBtn" data-toggle="modal" data-target="#modal_comCodeModal" style="margin-right: 7px; float: right;">
			공통코드 등록
		</button>
	</div>
	<br>
	<div id="bottomcate" style="float: none;">
	<div style="display: inline-block; float:left; margin: 40px 0;">
		<span id="totalCountText" style="font-weight: bold;"></span> 
	</div>
		
	<hr width = "100%;" style="margin: 7px 0 40px 0; border-color: #d1d3d1;">
		
	<div style="display: inline-block; float:right; margin: 0;">
	    <!-- 콤보박스 추가 -->
	    <label for="searchCodeNm" style="margin-right: 5px; font-weight: bold;">그룹명</label>
    	<select id="searchCodeNm" style="height: 30px; margin-right: 5px; border: solid 1px #66cc66; border-radius: 0.4rem;">
	    </select>
	
	    <!-- 검색어 입력 input 추가 -->
	    <label for="searchCodeDetailNm" style="margin-right: 5px; font-weight: bold;">상세코드명</label>
    	<input id="searchCodeDetailNm" name="searchCodeDetailNm" style="padding-left: 7px; height: 25px; width: 160px; margin-right: 5px; border: solid 1px #66cc66; border-radius: 0.4rem;" type="text" placeholder="검색어 입력" />
		
		<button class="btn" id="advanced-search-button" onclick="serchCom7010()" type="button" style="border:none; background-color: #66cc66; height: 30px; color: white;">
		<i class="fa fa-search"></i>
		</button> 
		
		<button class="btn" id="delete-button" onclick="deleteCom7010()" type="button" style="border:none; background-color: #ff6666; height: 30px; color: white; margin-left: 5px;">
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
                	<th>그룹코드</th>
                    <th>코드그룹명</th>
                    <th>상세코드</th>
                    <th>상세코드명</th>
                    <th>정렬순서</th>
                    <th>사용여부</th>
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
    
    <!-- ========================== 구성원 추가 모달 시작 ========================== -->
	<div class="modal fade" id="modal_comCodeModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content" style="padding: 5px;">
				<!-- Modal header -->
				<div class="modal-header">
					<h2>공통코드 등록</h2>
					<button id="btn_close_comCodeModal" type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form id="comCode_frm" name="comCode_frm">
						<div id="div_comCode">
							<div style="display: flex; justify-content: space-between;">
								<div>
									<div class="modal_title"> 상위그룹코드<span style="color: red;">*</span>
									</div>
									<input name=code_number class="input_modal" type="text" autocomplete="off" placeholder="상위그룹코드 입력" maxlength="10" readonly/>
								</div>
								<div>
									<div class="modal_title">
										상위그룹코드명<span style="color: red;">*</span>
									</div>
									<input name="code_name" class="input_modal" type="text" autocomplete="off" placeholder="상위그룹코드명 입력" maxlength="50" />
								</div>
							</div>

							<div style="margin: 10px 0;">
								<%-- daterange --%>
								<div class="modal_title">
									상세코드번호<span style="color: red;">*</span>
								</div>
								<input name="code_detail_number" type="text" class="input_modal daterange" placeholder="상세코드번호 입력" maxlength="10" readonly></input>
							</div>
							<div style="margin: 10px 0;">
								<div class="modal_title">
									상세코드명<span style="color: red;">*</span>
								</div>
								<input name=code_detail_name type="text" class="input_modal daterange" placeholder="상세코드명 입력" maxlength="10"></input>
							</div>
							<div style="margin: 10px 0;">
								<div class="modal_title">
									상세코드설명
								</div>
								<input name=code_description type="text" class="input_modal daterange" placeholder="상세코드설명 입력"></input>
							</div>
							<div style="margin: 10px 0;">
								<div class="modal_title">
									정렬순서<span style="color: red;">*</span>
								</div>
								<input name="sort" type="text" class="input_modal daterange" placeholder="정렬순서 입력" maxlength="10"></input>
							</div>
							<div class="use_yn_container" style="margin: 10px 0;" readonly>
								<div class="modal_title">
									사용여부
								</div>
								<div>
									<label>
										<input name="use_yn" type="radio" value="Y" checked /> 사용
									</label>
									<label style="margin-left: 10px;">
										<input name="use_yn" type="radio" value="N" /> 미사용
									</label>
								</div>
							</div>

						</div>
					</form>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer"
					 style="display: flex; justify-content: space-between;">
					<%-- form 전송 --%>
					<button type="button" class="btn btn_color" id="insertCom7010" onclick="insertCom7010()">
						<i class="fas fa-check"></i>입력완료
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ========================== 구성원 추가 모달 끝 ========================== -->
	
</div> <!-- 공지 리스트(content) 끝 -->


	
