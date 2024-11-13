package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Doc1010Service {

    BigInteger insertApprovalDocument(Map<String, Object> approvalData);

    Map<String, Object> findVacationDetailsByDocId(BigInteger docId);

    int updateAnnualLeaveApprovalStep (Map<String,Object> param);

}
