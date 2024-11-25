package kr.co.amonsoft.service.doc.impl;

import kr.co.amonsoft.mapper.apv.ApvCommonMapper;
import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.mapper.doc.DocCommonMapper;
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

    private final DocCommonMapper docCommonMapper;
    private final ApvCommonMapper apvCommonMapper;
    private final Doc1020Mapper doc1020Mapper;

    @Override
    public BigInteger insertApprovalDocument(Map<String, Object> approvalData) {
        List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) approvalData.get("approvalData");
        String currentApproverId = approvalStep.stream()
                .filter(step -> (Integer) step.get("approvalStepNo") == 2) // stepNo가 1인 데이터
                .map(step -> (String) step.get("userId")) // approverId 추출
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Approval step with stepNo 1 is missing"));

        approvalData.put("currentApproverId", currentApproverId);

        docCommonMapper.insertDocument(approvalData);

        // 생성된 docId를 가져옵니다.
        BigInteger docId = (BigInteger) approvalData.get("docId");

        // approvalStep과 expenseDetail에서 동일한 docId 사용
        approvalStep.forEach(step -> {
            step.put("docId", docId);
            apvCommonMapper.insertApprovalStep(step);
        });

        List<Map<String, Object>> documentDetail = (List<Map<String, Object>>) approvalData.get("data");
        documentDetail.forEach(detail -> {
            detail.put("docId", docId);
            doc1020Mapper.insertExpenseDetail(detail);
        });

        return docId;
    }


    @Override
    public List<Map<String, Object>> findExpenseDetailsByDocId(BigInteger docId) {
        return doc1020Mapper.findExpenseDetailsByDocId(docId);
    }
}
