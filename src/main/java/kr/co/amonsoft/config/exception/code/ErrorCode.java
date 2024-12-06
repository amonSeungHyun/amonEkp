package kr.co.amonsoft.config.exception.code;

import org.springframework.http.HttpStatus;

public enum ErrorCode {
    DUPLICATED_ITEM(HttpStatus.CONFLICT.value(), "이미 결재된 사직서가 존재합니다.");

    private int statusCode;
    private String message;

    ErrorCode(int statusCode, String message) {
        this.statusCode = statusCode;
        this.message = message;
    }
}
