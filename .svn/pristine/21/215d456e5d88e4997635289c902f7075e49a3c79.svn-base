package kr.co.amonsoft.service.doc.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.mapper.doc.Doc1040Mapper;
import kr.co.amonsoft.service.doc.Doc1040Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class Doc1040ServiceImpl implements Doc1040Service {

    private final Doc1040Mapper doc1040Mapper;
    
    private final Doc1020Mapper doc1020Mapper;
    
    @Override
    public Map<String, Object> getApprovalId() {
        return doc1040Mapper.getApprovalId();
    }

	@Override
	public void insertApprovalRequest(Map<String, Object> param) {
		Map<String,Object> documentMap = new HashMap<>();
		List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) param.get("approvalData");
		Map<String, Object> approvalRequestData = (Map<String, Object>) param.get("approvalRequestData");
		
		documentMap.put("userId", approvalRequestData.get("userId"));
		documentMap.put("docTitle", approvalRequestData.get("approval_title"));
		documentMap.put("docType", "03");
		
		// document 추가
        doc1040Mapper.insertDocumentApproval(documentMap);
        
        // 생성된 docId를 가져옵니다.
        BigInteger docId = (BigInteger) documentMap.get("docId");
        
        approvalRequestData.put("doc_id", docId);
        
        doc1040Mapper.insertApprovalRequest(approvalRequestData);
        
        approvalStep.forEach(step -> {
            step.put("docId", docId);
            step.put("create_id", approvalRequestData.get("userId"));
            doc1040Mapper.insertApprovalRequestStep(step);
        });
        
	}
	
	@Override
    public Map<String, Object> findApprovalRequestDetailsByDocId(BigInteger docId) {
        return doc1040Mapper.findApprovalRequestDetailsByDocId(docId);
    }
/*
    @Override
    public BigInteger insertApprovalDocument(Map<String, Object> approvalData) {
        Map<String,Object> documentMap = new HashMap<>();
        documentMap.put("userId", "lee");
        doc1020Mapper.insertDocument(documentMap);

        // 생성된 docId를 가져옵니다.
        BigInteger docId = (BigInteger) documentMap.get("docId");

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
        int approvalUpdateResult = doc1020Mapper.updateApprovalStatus(param);
        int docId = Integer.parseInt(String.valueOf(param.get("docId")));
        int stepUpdateResult = doc1020Mapper.updateDocumentCurrentStep(docId);
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


*/
}
