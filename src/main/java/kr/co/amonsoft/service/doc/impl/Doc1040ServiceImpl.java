package kr.co.amonsoft.service.doc.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.amonsoft.mapper.apv.ApvCommonMapper;
import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.mapper.doc.Doc1040Mapper;
import kr.co.amonsoft.mapper.doc.DocCommonMapper;
import kr.co.amonsoft.service.doc.Doc1040Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class Doc1040ServiceImpl implements Doc1040Service {

	private final DocCommonMapper docCommonMapper;
    private final ApvCommonMapper apvCommonMapper;
    private final Doc1040Mapper doc1040Mapper;
    
    @Override
    public Map<String, Object> getApprovalId() {
        return doc1040Mapper.getApprovalId();
    }

	@Override
	public BigInteger insertApprovalRequest(Map<String, Object> param) {
		docCommonMapper.insertDocument(param);
		BigInteger docId = (BigInteger) param.get("docId");
		
		List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) param.get("approvalData");
        approvalStep.forEach(step -> {
            step.put("docId", docId);
            apvCommonMapper.insertApprovalStep(step);
        });
		
        List<Map<String, Object>> approvalRequestData = (List<Map<String, Object>>) param.get("data");
        approvalRequestData.forEach(detail -> {
            detail.put("docId", docId);
            detail.put("userId", param.get("userId"));
            doc1040Mapper.insertApprovalRequest(detail);
        });
        
        return docId;
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
    public List<Map<String, Object>> findExpenseDetailsByDocId(BigInteger docId) {
        return doc1020Mapper.findExpenseDetailsByDocId(docId);
    }


*/
}
