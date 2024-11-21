<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="/css/com/com7080.css">

<%-- 말풍선 --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<%-- 지도 --%>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<style>
    #addressSearchButton {
        display: none; 
        height: 36px;
        border: solid 1px #d9d9d9;
        border-radius: 10px;
        background-color: #6c757d;
        color: white;
        font-weight: bold;
        cursor: pointer;
    }
</style>
<script>
	let html = "";
	let v_empno = 0;
	/* function getAnnualLeave(empno){
		$.ajax({
			 //  구성원 남은 연차 구해오기
			  url : "/getAnnualLeave.yolo",
			  dataType : "JSON",
			  data:{"empno":empno},
			  success : function(json){
				  $("div#div_annual").text(json.annual+" 일");
				
			  },// end of success
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		
		}); // end of ajax()----------------------------------------------------------------------
	
	} */
	$(document).ready(function(){
		
		let today = new Date();
		
		selectCom7080();
	    $(document).on('click', '#updateCom7080', function() {
	    	$('#passwordFieldsContainer').css('display', 'table-row'); 
	    	$('#passwordFieldsContainerChk').css('display', 'table-row'); 
	    	$('#phoneNoInput').prop('readonly', false).css('border', '1px solid #6c757d');
	        $('#addressInput').prop('readonly', false).css('border', '1px solid #6c757d');
	        $('#addressDetailInput').prop('readonly', false).css('border', '1px solid #6c757d');
	        $('#saveButtonContainer').css('display', 'block');
	        $('#addressSearchButton').css('display', 'block');
	    });
	})// $(document).ready(function()

		function selectCom7080() {
		    var userId = '${sessionScope.userId}';
		
		    $.ajax({
		        type: "POST",
		        url: "/amonsoft/controller/com/selectCom7080List",
		        dataType: "json",
		        data: {
		            userId: userId
		        },
		        success: function(data) {
		
		            if (data && data.length > 0) {
		                var userData = data[0];
		
		                var html = "";
		                html += "<div style='display:flex; justify-content: space-between; margin-top: 30px;'>"
								+"<div id='div_hr_title' style=' margin-bottom:20px;'>내 정보</div>";
		                html +="<button id='updateCom7080' type='button' class='btn_edit'>"
								+"<i class='fas fa-pen' style='margin:0px; width:16px;'></i>"
								+"</button>";
		                html += "</div>";
		                html += "<table>";
		                html += "    <thead>";
		                html += "        <tr style='height:40px;'>";
		                html += "            <th class='th_title' style='width:200px'>사번</th>";
		                html += "            <th id='user_id' class='th_content'>" + userData.userId + "</th>";
		                html += "        </tr>";
		                html += "        <tr style='height:40px;'>";
		                html += "            <th class='th_title'>입사일</th>";
		                html += "            <th class='th_content'><span>" + userData.jobStartDate + "</th>";
		                html += "        </tr>";
		                html += "        <tr style='height:40px;'>";
		                html += "            <th class='th_title'>부서</th>";
		                html += "            <th class='th_content'><span>" + userData.department + "</span></th>";
		                html += "        </tr>";
		                html += "        <tr style='height:40px;'>";
		                html += "            <th class='th_title'>직위</th>";
		                html += "            <th class='th_content'>" + userData.positionNm + "</th>";
		                html += "        </tr>";
		                html += "        <tr style='height:40px;'>";
		                html += "            <th class='th_title'>직책</th>";
		                html += "            <th class='th_content'>" + userData.roleNm + "</th>";
		                html += "        </tr>";
		                html += "        <tr id='passwordFieldsContainer' style='height:40px; display:none;'>";
		                html += "            <th class='th_title'>비밀번호</th>";
		                html += "            <th class='th_content'><input type='password' id='password' placeholder='비밀번호 입력' style='width:100%;'></th>";
		                html += "        </tr>";
		                html += "        <tr id='passwordFieldsContainerChk' style='height:40px; display:none;'>";
		                html += "            <th class='th_title'>비밀번호 확인</th>";
		                html += "            <th class='th_content'><input type='password' id='confirmPassword' placeholder='비밀번호 확인' style='width:100%;'></th>";
		                html += "        </tr>";
		                html += "        <tr style='height:40px;'>";
		                html += "            <th class='th_title'>휴대전화번호</th>";
		                html += "            <th class='th_content'><input type='text' id='phoneNoInput' value='" + userData.phoneNo + "' style='width:100%; border:none;' readonly></th>";
		                html += "        </tr>";
		                html += "        <tr style='height:40px;'>";
		                html += "            <th class='th_title'>주소</th>";
		                html += "            <th class='th_content'>";
		                html += "                <div style='display: flex; align-items: center;'>";
		                html += "                    <input type='text' id='addressInput' value='" + userData.address + "' style='width:250px; border:none;' readonly>"; 
		                html += "                    <button type='button' id='addressSearchButton' onclick='searchAddress()' style='margin-left: 10px; padding: 5px 10px; white-space: nowrap;'>주소 검색</button>";
		                html += "                </div>";
		                html += "            </th>";
		                html += "        </tr>";
		                html += "        <tr style='height:40px;'>";
		                html += "            <th class='th_title'>상세주소</th>";
		                html += "            <th class='th_content'><input type='text' id='addressDetailInput' value='" + userData.addressDetails + "' style='width:100%; border:none;' readonly></th>";
		                html += "        </tr>";
		                html += "    </thead>";
		                html += "</table>";
		
		                $("div#div_info").html(html);
		            } else {
		                console.error("데이터가 비어 있습니다.");
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error("데이터 조회 실패:", error);
		        }
		    });
		}
	  	
		function insertCom7080() {
			
		    const password = $('#password').val();
		    const confirmPassword = $('#confirmPassword').val();
		    const phoneNo = $('#phoneNoInput').val();
		    const address = $('#addressInput').val();
		    const addressDetail = $('#addressDetailInput').val();
		    const userId = $('#user_id').text().trim(); 

		    if (password !== confirmPassword) {
		        Swal.fire({
		            icon: 'warning',
		            title: '오류',
		            text: '비밀번호가 일치하지 않습니다.'
		        });
		        return;
		    }			
		    
		    Swal.fire({
		        title: '저장하시겠습니까?',
		        icon: 'question',
		        showCancelButton: true,
		        confirmButtonColor: '#3085d6',
		        cancelButtonColor: '#d33',
		        confirmButtonText: '저장',
		        cancelButtonText: '취소'
		    }).then((result) => {
		        if (result.isConfirmed) {
		            const param = {
		                    password: password,
		                    phoneNo: phoneNo,
		                    address: address,
		                    addressDetail: addressDetail,
		                    userId: userId
		                };
		
		            console.log("param >>>", param);
		            $.ajax({
		                url: "/amonsoft/controller/com/insertCom7080",
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
		                    $('#saveButtonContainer').css('display', 'none');
		                    $('#addressSearchButton').css('display', 'none');
		                    selectCom7080(); // 재조회
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
		
		function searchAddress() {
			new daum.Postcode({
				oncomplete: function(data) {
					$("#addressInput").val(data.address);
            		$("#addressDetailInput").focus(); 
				}
			}).open();
		}

</script>

<div id="user_detail_content">
	<div id="user_profile">
	
		<div id="profile_img" style="background-color:#239afe;">
			<div id="user_name">${sessionScope.username}</div>
			<input id="before_deptno" type="hidden" value="${sessionScope.department}" />
			<input id="before_position" type="hidden" value="${sessionScope.position}" />
			<input id="leaveno" type="hidden"  />
		</div>
		<%-- ======================== 프로필 시작 ========================= --%>
		<table>
			<thead>
				<tr>
					<th colspan="2">${sessionScope.username}</th>
				</tr>
				<tr>
					<th class="dept_position">부서</th>				
					<th class="user_dept_position">&nbsp;&nbsp;&nbsp;${sessionScope.department}</th>	
				</tr>
				<tr>
					<th class="dept_position">직위</th>				
					<th class="user_dept_position">&nbsp;&nbsp;&nbsp;${sessionScope.position}</th>				
				</tr>
				<tr>
					<th class="dept_position">직책</th>				
					<th class="user_dept_position">&nbsp;&nbsp;&nbsp;${sessionScope.roleNm}</th>				
				</tr>
				<tr>
					<%-- <th colspan="3">
						<a onclick="copy_to_clipboard('${requestScope.employeeMap.mobile}')" class="btn communication" href="#" data-toggle="tooltip" data-placement="top" title="${requestScope.employeeMap.mobile}"><i class="fas fa-phone-alt"></i></a>
						<a onclick="copy_to_clipboard('${requestScope.employeeMap.email}')" class="btn communication" href="#" data-toggle="tooltip" data-placement="top" title="${requestScope.employeeMap.email}"><i class="far fa-envelope"></i></a>
						<a class="btn communication" href="/messenger/receivedMessage.yolo?empno=${requestScope.employeeMap.empno}" data-toggle="tooltip" data-placement="top" title="메신저"><i class="fas fa-comment"></i></a>
					</th> --%>
				</tr>
			</thead>
		</table>
	</div>
		<%-- ======================== 프로필 끝 ========================= --%>	

	<div style="display:flex; justify-content: space-between;">
		<%-- ===================== 인사정보 내용 출력 시작 ===================== --%>
		<div id="div_info"></div>
		<%-- ===================== 인사정보 내용 출력 끝 ===================== --%>
		
		<div id="right_sidebar">
			<div id='div_leave_absence'></div>
			<a class="a_side" href="/docList"> <%-- TODO 클릭 시 캘린더로 이동 --%>
				<div class="div_rightside" id="annual">
					<i class="fas fa-leaf fa-lg i_sideIcon"></i>
					<div style="display: flex; justify-content: space-between; margin-top: 5px;">
						<div style="margin:15px 0 0 20px;">
							<div style="font-size: 12px; font-weight:600; color:#556372;">남은연차</div>
							<div id="div_annual" style="font-size: 20px; color: gray; font-weight:700;">15 일</div>
						</div>
					</d{iv>
				</div>
			</a>
		</div>
	</div>
</div>
<div id="saveButtonContainer" style="text-align: center; margin-top: 20px; display: none;">
    <button id="saveButton" type="button" onclick="insertCom7080()"style="padding: 10px 20px; font-size: 16px; background-color: #239afe; color: white; border: none; border-radius: 5px; cursor: pointer; margin-left: -30%;">
        저장
    </button>
</div>

