package kr.co.amonsoft.mapper.doc;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface Doc1020Mapper {

    void insertApprovalStep(Map<String, Object> approvalStep);

    void insertDocument(Map<String, Object> param);

    void insertExpenseDetail(Map<String, Object> expenseDetail);

    List<Map<String,Object>> findExpenseDetailsByDocId(BigInteger docId);

}
