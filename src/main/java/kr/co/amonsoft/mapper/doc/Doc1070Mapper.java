package kr.co.amonsoft.mapper.doc;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface Doc1070Mapper {
    void insertResignationDetail(Map<String, Object> expenseDetail);

    Map<String,Object> findResignationDetailsByDocId(BigInteger docId);

    int verifyDuplicateItem(String userId);

    List<Map<String, Object>> selectResignedUserList();

    void updateUserStatus(List<Map<String, Object>> updateUserStatusRequest);

}
