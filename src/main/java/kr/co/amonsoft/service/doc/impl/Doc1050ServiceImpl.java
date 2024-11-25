package kr.co.amonsoft.service.doc.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.amonsoft.mapper.apv.ApvCommonMapper;
import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.mapper.doc.Doc1040Mapper;
import kr.co.amonsoft.mapper.doc.Doc1050Mapper;
import kr.co.amonsoft.mapper.doc.Doc1060Mapper;
import kr.co.amonsoft.mapper.doc.DocCommonMapper;
import kr.co.amonsoft.service.doc.Doc1050Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class Doc1050ServiceImpl implements Doc1050Service {
	
	private final DocCommonMapper docCommonMapper;
    private final ApvCommonMapper apvCommonMapper;
    private final Doc1050Mapper doc1050Mapper;
	
	@Override
	public BigInteger insertDoc1050(Map<String, Object> approvalData) {
		List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) approvalData.get("approvalData");
		
		String currentApproverId = approvalStep.stream()
	            .filter(step -> Integer.valueOf(String.valueOf(step.get("approvalStepNo"))) == 2) // approvalStepNo는 Integer로 처리
	            .map(step -> String.valueOf(step.get("userId"))) // userId는 String으로 변환
	            .findFirst()
	            .orElseThrow(() -> new RuntimeException("Approval step with stepNo 2 is missing"));

	    approvalData.put("currentApproverId", currentApproverId);
		
		docCommonMapper.insertDocument(approvalData);
		BigInteger docId = (BigInteger) approvalData.get("docId");

        approvalStep.forEach(step -> {
            step.put("docId", docId);
            apvCommonMapper.insertApprovalStep(step);
        });
        
        List<Map<String, Object>>expenseDetailData = (List<Map<String, Object>>) approvalData.get("data");
        expenseDetailData.forEach(detail -> {
            detail.put("docId", docId);
            detail.put("userId", approvalData.get("userId"));
            doc1050Mapper.insertDoc1050(detail);
        });
        
        return docId;
	}

	@Override
	public List<Map<String, Object>> selectDoc1050(BigInteger docId) {
		return doc1050Mapper.selectDoc1050(docId);
	}

}
