package kr.co.amonsoft.mapper.doc;

import org.apache.ibatis.annotations.Mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

@Mapper
public interface DocCommonMapper {

    int findDocumentsUnderApprovalTotalCountByUserId(Map<String,Object> param);

    List<Map<String, Object>> findDocumentsUnderApproval(Map<String,Object> param);

    List<Map<String, Object>> findCompleteDocuments(Map<String,Object> param);

    List<Map<String, Object>> findPendingApprovalDocuments(Map<String,Object> param);

    Map<String, Object> findTeamLeadersByUserOrganization(String userId);

    int findDocumentsPendingApprovalTotalCountByUserId(Map<String,Object> param);

    int findCompleteDocumentsTotalCountByUserId(Map<String,Object> param);

    List<Map<String,Object>> findDocumentUrls();

    void insertDocument(Map<String, Object> param);

    // 결재할때 메일 관련 ############################################################
    List<Map<String, Object>> findCeoAndManager();
    List<Map<String, Object>> findDocTypeTitles();

}
