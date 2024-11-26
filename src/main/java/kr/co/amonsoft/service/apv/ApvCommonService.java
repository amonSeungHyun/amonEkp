package kr.co.amonsoft.service.apv;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface ApvCommonService {

    List<Map<String, Object>> findApprovalStepsByDocId(BigInteger docId);

    Map<String,Object> findDocumentCreatorInfo(BigInteger docId);

    Map<String, Object> findCurrentStepNo(BigInteger docId);

    Map<String, Object> findStepNoByDocIdAndUserId(BigInteger docId, String userId);

    int updateApprovalStatus(Map<String, Object> param);

}
