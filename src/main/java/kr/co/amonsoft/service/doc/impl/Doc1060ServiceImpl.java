package kr.co.amonsoft.service.doc.impl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.amonsoft.mapper.apv.ApvCommonMapper;
import kr.co.amonsoft.mapper.doc.Doc1060Mapper;
import kr.co.amonsoft.mapper.doc.DocCommonMapper;
import org.springframework.stereotype.Service;

import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.mapper.doc.Doc1040Mapper;
import kr.co.amonsoft.service.doc.Doc1060Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class Doc1060ServiceImpl implements Doc1060Service {

    private final DocCommonMapper docCommonMapper;
    private final ApvCommonMapper apvCommonMapper;
    private final Doc1060Mapper doc1060Mapper;
    
	@Override
	public BigInteger insertTransportExpense(Map<String, Object> param) {
        docCommonMapper.insertDocument(param);
        BigInteger docId = (BigInteger) param.get("docId");

        List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) param.get("approvalData");
        approvalStep.forEach(step -> {
            step.put("docId", docId);
            apvCommonMapper.insertApprovalStep(step);
        });

        List<Map<String, Object>>expenseDetail = (List<Map<String, Object>>) param.get("data");
        expenseDetail.forEach(detail -> {
            detail.put("docId", docId);
            doc1060Mapper.insertTransportExpense(detail);
        });

        return docId;
	}

	@Override
	public List<Map<String, Object>> findTransportExpenseDetailsByDocId(BigInteger docId) {
		return doc1060Mapper.findTransportExpenseDetailsByDocId(docId);
	}
}
