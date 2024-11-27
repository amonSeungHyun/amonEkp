<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" type="text/css" href="/css/common.css">
<style type="text/css">
	div.row{
			width: 100%;
			margin: 0px;
			padding: 0px;
		}
	div.v-line {
	  border-left : thin solid #cccccc;
	  height : 80px;
	  padding: 0px;
	}

	span#number {
		color : #00cc00;
		font-weight: bold;
		font-size: 11pt;
	}

	span#subject {
		font-weight: bold;
		font-size: 13pt;
	}

	a.link {
		color: #cccccc; /* 기본 색상 */
		text-decoration: none;
	}

	a:visited {
		text-decoration: none;
		color: #cccccc;
	}

	a.link:hover {
		text-decoration: none;
		color: gray;
	}

	a.mylink:hover {
		text-decoration: none;
	}

	a.link.active {
		color: black; /* 클릭된 링크 색상 */
	}

	/* div#leftFirst { overflow: scroll; }
	div#rightFirst { overflow: scroll; }	 */
	div#leftFirst  {

	height: 780px;
	padding: 0px;
	}

    input[type="checkbox"] {
        -webkit-appearance: none;
        position: relative;
        width: 20px;
        height: 20px;
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

    label#sub {
     font-size: 13pt;
     padding-top: 0px;
     margin-top: 0px;
     font-weight: bold;
     margin-left: 10px;

    }

   	span#status{
	width: 53px;
	height: 25px;
	background-color: #c1f0c1;
	border-radius: 0.5rem;
	color: #4d4d4d;;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;


	}

	span#needstatus{
	width: 58px;
	height: 25px;
	background-color: #c1f0c1;
	border-radius: 0.5rem;
	color: #4d4d4d;;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;


	}

	div#contents:hover {
	background-color: #efefef;
	cursor: pointer;
	}

	span#profile{
		width: 35px;
		height: 35px;
		border-radius: 40%;
		background-color: #239afe;
		color: white;
		border: 1px solid #ccced0;
		font-size: 9pt;
		text-align: center;
		padding: 7px 5px;
	}

		span#profile2{ /*테스트용  */
		width: 35px;
		height: 35px;
		border-radius: 40%;
		background-color: purple;
		color: white;
		border: 1px solid #ccced0;
		font-size: 9pt;
		text-align: center;
		padding: 7px 5px;
	}

	div#modalStatus{
	width: 450px;
	height: 50px;
	background-color: #eafaea;
	border-radius: 15px;
	border : 1px solid #c1f0c1;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: 10px 8px 20px 8px;
	padding-top: 11.5px;
	}


	div#modalContents{
	margin-top: 40px;
	width : 500px;
	height : 100%;
	}

	div#modalNumber{
	width : 35px;
	height : 35px;
	border-radius: 50%;
	border : 1px solid #ccced0;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	}

	span#modalSubContents{
	width : 500px;
	height : 400%;
	border-radius: 15px;
	border : 1px solid gray;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin-top: 10px;
	margin-left : 10px;
	padding: 20px 10px;
	}

/*     span#modalprof{
		width: 40px;
		height: 40px;
		border-radius: 40%;
		background-color: #239afe;
		color: white;
		border: 1px solid #ccced0;
		font-size: 10pt;
		text-align: center;
		padding: 9px 7px;
	} */

	 span#modalprof{
		width: 45px;
		height: 45px;
		border-radius: 40%;
		 background-color: #239afe;
		color: white;
		border: 0px solid #ccced0;
		font-size: 12pt;
		text-align: center;
		padding: 9px 7px;
	}



  table{
    border: 1px solid #ccced0;
    border-collapse: collapse;
    border-radius: 10px;
    border-style: hidden;
    box-shadow: 0 0 0 1px #ccced0;
    width: 380px;
    height : 80px;

  }

  td {

  }

  td.td-2 {
  	width: 50%;
  }

    td {
  	/* padding :10px 15px; */ /* 이거만 살리기 */
  	/* border : 1px solid; */
  }

/*   td.td-2 {
  	width: 50%;
  }	 */

