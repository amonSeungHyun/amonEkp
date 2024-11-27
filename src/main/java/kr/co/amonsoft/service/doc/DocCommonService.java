package kr.co.amonsoft.service.doc;

import java.util.List;
import java.util.Map;

public interface DocCommonService {
    int findDocumentsUnderApprovalTotalCountByUserId(String userId);

    List<Map<String,Object>> findDocumentsUnderApproval(Map<String,Object> param);

    List<Map<String,Object>> findPendingApprovalDocuments(Map<String,Object> param);

    List<Map<String, Object>> findCompleteDocuments(String userId);

    Map<String,Object> findTeamLeadersByUserOrganization(String userId);

    int findDocumentsPendingApprovalTotalCountByUserId(String userId);

    int findCompleteDocumentsTotalCountByUserId(String userId);
}
