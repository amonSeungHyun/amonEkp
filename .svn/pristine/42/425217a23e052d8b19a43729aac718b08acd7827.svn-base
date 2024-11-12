package kr.co.amonsoft.mapper.doc;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface Doc1010Mapper {

    void insertApprovalStep(Map<String, Object> approvalStep);

    void insertDocument(Map<String, Object> param);

    void insertVacationDetail(Map<String, Object> expenseDetail);

    List<Map<String,Object>> findApprovalStepsByDocId(BigInteger  docId);

    Map<String,Object> findVacationDetailsByDocId(BigInteger docId);

    int updateAnnualLeaveApprovalStep(Map<String,Object> param);

    int updateDocumentCurrentStep(int docId);

    Map<String,Object> findTeamLeadersByUserOrganization(String userId);

    List<Map<String,Object>> findDocumentsUnderApproval(String userId);

    Map<String, Object> findDocumentCreatorInfo(BigInteger docId);
}
