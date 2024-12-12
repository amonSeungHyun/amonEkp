<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fileDownload/1.4.2/jquery.fileDownload.min.js"></script>
<style>
    .filebox .upload-name {
        display: inline-block;
        height: 40px;
        padding: 0 10px;
        vertical-align: middle;
        border: 1px solid #dddddd;
        width: 70%;
        border-radius: 0.4rem;
        color: #999999;
    }
    .filebox label {
        display: inline-block;
        padding: 9px 20px;
        color: #fff;
        vertical-align: middle;
        text-align: center;
        background-color: #88eb1e;
        cursor: pointer;
        width : 25%;
        height: 40px;
        margin-left: 5px;
        margin-top: 5px;
        border-radius: 0.4rem;
    }
    /* CSS 정리된 스타일 */

    .table-area {
        border:0.75pt solid #000000;
        border-collapse:collapse;
        margin:10px;
        float: left;
    }
    .clearfix::after {
        content: "";
        clear: both;
        display: table;
    }

    .file-area {
        width: 50%; /* 영역 너비 */
        border: 2px solid #dddddd; /* 테두리 추가 */
        border-radius: 0.5rem;
        padding: 15px;
        margin: 10px;
        margin-left: 20px;
        float: left;
    }
    /* Additional styles for table formatting and inputs */
    .filebox input[type="file"] {
        display: none;
    }

    .filebox {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }

    .filebox .file-text {
        color: #999999;
        font-size: 16px;
        margin-right: 10px;
    }

    .filebox .add-file-btn {
        background-color: #88eb1e;
        color: #fff;
        border: none;
        padding: 9px 15px;
        border-radius: 0.4rem;
        cursor: pointer;
    }

    .uploaded-files {
        border-top: 1px solid #dddddd;
        padding-top: 10px;
        margin-top: 10px;
    }

    .uploaded-file {
        display: flex;
        align-items: center;
        margin-top: 5px;
    }

    .uploaded-file-name {
        width: 60%;
        border: 1px solid #dddddd;
        padding: 5px;
        border-radius: 0.4rem;
        margin-right: 10px;
        color: #333;
    }

    .download-btn, .delete-btn {
        background-color: #f0f0f0;
        border: 1px solid #dddddd;
        padding: 5px 10px;
        border-radius: 0.4rem;
        cursor: pointer;
        margin-right: 5px;
    }
</style>
<script>
    $(document).ready (function() {
        $("#file").on('change', function () {
            var fileName = $("#file").val();
            $(".upload-name").val(fileName);
        });
        $('.add-file-btn').on('click', function () {
            $('#fileInput').click();
        });

        $('#fileInput').on('change', function () {

            var fileList = this.files;
            const formData = new FormData();

            $.each(fileList, function (i, file) {

                formData.append("files", file);
            });

            // FormData 확인
            formData.forEach((value, key) => {
                console.log(key, value);
            });

            if (fileList.length === 0) {
                console.log("FormData에 파일이 추가되지 않았습니다.");
            }

            var $uploadedFilesContainer = $('.uploaded-files');

            // 선택한 파일들을 반복하여 파일 리스트 생성
            $.each(fileList, function (index, file) {
                var $fileItem = $('<div class="uploaded-file"></div>');

                // 파일명 표시하는 입력 필드
                var $fileNameInput = $('<input class="uploaded-file-name" readonly>').val(file.name);


                // 삭제 버튼
                var $deleteButton = $('<button class="delete-btn">-</button>').on('click', function () {
                    $fileItem.remove();
                    $('#fileInput').val("");
                });

                // 파일 아이템에 파일명, 다운로드, 삭제 버튼 추가
                $fileItem.append($fileNameInput, $deleteButton);

                // 파일 목록 영역에 파일 아이템 추가
                $uploadedFilesContainer.append($fileItem);
            });
        });
    });

    function downloadFile(fileId){
        alert(fileId);
        $.fileDownload('/file/download', {
            httpMethod: 'POST', // POST 방식 설정
            data: { fileId: fileId }, // 서버로 전송할 데이터
            successCallback: function (url) {
                alert("파일 다운로드 성공!");
            },
            failCallback: function (responseHtml, url) {
                alert("파일 다운로드 실패!");
                console.error("다운로드 실패 URL:", url);
            }
        });
    }
</script>
<c:if test="${not empty currentStepNo.currentStep && not empty fileList}">
<div class="file-area" id="attachArea">
    <div class="filebox">
        <span class="file-text">파일 찾기</span> <!-- 그레이 색상 텍스트 -->
    </div>
    <div class="uploaded-files">
        <c:forEach var="file" items="${fileList}" >
            <div class="uploaded-file">
                <input class="uploaded-file-name" readonly value="${file.originalFileName}">
                <button type="button" onclick="downloadFile(${file.fileId})" class="download-btn">다운로드</button>
            </div>
        </c:forEach>
    </div> <!-- 선택된 파일 목록이 표시될 영역 -->
</div>
</c:if>
<c:if test="${not empty currentStepNo.currentStep && empty fileList}">
    <div class="file-area" id="attachArea">
        <div class="filebox">
            <span class="file-text">파일 찾기</span> <!-- 그레이 색상 텍스트 -->
            <div>파일이 존재하지않습니다.</div>
        </div>
        <div class="uploaded-files"></div> <!-- 선택된 파일 목록이 표시될 영역 -->
    </div>
</c:if>
<c:if test="${empty currentStepNo.currentStep && empty fileList}">
    <div class="file-area" id="attachArea">
        <div class="filebox">
            <span class="file-text">파일 찾기</span> <!-- 그레이 색상 텍스트 -->
            <button type="button" class="add-file-btn">+</button>
            <input type="file" id="fileInput" multiple style="display: none;">
        </div>
        <div class="uploaded-files"></div> <!-- 선택된 파일 목록이 표시될 영역 -->
    </div>
</c:if>
