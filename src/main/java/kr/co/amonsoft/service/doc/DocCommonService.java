package kr.co.amonsoft.service.doc;

import java.util.List;
import java.util.Map;

public interface DocCommonService {
    int findDocumentsUnderApprovalTotalCountByUserId(Map<String,Object> param);

    List<Map<String,Object>> findDocumentsUnderApproval(Map<String,Object> param);

    List<Map<String,Object>> findPendingApprovalDocuments(Map<String,Object> param);

    List<Map<String, Object>> findCompleteDocuments(Map<String,Object> param);

    Map<String,Object> findTeamLeadersByUserOrganization(String userId);

    int findDocumentsPendingApprovalTotalCountByUserId(Map<String,Object> param);

    int findCompleteDocumentsTotalCountByUserId(Map<String,Object> param);

    List<Map<String,Object>> findDocumentUrls();
}
