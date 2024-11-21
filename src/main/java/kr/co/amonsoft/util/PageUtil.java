package kr.co.amonsoft.util;

import java.util.HashMap;
import java.util.Map;

public class PageUtil {

    private static final int DEFAULT_PAGE_NUM = 1;
    private static final int DEFAULT_PAGE_SIZE = 10;
    private static final int DEFAULT_BLOCK_SIZE = 10;

    public static Map<String, Object> getPagingParams(int pageNum, int totalCnt) {

        int pageSize =  DEFAULT_PAGE_SIZE;
        int blockSize = DEFAULT_BLOCK_SIZE;

        int totalPage = (int) Math.ceil((double) totalCnt / pageSize);
        pageNum = Math.min(Math.max(pageNum, 1), totalPage);

        int offset = (pageNum - 1) * pageSize;

        int startRow = (pageNum - 1) * pageSize + 1;
        int endRow = Math.min(pageNum * pageSize, totalCnt);

        int startPage = ((pageNum - 1) / blockSize) * blockSize + 1;
        int endPage = Math.min(startPage + blockSize - 1, totalPage);

        int prevPage = Math.max(startPage - blockSize, 1);
        int nextPage = startPage + blockSize;

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
