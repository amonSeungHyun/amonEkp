package kr.co.amonsoft.service.doc.impl;

import kr.co.amonsoft.config.security.CustomUserDetails;
import kr.co.amonsoft.mapper.apv.ApvCommonMapper;
import kr.co.amonsoft.mapper.doc.Doc1010Mapper;
import kr.co.amonsoft.mapper.doc.Doc1020Mapper;
import kr.co.amonsoft.mapper.doc.DocCommonMapper;
import kr.co.amonsoft.service.EmailService;
import kr.co.amonsoft.service.doc.Doc1010Service;
import kr.co.amonsoft.service.doc.Doc1020Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
@Slf4j
public class Doc1010ServiceImpl implements Doc1010Service {

    private final Doc1010Mapper doc1010Mapper;
    private final ApvCommonMapper apvCommonMapper;
    private final EmailService emailService;
    private final DocCommonMapper docCommonMapper;

    @Transactional
    @Override
    public BigInteger insertApprovalDocument(Map<String, Object> approvalData) {
        log.info("휴가계서비스 전 : {}", approvalData);
        List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) approvalData.get("approvalData");
        String currentApproverId = approvalStep.stream()
                .filter(step -> (Integer) step.get("approvalStepNo") == 2) // stepNo가 1인 데이터
                .map(step -> step.get("userId").toString()) // approverId 추출
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Approval step with stepNo 1 is missing"));

        approvalData.put("currentApproverId", currentApproverId);
        log.info("휴가계서비스 후 : {}", approvalData);
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
                doc1010Mapper.insertVacationDetail(detail);
        });

        // 결재후 메일
//        emailService.sendApprovalEmails((String)approvalData.get("docType"), currentApproverId);

        return docId;
    }


    @Override
    public Map<String, Object> findVacationDetailsByDocId(BigInteger docId) {
        return doc1010Mapper.findVacationDetailsByDocId(docId);
    }

    @Transactional
    @Override
    public int updateAnnualLeaveApprovalStep(Map<String,Object> param) {
        int approvalUpdateResult = doc1010Mapper.updateAnnualLeaveApprovalStep(param);
        int docId = Integer.parseInt(String.valueOf(param.get("docId")));
        int stepUpdateResult = apvCommonMapper.updateDocumentCurrentStep(docId);
        return (approvalUpdateResult > 0 && stepUpdateResult > 0) ? 1 : 0;
    }

}
