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

    List<Map<String,Object>> findApprovalStepsByDocId(BigInteger  docId);

    List<Map<String,Object>> findExpenseDetailsByDocId(BigInteger docId);

    int updateApprovalStatus(Map<String,Object> param);

    int updateDocumentCurrentStep(int docId);

    Map<String,Object> findTeamLeadersByUserOrganization(String userId);

    List<Map<String,Object>> findDocumentsUnderApproval(String userId);

    Map<String, Object> findDocumentCreatorInfo(BigInteger docId);

    Map<String, Object> findStepNoByDocIdAndUserId(Map<String, Object> param);

    Map<String, Object> findCurrentStepNo(BigInteger docId);

    List<Map<String,Object>> findPendingApprovalDocuments(String userId);

    int updateDocumentCompletionStatus(int docId);

    List<Map<String, Object>> findCompleteDocuments(String userId);
}