/*   span#status2{
	width: 55px;
	height: 25px;
	background-color: #c1f0c1;
	border-radius: 20%;
	color: black;
	text-align: center;
	 border: 1px solid #ccced0;
	margin: auto;
  } */

  span#status2{
	width: 60px;
	height: 30px;
	background-color: #c1f0c1;
	border-radius: 0.5rem;
	font-weight : bold;
	font-size : 14pt;
	color: #4d4d4d;;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;
  }

    span#status3{
  	width: 53px;
	height: 25px;
	background-color: #ff9999;
	border-radius: 20%;
	color: black;
	text-align: center;
	/* border: 1px solid #ccced0; */
	margin: auto;

	}

  div#modal-body{

 	height: 100%;
 	margin-bottom: 30px;
  }

  div#startContents{
  	height: 638px;
  }

  span#sizebold{
   font-size: 12pt;
   font-weight: bold;
  }

  div#parent {
  	width: 100%;
    display: flex;
  }

  div#icon{
  	flex:1

  }



   div#iconhover:hover {
  	width: 63px;
  	height: 32px;
  	background-color: #efefef;
	cursor: pointer;
	border-radius: 15px;
	}

  div#child{
  	flex:9
  }

  button#denial {
  width: 65px;
  height: 35px;
  border : 1px solid #ccced0;
  border-radius: 17.5px;
  background: white;
  margin-top: 30px;
  font-size: 12pt;
  padding: 4px 5px;
  font-weight: bold;
  color : #404040;

  }

  button#accept {
  width: 75px;
  height: 35px;
  border : 1px solid #39ac39;
  border-radius: 17.5px;
  background: #53c653;
  margin-top: 30px;
  font-size: 12pt;
  padding: 4px 5px;
  font-weight: bold;
  color : white;

  }

  .bhover:hover {
  	background-color: #efefef;
	transition: 0.7s;
  }

  span.font{
  font-size: 13pt;
  font-weight:bold;
  color:#404040;
  }

  .p:hover {
 	background-color: #efefef;
    transition: 0.7s;
    height:30px;
    border-radius: 15px;
  }

    button.bottom-line {

  	padding : 0px 0px 10px 0px;
  	margin-right: 20px;
  	background-color: white;
  	border: none;


  }

  .rightFirst {
  	overflow-y: scroll;
  	height: 780px;
  }

  	.rightFirst::-webkit-scrollbar {
    	width: 10px;
  	}
  	.rightFirst::-webkit-scrollbar-thumb {
    	background-color: #d9d9d9;
    	border-radius: 10px;
  	}
  	.rightFirst::-webkit-scrollbar-track {
    	background-color: #f2f2f2;
    	border-radius: 10px;
  	}


  .startContents {
  	overflow-y: scroll;
  }

  .startContents::-webkit-scrollbar {
    	width: 10px;
  	}
  	.startContents::-webkit-scrollbar-thumb {
    	background-color: #d9d9d9;
    	border-radius: 10px;
  	}
  	.startContents::-webkit-scrollbar-track {
    	background-color: #f2f2f2;
    	border-radius: 10px;
  	}

	button#delete{

	float: right;
	margin-right: 45px;
	background-color: white;
	border: 2px solid #bfbfbf;
	border-radius :5px;
	width: 26px;
	height: 26px;
	padding: 0px;

	}

	button#delete:hover {
 	background-color: #efefef;
  }
