package kr.co.amonsoft.mapper.apv;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface ApvCommonMapper {

    List<Map<String, Object>> findApprovalStepsByDocId(BigInteger docId);

    Map<String, Object> findDocumentCreatorInfo(BigInteger docId);

    Map<String, Object> findCurrentStepNo(BigInteger docId);

    Map<String, Object> findStepNoByDocIdAndUserId(Map<String, Object> stepNoMap);

    int updateApprovalStatus(Map<String, Object> param);

    int updateDocumentCompletionStatus(int docId);

    int updateDocumentCurrentStep(int docId);

    void insertApprovalStep(Map<String, Object> approvalStep);}
