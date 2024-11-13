package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Doc1020Service {

    BigInteger insertApprovalDocument(Map<String, Object> approvalData);

    List<Map<String, Object>> findExpenseDetailsByDocId(BigInteger docId);
}
