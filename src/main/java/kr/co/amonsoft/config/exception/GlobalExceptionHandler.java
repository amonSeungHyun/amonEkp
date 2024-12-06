package kr.co.amonsoft.config.exception;

import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Log4j2
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * DuplicateItemException handler
     *
     * @param ex 항목이 중복되었을시 발생되는 custom exception
     * @return 에러에 대한 응답 처리 객체
     */
    @ExceptionHandler(DuplicateItemException.class)
    public ResponseEntity<ErrorResponse> handleDuplicateItemException(DuplicateItemException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT).body(ErrorResponse.getDuplicateExResponse(ex));
    }


}
