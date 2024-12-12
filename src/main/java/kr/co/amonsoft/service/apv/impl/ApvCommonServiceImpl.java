package kr.co.amonsoft.service.apv.impl;

import kr.co.amonsoft.mapper.apv.ApvCommonMapper;
import kr.co.amonsoft.service.apv.ApvCommonService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class ApvCommonServiceImpl implements ApvCommonService {

    private final ApvCommonMapper apvCommonMapper;


    @Override
    public List<Map<String, Object>> findApprovalStepsByDocId(BigInteger docId) {
        return apvCommonMapper.findApprovalStepsByDocId(docId);
    }

    @Override
    public Map<String, Object> findDocumentCreatorInfo(BigInteger docId) {
        return apvCommonMapper.findDocumentCreatorInfo(docId);
    }

    @Override
    public Map<String, Object> findCurrentStepNo(BigInteger docId) {
        return apvCommonMapper.findCurrentStepNo(docId);
    }

    @Override
    public Map<String, Object> findStepNoByDocIdAndUserId(BigInteger docId, String userId) {
        Map<String, Object> stepNoMap = new HashMap<>();
        stepNoMap.put("docId", docId);
        stepNoMap.put("userId", userId);
        return apvCommonMapper.findStepNoByDocIdAndUserId(stepNoMap);
    }

    @Override
    public List<Map<String, Object>> findByOrganizationAndUserInfo() {
        return apvCommonMapper.findByOrganizationAndUserInfo();
    }

    @Transactional
    @Override
    public int updateApprovalStatus(Map<String,Object> param) {
        int stepUpdateResult = 0;
        int approvalUpdateResult = apvCommonMapper.updateApprovalStatus(param);
        int docId = Integer.parseInt(String.valueOf(param.get("docId")));
        String status = String.valueOf(param.get("status"));
        String roleCode = String.valueOf(param.get("roleCode"));
        //반려일때
        if(status.equals("04")) {
            stepUpdateResult =  apvCommonMapper.updateDocumentToRejectedStatus(docId);
        }else{
            //대표님 결재
            if (roleCode.equals("01")) {
                stepUpdateResult = apvCommonMapper.updateDocumentCompletionStatus(docId);
            } else {
                stepUpdateResult = apvCommonMapper.updateDocumentCurrentStep(docId);
            }
        }
        //다음결재자 업데이트
        apvCommonMapper.updateCurrentApproverId(docId);
        return (approvalUpdateResult > 0 && stepUpdateResult > 0) ? 1 : 0;
    }
}
