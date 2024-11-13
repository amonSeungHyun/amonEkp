package kr.co.amonsoft.mapper.doc;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface DocCommonMapper {

    List<Map<String, Object>> findDocumentsUnderApproval(String userId);

    List<Map<String, Object>> findCompleteDocuments(String userId);

    List<Map<String, Object>> findPendingApprovalDocuments(String userId);

    Map<String, Object> findTeamLeadersByUserOrganization(String userId);

}
