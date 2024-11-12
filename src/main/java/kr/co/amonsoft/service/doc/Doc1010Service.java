package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Doc1010Service {

    BigInteger insertApprovalDocument(Map<String, Object> approvalData);

    List<Map<String, Object>> findApprovalStepsByDocId(BigInteger docId);

    Map<String, Object> findVacationDetailsByDocId(BigInteger docId);

    int updateAnnualLeaveApprovalStep (Map<String,Object> param);

    Map<String,Object> findTeamLeadersByUserOrganization(String userId);

    List<Map<String,Object>> findDocumentsUnderApproval(String userId);

    Map<String,Object> findDocumentCreatorInfo(BigInteger docId);
}