</style>
<script type="text/javascript">

	$(document).ready(function() {
		const activePath = localStorage.getItem('activePath') || window.location.pathname;

		$("a.link").each(function() {
			if ($(this).attr("href") === activePath) {
				$(this).addClass("active");
			}
		});
	});


	function loadDocuments(type) {
		$.ajax({
			type: "GET",
			url: "/docList/changeList",
			dataType: "json",
			data: {
				pageNum: 1,
				type: type
			},
			success: function(data) {
				var tableBody = $("#documentTable tbody");
				tableBody.empty();  // 기존 데이터를 지우고 새로운 데이터를 추가
				$.each(data.resultList, function(index, doc) {
					var rowHtml = $('<tr>')
							.attr('onclick', "documentDetailView(" + doc.docId + ", " + doc.docType + ")") // 클릭 시 상세보기 함수 호출
							.append('<td>' + doc.docTypeName + '</td>') // 결재 분류
							.append('<td>' + doc.docTitle + '</td>')    // 결재 제목
							.append('<td>' + doc.createdDate + '</td>') // 작성일
							.append('<td>' + doc.docStatusName + '</td>'); // 결재 상태
					tableBody.append(rowHtml);
				});
				// 페이징 표시 함수 호출
				updateButtonStyles(type);
				pageNumDisplay(data.pager);
			},
			error: function(xhr, status, error) {
				console.error("데이터 조회 실패:", error);
			}
		});
	}

	function updateButtonStyles(activeType) {
		// 버튼 스타일을 조건에 따라 동적으로 설정
		$("#wating").css("color", activeType === "pending" ? "black" : "gray")
				.css("border-bottom", activeType === "pending" ? "4px solid #00cc00" : "none");
		$("#mine").css("color", activeType === "underApproval" ? "black" : "gray")
				.css("border-bottom", activeType === "underApproval" ? "4px solid #00cc00" : "none");
		$("#complete").css("color", activeType === "complete" ? "black" : "gray")
				.css("border-bottom", activeType === "complete" ? "4px solid #00cc00" : "none");
	}

	function selectDocumentSearchList(pageNum,type) {
		$.ajax({
			type: "GET",
			url: "/docList/changeList",
			dataType: "json",
			data: {
				pageNum: pageNum,
				type: 'approval'
			},
			success: function(data) {
				var tableBody = $("#documentTable tbody");
				tableBody.empty();  // 기존 데이터를 지우고 새로운 데이터를 추가
				$.each(data.resultList, function(index, doc) {
					var rowHtml = $('<tr>')
							.attr('onclick', "documentDetailView(" + doc.docId + ", " + doc.docType + ")") // 클릭 시 상세보기 함수 호출
							.append('<td>' + doc.docTypeName + '</td>') // 결재 분류
							.append('<td>' + doc.docTitle + '</td>')    // 결재 제목
							.append('<td>' + doc.createdDate + '</td>') // 작성일
							.append('<td>' + doc.docStatusName + '</td>'); // 결재 상태
					tableBody.append(rowHtml);
				});
				// 페이징 표시 함수 호출
				pageNumDisplay(data.pager);
			},
			error: function(xhr, status, error) {
				console.error("데이터 조회 실패:", error);
			}
		});
	}

	function setActiveLink(element) {
		$("a.link").removeClass("active");
		$(element).addClass("active");

		localStorage.setItem('activePath', $(element).attr("href"));
	}

	/*페이징 그리기*/
	function pageNumDisplay(pager) {
		var pageNumDiv = $("#pageNumDiv");
		pageNumDiv.empty();
		if (pager.startPage > pager.blockSize) {
			pageNumDiv.append(
					'<a href="javascript:selectDocumentSearchList(' + pager.prevPage + ');">' +
					'<button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&lt;</button>' +
					'</a>'
			);
		}
		for (var i = pager.startPage; i <= pager.endPage; i++) {
			if (pager.pageNum !== i) {
				pageNumDiv.append(
						'<a class="page-numbox" href="javascript:selectDocumentSearchList(' + i + ');">' + i + '</a>'
				);
			} else {
				pageNumDiv.append(
						'<a class="page-num is-active" disabled>' + i + '</a>'
				);
			}
		}
		if (pager.endPage < pager.totalPage) {
			pageNumDiv.append(
					'<a href="javascript:selectDocumentSearchList(' + pager.nextPage + ');">' +
					'<button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&gt;</button>' +
					'</a>'
			);
		}
	}


	function documentDetailView(docId, docType){
		let docTypeCode = parseInt(docType);
        let referenceType = "doc";
		// 상태 코드에 따른 파라미터 설정
		if (docTypeCode === 1) {
			fullUrl = "/approval/annualLeaveView?docId=" + docId;
		} else if (docTypeCode === 2) {
			fullUrl = "/approval/expenseDetailView?docId=" + docId + "&referenceType=" + referenceType ;
		} else if (docTypeCode === 3) {
			fullUrl = "/doc/doc1040View?docId=" + docId + "&referenceType=" + referenceType ;
		} else if (docTypeCode === 4) {
			fullUrl = "/doc/doc1040View?docId=" + docId + "&referenceType=" + referenceType ;
		} else if (docTypeCode === 5) {
			fullUrl = "/doc/doc1050View?docId=" + docId + "&referenceType=" + referenceType ;
		} else if (docTypeCode === 6) {
			fullUrl = "/doc/doc1060View?docId=" + docId + "&referenceType=" + referenceType ;
		} else {
			// docType이 예상치 못한 값일 경우 기본 URL로 설정
			fullUrl = "/defaultView?docId=" + docId;
		}

		// 생성된 URL로 이동
		window.location.href = fullUrl;
	}
