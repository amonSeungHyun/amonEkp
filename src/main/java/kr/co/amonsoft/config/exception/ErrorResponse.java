package kr.co.amonsoft.config.exception;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;

@Getter
public class ErrorResponse {

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime timestamp; // 발생시간
    private int statusCode;                 // 에러 상태 코드
    private String resultMsg;           // 에러 메시지


    @Builder
    protected ErrorResponse(final DuplicateItemException ex) {
        this.timestamp = LocalDateTime.now();
        this.resultMsg = ex.getMessage();
        this.statusCode = HttpStatus.CONFLICT.value();
    }

    public static ErrorResponse getDuplicateExResponse(final DuplicateItemException ex) {
        return new ErrorResponse(ex);
    }
}
