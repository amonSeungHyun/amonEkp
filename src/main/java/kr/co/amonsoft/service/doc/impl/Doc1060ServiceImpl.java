package kr.co.amonsoft.service.doc.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.mapper.doc.Doc1040Mapper;
import kr.co.amonsoft.service.doc.Doc1060Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class Doc1060ServiceImpl implements Doc1060Service {

    private final Doc1040Mapper doc1040Mapper;
    
	@Override
	public void insertTransportExpense(Map<String, Object> param) {
		Map<String,Object> documentMap = new HashMap<>();
		List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) param.get("approvalData");
		List<Map<String, Object>> expenseDetailData = (List<Map<String, Object>>) param.get("expenseDetailData");
		
		documentMap.put("userId", param.get("userId"));
		documentMap.put("docTitle", param.get("docTitle"));
		documentMap.put("docType", "06");
		
		// document 추가
        doc1040Mapper.insertDocumentApproval(documentMap);
        
        // 생성된 docId를 가져옵니다.
        BigInteger docId = (BigInteger) documentMap.get("docId");
                
        // 결재선
        approvalStep.forEach(step -> {
            step.put("docId", docId);
            step.put("create_id", param.get("userId"));
            doc1040Mapper.insertApprovalRequestStep(step);
        });
        
        // 교통비
        expenseDetailData.forEach(detail -> {
            detail.put("docId", docId);
            detail.put("create_id", param.get("userId"));
            doc1040Mapper.insertTransportExpense(detail);
        });
        
	}
	
	@Override
    public Map<String, Object> findApprovalRequestDetailsByDocId(BigInteger docId) {
        return doc1040Mapper.findApprovalRequestDetailsByDocId(docId);
    }

	@Override
	public List<Map<String, Object>> findTransportExpenseDetailsByDocId(BigInteger docId) {
		return doc1040Mapper.findTransportExpenseDetailsByDocId(docId);
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
