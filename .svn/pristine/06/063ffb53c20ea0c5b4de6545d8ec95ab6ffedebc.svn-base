<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

<style>
	/* CSS 스타일 */
	.tui-datepicker-input.tui-has-focus {
		margin-top : 10px;
		margin-right: 5px;
	}

	div#peopleContent {
		margin-right: 10px;
	}

	div#header {
		border-bottom: solid 1px #d9d9d9;
		display: flex;
		justify-content: space-between;
	}

	span.title {
		font-size: 28px;
		margin-right: 20px;
		font-weight: 700;
		letter-spacing: -1.12px;
	}

	div#header_title, div#button_title {
		margin: 35px 20px 20px 20px;
	}

	button#registMember {
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		color: white;
	}

	tr {
		font-size: 10pt;
	}

	.th_200 {
		width: 200px;
	}

	.th_150 {
		width: 150px;
	}

	.th_100 {
		width: 100px;
	}

	.th_50 {
		width: 50px;
	}

	.th_20 {
		width: 20px;
	}

	div.profile_icon {
		width: 30px;
		height: 30px;
		border-radius: 40%;
		color: white;
		text-align: center;
		padding-top: 6px;
		border: 1px solid #ccced0;
		font-weight: bold;
		margin: auto 8px;
		font-size: 5pt;
	}

	div.profile_icon2 {
		width: 50px;
		height: 50px;
		border-radius: 40%;
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 6px;
		border: 1px solid #ccced0;
		font-weight: bold;
		margin: auto 8px;
		font-size: 15px;
	}

	div.profile_icon2>div {
		margin-top: 3px;
	}

	div.profile, div.profile2 {
		display: flex;
		justify-content: start;
	}

	div#search_buttons {
		display: flex;
		justify-content: end;
		border-bottom: solid 1px #d9d9d9;
		padding: 10px 20px;
	}

	button.btn_search:hover {
		background-color: #ebebeb;
	}

	div#div_toggle_buttons {
		background-color: #ebebeb;
		padding: 3px;
		border-radius: 5px;
	}

	button.btn_view_style:focus {
		outline: none;
	}

	input.input_search {
		border: none;
		border-top-right-radius: 10px;
		border-bottom-right-radius: 10px;
	}

	input.input_search:focus {
		outline: none;
	}

	div#div_search {
		border: solid 2px #07B419;
		border-radius: 10px;
		height: 30px;
		padding-left: 3px;
		margin-top: 8px;
		position: relative;
		left: 38px;
		display: none;
	}

	.hidden {
		opacity: 0;
		pointer-events: none;
	}

	div.dept_position {
		background-color: #F8F9FA;
		padding: 10px;
		border-radius: 10px;
		margin-top: 3px;
	}

	div.div_name2 {
		font-size: 20px;
		font-weight: 500;
		color: #242A30;
		line-height: 14px;
		margin-top: 15px;
	}

	#search_result > table > tbody > tr > td{
		height: 55px;
		padding: 0;
		vertical-align: middle;
	}

	ul.ul_pagebar {
		list-style:none;
		margin:0 auto;
		width:700px;
		display: flex;
		align-items: baseline;
		padding: 0;
		justify-content: center;
	}

	li.li_pagebar {
		display: inline-block;
		padding-top: 9px;
		width: 40px;
		height: 40px;
		text-align: center;
		font-weight: 700;
	}

	li.li_pagebar > a {
		text-decoration: none;
		font-size: 14px;
		color:#2ecc71;
	}

	li.li_currentpage {
		background-color: #2ecc71;
		color: white;
		font-weight: 700;
		display: inline-block;
		width: 40px;
		height: 40px;
		border-radius: 50%;
		text-align: center;
		vertical-align: middle;
		padding-top: 9px;
	}

	.badge {
		font-size: 15px;
	}

	td {
		vertical-align: middle !important;
	}
</style>

