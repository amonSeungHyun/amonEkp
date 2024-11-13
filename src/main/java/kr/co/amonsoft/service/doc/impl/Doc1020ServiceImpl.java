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

    private final Doc1020Mapper doc1020Mapper;
    private final ApvCommonMapper apvCommonMapper;

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
    public List<Map<String, Object>> findExpenseDetailsByDocId(BigInteger docId) {
        return doc1020Mapper.findExpenseDetailsByDocId(docId);
    }
}
