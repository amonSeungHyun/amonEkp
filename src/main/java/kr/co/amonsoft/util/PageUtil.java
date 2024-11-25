package kr.co.amonsoft.util;

import java.util.HashMap;
import java.util.Map;

public class PageUtil {

    private static final int DEFAULT_PAGE_NUM = 1;
    private static final int DEFAULT_PAGE_SIZE = 10;
    private static final int DEFAULT_BLOCK_SIZE = 10;

    public static Map<String, Object> getPagingParams(int pageNum, int totalCnt) {

        int pageSize = DEFAULT_PAGE_SIZE;  // 페이지 크기
        int blockSize = DEFAULT_BLOCK_SIZE;  // 블록 크기

        // 총 페이지 수 계산
        int totalPage = (int) Math.ceil((double) totalCnt / pageSize);

        // pageNum이 1보다 작거나 totalPage보다 큰 경우 보정
        pageNum = Math.max(1, Math.min(pageNum, totalPage));

        // offset 보정 (음수 방지)
        int offset = Math.max(0, (pageNum - 1) * pageSize);

        // 각 페이지의 시작/끝 행 계산
        int startRow = (pageNum - 1) * pageSize + 1;
        int endRow = Math.min(pageNum * pageSize, totalCnt);

        // 페이징 블록 계산
        int startPage = ((pageNum - 1) / blockSize) * blockSize + 1;
        int endPage = Math.min(startPage + blockSize - 1, totalPage);

        // 이전/다음 페이지 계산
        int prevPage = Math.max(startPage - blockSize, 1);
        int nextPage = Math.min(startPage + blockSize, totalPage);

        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("offset", offset);
        pagingParams.put("limit", pageSize);
        pagingParams.put("startRow", startRow);
        pagingParams.put("endRow", endRow);
        pagingParams.put("totalPage", totalPage);
        pagingParams.put("totalCnt", totalCnt);
        pagingParams.put("pageNum", pageNum);
        pagingParams.put("startPage", startPage);
        pagingParams.put("endPage", endPage);
        pagingParams.put("prevPage", prevPage);
        pagingParams.put("nextPage", nextPage);

        return pagingParams;
    }

}
