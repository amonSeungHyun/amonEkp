<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	/* 공지 상세 사이드 모달  */
	
	div#myListModal {
		/* border:solid 2px green; */
		width: 40%;
		height: 100%;
		overflow: auto;
		display: flex;
		flex-direction: column;
		position: fixed;
		top: 0px;
		left: 2000px;
		z-index: 1052;
		background: white;
		border-radius: 0.3rem;
		color: black;
		transition: all 0.5s; 
		padding: 5px;
	}

	div#myListModal.active {
		top: 0px;
		left: 60%;
	}
	
	div#myListModal_outside {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.2);
		z-index: 1051;
		display: none;
	}
	
	div.modalHeader {
		width: 90%;
		margin: auto 5%;
		height: 7%;
		padding-top: 15px;
	}
	
	div.modalBody {
		width: 90%;
		margin: auto 5%;
	/*	height: 100%; */
	}
	
	div.modalFooter {
		width: 90%;
		margin: auto 5%;

	}
	
	/* 공지 상세 모달 content  */
	
	div.modal-listContent {
		width: 90%;
		margin: auto 5%;
	}
	
	div.modal-cmtContent {
		width: 90%;
		margin: auto 5%;
	}
	
	
	span.modalBage {
		font-size:14px; 
		font-weight: normal; 
		margin-right: 7px;
	}
	
	textarea {
		width: 100%;
		margin: 20px 0 5px 0;
		border: 1px solid #dddddd;
		border-radius: 0.4rem;
	}
	
	button.commentBnt, 
	button.commentCancleBnt {
		width: 70px;
		height: 30px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 15px;
		font-weight: bold;
		font-size : 11pt;
		text-align : center;
		background-color: #07b419;
		color: white;
	}
	
	button.MYcommentBnt,
	button.MYcommentCancelBnt {
		width: 40px;
		height: 20px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 10px;
		font-weight: bold;
		font-size : 9pt;
		text-align : center;
		background-color: #FFFFFF;
		color: #07b419;
	}
	
	button.cmtEditBnt {
		width: 40px;
		height: 20px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 10px;
		font-weight: bold;
		font-size : 9pt;
		text-align : center;
		background-color: #07b419;
		color: white;
	}
	
	 button.commentBnt:hover, 
	 button.commentCancleBnt:hover,
	 button.MYcommentBnt:hover,
	 button.MYcommentCancelBnt:hover, 
	 button.cmtEditBnt:hover {
		filter: brightness(90%);
	}
	
	#prof {
		margin-bottom: 10px;
	}
	
	/* 파일 다운로드 링크  */
	a.filedown:link, a.filedown:visited, a.filedown:active, a.filedown:hover {
		text-decoration: none;
		color: #9e9e9e;
	}
	
	
	
	/*  프로필 */
	span#prof{
		width: 5px; 
		height: 5px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 10px;
		border: 1px solid #ccced0;
		font-weight: bold;
		font-size: 10pt;
		margin: auto 5px;
	}
	
	textarea#commentContent:focus {
		outline : 2px solid #66cc66;
		border-radius: 0.5rem;
		
	}
	
	div.commentrow {
		align-content: center;
		border: 1px solid #e8e5e5;
		border-radius: 0.5rem;
		
	}
	
	div.commentrow:hover {
		background-color: #f4f2f2;
		border-radius: 0.5rem;
	}

</style>    
    
<script type="text/javascript">

			
			
</script>    
    
    
 <%-- 공지 상세 모달 클릭 시 배경 fade out --%>   
 <div id="myListModal_outside"></div>
    

