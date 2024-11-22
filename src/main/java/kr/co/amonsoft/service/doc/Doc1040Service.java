package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Doc1040Service {

    Map<String,Object> getApprovalId();

    BigInteger insertApprovalRequest(Map<String, Object> param);

	Map<String, Object> findApprovalRequestDetailsByDocId(BigInteger docId);

}
