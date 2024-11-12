<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
a.link:link {color: #cccccc;}
a:visited {text-decoration: none; color: #cccccc;}
a.link:hover {text-decoration: none; color: gray;}
a.mylink:hover {text-decoration: none; }
a:active {text-decoration: none; color: #cccccc;}

	button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		/*margin-left:75%;*/
		width: 100px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}
	

</style>    

<script type="text/javascript">
	function goWrite() {
		window.location.href = "/workflow";
	}
</script> 

<div style="display: flex; padding-top: 30px; padding-left: 30px; padding-bottom: 40px;]" class="border-bottom">
	 <span ><a class="mylink" href="javascript:location.href='/workflow/selectWrite'" style="color: #404040; font-size: 23pt; font-weight: bold; padding-right: 20px;"><</a></span>
	<c:if test="${empty documentCreatorInfo.docStatus}">
		<span style="color:#404040; font-size: 23pt; font-weight: bold;" onclick="javascript:location.href='/workflow/modify'">작성하기</span>
		<button type="button" class="headerBtn" onclick="goWrite();">
			<i class="bi bi-send" style="margin-right: 10px;"></i>
			결재선 지정
		</button>
		<button type="button" class="headerBtn" onclick="insertApprovalExpenseDetail();">
			<i class="bi bi-send" style="margin-right: 10px;"></i>
			 결재
		</button>
	</c:if>
	<c:if test="${not empty currentStepNo.docCurrentStep}">
		<c:if test="${currentStepNo.docCurrentStep == userStepNo.stepNo}">
			<input id="approverId" type="hidden" value="${sessionScope.userId}">
			<input id="userStepNo" type="hidden" value="${userStepNo.stepNo}">
			<button type="button" class="headerBtn" onclick="updateApproveDocument();">
				<i class="bi bi-send" style="margin-right: 10px;"></i>
				승인
			</button>
			<button type="button" class="headerBtn" onclick="updateRejectDocument();">
				<i class="bi bi-send" style="margin-right: 10px;"></i>
				반려
			</button>
		</c:if>
	</c:if>
	<button type="button" class="headerBtn" onclick="goWrite();">
		<i class="bi bi-send" style="margin-right: 10px;"></i>
		목록
	</button>
</div >


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">