<%-- 게시글 상세 Modal --%>
<div id="myListModal">
    <%-- Modal content --%>
    <div class="modalHeader">
    	<span style="font-size:20px;">&#128226;</span><span class="myListModalTitle ml-3" style="font-size: 20px; font-weight: bold;"> 부서 공지 </span>
     	<button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
    </div>
   	<div class="modalBody">
  	 	<div class="modal-listContent"> 
				<div>
		 			<span class="mt-2 mb-2" style="font-size: 13pt;"><span id="prof" class="py-2">브래드</span><span id="name"> 작성자  ▶ 인사부</span></span>
		 			<div style="float: right;">
		  			<span class="badge badge-pill badge-dark py-1" style="font-size: 10pt;">작성일</span>
		  			<span id="writedate" class="badge badge-pill badge-dark py-1" style="font-size: 10pt;">2022-12-25</span>
		 			</div>
		   		</div>
		     	<div style="margin: 5px auto; clear: right;">
		      	<span  id="subject" class="badge badge-light mt-3" style="margin-top: 10px; font-size: 13pt;">공지제목 쓰는 곳 &nbsp;</span>
		     	</div>
		     	
		     	<div class="filedownload" >
		           <span style="font-size:10pt;"><span style='font-size:20px;'>&#128194;</span>
					<span id="noticeFile"></span>
					<input type="hidden" id="file_notino" name="notino" value=""/>
		           </span>
		        </div>
		        
		        
		     	<div>
		     		<span style="display: block; margin-top: 20px; margin-bottom: 10px;"> <span style='font-size:20px;'>&#128312;</span> 공지 내용 </span>
		     		<span id="content" style="display: block; height: 200px; width: 100%; border: 1px solid #e0e0e0; color:gray; overflow: auto;">작성된 공지 내용 들어가는 곳</span>
		     	</div>
     			<input id="notino" type="hidden">
     			
				 <%-- 댓글 입력란 시작 --%>     	
	
		    	 	
		     	 <div style="margin: 30px 0;">
		      	 <span style="font-size: 16px;">&#128313; 댓글</span>
		   		 <div class="commentBox">
		   		 
		      	 <%-- 댓글폼 --%>
		    	<form id="commentFrm" name="commentFrm" style="resize: none; width:100%; margin: 0;">
		       	<textarea id="commentContent" name="content" maxlength="50"  placeholder="댓글을 입력하세요." style="resize: none; width:100%; height: 20%; margin: 0;"></textarea>
		       	<div class="mt-2">
		       		<button type="button" class="commentBnt" onclick="goAddCmt()">댓글쓰기</button>
					<button type="reset" class="commentCancleBnt">취소</button>
		        	<div class="textLengthWrap" style="float: right; color: #808080;">
				   		<span class="textCount">0자</span>
				    	<span class="textTotal">/50자</span>
					</div>
				</div>
				<input type="hidden" name="fk_empno" id="fk_empno"  value="${sessionScope.loginuser.empno}" />  
				<input type="hidden" name="fk_notino" id="fk_notino"  />
	    		</form>
	    		
	    	</div>
			</div> <%-- 댓글 입력란 끝 --%>   
			
	
			</div>
		</div> <%-- modal body --%>
			
		<div  class="modalFooter">
			<div class="modal-cmtContent " id="showCmt">
		      
		      	<%-- 댓글 내용 --%> <%-- 내가 쓴 댓글은 수정, 삭제 버튼 나오게 하기 / 수정시 댓글내용은 입력폼으로 변경된다. --%>
		      	<%--
		      	<div class="mt-3 mb-2" >
		      	
		      	
		      	
		      	<div class="commentrow  px-2 py-2" >
		       	<span class="mt-2 mb-3" style="font-size: 10pt; color: gray;"> ┗ <span id="prof" class="py-2">작성자</span><span class="ml-1 mr-1" id="fk_empno" >김땡땡</span><span class="ml-3" id="cmtWritedate">2022-11-30</span></span>
		       	<div style="display:inline;	float: right;">
	     			<button type="button" class="MYcommentBnt mr-0" >수정</button> 
	     			<button type="button" class="MYcommentCancelBnt mr-0">삭제</button>
	      		</div>
	      		<div class="mt-3">
	       		<span class="commentrow mt-3 mb-4" style="font-size: 10pt; color: gray;" id="cmtContent"> &nbsp; ▶ 좋은 댓글 작성합니다.</span>
	       		<button type="button" class="cmtEditBnt mr-0" style="float: right;">확인</button>
		       	</div>
		       	</div>	
		       	
		       	<hr>
		       
		  		</div>  댓글내용 끝 
		  		--%>
	  		</div>
	  	</div><%-- footer  끝 --%>
	  	
</div>


	    

