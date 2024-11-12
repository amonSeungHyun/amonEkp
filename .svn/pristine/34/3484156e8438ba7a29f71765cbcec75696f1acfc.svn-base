package kr.co.amonsoft.service.doc.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.mapper.doc.Doc1040Mapper;
import kr.co.amonsoft.mapper.doc.Doc1050Mapper;
import kr.co.amonsoft.service.doc.Doc1050Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class Doc1050ServiceImpl implements Doc1050Service {
	
	private final Doc1040Mapper doc1040Mapper;
	
	private final Doc1050Mapper doc1050Mapper;
	
	private final Doc1020Mapper doc1020Mapper;
	
	@Override
	public void insertDoc1050(Map<String, Object> param) {
		Map<String,Object> documentMap = new HashMap<>();
		List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) param.get("approvalData");
		List<Map<String, Object>> expenseDetailData = (List<Map<String, Object>>) param.get("expenseDetailData");
		
		documentMap.put("userId", param.get("userId"));
		documentMap.put("docTitle", param.get("docTitle"));
		documentMap.put("docType", "05");
		
		 doc1040Mapper.insertDocumentApproval(documentMap);
		 
        // 생성된 docId를 가져옵니다.
        BigInteger docId = (BigInteger) documentMap.get("docId");
        
        // 결재선
        approvalStep.forEach(step -> {
            step.put("docId", docId);
            step.put("create_id", param.get("userId"));
            doc1040Mapper.insertApprovalRequestStep(step);
        });
        
        // 법인카드사용내역
        expenseDetailData.forEach(detail -> {
            detail.put("docId", docId);
            detail.put("create_id", param.get("userId"));
            doc1050Mapper.insertDoc1050(detail);
        });
        
	}

	@Override
	public List<Map<String, Object>> selectDoc1050(BigInteger docId) {
		return doc1050Mapper.selectDoc1050(docId);
	}

}
