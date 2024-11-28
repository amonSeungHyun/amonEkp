package kr.co.amonsoft.service.doc.impl;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import kr.co.amonsoft.mapper.apv.ApvCommonMapper;
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
	public BigInteger insertApprovalRequest(Map<String, Object> approvalData) {
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
		
        List<Map<String, Object>> approvalRequestData = (List<Map<String, Object>>) approvalData.get("data");
        List<Integer> referenceDocIds = (List<Integer>)approvalRequestData.get(0).get("reference_doc_id");
        String referenceDocIdsString = referenceDocIds.stream()
                .map(String::valueOf)
                .collect(Collectors.joining(","));
        
        approvalRequestData.forEach(detail -> {
            detail.put("docId", docId);
            detail.put("userId", approvalData.get("userId"));
            detail.put("reference_doc_id", referenceDocIdsString);
            doc1040Mapper.insertApprovalRequest(detail);
        });
        
        return docId;
	}
	
	@Override
    public Map<String, Object> findApprovalRequestDetailsByDocId(BigInteger docId) {
        return doc1040Mapper.findApprovalRequestDetailsByDocId(docId);
    }

	@Override
	public List<Map<String, Object>> selectReferenceApproval(Map<String, Object> param) {
		return doc1040Mapper.selectReferenceApproval(param);
	}

	@Override
	public int selectReferenceApprovalCnt() {
		return doc1040Mapper.selectReferenceApprovalCnt();
	}

	@Override
	public List<Map<String, Object>> selectReferenceApprovalView(Map<String, Object> param) {
		String referenceDocIdsString = (String)param.get("reference_doc_id");

		// 문자열을 쉼표 기준으로 분리하여 List<Integer>로 변환
		List<Integer> referenceDocIds = Arrays.stream(referenceDocIdsString.split(","))
		                                      .map(Integer::parseInt)
		                                      .collect(Collectors.toList());
		param.put("reference_doc_id", referenceDocIds);
		return doc1040Mapper.selectReferenceApprovalView(param);
	}
}
