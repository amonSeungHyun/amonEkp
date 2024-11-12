package kr.co.amonsoft.service.doc.impl;

import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.service.doc.Doc1020Service;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class Doc1020ServiceImpl implements Doc1020Service {

    private final Doc1020Mapper doc1020Mapper;

    @Override
    public BigInteger insertApprovalDocument(Map<String, Object> approvalData) {
        doc1020Mapper.insertDocument(approvalData);

        // 생성된 docId를 가져옵니다.
        BigInteger docId = (BigInteger) approvalData.get("docId");

        // approvalStep과 expenseDetail에서 동일한 docId 사용
        List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) approvalData.get("approvalData");
        approvalStep.forEach(step -> {
            step.put("docId", docId);
            doc1020Mapper.insertApprovalStep(step);
        });

        List<Map<String, Object>>expenseDetail = (List<Map<String, Object>>) approvalData.get("expenseDetailData");
        expenseDetail.forEach(detail -> {
            detail.put("docId", docId);
            doc1020Mapper.insertExpenseDetail(detail);
        });

        return docId;
    }

    @Override
    public List<Map<String, Object>> findApprovalStepsByDocId(BigInteger docId) {
        return doc1020Mapper.findApprovalStepsByDocId(docId);
    }

    @Override
    public List<Map<String, Object>> findExpenseDetailsByDocId(BigInteger docId) {
        return doc1020Mapper.findExpenseDetailsByDocId(docId);
    }

    @Transactional
    @Override
    public int updateApprovalStatus(Map<String,Object> param) {
        int stepUpdateResult = 0;
        int approvalUpdateResult = doc1020Mapper.updateApprovalStatus(param);
        int docId = Integer.parseInt(String.valueOf(param.get("docId")));
        int userStepNo = Integer.parseInt(String.valueOf(param.get("userStepNo")));
        String roleCode = String.valueOf(param.get("roleCode"));
        //대표님 결재
        if(roleCode.equals("01")){
            stepUpdateResult = doc1020Mapper.updateDocumentCompletionStatus(docId);
        }else{
            stepUpdateResult = doc1020Mapper.updateDocumentCurrentStep(docId);
        }
        return (approvalUpdateResult > 0 && stepUpdateResult > 0) ? 1 : 0;
    }

    @Override
    public Map<String, Object> findTeamLeadersByUserOrganization(String userId) {
        return doc1020Mapper.findTeamLeadersByUserOrganization(userId);
    }

    @Override
    public List<Map<String, Object>> findDocumentsUnderApproval(String userId) {
        return doc1020Mapper.findDocumentsUnderApproval(userId);
    }

    @Override
    public Map<String, Object> findDocumentCreatorInfo(BigInteger docId) {
        return doc1020Mapper.findDocumentCreatorInfo(docId);
    }

    @Override
    public Map<String, Object> findCurrentStepNo(BigInteger docId) {
        return doc1020Mapper.findCurrentStepNo(docId);
    }

    @Override
    public Map<String, Object> findStepNoByDocIdAndUserId(BigInteger docId, String userId) {
        Map<String, Object> stepNoMap = new HashMap<>();
        stepNoMap.put("docId", docId);
        stepNoMap.put("userId", userId);
        return doc1020Mapper.findStepNoByDocIdAndUserId(stepNoMap);
    }

    @Override
    public List<Map<String, Object>> findPendingApprovalDocuments(String userId) {
        return doc1020Mapper.findPendingApprovalDocuments(userId);
    }

    @Override
    public List<Map<String, Object>> findCompleteDocuments(String userId) {
        return doc1020Mapper.findCompleteDocuments(userId);
    }

}
