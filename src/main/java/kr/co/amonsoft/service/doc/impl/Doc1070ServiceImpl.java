package kr.co.amonsoft.service.doc.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.amonsoft.config.exception.DuplicateItemException;
import kr.co.amonsoft.mapper.apv.ApvCommonMapper;
import kr.co.amonsoft.mapper.doc.Doc1070Mapper;
import kr.co.amonsoft.mapper.doc.DocCommonMapper;
import kr.co.amonsoft.service.doc.Doc1070Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigInteger;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
@Log4j2
public class Doc1070ServiceImpl implements Doc1070Service {

    private final ObjectMapper objectMapper;
    private final DocCommonMapper docCommonMapper;
    private final ApvCommonMapper apvCommonMapper;
    private final Doc1070Mapper doc1070Mapper;

    @Override
    @Transactional(rollbackFor={Exception.class, SQLException.class})
    public BigInteger insertResignation(String jsonData, String userId) throws JsonProcessingException {
        BigInteger docId;
        int duplicateCnt = doc1070Mapper.verifyDuplicateItem(userId);
        if(duplicateCnt == 0) {
            Map<String, Object> insertResignationRequest = objectMapper.readValue(jsonData, new TypeReference<Map<String, Object>>() {});
            insertResignationRequest.put("userId",userId);
            List<Map<String, Object>> approvalStep = (List<Map<String, Object>>) insertResignationRequest.get("approvalData");
            String currentApproverId = approvalStep.stream()
                    .filter(step -> (Integer) step.get("approvalStepNo") == 2) // stepNo가 1인 데이터
                    .map(step -> step.get("userId").toString()) // approverId 추출
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException("Approval step with stepNo 1 is missing"));

            insertResignationRequest.put("currentApproverId", currentApproverId);

            docCommonMapper.insertDocument(insertResignationRequest);

            // 생성된 docId를 가져옵니다.
            docId = (BigInteger) insertResignationRequest.get("docId");

            // approvalStep과 resignationDetail에서 동일한 docId 사용
            approvalStep.forEach(step -> {
                step.put("docId", docId);
                apvCommonMapper.insertApprovalStep(step);
            });

            List<Map<String, Object>> resignationDetail = (List<Map<String, Object>>) insertResignationRequest.get("data");
            resignationDetail.forEach(detail -> {
                detail.put("docId", docId);
                detail.put("userId", userId);
                doc1070Mapper.insertResignationDetail(detail);
            });

        }else {
            throw new DuplicateItemException("이미 결재된 사직서가 존재합니다.");
        }
        return docId;

    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> findResignationDetailsByDocId(BigInteger docId) {
        String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
        Map<String, Object> resignationDetail = doc1070Mapper.findResignationDetailsByDocId(docId);
        String phoneNumber = String.valueOf(resignationDetail.get("phoneNumber"));
        if(StringUtils.hasText(phoneNumber)) {
            String formatPhoneNumber = phoneNumber.replaceAll(regEx, "$1-$2-$3");
            resignationDetail.put("phoneNumber", formatPhoneNumber);
        }
        return resignationDetail;
    }
}
