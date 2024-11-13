package kr.co.amonsoft.mapper.doc;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface Doc1010Mapper {

    void insertApprovalStep(Map<String, Object> approvalStep);

    void insertDocument(Map<String, Object> param);

    void insertVacationDetail(Map<String, Object> expenseDetail);

    Map<String,Object> findVacationDetailsByDocId(BigInteger docId);

    int updateAnnualLeaveApprovalStep(Map<String,Object> param);

}
