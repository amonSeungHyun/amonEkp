package kr.co.amonsoft.config.exception;

/**
 * 중복된 데이터로 요청시 발생되는 custom exception
 */
public class DuplicateItemException extends RuntimeException {

    public DuplicateItemException(String message) {
        super(message);
    }
}