</script>
<div style="padding-top: 35px; padding-left: 40px; padding-bottom: 35px;">
	<c:if test="${role <= 3}}">
		<span>
			<a class="link" href="/docPendingList" onclick="setActiveLink(this)" style="font-size: 27pt; font-weight: bold;">
				회사 문서함
			</a>
		</span>
	</c:if>
	<span>
		<a class="mylink link" href="/docList" onclick="setActiveLink(this)" style="font-size: 27pt; font-weight: bold; padding-right: 20px;">
			내 문서함
		</a>
	</span>
	<select>
		<option>지출결의서</option>
		<option>근태계</option>
	</select>
	<button type="button" class="headerBtn" style="margin-left : 0px; float:right; margin-right:10px;" onclick="javascript:location.href='/doc/selectWrite'">
		<i class="bi bi-pencil-fill"></i>
		작성하기
	</button>
</div>
<div class="border-top"></div>

<div class="" >
 <div >
    	 <div style="padding:15px 10px 0px 35px;">
			 <c:choose>
				 <c:when test="${role <= 3}">
					 <button class="bottom-line" id="wating" style="border-bottom : 4px solid #00cc00;" onclick="loadDocuments('pending')">
						 <span id="subject" class="doc1" style="color:black;">결재 승인 대기 문서 ${role}</span><span id="number" class="num1"></span>
					 </button>
				 </c:when>
				 <c:otherwise>
					 <button class="bottom-line" id="mine" style="border-bottom : 4px solid #00cc00;" onclick="loadDocuments('underApproval')">
						 <span id="subject" class="doc2" style="color:gray;">결재 중 문서 </span><span id="number" class="num2"></span>
					 </button>
				 </c:otherwise>
			 </c:choose>
	    		<button class="bottom-line" id="complete"  onclick="loadDocuments('complete')">
	    			<span id=subject class="doc3" style="color:gray;">완료</span> <span id="number" class="num3"> </span>
	    		</button>
    	 </div>
	    <div id="documentContent" class="border-top" >
	    	<div id="startContents" class="border-bottom startontents">
				<div id="search_result" style="padding : 10px;">
					<table id="documentTable" class="table table-bordered table-hover" style="margin-top: 20px;">
						<thead>
							<th style="width:7%">결재 분류</th>
							<th class="th_100">결재 제목</th>
							<th style="width: 10%">작성일</th>
							<th style="width: 10%">결재 상태</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach var="doc" items="${documents}">
							<tr onclick="documentDetailView(${doc.docId}, ${doc.docType})">
								<td>${doc.docTypeName}</td>
								<td>${doc.docTitle}</td>
								<td>${doc.createdDate}</td>
								<td>${doc.docStatusName}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="container">
				<div id="pageNumDiv" class="pagination p12">
					<c:if test="${pager.startPage > pager.blockSize}">
						<!-- 스크립트는 검색하는 param값-->
						<a href="javascript:selectDocumentSearchList('${pager.prevPage}');" style="padding-top: 3px;">
							<button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&lt;</button>
						</a>
					</c:if>
					<c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
						<c:choose>
							<c:when test="${pager.pageNum != i}">
								<a class="page-numbox" href="javascript:selectDocumentSearchList('${i}');">${i}</a>
							</c:when>
							<c:otherwise>
								<a class="page-num is-active" disabled>${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pager.endPage < pager.totalPage}">
						<a href="javascript:selectDocumentSearchList();" class="" style="padding-top: 3px;">
							<button type="button" class="btn btn-secondary" style="background-color: #2ecc71; border-color: #2ecc71">&gt;</button>
						</a>
					</c:if>
				</div>
			</div>
	    </div>
	<!-- ajax 올릴 것 끝1 -->
	</div>
  </div>
<!-- 모달창 시작  -->
<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <div class="modal-title fs-2" id="exampleModalLabel" style="font-weight: bold; font-size: 15pt;">승인 · 참조 현황</div>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modal-body">
		    <!-- <div id="modalContents">
		    	<span id="modalNumber" style="	margin-top: 10px; margin-left : 30px; ">&nbsp;&nbsp;1&nbsp;&nbsp;</span>
		    	<span id="modalSubContents">
		    		<span id="modalprof">지현</span>
					<span id="statusstatus" style="font-size: 9pt; padding: 5px;"> 진행중</span>
		    	</span>
		    </div> -->
		    <!-- 내용 시작 -->
		    <!-- <div id="approvalModal"> -->
      	</div>
    </div>
  </div>
</div>
</div>
<!-- 모달창 끝 -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">