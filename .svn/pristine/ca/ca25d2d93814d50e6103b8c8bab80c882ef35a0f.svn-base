package kr.co.amonsoft.service.doc;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface Doc1020Service {

    BigInteger insertApprovalDocument(Map<String, Object> approvalData);

    List<Map<String, Object>> findApprovalStepsByDocId(BigInteger docId);

    List<Map<String, Object>> findExpenseDetailsByDocId(BigInteger docId);

    int updateApprovalStatus (Map<String,Object> param);

    Map<String,Object> findTeamLeadersByUserOrganization(String userId);

    List<Map<String,Object>> findDocumentsUnderApproval(String userId);

    Map<String,Object> findDocumentCreatorInfo(BigInteger docId);

    Map<String, Object> findCurrentStepNo(BigInteger docId);

    Map<String, Object> findStepNoByDocIdAndUserId(BigInteger docId, String userId);

    List<Map<String,Object>> findPendingApprovalDocuments(String userId);

    List<Map<String, Object>> findCompleteDocuments(String userId);
}