<script>
	// 정적 데이터를 사용하여 사원 목록을 표시하는 함수
	function viewEmpList(currentShowPageNo) {
		let html = `
        <table class="table table-bordered table-hover" style="margin-top: 20px;">
            <thead>
                <tr>
                    <th rowspan="2" style="width:5%;"><input type="checkbox" name="chk-all" id="chk-all"/></th>
                    <th rowspan="2" style="vertical-align: middle; text-align:start; width:10%;">이름</th>
                    <th colspan=4>기본 정보</th>
                    <th colspan=2>인사 정보</th>
                </tr>
                <tr>
                    <th style="width:5%">상태</th>
                    <th style="width:7%">사번</th>
                    <th style="width:10%">근무개월</th>
                    <th style="width:10%">근무일수</th>
                    <th style="width:7%">부서</th>
                    <th style="width:7%">직위</th>
                    <th style="width:10%">예상퇴직금</th>
                </tr>
            </thead>
            <tbody>
                <tr class="tr_emp">
                    <td class='text-center'><input type='checkbox' name='chk' value='1001'/></td>
                    <td class="th_50">
                        <div class="profile">
                            <div class="profile_icon" style="background-color:#239afe"><div>길동</div></div>
                            <div style="padding-top:3px;">홍길동</div>
                        </div>
                    </td>
                    <td>재직</td>
                    <td class="emp_empno">1001</td>
                    <td>36</td>
                    <td>720</td>
                    <td>개발팀</td>
                    <td>팀장</td>
                    <td><span style="font-weight: bold;" class="severance_pay">5,000,000</span>원</td>
                </tr>
                <tr class="tr_emp">
                    <td class='text-center'><input type='checkbox' name='chk' value='1002'/></td>
                    <td class="th_50">
                        <div class="profile">
                            <div class="profile_icon" style="background-color:#239afe"><div>영희</div></div>
                            <div style="padding-top:3px;">김영희</div>
                        </div>
                    </td>
                    <td>재직</td>
                    <td class="emp_empno">1002</td>
                    <td>24</td>
                    <td>480</td>
                    <td>기획팀</td>
                    <td>대리</td>
                    <td><span style="font-weight: bold;" class="severance_pay">3,500,000</span>원</td>
                </tr>
            </tbody>
        </table>`;

		$("div#search_result").html(html);
		makeCommentPageBar(currentShowPageNo);
	}

	// 페이징바 생성 함수
	function makeCommentPageBar(currentShowPageNo) {
		const totalPage = 2;
		const blockSize = 10;
		let loop = 1;
		let pageNo = 1;

		let pageBarHTML = "<ul class='ul_pagebar'>";
		while (!(loop > blockSize || pageNo > totalPage)) {
			if (pageNo == currentShowPageNo) {
				pageBarHTML += "<li class='li_currentpage'>" + pageNo + "</li>";
			} else {
				pageBarHTML += "<li class='li_pagebar'><a href='javascript:viewEmpList(\"" + pageNo + "\")'>" + pageNo + "</a></li>";
			}
			loop++;
			pageNo++;
		}
		$("div#pageBar").html(pageBarHTML);
	}
</script>

<body>
<nav class="top-nav border-bottom">
	<span class="text-muted h4 font-weight-bold">퇴직금</span>
</nav>

<div id="pay-stub-content">
	<div id="category" class="d-flex">
		<a href="#" class="text-muted font-weight-bold mr-2 detail-category green_bottom"><span>퇴직금 조회 및 지급</span></a>
	</div>

	<div id="search_buttons">
		<div id="div_search">
			<i class="fas fa-search"></i> <input id="searchWord" class="input_search" type="text" placeholder="검색" />
		</div>
		<button type="button" id="btn_search" class="btn btn_search">
			<i class="fas fa-search"></i>
		</button>
	</div>

	<div id="search_result"></div>

	<div id="pageBar" style="width: 80%; height: 100px; margin:0 auto;"></div>
	<button type="button" class="btn btn-light btn-outline-secondary btn-sm ml-3 gopay" id="checkedPayment">체크지급</button>
</div>

<div class="modal fade" id="payStubModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">급여명세서</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table">
					<thead class="thead-dark">
					<tr>
						<th>근무기준 달</th>
						<th>급여</th>
						<th>초과근무 수당</th>
						<th>합계</th>
					</tr>
					</thead>
					<tbody id="data-tbody">
					<tr>
						<td>2023-09</td>
						<td>3,000,000</td>
						<td>200,000</td>
						<td>3,200,000</td>
					</tr>
					<tr>
						<td>2023-08</td>
						<td>2,800,000</td>
						<td>100,000</td>
						<td>2,900,000</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script>
	// 문서가 로드될 때 기본으로 사원 목록을 표시
	$(document).ready(function() {
		viewEmpList(1); // 첫 페이지 표시
	});
</script>
</body>
